import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/meetingDetailsAdminModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class MeetingDetailsAdminApi {
  Future<MeetingDetailsAdminModel> meetingDetailsAdmin(
      Map<String, String?> meetingData) async {
    print("MeetingDetailsAdmin before API: $meetingData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.meetingDetailsAdminApi),
        body: meetingData,
        headers: headers,
        encoding: encoding,
      );

      print("MeetingDetailsAdmin Status Code: ${response.statusCode}");
      print("MeetingDetailsAdmin API Body: ${response.body}");

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
      print("Get MeetingDetailsAdmin Response from API: $respMap");

      if (response.statusCode == 200) {
        final detailData =
            MeetingDetailsAdminModel.fromJson(respMap['Data'][0][0]);
        return detailData;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON MeetingDetailsAdmin API: $e");
      throw "$e";
    }
  }
}
