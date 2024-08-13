import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/getEmployeeOnlineClassCredentialsModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class GetEmployeeOnlineClassCredentialsApi {
  dynamic getValues(Map<String, String?> request, String mode) async {
    try {
      http.Response response = await http.post(
          Uri.parse(ApiEndpoints.getUserDetailCredentialApi),
          body: request,
          encoding: encoding,
          headers: headers);

      print('status of get employee sms meeting config ${response.statusCode}');
      print('body of get employee sms meeting config ${response.body}');

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
        if (mode == "0") {
          var data = (respMap["Data"] as List)
              .map((e) => GetEmployeeOnlineClassCredentialsModel.fromJson(e))
              .toList();
          return data;
        } else {
          return 'Success';
        }
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print('error on get employee sms meeting config $e');
      throw e;
    }
  }
}
