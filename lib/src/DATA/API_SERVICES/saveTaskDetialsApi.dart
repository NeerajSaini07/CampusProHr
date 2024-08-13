import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';

class SaveTaskDetailsApi {
  Future<String> saveTask(Map<String, String> payload, List<File>? img) async {
    try {
      // http.Response response = await http.post(
      //     Uri.parse(Api.saveTaskManagement),
      //     body: payload,
      //     encoding: encoding,
      //     headers: headers);

      // create multipart request
      var uri = Uri.parse(ApiEndpoints.saveTaskManagement);
      var request = new http.MultipartRequest("POST", uri)
        ..fields.addAll(payload);

      if (img != null)
        img.forEach((element) async {
          // open a bytestream
          var stream =
              new http.ByteStream(DelegatingStream.typed(element.openRead()));

          // get file length
          print(element.length());
          var length = await element.length();

          // multipart that takes file
          var multipartFile = new http.MultipartFile('image', stream, length,
              filename: element.path.split('/').last);

          print("multipartFile ${multipartFile.filename}");

          // add file to multipart
          request.files.add(multipartFile);
        });

      print('${request.fields},${request.files}');
      // send
      var response = await request.send();

      print('status of SaveTaskDetails ${response.statusCode}');
      // print('body of SaveTaskDetails ${response.body}');

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      final respMap = await response.stream.bytesToString();
      // var resMap = jsonDecode(response.body);
      print("adaskdalkdsad${respMap}");

      if (response.statusCode == 200) {
        // if (resMap["Data"][0]["Message"] == "Task saved successfully") {
        //   return "Success";
        // }
        return "Success";
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print(' error on saveTaskDetails $e');
      throw e;
    }
  }
}
