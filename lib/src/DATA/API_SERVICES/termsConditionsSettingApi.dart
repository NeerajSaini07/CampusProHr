import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class TermsConditionsSettingApi {
  Future<String> termsConditionsSetting(
      Map<String, String?> termsConditionsSettingData) async {
    print("TermsConditionsSetting before API: $termsConditionsSettingData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.termsConditionsSettingApi),
        body: termsConditionsSettingData,
        headers: headers,
        encoding: encoding,
      );

      print("TermsConditionsSetting Status Code: ${response.statusCode}");
      print("TermsConditionsSetting API Body: ${response.body}");

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
        final setting = (respMap['Data'][0]['PaymentTerms'] as String);
        return setting;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON TermsConditionsSetting API: $e");
      throw "$e";
    }
  }
}
