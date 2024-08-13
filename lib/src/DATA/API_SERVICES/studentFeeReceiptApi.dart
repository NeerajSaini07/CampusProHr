import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';
import 'package:campus_pro/src/DATA/MODELS/studentFeeReceiptModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class StudentFeeReceiptApi {
  Future<List<StudentFeeReceiptModel>> finalReceiptData(
      Map<String, String?> requestPayload) async {
    print("StudentFeeReceipt before API: $requestPayload");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.studentFeeReceiptApi),
        body: requestPayload,
        headers: headers,
        encoding: encoding,
      );

      print("StudentFeeReceipt Status Code: ${response.statusCode}");
      print("StudentFeeReceipt API Body: ${response.body}");

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
      print("Get StudentFeeReceipt Response from API: $respMap");

      if (response.statusCode == 200) {
        if (respMap != null) {
          final feeDetails = (respMap as List)
              .map((e) => StudentFeeReceiptModel.fromJson(e))
              .toList();
          return feeDetails;
        } else
          throw NO_RECORD_FOUND;
      }

      throw SOMETHING_WENT_WRONG;

      // final feeDetails =
      //     (respMap as List).map((e) => FeeDetailsModel.fromJson(e)).toList();
      // return feeDetails;
      // throw "";
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON StudentFeeReceipt API: $e");
      throw "$e";
    }
  }
}
