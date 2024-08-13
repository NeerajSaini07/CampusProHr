import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';

class VerifyIdProofGatePassApi {
  Future<String> verifyId(
      Map<String, String> payload, File? _pickedImage) async {
    try {
      // http.Response response = await http.post(Uri.parse(Api.verifyIdGatePass),
      //     body: paylaod, encoding: encoding, headers: headers);
      //
      // print("status of verify id api ${response.statusCode}");
      // print("body of verify id api ${response.body}");
      //
      var uri = Uri.parse(ApiEndpoints.verifyIdGatePass);
      var request = new http.MultipartRequest("POST", uri)
        ..fields.addAll(payload);

      var stream =
          new http.ByteStream(DelegatingStream.typed(_pickedImage!.openRead()));

      // get file length
      var length = await _pickedImage.length();

      // multipart that takes file
      var multipartFile = new http.MultipartFile('image', stream, length,
          filename: _pickedImage.path.split('/').last);

      print("multipartFile ${multipartFile.filename}");

      // add file to multipart
      request.files.add(multipartFile);

      var response = await request.send();

      print(response.statusCode);

      //
      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      //var respMap = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return "Success";
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("error of verify id $e");
      throw e;
    }
  }
}
