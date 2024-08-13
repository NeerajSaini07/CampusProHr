import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/checkEmailRegistrationModel.dart';
import 'package:http/http.dart' as http;

import '../../UTILS/api_endpoints.dart';

class CheckEmailRegistrationApi {
  Future<CheckEmailRegistrationModel> checkEmailRegistration(
      Map<String, String?> emailData) async {
    print("CheckEmailRegistration before API: $emailData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.checkEmailRegistrationApi),
        body: emailData,
        headers: headers,
        encoding: encoding,
      );

      print("CheckEmailRegistration API Status Code: ${response.statusCode}");
      print("CheckEmailRegistration API Body: ${response.body}");

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      Map<String, dynamic> respMap = json.decode(response.body);

      if (response.statusCode == 200) {
        final emailResponse = CheckEmailRegistrationModel.fromJson(respMap);
        return emailResponse;
      }

      throw respMap['message'] as String;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON CheckEmailRegistration API: $e");
      throw "$e";
    }
  }
}
