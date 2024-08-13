import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/meetingDetailsModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class MeetingDetailsApi {
  Future<MeetingDetailsModel> meetingDetails(
      Map<String, String?> meetingData) async {
    print("MeetingDetails before API: $meetingData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.meetingDetailsApi),
        body: meetingData,
        headers: headers,
        encoding: encoding,
      );

      print("MeetingDetails Status Code: ${response.statusCode}");
      print("MeetingDetails API Body: ${response.body}");

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
      print("Get MeetingDetails Response from API: $respMap");

      if (response.statusCode == 200) {
        final detailData = MeetingDetailsModel.fromJson(respMap['Data']);
        return detailData;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON MeetingDetails API: $e");
      throw "$e";
    }
  }
}
