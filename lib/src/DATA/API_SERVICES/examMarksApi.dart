import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/examMarksModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class ExamMarksApi {
  Future<List<ExamMarksModel>> examMarks(Map<String, String?> examData) async {
    print("ExamMarks before API: $examData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.examMarksApi),
        body: examData,
        headers: headers,
        encoding: encoding,
      );

      print("ExamMarks Status Code: ${response.statusCode}");
      print("ExamMarks API Body: ${response.body}");

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
        final examMarksList = (respMap['Data'] as List)
            .map((e) => ExamMarksModel.fromJson(e))
            .toList();
        return examMarksList;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON ExamMarks API: $e");
      throw "$e";
    }
  }
}
