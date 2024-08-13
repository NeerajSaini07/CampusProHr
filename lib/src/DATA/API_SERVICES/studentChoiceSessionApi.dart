import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';
import 'package:campus_pro/src/DATA/MODELS/assignTeacherModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class StudentChoiceSessionApi {
  Future<String> studentChoiceSession(Map<String, String?> sessionData) async {
    print("StudentChoiceSession before API: $sessionData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.studentChoiceSessionApi),
        body: sessionData,
        headers: headers,
        encoding: encoding,
      );

      print("StudentChoiceSession Status Code: ${response.statusCode}");
      print("StudentChoiceSession API Body: ${response.body}");

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

      if (response.statusCode == 200) {
        final myClass = respMap['Data'][0]['ClassIDs'] as String;
        return myClass;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON StudentChoiceSession API: $e");
      throw "$e";
    }
  }
}
