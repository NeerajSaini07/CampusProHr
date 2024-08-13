import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/getExamTypeAdminModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class GetExamTypeAdminApi {
  Future<List<GetExamTypeAdminModel>> getExam(
      Map<String, String?> request) async {
    try {
      http.Response response = await http.post(
          Uri.parse(ApiEndpoints.getExamForExamMarks),
          body: request,
          encoding: encoding,
          headers: headers);

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }
      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }
      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      print('status of get exam type admin : ${response.statusCode}');
      print('body of get exam type admin : ${response.body}');

      Map<String, dynamic> respMap = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final data = (respMap['Data'][0] as List)
            .map((e) => GetExamTypeAdminModel.fromJson(e))
            .toList();
        return data;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print('error on get exam type admin $e}');
      throw e;
    }
  }
}
