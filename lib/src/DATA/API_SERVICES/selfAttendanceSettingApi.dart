import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';
import 'package:campus_pro/src/DATA/MODELS/assignTeacherModel.dart';
import 'package:campus_pro/src/DATA/MODELS/selfAttendanceSettingModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class SelfAttendanceSettingApi {
  Future<bool> selfAttendanceSetting(Map<String, String?> schoolData) async {
    print("SelfAttendanceSetting before API: $schoolData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.selfAttendanceSettingApi),
        body: schoolData,
        headers: headers,
        encoding: encoding,
      );

      print("SelfAttendanceSetting Status Code: ${response.statusCode}");
      print("SelfAttendanceSetting API Body: ${response.body}");

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
        final status = respMap['Data']['SelfAttendance'] as String;
        if (status == '1') {
          return true;
        } else {
          return false;
        }
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON SelfAttendanceSetting API: $e");
      throw "$e";
    }
  }
}
