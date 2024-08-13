import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:http/http.dart' as http;
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:async/async.dart';
import 'package:image_picker/image_picker.dart';

class SaveVisitorDetailsGatePassApi {
  Future<String> saveDetails(
      Map<String, String> payload, File _pickedImage) async {
    try {
      print(
          "SaveVisitorDetailsGatePass before API => $payload, _pickedImage: ${_pickedImage.path}");
      //
      // print(_filePickedList);
      // var request = http.MultipartRequest(
      //   "POST",
      //   Uri.parse(Api.saveVisitorGatePassApi),
      // );
      // request.files.add(http.MultipartFile(
      //     'image',
      //     _filePickedList.readAsBytes().asStream(),
      //     _filePickedList.lengthSync(),
      //     filename: "test"));
      // //
      // print("done");
      //
      var uri = Uri.parse(ApiEndpoints.saveVisitorGatePassApi);
      var request = new http.MultipartRequest("POST", uri)
        ..fields.addAll(payload);

      var stream =
          new http.ByteStream(DelegatingStream.typed(_pickedImage.openRead()));

      // get file length
      var length = await _pickedImage.length();

      // multipart that takes file
      var multipartFile = new http.MultipartFile('image', stream, length,
          filename: _pickedImage.path.split('/').last);

      print("multipartFile ${multipartFile.filename}");

      // add file to multipart
      request.files.add(multipartFile);

      var response = await request.send();
      //
      print(
          "SaveVisitorDetailsGatePass response status code => ${response.statusCode}");

      //
      // http.Response response = await http.post(
      //     Uri.parse(Api.saveVisitorGatePassApi),
      //     body: payload,
      //     encoding: encoding,
      //     headers: headers);
      //
      // print("status of save details api ${response.statusCode}");
      // print("body of save details api ${response.body}");

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }
      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      var respMap = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        if (respMap.toLowerCase() == "done") {
          return "done";
        } else {
          return "fail";
        }
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("error on save visitor details api $e");
      throw e;
    }
  }
}
