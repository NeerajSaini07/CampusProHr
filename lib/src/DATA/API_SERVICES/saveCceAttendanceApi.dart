import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:http/http.dart' as http;

class SaveCceAttendanceApi {
  Future<String> saveCceAttendance(Map<String, String?> request) async {
    try {
      // http.Response response = await http.post(
      //     Uri.parse(Api.saveCceAttendanceClassApi),
      //     body: request,
      //     encoding: encoding,
      //     headers: headers);

      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.saveCceAttendanceClassApi),
        body: request,
        headers: headers,
        encoding: encoding,
      );

      print('status of save cce attendance ${response.statusCode}');
      print('body of save cce attendance ${response.body}');

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }
      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }
      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      var respMap = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (respMap == "Attendance Saved") {
          return 'Success';
        }
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print('error on save cce attendance $e');
      throw e;
    }
  }
}
