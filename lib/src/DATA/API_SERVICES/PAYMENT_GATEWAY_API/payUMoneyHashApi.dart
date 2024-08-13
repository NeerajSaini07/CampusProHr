import 'dart:convert';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/PAYMENT_GATEWAY_MODELS/payUMoneyHashModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class PayUMoneyHashApi {
  Future<List<PayUMoneyHashModel>> payUMoneyHash(
      Map<String, String?> sendData) async {
    print("PayUMoneyHash before API: $sendData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.payUMoneyHashApi),
        body: sendData,
        headers: headers,
        encoding: encoding,
      );

      print("PayUMoneyHash Status Code: ${response.statusCode}");
      print("PayUMoneyHash API Body: ${response.body}");

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      final respMap = json.decode(response.body);

      if (response.statusCode == 200) {
        final hashData = (respMap as List)
            .map((e) => PayUMoneyHashModel.fromJson(e))
            .toList();
        return hashData;
      }

      throw SOMETHING_WENT_WRONG;
    } catch (e) {
      print("ERROR ON PayUMoneyHash API: $e");
      throw "$e";
    }
  }
}
