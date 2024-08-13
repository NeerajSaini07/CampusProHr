// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;

class AddCircularEmployeeApi {
  Future<String> addCircularEmployee(
      Map<String, String> requestPayload, List<File>? _filePickedList) async {
    print("Sendcircular before API: $requestPayload");
    print("image before Api : $_filePickedList");
    try {
      // http.Response response = await http.post(
      //   Uri.parse(Api.addCircularEmployee),
      //   body: requestPayload,
      //   headers: headers,
      //   encoding: encoding,
      // );

      // create multipart request
      var uri = Uri.parse(ApiEndpoints.addCircularEmployee);
      //.. this is cascade operator
      var request = new http.MultipartRequest("POST", uri)
        ..fields.addAll(requestPayload);

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

      print('${request.fields},${request.files}');
      // send
      var response = await request.send();

      print("Sendcircular Status Code: ${response.statusCode}");
      //print("Sendcircular API Body: ${response.body}");
      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      //final respMap = json.decode(response.body);
      final respMap = await response.stream.bytesToString();
      print("Sendcircular Response from API: $respMap");
      print(response.statusCode);

      final dataList = respMap;
      final respMap1 = jsonDecode(respMap);

      // String checkString = "Success";
      if (response.statusCode == 200) {
        //return dataList;
        if (respMap1 == "Success") {
          return dataList;
        }
      }

      if (response.statusCode == 200) {
        if (dataList.toLowerCase() == 'already applied.') {
          return dataList;
        }
      }
      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON Send Circular API: $e");
      throw "$e";
    }
  }
}
