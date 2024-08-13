import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/studentRemarkListModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class StudentRemarkListApi {
  Future<List<StudentRemarkListModel>> studentRemark(
      Map<String, String?> remarkData) async {
    print("StudentRemarkList before API: $remarkData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.studentRemarkListApi),
        body: remarkData,
        headers: headers,
        encoding: encoding,
      );

      print("StudentRemarkList Status Code: ${response.statusCode}");
      print("StudentRemarkList API Body: ${response.body}");

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
      print("StudentRemarkList Response from API: $respMap");

      if (response.statusCode == 200) {
        final remarkList = (respMap as List)
            .map((e) => StudentRemarkListModel.fromJson(e))
            .toList();
        return remarkList;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON StudentRemarkList API: $e");
      throw "$e";
    }
  }
}
