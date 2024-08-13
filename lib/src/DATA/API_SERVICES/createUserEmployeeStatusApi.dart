import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:http/http.dart' as http;

import '../../UTILS/api_endpoints.dart';

class CreateUserEmployeeStatusApi {
  Future<bool> createStatus(Map<String, String?> createData) async {
    print("CreateUserEmployeeStatus before API: $createData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.createUserEmployeeStatusApi),
        body: createData,
        headers: headers,
        encoding: encoding,
      );

      print("CreateUserEmployeeStatus API Status Code: ${response.statusCode}");
      print("CreateUserEmployeeStatus API Body: ${response.body}");

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
      print("CreateUserEmployeeStatus Response from API: $respMap");

      if (response.statusCode == 200) {
        return true;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON CreateUserEmployeeStatus API: $e");
      throw "$e";
    }
  }
}
