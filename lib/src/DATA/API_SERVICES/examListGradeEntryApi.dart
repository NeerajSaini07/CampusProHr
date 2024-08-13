import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/examListGradeEntryModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class ExamListGradeEntryApi {
  Future<List<ExamListGradeEntryModel>> gradeList(
      Map<String, String?> gradeData) async {
    print("ExamListGradeEntry before API: $gradeData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.examListGradeEntryApi),
        body: gradeData,
        headers: headers,
        encoding: encoding,
      );

      print("ExamListGradeEntry Status Code: ${response.statusCode}");
      print("ExamListGradeEntry API Body: ${response.body}");

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
        final gradeList = (respMap as List)
            .map((e) => ExamListGradeEntryModel.fromJson(e))
            .toList();
        return gradeList;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON ExamListGradeEntry API: $e");
      throw "$e";
    }
  }
}
