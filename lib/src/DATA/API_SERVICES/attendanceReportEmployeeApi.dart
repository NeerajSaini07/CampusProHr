import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/attendanceReportEmployeeModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';

import 'package:http/http.dart' as http;

class AttendanceReportEmployeeApi {
  Future<List<AttendanceReportEmployeeModel>> attendanceReport(
      Map<String, String?> requestPayload) async {
    print("attendance report before API: $requestPayload");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.getAttendanceReportEmployee),
        body: requestPayload,
        headers: headers,
        encoding: encoding,
      );
      print("attendance report Status Code: ${response.statusCode}");
      print("attendance report API Body: ${response.body}");

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      //Map<String, dynamic> respMap = json.decode(response.body);
      Map<String, dynamic> respMap = json.decode(response.body);
      print("Get  attendance report Response from API: $respMap");
      List<dynamic> respMap1 = respMap['Data'];
      print("Get  attendance report Response resMap1 from API: $respMap1");
      List<dynamic> respMap2 = respMap1[0]['Table'];
      print("Get  attendanceList report Response resMap2 from API: $respMap2");
      if (response.statusCode == 200) {
        final attendanceReport = (respMap2)
            .map((e) => AttendanceReportEmployeeModel.fromJson(e))
            .toList();
        return attendanceReport;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON  Attendance report API: $e");
      throw "$e";
    }
  }
}
