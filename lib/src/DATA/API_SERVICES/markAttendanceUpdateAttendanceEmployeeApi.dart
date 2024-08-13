import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class MarkAttendanceUpdateAttendanceEmployeeApi {
  Future<List> updateAttendance(Map<String, String?> attendanceList) async {
    print(" update Attendance before API: $attendanceList");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.markAttendanceUpdateAttendance),
        body: attendanceList,
        headers: headers,
        encoding: encoding,
      );

      print(" update Attendance Status Code: ${response.statusCode}");
      print(" update Attendance API Body: ${response.body}");

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
      print("Get  update Attendance Response from API: $respMap");
      //var respMap1 = respMap["Data"];
      if (response.statusCode == 200) {
        if (respMap["Data"] == "Success") {
          //String? res = "Already Marked";
          return respMap["Data"];
        } else {
          return respMap["Data"];
        }
      }
      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON  update Attendance API: $e");
      throw "$e";
    }
  }
}
