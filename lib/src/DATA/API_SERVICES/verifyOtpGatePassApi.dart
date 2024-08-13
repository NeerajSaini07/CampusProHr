import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class VerifyOtpGatePassApi {
  Future<String> verifyOtp(Map<String, String?> paylaod) async {
    try {
      http.Response response = await http.post(
          Uri.parse(ApiEndpoints.gatePassVerifyOtpApi),
          body: paylaod,
          encoding: encoding,
          headers: headers);

      print("status of verify otp api ${response.statusCode}");
      print("body of vertify otp api ${response.body}");

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
        return respMap;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("error of verify otp $e");
      throw e;
    }
  }
}
