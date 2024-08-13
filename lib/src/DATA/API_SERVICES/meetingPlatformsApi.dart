import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/meetingPlatformsModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class MeetingPlatformsApi {
  Future<List<MeetingPlatformsModel>> meetingPlatforms(
      Map<String, String?> data) async {
    print("MeetingPlatforms before API: $data");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.meetingPlatformsApi),
        body: data,
        headers: headers,
        encoding: encoding,
      );

      print("MeetingPlatforms Status Code: ${response.statusCode}");
      print("MeetingPlatforms API Body: ${response.body}");

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
        final platformList = (respMap['Data'][0] as List)
            .map((e) => MeetingPlatformsModel.fromJson(e))
            .toList();
        return platformList;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON MeetingPlatforms API: $e");
      throw "$e";
    }
  }
}
