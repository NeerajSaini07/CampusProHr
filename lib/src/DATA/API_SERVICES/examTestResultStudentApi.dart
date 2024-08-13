import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/examTestResultStudentModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class ExamTestResultStudentApi {
  Future<List<ExamTestResultStudentModel>> resultData(
      Map<String, String?> requestPayload) async {
    print("ExamTestReultStudent before API: $requestPayload");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.examMarksApi),
        body: requestPayload,
        headers: headers,
        encoding: encoding,
      );

      print("ExamTestReultStudent Status Code: ${response.statusCode}");
      print("ExamTestReultStudent API Body: ${response.body}");

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
        final resultList = (respMap['Data'] as List)
            .map((e) => ExamTestResultStudentModel.fromJson(e))
            .toList();
        return resultList;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON ExamTestReultStudent API: $e");
      throw "$e";
    }
  }
}
