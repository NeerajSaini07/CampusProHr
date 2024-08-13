import 'dart:io';

import 'package:campus_pro/src/DATA/MODELS/classListModel.dart';
import 'dart:convert';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class ClassListApi {
  Future<List<ClassListModel>> classList(
      Map<String, String?> requestPayload) async {
    print(" ClassList before API: $requestPayload");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.classListApi),
        body: requestPayload,
        headers: headers,
        encoding: encoding,
      );

      print(" ClassList Status Code: ${response.statusCode}");
      print(" ClassList API Body: ${response.body}");

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      Map<String, dynamic> respMap = json.decode(response.body);
      print("Get ClassList Response from API: $respMap");

      final classesList = (respMap["Data"] as List)
          .map((e) => ClassListModel.fromJson(e))
          .toList();
      return classesList;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON ClassList API: $e");
      throw "$e";
    }
  }
}
