import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class AddNewEnquiryApi {
  Future<bool> addNewEnquiry(Map<String, String?> newEnquiryData) async {
    print("AddNewEnquiry before API: $newEnquiryData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.addNewEnquiryApi),
        body: newEnquiryData,
        headers: headers,
        encoding: encoding,
      );

      print("AddNewEnquiry Status Code: ${response.statusCode}");
      print("AddNewEnquiry API Body: ${response.body}");

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

      print("AddNewEnquiry Response from API: $respMap");

      if (response.statusCode == 200) {
        return true;
      }

      return false;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON AddNewEnquiry API: $e");
      throw "$e";
    }
  }
}
