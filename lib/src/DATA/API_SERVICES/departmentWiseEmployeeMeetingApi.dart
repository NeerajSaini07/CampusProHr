import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/departmentWiseEmployeeMeetingModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class DepartmentWiseEmployeeMeetingApi {
  Future<List<DepartmentWiseEmployeeMeetingModel>> getDepartments(
      Map<String, String?> departmentData) async {
    print("DepartmentWiseEmployeeMeeting before API: $departmentData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.departmentWiseEmployeeMeetingApi),
        body: departmentData,
        headers: headers,
        encoding: encoding,
      );

      print(
          "DepartmentWiseEmployeeMeeting Status Code: ${response.statusCode}");
      print("DepartmentWiseEmployeeMeeting API Body: ${response.body}");

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
        final departmentList = (respMap['Data'][0] as List)
            .map((e) => DepartmentWiseEmployeeMeetingModel.fromJson(e))
            .toList();
        return departmentList;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON DepartmentWiseEmployeeMeeting API: $e");
      throw "$e";
    }
  }
}
