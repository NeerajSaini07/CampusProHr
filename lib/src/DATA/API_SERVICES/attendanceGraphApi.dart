import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/attendanceGraphModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class AttendanceGraphApi {
  Future<List<AttendanceGraphModel>> attendanceGraph(
      Map<String, String?> requestPayload) async {
    print("AttendanceGraph before API: $requestPayload");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.attendanceGraphApi),
        body: requestPayload,
        headers: headers,
        encoding: encoding,
      );

      print("AttendanceGraph Status Code: ${response.statusCode}");
      print("AttendanceGraph API Body: ${response.body}");

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
      print("Get AttendanceGraph Response from API: $respMap");

      if (response.statusCode == 200) {
        final attendanceData = (respMap['Data'] as List)
            .map((e) => AttendanceGraphModel.fromJson(e))
            .toList();
        return attendanceData;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON AttendanceGraph API: $e");
      throw "$e";
    }
  }
}
