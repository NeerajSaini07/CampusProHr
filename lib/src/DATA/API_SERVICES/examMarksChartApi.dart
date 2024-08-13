import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/examMarksChartModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class ExamMarksChartApi {
  Future<List<ExamMarksChartModel>> examMarksChart(
      Map<String, String?> examChartData) async {
    print("ExamMarksChart before API: $examChartData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.examMarksChartApi),
        body: examChartData,
        headers: headers,
        encoding: encoding,
      );

      print("ExamMarksChart Status Code: ${response.statusCode}");
      print("ExamMarksChart API Body: ${response.body}");

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
        final examMarksChartList = (respMap['Data'] as List)
            .map((e) => ExamMarksChartModel.fromJson(e))
            .toList();
        return examMarksChartList;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON examMarksChart API: $e");
      throw "$e";
    }
  }
}
