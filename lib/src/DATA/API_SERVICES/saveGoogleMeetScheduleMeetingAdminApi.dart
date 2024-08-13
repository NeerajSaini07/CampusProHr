import 'dart:convert';
import 'dart:io';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:http/http.dart' as http;
import '../../UTILS/api_endpoints.dart';

class SaveGoogleMeetScheduleMeetingAdminApi {
  Future<bool> scheduleMeetingAdmin(Map<String, String?> meetingData) async {
    print(
        "SaveGoogleMeetScheduleMeetingAdmin data before API: ${meetingData['MeetingLink']} & $meetingData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.saveGoogleMeetScheduleMeetingAdminApi),
        body: meetingData,
        headers: headers,
        encoding: encoding,
      );

      print(
          "SaveGoogleMeetScheduleMeetingAdmin status code on API: ${response.statusCode}");
      print("SaveGoogleMeetScheduleMeetingAdmin body on API: ${response.body}");

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      final respMap = json.decode(response.body);
      print("SaveGoogleMeetScheduleMeetingAdmin Response from API: $respMap");

      if (response.statusCode == 200) {
        return true;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON SaveGoogleMeetScheduleMeetingAdmin API: $e");
      throw "$e";
    }
  }
}
