import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/examAnalysisLineChartModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class ExamAnalysisLineChartApi {
  Future<ExamAnalysisLineChartModel> examAnalysisLineChart(
      Map<String, String?> examData) async {
    print("ExamAnalysisLineChart before API: $examData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.examAnalysisLineChartApi),
        body: examData,
        headers: headers,
        encoding: encoding,
      );

      print("ExamAnalysisLineChart Status Code: ${response.statusCode}");
      print("ExamAnalysisLineChart API Body: ${response.body}");

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
      print("ExamAnalysisLineChart Response from API: $respMap");

      if (response.statusCode == 200) {
        final lineChartData =
            ExamAnalysisLineChartModel.fromJson(respMap["Data"][0][0]);
        return lineChartData;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON ExamAnalysisLineChart API: $e");
      throw "$e";
    }
  }
}
