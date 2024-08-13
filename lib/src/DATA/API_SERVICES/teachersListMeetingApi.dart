import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/teachersListMeetingModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class TeachersListMeetingApi {
  Future<List<TeachersListMeetingModel>> teacherList(
      Map<String, String?> teacherData) async {
    print("TeacherList before API: $teacherData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.teachersListMeetingApi),
        body: teacherData,
        headers: headers,
        encoding: encoding,
      );

      print("TeacherList Status Code: ${response.statusCode}");
      print("TeacherList API Body: ${response.body}");

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
        final teacherList = (respMap as List)
            .map((e) => TeachersListMeetingModel.fromJson(e))
            .toList();
        return teacherList;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON TeacherList API: $e");
      throw "$e";
    }
  }
}
