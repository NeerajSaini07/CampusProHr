import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/classListHwStatusAdminModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class ClassListHwStatusAdminApi {
  Future<List<ClassListHwStatusAdminModel>> getClassList(
      Map<String, String?> classList) async {
    print(" studentList before API: $classList");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.getClassListHwStatusAdmin),
        body: classList,
        headers: headers,
        encoding: encoding,
      );

      print(" studentList Status Code: ${response.statusCode}");
      print(" studentList API Body: ${response.body}");

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      List<dynamic> respMap = json.decode(response.body);
      print("Get  studentList Response from API: $respMap");

      if (response.statusCode == 200) {
        // if (respMap["Data"][0]["AuthCheck"] == "Failed") {
        //   throw SOMETHING_WENT_WRONG;
        // } else {
        final classList = (respMap)
            .map((e) => ClassListHwStatusAdminModel.fromJson(e))
            .toList();
        return classList;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON  studentList API: $e");
      throw "$e";
    }
  }
}
