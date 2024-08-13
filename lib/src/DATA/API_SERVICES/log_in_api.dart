import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:http/http.dart' as http;

import '../../UTILS/api_endpoints.dart';

class LogInApi {
  Future<bool> logIn(Map<String, String> loginData) async {
    print("loginData before API: $loginData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.loginApi),
        body: loginData,
        headers: headers,
        encoding: encoding,
      );

      print("Login API Status Code: ${response.statusCode}");
      print("Login API Body: ${response.body}");

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 503) {
        throw UnderConstruction;
      }

      Map<String, dynamic> respMap = json.decode(response.body);
      print("Login Response from API: $respMap");
      final logInData = respMap['Data'][0];
      String status = logInData['Validated'] as String;
      if (status.toUpperCase() == "Y") {
        String uid = (logInData['OUserid']).toString();
        String loginToken = logInData['Token'] as String;
        int isMasterPwd = logInData['IsMasterPwd'];
        await UserUtils.cacheId(uid);
        await UserUtils.cacheLoginToken(loginToken);
        await UserUtils.cacheIsMasterPwd(isMasterPwd);
        return true;
      }

      if (status.toUpperCase() == "N") {
        throw respMap['Data'][0]['ValidateMessage'] as String;
      }

      throw respMap['message'] as String;
    } on SocketException catch (e) {
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON LOGIN API: $e");
      throw "$e";
    }
  }
}
