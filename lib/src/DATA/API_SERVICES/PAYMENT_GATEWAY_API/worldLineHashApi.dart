import 'dart:convert';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/PAYMENT_GATEWAY_MODELS/payUBizzHashModel.dart';
import 'package:campus_pro/src/DATA/MODELS/PAYMENT_GATEWAY_MODELS/worldLineHashModel.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';
import 'package:campus_pro/src/DATA/MODELS/calenderStudentModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class WorldLineHashApi {
  Future<List<WorldLineHashModel>> worldLineHash(
      Map<String, String?> sendData) async {
    print("WorldLineHash before API: $sendData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.worldLineHashApi),
        body: sendData,
        headers: headers,
        encoding: encoding,
      );

      print("WorldLineHash Status Code: ${response.statusCode}");
      print("WorldLineHash API Body: ${response.body}");

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      final respMap = json.decode(response.body);

      if (response.statusCode == 200) {
        final hashData = (respMap as List)
            .map((e) => WorldLineHashModel.fromJson(e))
            .toList();
        return hashData;
      }

      throw SOMETHING_WENT_WRONG;
    } catch (e) {
      print("ERROR ON WorldLineHash API: $e");
      throw "$e";
    }
  }
}
