import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class ApplyForLeaveApi {
  Future<String> applyForLeave(Map<String, String?> requestPayload) async {
    print("ApplyForLeave before API: $requestPayload");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.applyForLeaveApi),
        body: requestPayload,
        headers: headers,
        encoding: encoding,
      );

      print("ApplyForLeave Status Code: ${response.statusCode}");
      print("ApplyForLeave API Body: ${response.body}");

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }
      final respMap = json.decode(response.body);
      // print("Get ApplyForLeave Response from API: $respMap");

      final dataList =
          (respMap as List).map((e) => ApplyLeaveModel.fromJson(e)).toList();

      if (response.statusCode == 200) {
        if (dataList[0].status!.toLowerCase() == 'success') {
          return dataList[0].status!;
        }
      }

      if (response.statusCode == 200) {
        if (dataList[0].status!.toLowerCase() == 'already applied.') {
          return dataList[0].status!;
        }
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON ApplyForLeave API: $e");
      throw "$e";
    }
  }
}

class ApplyLeaveModel {
  String? status = "";

  ApplyLeaveModel({this.status});

  ApplyLeaveModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    return data;
  }
}
