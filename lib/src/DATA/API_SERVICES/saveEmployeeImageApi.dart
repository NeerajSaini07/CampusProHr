import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;

class SaveEmployeeImageApi {
  Future<bool> saveEmployeeImage(
      Map<String, String> editData, File? _pickedImage) async {
    print("SaveEmployeeImage before API DATA: $editData");
    print("SaveEmployeeImage before API Image: ${_pickedImage!.path}");
    try {
      // create multipart request
      var uri = Uri.parse(ApiEndpoints.saveEmployeeeImageApi);
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
      print("multipartFile => ${response.statusCode}");
      print("SaveEmployeeImage status code -- ${response.statusCode}");

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

      print("SaveEmployeeImage reponse API => $respStr");

      if (response.statusCode == 200) {
        return true;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON SaveEmployeeImage API: $e");
      throw "$e";
    }
  }
}
