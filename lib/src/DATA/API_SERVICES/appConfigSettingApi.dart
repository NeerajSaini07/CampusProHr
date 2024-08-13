import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/appConfigSettingModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class AppConfigSettingApi {
  Future<AppConfigSettingModel> appConfigSetting(
      Map<String, String?> schoolData) async {
    print("AppConfigSetting before API: $schoolData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.appConfigSettingApi),
        body: schoolData,
        headers: headers,
        encoding: encoding,
      );

      print("AppConfigSetting Status Code: ${response.statusCode}");
      print("AppConfigSetting API Body: ${response.body}");

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      final respMap = json.decode(response.body);

      if (response.statusCode == 200) {
        final settingData = AppConfigSettingModel.fromJson(respMap['Data'][0]);
        return settingData;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON AppConfigSetting API: $e");
      throw "$e";
    }
  }
}
