// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';

class AssignClassCoordinatorApi {
  Future<String> saveCoordinator(
      Map<String, String> requestPayload, List<File>? img) async {
    try {
      // http.Response response = await http.post(
      //     Uri.parse(Api.assignClassCoordinatorApi),
      //     body: requestPayload,
      //     encoding: encoding,
      //     headers: headers);

      /////
      var uri = Uri.parse(ApiEndpoints.assignClassCoordinatorApi);
      var request = new http.MultipartRequest("POST", uri)
        ..fields.addAll(requestPayload);

      if (img != null)
        img.forEach((element) async {
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

      print('${request.fields},${request.files}');
      // send
      var response = await request.send();

      print('${request.fields},${request.files}');

      /////

      print('status of assignClassCoordinator api ${response.statusCode}');

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      // var respMap = jsonDecode(response.body);
      final respMap = await response.stream.bytesToString();
      print(respMap);

      if (response.statusCode == 200) {
        if (respMap == '{"Data":"Success"}') {
          return 'Success';
        }
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print('error on assignClassCoordinator $e');
      throw e;
    }
  }
}
