import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class MarkAttendanceSaveAttendanceEmployeeApi {
  Future<List> saveAtt(Map<String, String?> attendanceList) async {
    print(" save Attendance before API: $attendanceList");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.markAttendanceSaveAttendance),
        body: attendanceList,
        headers: headers,
        encoding: encoding,
      );

      print(" save Attendance Status Code: ${response.statusCode}");
      print(" save Attendance API Body: ${response.body}");

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      Map<String, dynamic> respMap = json.decode(response.body);
      print("Get  save Attendance Response from API: $respMap");
      //var respMap1 = respMap["Data"];
      if (response.statusCode == 200) {
        if (respMap["Data"] == "Already Marked") {
          String? res = "Already Marked";
          return [res];
        } else {
          return respMap["Data"];
        }
      }
      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON  save Attendance API: $e");
      throw "$e";
    }
  }
}
