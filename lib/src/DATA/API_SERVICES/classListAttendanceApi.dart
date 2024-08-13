import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/classListAttendanceModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class ClassListAttendanceApi {
  Future<List<ClassListAttendanceModel>> getClass(
      Map<String, String?> classList) async {
    print(" classList before API: $classList");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.getClassAttendanceReportApi),
        body: classList,
        headers: headers,
        encoding: encoding,
      );

      print(" classList Status Code: ${response.statusCode}");
      print(" classList API Body: ${response.body}");

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      List<dynamic> respMap = json.decode(response.body);
      print("Get  classList Response from API: $respMap");

      if (response.statusCode == 200) {
        // if (respMap["Data"][0]["AuthCheck"] == "Failed") {
        //   throw SOMETHING_WENT_WRONG;
        // } else {
        final classList =
            (respMap).map((e) => ClassListAttendanceModel.fromJson(e)).toList();
        return classList;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON  ClassList API: $e");
      throw "$e";
    }
  }
}
