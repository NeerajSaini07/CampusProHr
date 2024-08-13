import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class UpdateStudentMobileNoApi {
  Future<bool> updateDetail(Map<String, String?> updateData) async {
    print("UpdateStudentMobileNo before API: $updateData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.updateStudentMobileNoApi),
        body: updateData,
        headers: headers,
        encoding: encoding,
      );

      print("UpdateStudentMobileNo Status Code: ${response.statusCode}");
      print("UpdateStudentMobileNo API Body: ${response.body}");

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
      print("UpdateStudentMobileNo Response from API: $respMap");

      if (response.statusCode == 200) {
        return true;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON UpdateStudentMobileNo API: $e");
      throw "$e";
    }
  }
}
