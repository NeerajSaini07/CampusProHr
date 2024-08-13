import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:http/http.dart' as http;

import '../../UTILS/api_endpoints.dart';

class FeedbackStudentApi {
  Future<bool> sendFeedBack(Map<String, String?> feedBackData) async {
    print("feedBackData before API: $feedBackData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.feedBackStudentApi),
        body: feedBackData,
        headers: headers,
        encoding: encoding,
      );

      print("feedBackData API Status Code: ${response.statusCode}");
      print("feedBackData API Body: ${response.body}");

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      Map<String, dynamic> respMap = json.decode(response.body);

      String status = respMap["Data"][0]["Status"] as String;

      if (status == "1") {
        return true;
      }
      return false;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON FeedBackApi: $e");
      throw "$e";
    }
  }
}
