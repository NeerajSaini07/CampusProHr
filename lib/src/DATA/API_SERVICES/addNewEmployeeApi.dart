import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class AddNewEmployeeApi {
  Future<String> addNewEmployee(Map<String, String?> requestPayload) async {
    print("addNewEmployee  before API: $requestPayload");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.addNewEmployeeAdminApi),
        body: requestPayload,
        headers: headers,
        encoding: encoding,
      );

      print("addNewEmployee Status Code: ${response.statusCode}");
      print("addNewEmployee API Body: ${response.body}");

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
        final newEmp = respMap['Data'][0];
        if (newEmp == "This Employee Code Already Exist") {
          throw 'Employee already exist with this Emp No.';
        } else {
          return newEmp;
        }
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON addNewEmployee API: $e");
      throw "$e";
    }
  }
}
