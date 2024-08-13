import 'dart:convert';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/PAYMENT_GATEWAY_MODELS/ebsHashModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class EbsHashApi {
  Future<List<EbsHashModel>> ebsHash(Map<String, String?> sendData) async {
    print("EbsHash before API: $sendData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.ebsHashApi),
        body: sendData,
        headers: headers,
        encoding: encoding,
      );

      print("Ebs Status Code: ${response.statusCode}");
      print("Ebs API Body: ${response.body}");

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      final respMap = json.decode(response.body);

      if (response.statusCode == 200) {
        final hashData =
            (respMap as List).map((e) => EbsHashModel.fromJson(e)).toList();
        return hashData;
      }

      throw SOMETHING_WENT_WRONG;
    } catch (e) {
      print("ERROR ON EbsHashApi API: $e");
      throw "$e";
    }
  }
}
