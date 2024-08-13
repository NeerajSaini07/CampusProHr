import 'dart:convert';
import 'dart:io';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/subjectExamMarkModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class SubjectExamMarksApi {
  Future<List<SubjectExamMarksModel>> subjectData(
      Map<String, String?> requestPayload) async {
    print("SubjectExamMarks before API: $requestPayload");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.subjectExamMarkApi),
        body: requestPayload,
        headers: headers,
        encoding: encoding,
      );

      print("SubjectExamMarks Status Code: ${response.statusCode}");
      print("SubjectExamMarks API Body: ${response.body}");

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
      print("SubjectExamMarks Response from API: $respMap");

      if (response.statusCode == 200) {
        final subjectList = (respMap as List)
            .map((e) => SubjectExamMarksModel.fromJson(e))
            .toList();
        return subjectList;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON SubjectExamMarks API: $e");
      throw "$e";
    }
  }
}
