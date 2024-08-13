import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class SaveSubjectEnrichmentDetailsApi {
  Future<String> saveSubjectDetail(Map<String, String?> request) async {
    try {
      http.Response response = await http.post(
          Uri.parse(ApiEndpoints.saveSubjectEnchDetailApi),
          body: request,
          encoding: encoding,
          headers: headers);

      print('status of save subject api ${response.statusCode}');
      print('body of save subject api ${response.body}');

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      var respMap = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (respMap == "Grade Deleted") {
          return "Grade Deleted";
        } else if (respMap == "Grade Saved" || respMap == "Grade Updated") {
          return "Grade Saved/Updated";
        }
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print('error on save subject api $e');
      throw e;
    }
  }
}
