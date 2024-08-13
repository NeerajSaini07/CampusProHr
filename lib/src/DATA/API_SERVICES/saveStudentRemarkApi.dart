import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class SaveStudentRemarkApi {
  Future<bool> saveRemark(Map<String, String?> saveData) async {
    print("SaveStudentRemark before API: $saveData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.saveStudentRemarkApi),
        body: saveData,
        headers: headers,
        encoding: encoding,
      );

      print("SaveStudentRemark Status Code: ${response.statusCode}");
      print("SaveStudentRemark API Body: ${response.body}");

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
      print("SaveStudentRemark Response from API: $respMap");

      if (response.statusCode == 200) {
        return true;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON SaveStudentRemark API: $e");
      throw "$e";
    }
  }
}
