import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/examsListExamAnalysisModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class ExamsListExamAnalysisApi {
  Future<List<ExamsListExamAnalysisModel>> examsListExamAnalysis(
      Map<String, String?> examData) async {
    print("ExamsListExamAnalysis before API: $examData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.examsListExamAnalysisApi),
        body: examData,
        headers: headers,
        encoding: encoding,
      );

      print("ExamsListExamAnalysis Status Code: ${response.statusCode}");
      print("ExamsListExamAnalysis API Body: ${response.body}");

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      final respMap = json.decode(response.body);
      print("ExamsListExamAnalysis Response from API: $respMap");

      if (response.statusCode == 200) {
        final examList = (respMap["Data"][0] as List)
            .map((e) => ExamsListExamAnalysisModel.fromJson(e))
            .toList();
        return examList;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON ExamsListExamAnalysis API: $e");
      throw "$e";
    }
  }
}
