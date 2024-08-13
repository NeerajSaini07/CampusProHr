import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/getExamMarksForTeacherModel.dart';
import 'package:http/http.dart' as http;
import 'package:campus_pro/src/UTILS/api_endpoints.dart';

class GetExamMarksForTeacherApi {
  Future<List<GetExamMarksForTeacherModel>> getExamMarks(
      Map<String, String?> request) async {
    print("GetExamMarksForTeacher data before Api : $request");
    try {
      http.Response response = await http.post(
          Uri.parse(ApiEndpoints.getExamMarksForAdmin),
          body: request,
          headers: headers,
          encoding: encoding);

      print('GetExamMarksForTeacher Api Status Code : ${response.statusCode}');
      print('GetExamMarksForTeacher API Body : ${response.body}');

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      List<dynamic> respMap = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final data = (respMap)
            .map((e) => GetExamMarksForTeacherModel.fromJson(e))
            .toList();
        return data;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print('Error on exam marks admin $e}');
      throw e;
    }
  }
}
