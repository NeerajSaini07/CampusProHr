import 'dart:convert';
import 'dart:io';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class ChangePasswordStudentApi {
  Future<String> changePassword(Map<String, String?> requestPayload) async {
    print(" ChangePasswordStudentApi before API: $requestPayload");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.changePasswordApi),
        body: requestPayload,
        headers: headers,
        encoding: encoding,
      );
      print(" ChangePassword Status Code: ${response.statusCode}");
      print(" ChangePassword API Body: ${response.body}");
      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      Map<String, dynamic> respMap = json.decode(response.body);

      print("Change password Response from API: $respMap");

      if (response.statusCode == 200) {
        // if (respMap['Data'][0]['message'] == "Success") {
        //   return true;
        // }
        return respMap['Data'][0]['message'];
      }

      throw respMap['Data'][0]['message'] as String;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON  ChangePasswordStudentApi API: $e");
      throw "$e";
    }
  }
}
