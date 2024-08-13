import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class SendStudentDetailsApi {
  Future<bool> sendDetail(Map<String, String?> sendData) async {
    print("SendStudentDetails before API: $sendData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.sendStudentDetailsApi),
        body: sendData,
        headers: headers,
        encoding: encoding,
      );

      print("SendStudentDetails Status Code: ${response.statusCode}");
      print("SendStudentDetails API Body: ${response.body}");

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
      print("SendStudentDetails Response from API: $respMap");

      if (response.statusCode == 200) {
        return true;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON SendStudentDetails API: $e");
      throw "$e";
    }
  }
}
