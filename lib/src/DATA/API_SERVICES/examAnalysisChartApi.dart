import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/examAnalysisChartModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class ExamAnalysisChartApi {
  Future<List<ExamAnalysisChartModel>> examAnalysisChart(
      Map<String, String?> examData) async {
    print("ExamAnalysisChart before API: $examData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.examAnalysisChartApi),
        body: examData,
        headers: headers,
        encoding: encoding,
      );

      print("ExamAnalysisChart Status Code: ${response.statusCode}");
      print("ExamAnalysisChart API Body: ${response.body}");

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
      print("ExamAnalysisChart Response from API: $respMap");

      if (response.statusCode == 200) {
        final chartData = (respMap["Data"][0] as List)
            .map((e) => ExamAnalysisChartModel.fromJson(e))
            .toList();

        return chartData;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON ExamAnalysisChart API: $e");
      throw "$e";
    }
  }
}
