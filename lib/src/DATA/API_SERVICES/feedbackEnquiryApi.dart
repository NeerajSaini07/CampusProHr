import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/feedbackEnquiryModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class FeedbackEnquiryApi {
  Future<List<FeedbackEnquiryModel>> feedbackEnquiry(
      Map<String, String?> feedbackData) async {
    print("feedbackEnquiry before API: $feedbackData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.feedbackEnquiryApi),
        body: feedbackData,
        headers: headers,
        encoding: encoding,
      );

      print("feedbackEnquiry Status Code: ${response.statusCode}");
      print("feedbackEnquiry API Body: ${response.body}");

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

      print("feedbackEnquiry Response from API: $respMap");

      if (response.statusCode == 200) {
        final feedbackList = (respMap['Data'] as List)
            .map((e) => FeedbackEnquiryModel.fromJson(e))
            .toList();
        return feedbackList;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON feedbackEnquiry API: $e");
      throw "$e";
    }
  }
}
