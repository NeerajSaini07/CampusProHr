import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';
import 'package:campus_pro/src/DATA/MODELS/attendanceGraphModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:file_picker/file_picker.dart';
import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class SendHomeworkCommentApi {
  Future<bool> sendHomeworkComments(
      Map<String, String> comments, List<File>? _filePickedList) async {
    print("SendHomeworkComments before API: $comments");
    try {
      // create multipart request
      var uri = Uri.parse(ApiEndpoints.sendHomeworkCommentsApi);
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

          print("multipartFile vvvv ${multipartFile.filename}");

          // add file to multipart
          request.files.add(multipartFile);
        });

      // send
      var response = await request.send();

      print("multipartFile => ${response.statusCode}");
      print("SendHomeworkComments status code -- ${response.statusCode}");

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      final respStr = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        return true;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON SendHomeworkComments API: $e");
      throw "$e";
    }
  }
}

// class SendHomeworkCommentApi {
//   Future<bool> sendHomeworkComments(Map<String, String?> comments,
//       List<PlatformFile>? _filePickedList) async {
//     print("SendHomeworkComments before API: $comments");
//     try {
//       http.Response response = await http.post(
//         Uri.parse(Api.sendHomeworkCommentsApi),
//         body: comments,
//         headers: headers,
//         encoding: encoding,
//       );

//       print("SendHomeworkComments Status Code: ${response.statusCode}");
//       print("SendHomeworkComments API Body: ${response.body}");

//       if (response.statusCode == 500) {
//         throw SOMETHING_WENT_WRONG;
//       }

//       if (response.statusCode == 204) {
//         throw NO_RECORD_FOUND;
//       }

//       final respMap = json.decode(response.body);
//       print("SendHomeworkComments Response from API: $respMap");
//       print("response.body from API: ${response.body}");
//       // String json.decode(response.body);

//       if (response.statusCode == 200) {
//         return true;
//       }

//       throw SOMETHING_WENT_WRONG;
//     } catch (e) {
//       print("ERROR ON SendHomeworkComments API: $e");
//       throw "$e";
//     }
//   }
// }
