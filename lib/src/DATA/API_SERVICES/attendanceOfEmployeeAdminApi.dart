import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/attendanceOfEmployeeAdminModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';

import 'package:http/http.dart' as http;

class AttendanceOfEmployeeAdminApi {
  Future<List<AttendanceOfEmployeeAdminModel>> attendanceOfEmployee(
      Map<String, String?> requestPayload) async {
    print("attendance employee before API: $requestPayload");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.getAttendanceofEmployeeAdminApi),
        body: requestPayload,
        headers: headers,
        encoding: encoding,
      );
      print("attendance employee Status Code: ${response.statusCode}");
      print("attendance employee API Body: ${response.body}");

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      //Map<String, dynamic> respMap = json.decode(response.body);
      List<dynamic> respMap = json.decode(response.body);
      print("Get  attendanceList employee Response from API: $respMap");
      // List<dynamic> respMap1 = respMap['Data'];
      // print("Get  attendanceList Response from API: $respMap1");
      if (response.statusCode == 200) {
        final attendanceList = (respMap)
            .map((e) => AttendanceOfEmployeeAdminModel.fromJson(e))
            .toList();
        return attendanceList;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON  Attendance List API: $e");
      throw "$e";
    }
  }
}
