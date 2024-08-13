import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';

import 'package:campus_pro/src/DATA/MODELS/homeWorkStudentModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class HomeWorkStudentApi {
  Future<List<HomeWorkStudentModel>> homeWorkData(
      Map<String, String?> homeworkData) async {
    print("homeWorkStudentOnLoad before API: $homeworkData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.homeWorkStudent),
        body: homeworkData,
        headers: headers,
        encoding: encoding,
      );

      print(" homeWorkStudent Status Code: ${response.statusCode}");
      print(" homeWorkStudent API Body: ${response.body}");

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
      print("homeWorkStudent Response from API: $respMap");

      if (response.statusCode == 200) {
        final homeWorkList = (respMap["Data"] as List)
            .map((e) => HomeWorkStudentModel.fromJson(e))
            .toList();
        return homeWorkList;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON homeWorkStudent API: $e");
      throw "$e";
    }
  }
}
