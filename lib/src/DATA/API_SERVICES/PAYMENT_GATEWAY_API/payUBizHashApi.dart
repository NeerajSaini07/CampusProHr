import 'dart:convert';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/PAYMENT_GATEWAY_MODELS/payUBizzHashModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class PayUBizHashApi {
  Future<List<PayUBizHashModel>> payUBizHash(
      Map<String, String?> sendData) async {
    print("PayUBizHash before API: $sendData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.payUBizHashApi),
        body: sendData,
        headers: headers,
        encoding: encoding,
      );

      print("PayUBizHash Status Code: ${response.statusCode}");
      print("PayUBizHash API Body: ${response.body}");

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      final respMap = json.decode(response.body);

      if (response.statusCode == 200) {
        final hashData =
            (respMap as List).map((e) => PayUBizHashModel.fromJson(e)).toList();
        return hashData;
      }

      throw SOMETHING_WENT_WRONG;
    } catch (e) {
      print("ERROR ON PayUBizHash API: $e");
      throw "$e";
    }
  }
}
