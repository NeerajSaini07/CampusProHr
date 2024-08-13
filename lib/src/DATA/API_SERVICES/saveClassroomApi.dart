import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';

class SaveClassroomApi {
  Future<String> classRoomSave(
      Map<String, String> requestPayload, List<File>? selectedFile) async {
    try {
      // http.Response response = await http.post(Uri.parse(Api.saveClassRoomApi),
      //     body: request, headers: headers, encoding: encoding);

      var uri = Uri.parse(ApiEndpoints.saveClassRoomApi);
      var request = http.MultipartRequest('POST', uri)
        ..fields.addAll(requestPayload);

      if (selectedFile != null) {
        selectedFile.forEach((element) async {
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

      var body = await response.stream.bytesToString();
      print(body);

      print('status of save class room api ${response.statusCode}');
      print('body of save class room api $body');

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }
      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      var respMap = body;
      var decode = jsonDecode(respMap);
      if (response.statusCode == 200) {
        if (decode == 'Success') {
          return 'Success';
        }
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print('error on save class room api $e');
      throw e;
    }
  }
}
