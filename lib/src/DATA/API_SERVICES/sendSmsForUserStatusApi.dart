import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';

class SendSmsForUserStatusApi {
  Future<String> sendSms(Map<String, String?> request) async {
    try {
      http.Response response = await http.post(
          Uri.parse(ApiEndpoints.managerUSerSendSmsApi),
          body: request,
          encoding: encoding,
          headers: headers);

      print("status code of send sms api manage user ${response.statusCode} ");
      print("body of send sms api manage user ${response.body}");

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }
      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }
      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      if (response.statusCode == 200) {
        return "Success";
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("error on send sms api manager user $e");
      throw e;
    }
  }
}
