import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';

class AssignClassTeacherAdminApi {
  Future<String> assignClassTeacher(Map<String, String?> request) async {
    try {
      http.Response response = await http.post(
          Uri.parse(ApiEndpoints.saveClassTeacherAdmin),
          body: request,
          headers: headers,
          encoding: encoding);

      print('status of save class teacher api ${response.statusCode}');
      print('body of save class teacher api ${response.body}');

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }
      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }
      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      Map<String, dynamic> respMap = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (respMap['Data'][0] == "Teacher Assigned...") {
          return 'Success';
        }
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print('Error on save class teacher api $e');
      throw e;
    }
  }
}
