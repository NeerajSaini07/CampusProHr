import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/yearSessionListExamAnalysisModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class YearSessionListExamAnalysisApi {
  Future<List<YearSessionListExamAnalysisModel>> yearSessionListExamAnalysis(
      Map<String, String?> yearData) async {
    print("YearSessionListExamAnalysis before API: $yearData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.yearSessionListExamAnalysisApi),
        body: yearData,
        headers: headers,
        encoding: encoding,
      );

      print("YearSessionListExamAnalysis Status Code: ${response.statusCode}");
      print("YearSessionListExamAnalysis API Body: ${response.body}");

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
      print("YearSessionListExamAnalysis Response from API: $respMap");

      if (response.statusCode == 200) {
        final yearData = (respMap['Data'][0] as List)
            .map((e) => YearSessionListExamAnalysisModel.fromJson(e))
            .toList();

        return yearData;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON YearSessionListExamAnalysis API: $e");
      throw "$e";
    }
  }
}
