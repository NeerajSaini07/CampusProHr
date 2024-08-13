import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:http/http.dart' as http;

import '../../UTILS/api_endpoints.dart';

class ForgotPasswordApi {
  Future<bool> forgotPassword(Map<String, String?> passwordData) async {
    print("ForgotPassword before API: $passwordData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.forgotPasswordApi),
        body: passwordData,
        headers: headers,
        encoding: encoding,
      );

      print("ForgotPassword API Status Code: ${response.statusCode}");
      print("ForgotPassword API Body: ${response.body}");

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      Map<String, dynamic> respMap = json.decode(response.body);

      if (response.statusCode == 200) {
        return true;
      }

      throw respMap['message'] as String;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON ForgotPassword API: $e");
      throw "$e";
    }
  }
}
