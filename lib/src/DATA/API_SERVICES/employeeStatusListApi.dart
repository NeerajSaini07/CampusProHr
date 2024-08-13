import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/employeeStatusListModel.dart';
import 'package:http/http.dart' as http;

import '../../UTILS/api_endpoints.dart';

class EmployeeStatusListApi {
  Future<EmployeeStatusListModel> employeeStatus(
      Map<String, String?> statusData) async {
    print("EmployeeStatusList before API: $statusData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.employeeStatusListApi),
        body: statusData,
        headers: headers,
        encoding: encoding,
      );

      print("EmployeeStatusList API Status Code: ${response.statusCode}");
      print("EmployeeStatusList API Body: ${response.body}");

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
      // if (response.statusCode == 200) {
      print("EmployeeStatusList Response from API: $respMap");

      if (response.statusCode == 200) {
        final statusList = EmployeeStatusListModel.fromJson(respMap);
        return statusList;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON EmployeeStatusList API: $e");
      throw "$e";
    }
  }
}
