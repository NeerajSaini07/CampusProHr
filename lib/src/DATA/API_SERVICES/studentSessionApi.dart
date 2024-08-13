import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';
import 'package:campus_pro/src/DATA/MODELS/assignTeacherModel.dart';
import 'package:campus_pro/src/DATA/MODELS/studentSessionModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class StudentSessionApi {
  Future<List<StudentSessionModel>> studentSession(
      Map<String, String?> sessionData) async {
    print("StudentSession before API: $sessionData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.studentSessionApi),
        body: sessionData,
        headers: headers,
        encoding: encoding,
      );

      print("StudentSession Status Code: ${response.statusCode}");
      print("StudentSession API Body: ${response.body}");

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
        final sessionList = (respMap as List)
            .map((e) => StudentSessionModel.fromJson(e))
            .toList();
        return sessionList;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON StudentSession API: $e");
      throw "$e";
    }
  }
}
