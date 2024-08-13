import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class StudentFeeFineApi {
  Future<String> studentFeeFine(Map<String, String?> studentFeeFineData) async {
    print("StudentFeeFine before API: $studentFeeFineData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.studentFeeFineApi),
        body: studentFeeFineData,
        headers: headers,
        encoding: encoding,
      );

      print("StudentFeeFine Status Code: ${response.statusCode}");
      print("StudentFeeFine API Body: ${response.body}");

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      final respMap = jsonDecode(response.body);

      print("Get StudentFeeFine Response from API: $respMap");

      if (response.statusCode == 200) {
        final studentFine = respMap as double;
        print("StudentFeeFine Check: $studentFine");
        return studentFine.toString();
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON StudentFeeFine API: $e");
      throw "$e";
    }
  }
}
