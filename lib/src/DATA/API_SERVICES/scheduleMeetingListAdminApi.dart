import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/scheduleMeetingListAdminModel.dart';
import 'package:campus_pro/src/DATA/MODELS/subjectListMeetingModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class ScheduleMeetingListAdminApi {
  Future<List<ScheduleMeetingListAdminModel>> meetingList(
      Map<String, String?> meetingData) async {
    print("ScheduleMeetingListAdmin before API: $meetingData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.scheduledMeetingListAdminApi),
        body: meetingData,
        headers: headers,
        encoding: encoding,
      );

      print("ScheduleMeetingListAdmin Status Code: ${response.statusCode}");
      print("ScheduleMeetingListAdmin API Body: ${response.body}");

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

      if (response.statusCode == 200) {
        final meetingList = (respMap['Data'][0] as List)
            .map((e) => ScheduleMeetingListAdminModel.fromJson(e))
            .toList();
        return meetingList;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON ScheduleMeetingListAdmin API: $e");
      throw "$e";
    }
  }
}
