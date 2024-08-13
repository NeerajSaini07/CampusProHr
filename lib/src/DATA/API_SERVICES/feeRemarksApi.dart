import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/feeRemarksModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class FeeRemarksApi {
  Future<FeeRemarksModel> feeRemarks(
      Map<String, String?> feeRemarksData) async {
    print("FeeRemarks before API: $feeRemarksData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.feeRemarksApi),
        body: feeRemarksData,
        headers: headers,
        encoding: encoding,
      );

      print("FeeRemarks Status Code: ${response.statusCode}");
      print("FeeRemarks API Body: ${response.body}");

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      Map<String, dynamic> respMap = json.decode(response.body);
      print("Get FeeRemarks Response from API: $respMap");

      // final feeRemarksList = FeeRemarksModel.fromJson(respMap);
      throw "";
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON FeeRemarks API: $e");
      throw "$e";
    }
  }
}
