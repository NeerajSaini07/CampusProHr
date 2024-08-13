import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/checkEmailRegistrationModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:http/http.dart' as http;

import '../../UTILS/api_endpoints.dart';

class UpdateEmailApi {
  Future<bool> updateEmail(Map<String, String?> emailData) async {
    print("UpdateEmail before API: $emailData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.updateEmailApi),
        body: emailData,
        headers: headers,
        encoding: encoding,
      );

      print("UpdateEmail API Status Code: ${response.statusCode}");
      print("UpdateEmail API Body: ${response.body}");

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      Map<String, dynamic> respMap = json.decode(response.body);

      if (response.statusCode == 200) {
        final status = respMap["Data"][0]["Status"] as String;
        if (status.toLowerCase() == 'true') return true;
      }

      throw respMap['message'] as String;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON UpdateEmail API: $e");
      throw "$e";
    }
  }
}
