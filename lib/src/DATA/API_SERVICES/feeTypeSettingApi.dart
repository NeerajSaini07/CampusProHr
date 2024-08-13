import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class FeeTypeSettingApi {
  Future<String> feeTypeSetting(Map<String, String?> feeTypeSettingData) async {
    print("FeeTypeSetting before API: $feeTypeSettingData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.feeTypeSettingApi),
        body: feeTypeSettingData,
        headers: headers,
        encoding: encoding,
      );

      print("FeeTypeSetting Status Code: ${response.statusCode}");
      print("FeeTypeSetting API Body: ${response.body}");

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
        final feeTypeSettingList = (respMap['Status'] as String);
        return feeTypeSettingList;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON FeeTypeSetting API: $e");
      throw "$e";
    }
  }
}
