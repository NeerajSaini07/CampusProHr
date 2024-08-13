import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/staffMeetingsEmployeeDashboardModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class StaffMeetingsEmployeeDashboardApi {
  Future<List<StaffMeetingsEmployeeDashboardModel>> onlineMeetings(
      Map<String, String?> meetings) async {
    print("StaffMeetingsEmployeeDashboard before API: $meetings");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.staffMeetingsEmployeeDashboardApi),
        body: meetings,
        headers: headers,
        encoding: encoding,
      );

      print(
          "StaffMeetingsEmployeeDashboard Status Code: ${response.statusCode}");
      print("StaffMeetingsEmployeeDashboard API Body: ${response.body}");

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
      print("StaffMeetingsEmployeeDashboard Response from API: $respMap");

      if (response.statusCode == 200) {
        final meetingData = (respMap["Data"][0] as List)
            .map((e) => StaffMeetingsEmployeeDashboardModel.fromJson(e))
            .toList();
        return meetingData;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON StaffMeetingsEmployeeDashboard API: $e");
      throw "$e";
    }
  }
}
