import 'dart:io';

import 'package:campus_pro/src/DATA/MODELS/classListEnquiryModel.dart';
import 'dart:convert';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class ClassListEnquiryApi {
  Future<List<ClassListEnquiryModel>> classList(
      Map<String, String?> requestPayload) async {
    print(" ClassListEnquiry before API: $requestPayload");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.classListEnquiryApi),
        body: requestPayload,
        headers: headers,
        encoding: encoding,
      );

      print(" ClassListEnquiry Status Code: ${response.statusCode}");
      print(" ClassListEnquiry API Body: ${response.body}");

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
      print("ClassListEnquiry Response from API: $respMap");

      final classesList = (respMap as List)
          .map((e) => ClassListEnquiryModel.fromJson(e))
          .toList();
      return classesList;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON ClassListEnquiry API: $e");
      throw "$e";
    }
  }
}
