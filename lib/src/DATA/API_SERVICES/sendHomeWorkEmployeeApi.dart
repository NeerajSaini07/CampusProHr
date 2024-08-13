import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:flutter/material.dart';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;

class SendHomeWorkEmployeeApi {
  Future<String> sendHomeWorkEmployee(
      Map<String, String> requestPayload, List<File>? _filePickedList) async {
    print("send homework before API: $requestPayload");
    try {
      // http.Response response = await http.post(
      //   Uri.parse(Api.sendHomeWorkEmployeeApi),
      //   body: requestPayload,
      //   headers: headers,
      //   encoding: encoding,
      // );

      // create multipart request
      var uri = Uri.parse(ApiEndpoints.sendHomeWorkEmployeeApi);
      var request = new http.MultipartRequest("POST", uri)
        ..fields.addAll(requestPayload);

      if (_filePickedList != null)
        _filePickedList.forEach((element) async {
          // open a bytestream
          var stream = new http.ByteStream(Stream.castFrom(element.openRead()));

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

      print("SendHomeWork Status Code: ${response.statusCode}");
      //print("SendHomeWork API Body: ${response.body}");
      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      //final respMap = json.decode(response.body);
      final respMap = await response.stream.bytesToString();
      print("SendHomeWork Response from API: $respMap");
      print(response.statusCode);

      // final dataList = (respMap)
      //     .map((e) => CreateHomeWorkEmployeeModel.fromJson(e))
      //     .toList();
      final dataList = respMap;
      print(dataList);
      if (response.statusCode == 200) {
        // if (dataList.toLowerCase() == 'success') {
        //   return dataList;
        // }
        return dataList;
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
      print("ERROR ON SendHomeWork API: $e");
      throw "$e";
    }
  }
}

// class CreateHomeWorkEmployeeModel {
//   String? status = "";
//
//   CreateHomeWorkEmployeeModel({this.status});
//
//   CreateHomeWorkEmployeeModel.fromJson(Map<String, dynamic> json) {
//     status = json['Status'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['Status'] = this.status;
//     return data;
//   }
// }
