import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/classListAttendanceReportModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class ClassListAttendanceReportApi {
  Future<List<ClassListAttendanceReportModel>> getClass(
      Map<String, String?> classList) async {
    print(" classList before API: $classList");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.ClassAttendanceReportApi),
        body: classList,
        headers: headers,
        encoding: encoding,
      );

      print("ClassListAttendanceReport Status Code: ${response.statusCode}");
      print("ClassListAttendanceReport API Body: ${response.body}");

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      List<dynamic> respMap = json.decode(response.body);
      print("ClassListAttendanceReport Response from API: $respMap");

      if (response.statusCode == 200) {
        // if (respMap["Data"][0]["AuthCheck"] == "Failed") {
        //   throw SOMETHING_WENT_WRONG;
        // } else {
        final classList = (respMap)
            .map((e) => ClassListAttendanceReportModel.fromJson(e))
            .toList();
        return classList;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON ClassListAttendanceReport API: $e");
      throw "$e";
    }
  }
}
