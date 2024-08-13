import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class EmailCheckScheduleMeetingApi {
  Future<String> emailData(Map<String, String?> data) async {
    print("EmailCheckScheduleMeeting before API: $data");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.emailCheckScheduledMeetingApi),
        body: data,
        headers: headers,
        encoding: encoding,
      );

      print("EmailCheckScheduleMeeting Status Code: ${response.statusCode}");
      print("EmailCheckScheduleMeeting API Body: ${response.body}");

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      // final respMap = json.decode(response.body);

      if (response.statusCode == 200) {
        final emailId = '';
        return emailId;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON EmailCheckScheduleMeeting API: $e");
      throw "$e";
    }
  }
}
