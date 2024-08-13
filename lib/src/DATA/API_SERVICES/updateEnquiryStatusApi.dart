import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class UpdateEnquiryStatusApi {
  Future<bool> updateEnquiryStatus(Map<String, String?> updateData) async {
    print("UpdateEnquiryStatus before API: $updateData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.updateEnquiryStatusApi),
        body: updateData,
        headers: headers,
        encoding: encoding,
      );

      print("UpdateEnquiryStatus Status Code: ${response.statusCode}");
      print("UpdateEnquiryStatus API Body: ${response.body}");

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

      print("UpdateEnquiryStatus Response from API: $respMap");

      if (response.statusCode == 200) {
        return true;
      }

      return false;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON UpdateEnquiryStatus API: $e");
      throw "$e";
    }
  }
}
