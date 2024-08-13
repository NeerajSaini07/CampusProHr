import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/studentListMeetingModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class StudentListMeetingApi {
  Future<List<StudentListMeetingModel>> studentListMeeting(
      Map<String, String?> stuData) async {
    print("StudentListMeeting before API: $stuData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.studentListMeetingApi),
        body: stuData,
        headers: headers,
        encoding: encoding,
      );

      print("StudentListMeeting Status Code: ${response.statusCode}");
      print("StudentListMeeting API Body: ${response.body}");

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
        final studentList = (respMap['Data'][0] as List)
            .map((e) => StudentListMeetingModel.fromJson(e))
            .toList();
        return studentList;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON StudentListMeeting API: $e");
      throw "$e";
    }
  }
}
