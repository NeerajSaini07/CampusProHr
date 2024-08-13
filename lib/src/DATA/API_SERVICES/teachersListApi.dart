import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';
import 'package:campus_pro/src/DATA/MODELS/assignTeacherModel.dart';
import 'package:campus_pro/src/DATA/MODELS/teachersListModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class TeachersListApi {
  Future<List<TeachersListModel>> teacherList(
      Map<String, String?> teacherData) async {
    print("TeacherList before API: $teacherData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.teachersListApi),
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
        final teacherList = (respMap['Data'] as List)
            .map((e) => TeachersListModel.fromJson(e))
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
