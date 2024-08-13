import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';

import 'package:campus_pro/src/DATA/MODELS/yearSessionModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class YearSessionApi {
  Future<List<YearSessionModel>> yearSessionData(
      Map<String, String?> requestPayload) async {
    print(" YearSessionApi before API: $requestPayload");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.yearSessionApi),
        body: requestPayload,
        headers: headers,
        encoding: encoding,
      );

      print(" YearSessionApi Status Code: ${response.statusCode}");
      print(" YearSessionApi API Body: ${response.body}");

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      Map<String, dynamic> respMap = json.decode(response.body);
      print("Get YearSessionApi Response from API: $respMap");

      final activityList = (respMap["Data"] as List)
          .map((e) => YearSessionModel.fromJson(e))
          .toList();
      return activityList;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON  YearSessionApi API: $e");
      throw "$e";
    }
  }
}
