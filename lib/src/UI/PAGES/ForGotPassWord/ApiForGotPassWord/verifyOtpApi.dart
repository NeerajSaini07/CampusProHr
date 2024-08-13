import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';

class VerifyOtpApiForgotPassword {
  Future verifyOtp({Map<String, String>? payload}) async {
    try {
      http.Response response = await http.post(
          Uri.parse(ApiEndpoints.baseUrl + "VerifyOtp"),
          encoding: encoding,
          headers: headers,
          body: payload);

      print("status code of verify otp api ${response.statusCode}");
      print("Body of check verify otp api ${response.body}");

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
      throw e;
    } catch (e) {
      print("error on verify otp api $e");
      throw e;
    }
  }
}
