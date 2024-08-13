import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class SendSmsAdminApi {
  Future<String> submitSms(Map<String, String?> request) async {
    try {
      http.Response response = await http.post(Uri.parse(ApiEndpoints.submitSmsAdmin),
          body: request, encoding: encoding, headers: headers);

      print('status of send sms ${response.statusCode}');
      print('body of send sms ${response.body}');

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }
      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }
      Map<String, dynamic> respMap = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (respMap['Data'][0] == 'Message Sent') {
          return 'Success';
        }
      }
      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print('error on send sms $e');
      throw e;
    }
  }
}
