import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/onlineMeetingsModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class OnlineMeetingsApi {
  Future<List<OnlineMeetingsModel>> onlineMeetings(
      Map<String, String?> meetings) async {
    print("OnlineMeetings before API: $meetings");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.onlineMeetingsApi),
        body: meetings,
        headers: headers,
        encoding: encoding,
      );

      print("OnlineMeetings Status Code: ${response.statusCode}");
      print("OnlineMeetings API Body: ${response.body}");

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
      print("Get OnlineMeetings Response from API: $respMap");

      if (response.statusCode == 200) {
        final meetingData = (respMap as List)
            .map((e) => OnlineMeetingsModel.fromJson(e))
            .toList();
        return meetingData;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON OnlineMeetings API: $e");
      throw "$e";
    }
  }
}
