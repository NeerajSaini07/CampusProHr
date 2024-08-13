import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;

class SendCustomChatApi {
  Future<bool> sendCustomChatData(
      Map<String, String> commentData, List<File>? _filePickedList) async {
    print("SendCustomChat before API: $commentData");
    try {
      // create multipart request
      var uri = Uri.parse(ApiEndpoints.sendCustomChatApi);
      var request = new http.MultipartRequest("POST", uri)
        ..fields.addAll(commentData);

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

      print("multipartFile => ${response.statusCode}");
      print("SendCustomChat status code -- ${response.statusCode}");

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
      print("ERROR ON SendCustomClassRoomComments API: $e");
      throw "$e";
    }
  }
}
