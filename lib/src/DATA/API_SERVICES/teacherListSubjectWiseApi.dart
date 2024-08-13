import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/teacherListSubjectWiseModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class TeacherListSubjectWiseApi {
  Future<List<TeacherListSubjectWiseModel>> teacherList(
      Map<String, String?> teacherData) async {
    print("TeacherList SubjectWise before API: $teacherData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.teacherListSubjectWise),
        body: teacherData,
        headers: headers,
        encoding: encoding,
      );

      print("TeacherList SubjectWise Status Code: ${response.statusCode}");
      print("TeacherList SubjectWise API Body: ${response.body}");

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
        final teacherList = (respMap['Data'][0] as List)
            .map((e) => TeacherListSubjectWiseModel.fromJson(e))
            .toList();
        return teacherList;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON TeacherList SubjectWise API: $e");
      throw "$e";
    }
  }
}
