import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';
import 'package:campus_pro/src/DATA/MODELS/viewEnquiryModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class ViewEnquiryApi {
  Future<List<ViewEnquiryModel>> viewEnquiry(
      Map<String, String?> viewData) async {
    print("viewEnquiry before API: $viewData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.viewEnquiryApi),
        body: viewData,
        headers: headers,
        encoding: encoding,
      );

      print("viewEnquiry Status Code: ${response.statusCode}");
      print("viewEnquiry API Body: ${response.body}");

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

      print("viewEnquiry Response from API: $respMap");

      if (response.statusCode == 200) {
        final viewEnquiryList = (respMap['Data'] as List)
            .map((e) => ViewEnquiryModel.fromJson(e))
            .toList();
        return viewEnquiryList;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON viewEnquiry API: $e");
      throw "$e";
    }
  }
}
