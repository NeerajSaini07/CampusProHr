import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/scheduleMeetingTodayListModel.dart';
import 'package:campus_pro/src/DATA/MODELS/subjectListMeetingModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class ScheduleMeetingTodayListApi {
  Future<List<ScheduleMeetingTodayListModel>> meetingList(
      Map<String, String?> meetingData) async {
    print("ScheduleMeetingTodayList before API: $meetingData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.scheduleMeetingTodayListApi),
        body: meetingData,
        headers: headers,
        encoding: encoding,
      );

      print("ScheduleMeetingTodayList Status Code: ${response.statusCode}");
      print("ScheduleMeetingTodayList API Body: ${response.body}");

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
            .map((e) => ScheduleMeetingTodayListModel.fromJson(e))
            .toList();
        return meetingList;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON ScheduleMeetingTodayList API: $e");
      throw "$e";
    }
  }
}
