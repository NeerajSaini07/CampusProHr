import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/markAttendanceListEmployeeModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class MarkAttendanceListEmployeeApi {
  Future<List<MarkAttendanceListEmployeeModel>> markAttendanceList(
      Map<String, String?> attendanceList) async {
    print("Get Attendance Student List : $attendanceList");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.getMarkAttendanceStuListEmployee),
        body: attendanceList,
        headers: headers,
        encoding: encoding,
      );

      print(" Attendance Student List Status Code: ${response.statusCode}");
      print(" Attendance Student List API Body: ${response.body}");

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      Map<String, dynamic> respMap = json.decode(response.body);

      List<dynamic> respMap1 = respMap['Data'];
      print('Attendance Student List result $respMap1 ');

      if (response.statusCode == 200) {
        final attendanceList = (respMap1)
            .map((e) => MarkAttendanceListEmployeeModel.fromJson(e))
            .toList();
        return attendanceList;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON mark Attendance API: $e");
      throw "$e";
    }
  }
}
