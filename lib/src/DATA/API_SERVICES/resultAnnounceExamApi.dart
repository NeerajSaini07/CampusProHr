import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/resultAnnounceClassModel.dart';
import 'package:campus_pro/src/DATA/MODELS/resultAnnounceExamModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';

import 'package:http/http.dart' as http;

class ResultAnnounceExamApi {
  Future<List<ResultAnnounceExamModel>> getExam(
      Map<String, dynamic> request) async {
    print('Exam request before api $request');

    try {
      http.Response response = await http.post(
          Uri.parse(ApiEndpoints.getResultAnnounceExamApi),
          body: request,
          headers: headers,
          encoding: encoding);

      print("Exam Status Code: ${response.statusCode}");
      print("Exam API Body: ${response.body}");

      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }
      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }
      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      Map<String, dynamic> respMap = jsonDecode(response.body);
      print('Response from api $respMap');
      if (response.statusCode == 200) {
        final examList = (respMap['Data'][0] as List)
            .map((e) => ResultAnnounceExamModel.fromJson(e))
            .toList();
        return examList;
      }
      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("Error on Exam api $e");
      throw e;
    }
  }
}
