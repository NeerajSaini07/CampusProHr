import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/employeeInfoModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class EmployeeInfoApi {
  Future<EmployeeInfoModel> employeeInfo(
      Map<String, String?> employeeInfoData) async {
    print("EmployeeInfo before API: $employeeInfoData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.employeeInfoApi),
        body: employeeInfoData,
        headers: headers,
        encoding: encoding,
      );

      print("EmployeeInfo Status Code: ${response.statusCode}");
      print("EmployeeInfo API Body: ${response.body}");

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

      if (response.statusCode == 200) {
        final employeeInfo = EmployeeInfoModel.fromJson(respMap['Data'][0]);
        return employeeInfo;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON EmployeeInfo API: $e");
      throw "$e";
    }
  }
}
