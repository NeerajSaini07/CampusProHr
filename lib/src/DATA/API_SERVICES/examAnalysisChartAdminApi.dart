import 'dart:convert';
import 'dart:io';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/examAnalysisChartAdminModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class ExamAnalysisChartAdminApi {
  Future<List<ExamAnalysisChartAdminModel>> examAnalysisChartAdminData(
      Map<String, String?> requestPayload) async {
    print("ExamAnalysisChartAdmin before API: $requestPayload");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.examAnalysisChartAdminApi),
        body: requestPayload,
        headers: headers,
        encoding: encoding,
      );

      print("ExamAnalysisChartAdmin Status Code: ${response.statusCode}");
      print("ExamAnalysisChartAdmin API Body: ${response.body}");

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
      print("ExamAnalysisChartAdmin Response from API: $respMap");

      if (response.statusCode == 200) {
        final data = (respMap['Data'] as List)
            .map((e) => ExamAnalysisChartAdminModel.fromJson(e))
            .toList();
        return data;
      }
      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON ExamAnalysisChartAdmin API: $e");
      throw "$e";
    }
  }
}
