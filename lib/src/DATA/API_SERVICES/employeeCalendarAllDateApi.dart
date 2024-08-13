import 'dart:convert';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/EmployeeCalendarAllDateModal.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class EmployeeCalendarAllDateApi {
  Future<List<EmployeeCalendarAllDateModal>> getEmployeeCalendarApi(
      Map<String, String?> payload) async {
    try {
      http.Response response = await http.post(
          Uri.parse(ApiEndpoints.employeeCalendarAllDateApi),
          body: payload,
          headers: headers,
          encoding: encoding);

      print("status code of employee calendar api ${response.statusCode}");
      print("body of employee calendar api ${response.body}");

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      final respMap = jsonDecode(response.body);

      if (response.statusCode == 200) {
        var data = (respMap["Data"]["Table"] as List)
            .map((e) => EmployeeCalendarAllDateModal.fromJson(e))
            .toList();
        return data;
      }

      throw SOMETHING_WENT_WRONG;
    } catch (e) {
      print("error on employee calendar $e");
      if (e == "false") {
        return [EmployeeCalendarAllDateModal(id: "-1")];
      }
      return [];
    }
  }
}
