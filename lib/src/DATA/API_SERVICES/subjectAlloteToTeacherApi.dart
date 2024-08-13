import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class SubjectAlloteToTeacherApi {
  Future<String> alloteSubject(Map<String, String?> request) async {
    try {
      http.Response response = await http.post(
          Uri.parse(ApiEndpoints.alloteSubjectAdmin),
          body: request,
          encoding: encoding,
          headers: headers);

      print('status of allotte subject api ${response.statusCode}');
      print('body of allotte subject api ${response.body}');

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }
      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }
      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      String respMap = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (respMap == "Done") {
          return "Success";
        } else if (respMap == "Please Select at least one Section") {
          return "Please Select at least one Section";
        }
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print('error on allote subject api $e');
      throw e;
    }
  }
}
