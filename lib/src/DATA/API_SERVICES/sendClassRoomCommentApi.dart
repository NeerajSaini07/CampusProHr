import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';
import 'package:campus_pro/src/DATA/MODELS/attendanceGraphModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;

class SendClassRoomCommentApi {
  Future<bool> sendClassRoomComments(
      Map<String, String> comments, List<File>? _filePickedList) async {
    print("SendClassRoomComments before API: $comments");
    try {
      // create multipart request
      var uri = Uri.parse(ApiEndpoints.sendClassRoomCommentApi);
      var request = new http.MultipartRequest("POST", uri)
        ..fields.addAll(comments);

      if (_filePickedList != null)
        _filePickedList.forEach((element) async {
          // open a bytestream
          var stream =
              new http.ByteStream(DelegatingStream.typed(element.openRead()));

          // get file length
          var length = await element.length();

          // multipart that takes file
          var multipartFile = new http.MultipartFile('image', stream, length,
              filename: element.path.split('/').last);

          print("multipartFile ${multipartFile.filename}");

          // add file to multipart
          request.files.add(multipartFile);
        });

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
      print("SendClassRoomComments status code -- ${response.statusCode}");

      final respStr = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        return true;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON SendClassRoomComments API: $e");
      throw "$e";
    }
  }
}
// class SendClassRoomCommentApi {
//   Future<bool> sendClassRoomComments(Map<String, String?> comments) async {
//     print("SendClassRoomComments before API: $comments");
//     try {
//       http.Response response = await http.post(
//         Uri.parse(Api.sendClassRoomCommentApi),
//         body: comments,
//         headers: headers,
//         encoding: encoding,
//       );

//       print("SendClassRoomComments Status Code: ${response.statusCode}");
//       print("SendClassRoomComments API Body: ${response.body}");

//       if (response.statusCode == 500) {
//         throw SOMETHING_WENT_WRONG;
//       }

//       if (response.statusCode == 204) {
//         throw NO_RECORD_FOUND;
//       }

//       String respMap = json.decode(response.body);
//       print("Get SendClassRoomComments Response from API: $respMap");
//       print("response.body from API: ${response.body}");
//       // String json.decode(response.body);

//       if (response.statusCode == 200 && respMap.toLowerCase() == 'success') {
//         return true;
//       }

//       throw SOMETHING_WENT_WRONG;
//     } catch (e) {
//       print("ERROR ON SendClassRoomComments API: $e");
//       throw "$e";
//     }
//   }
// }
