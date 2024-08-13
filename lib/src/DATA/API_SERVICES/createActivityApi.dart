// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:io';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';

class CreateActivityApi {
  Future<String> createActivityData(
      Map<String, String> sendActivity, List<File>? image) async {
    print("CreateActivityApi before API: $sendActivity");
    try {
      // http.Response response = await http.post(
      //   Uri.parse(Api.saveActivityApi),
      //   body: sendActivity,
      //   headers: headers,
      //   encoding: encoding,
      // );

      var uri = Uri.parse(ApiEndpoints.saveActivityApi);
      var request = http.MultipartRequest('POST', uri)
        ..fields.addAll(sendActivity);

      if (image != null) {
        image.forEach((element) async {
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
      }

      print('${request.fields},${request.files}');
      // send
      var response = await request.send();

      print("CreateActivityApi API Status Code: ${response.statusCode}");

      var body = await response.stream.bytesToString();

      print('createactivity api body : $body');

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      var respMap = jsonDecode(body);

      if (response.statusCode == 200) {
        if (respMap == 'Success') {
          return 'Success';
        }
      }

      throw respMap as String;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON CreateActivityApi: $e");
      throw "$e";
    }
  }
}
