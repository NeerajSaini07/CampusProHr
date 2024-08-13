import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/studentDetailSearchModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class StudentDetailSearchApi {
  Future<StudentDetailSearchModel> studentDetail(
      Map<String, String?> studentData) async {
    print("StudentDetailSearch before API: $studentData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.studentDetailSearchApi),
        body: studentData,
        headers: headers,
        encoding: encoding,
      );

      print("StudentDetailSearch Status Code: ${response.statusCode}");
      print("StudentDetailSearch API Body: ${response.body}");

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
      print("StudentDetailSearch Response from API: $respMap");

      if (response.statusCode == 200) {
        final student = StudentDetailSearchModel.fromJson(respMap[0]);
        return student;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON StudentDetailSearch API: $e");
      throw "$e";
    }
  }
}
