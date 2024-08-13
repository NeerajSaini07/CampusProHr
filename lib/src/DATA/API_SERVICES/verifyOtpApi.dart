import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:http/http.dart' as http;

import '../../UTILS/api_endpoints.dart';

class VerifyOtpApi {
  Future<bool> verifyOtp(Map<String, String?> otpData) async {
    print("VerifyOtp before API: $otpData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.verifyOtpApi),
        body: otpData,
        headers: headers,
        encoding: encoding,
      );

      print("VerifyOtp API Status Code: ${response.statusCode}");
      print("VerifyOtp API Body: ${response.body}");

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
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
      print("ERROR ON VerifyOtp API: $e");
      throw "$e";
    }
  }
}
