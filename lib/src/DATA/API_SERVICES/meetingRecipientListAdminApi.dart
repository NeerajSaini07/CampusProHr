import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/meetingRecipientListAdminModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class MeetingRecipientListAdminApi {
  Future<List<MeetingRecipientListAdminModel>> meetingStatus(
      Map<String, String?> meetings) async {
    print("MeetingRecipientListAdmin before API: $meetings");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.meetingStatusListAdminApi),
        body: meetings,
        headers: headers,
        encoding: encoding,
      );

      print("MeetingRecipientListAdmin Status Code: ${response.statusCode}");
      print("MeetingRecipientListAdmin API Body: ${response.body}");

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      final respMap = json.decode(response.body);
      print("MeetingRecipientListAdmin Response from API: $respMap");

      if (response.statusCode == 200) {
        final meetingData = (respMap["Data"] as List)
            .map((e) => MeetingRecipientListAdminModel.fromJson(e))
            .toList();
        return meetingData;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON MeetingRecipientListAdmin API: $e");
      throw "$e";
    }
  }
}
