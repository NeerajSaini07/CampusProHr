import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class ActivityApi {
  Future<List<ActivityModel>> activityData(
      Map<String, String?> requestPayload) async {
    print("Activity before API: $requestPayload");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.activityApi),
        body: requestPayload,
        headers: headers,
        encoding: encoding,
      );

      print("Activity Status Code: ${response.statusCode}");
      print("Activity API Body: ${response.body}");

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      Map<String, dynamic> respMap = json.decode(response.body);
      print("Get Activity Response from API: $respMap");

      final activityList = (respMap['Data'] as List)
          .map((e) => ActivityModel.fromJson(e))
          .toList();
      return activityList;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON Activity API: $e");
      throw "$e";
    }
  }
}
