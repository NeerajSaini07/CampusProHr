import 'dart:convert';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class GatewayTypeApi {
  Future<String> gatewayType(
      Map<String, String?> sendData) async {
    print("GatewayType before API: $sendData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.gatewayTypeApi),
        body: sendData,
        headers: headers,
        encoding: encoding,
      );

      print("GatewayType Status Code: ${response.statusCode}");
      print("GatewayType API Body: ${response.body}");

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      final respMap = json.decode(response.body);

      if (response.statusCode == 200) {
        final gatewayUrl = respMap["Data"][0] as String;
        return gatewayUrl;
      }

      throw SOMETHING_WENT_WRONG;
    } catch (e) {
      print("ERROR ON GatewayType API: $e");
      throw "$e";
    }
  }
}
