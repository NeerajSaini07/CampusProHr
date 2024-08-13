import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class DeleteStudentRemarkApi {
  Future<bool> deleteRemark(Map<String, String?> deleteData) async {
    print("DeleteStudentRemark before API: $deleteData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.deleteStudentRemarkApi),
        body: deleteData,
        headers: headers,
        encoding: encoding,
      );

      print("DeleteStudentRemark Status Code: ${response.statusCode}");
      print("DeleteStudentRemark API Body: ${response.body}");

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
      print("DeleteStudentRemark Response from API: $respMap");

      if (response.statusCode == 200) {
        return true;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON DeleteStudentRemark API: $e");
      throw "$e";
    }
  }
}
