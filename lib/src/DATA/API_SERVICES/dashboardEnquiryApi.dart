import 'dart:io';

import 'dart:convert';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/dashboardEnquiryModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class DashboardEnquiryApi {
  Future<DashboardEnquiryModel> dashboardEnquiry(
      Map<String, String?> dashboardEnquiryData) async {
    print(" DashboardEnquiry before API: $dashboardEnquiryData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.dashboardEnquiryApi),
        body: dashboardEnquiryData,
        headers: headers,
        encoding: encoding,
      );

      print(" DashboardEnquiry Status Code: ${response.statusCode}");
      print(" DashboardEnquiry API Body: ${response.body}");

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
        final dashboardEnquiry = DashboardEnquiryModel.fromJson(respMap);

        return dashboardEnquiry;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON DashboardEnquiryApi: $e");
      throw "$e";
    }
  }
}
