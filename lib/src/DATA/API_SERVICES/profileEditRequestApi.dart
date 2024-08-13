import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;

class ProfileEditRequestApi {
  Future<bool> profileEditRequest(
      Map<String, String> editData, File? _pickedImage) async {
    print("ProfileEditRequest before API: $editData");
    try {
      // create multipart request
      var uri = Uri.parse(ApiEndpoints.profileEditApi);
      var request = new http.MultipartRequest("POST", uri)
        ..fields.addAll(editData);

      if (_pickedImage != null) {
        // open a bytestream
        var stream = new http.ByteStream(
            DelegatingStream.typed(_pickedImage.openRead()));

        // get file length
        var length = await _pickedImage.length();

        // multipart that takes file
        var multipartFile = new http.MultipartFile('image', stream, length,
            filename: _pickedImage.path.split('/').last);

        print("multipartFile ${multipartFile.filename}");

        // add file to multipart
        request.files.add(multipartFile);
      }

      // send
      var response = await request.send();

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      print("multipartFile => ${response.statusCode}");
      print("ProfileEditRequest status code -- ${response.statusCode}");

      final respStr = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        return true;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON ProfileEditRequest API: $e");
      throw "$e";
    }
  }
}
// class ProfileEditRequestApi {
//   Future<bool> profileEditRequest(
//       Map<String, String?> editData, File? _pickedImage) async {
//     print("ProfileEditRequest before API: $editData");
//     try {
//       http.Response response = await http.post(
//         Uri.parse(Api.profileEditApi),
//         body: requestPayload,
//         headers: headers,
//         encoding: encoding,
//       );

//       print("ProfileEditRequest Status Code: ${response.statusCode}");
//       print("ProfileEditRequest API Body: ${response.body}");

//       if (response.statusCode == 500) {
//         throw SOMETHING_WENT_WRONG;
//       }

//       if (response.statusCode == 204) {
//         throw NO_RECORD_FOUND;
//       }

//       String respMap = json.decode(response.body);

//       print("ProfileEditRequest Response from API: $respMap");

//       if (response.statusCode == 200 && respMap.toLowerCase() == 'success') {
//         return true;
//       }

//       return false;
//     } catch (e) {
//       print("ERROR ON ProfileEditRequest API: $e");
//       throw "$e";
//     }
//   }
// }
