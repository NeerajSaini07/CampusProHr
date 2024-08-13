import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class AuthTokenForBusLocationApi {
  Future<String> authToken(Map<String, String?> data) async {
    print("AuthTokenForBusLocation before API: $data");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.authTokenForBusLocationApi),
        body: data,
        headers: headers,
        encoding: encoding,
      );

      print("AuthTokenForBusLocation Status Code: ${response.statusCode}");
      print("AuthTokenForBusLocation API Body: ${response.body}");

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
      print("Get AuthTokenForBusLocation Response from API: $respMap");

      final authToken = respMap['Data'][0]['Token'] as String;
      return authToken;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON AuthTokenForBusLocation API: $e");
      throw "$e";
    }
  }
}
