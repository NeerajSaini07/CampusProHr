import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class InactiveCompOrSuggApi {
  Future<String> inActiveSug(Map<String, String?> requestPayload) async {
    try {
      http.Response response = await http.post(
          Uri.parse(ApiEndpoints.inactiveCompOrSuggApi),
          body: requestPayload,
          headers: headers,
          encoding: encoding);
      print('Status Code of Inactive suggestion ${response.statusCode}');
      print('body of Reply Inactive suggestion ${response.body}');

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      Map<String, dynamic> respMap = json.decode(response.body);
      print('Result Inactive suggestion $respMap');

      if (response.statusCode == 200) {
        if (respMap['Data'][0]['Message'] == 'Success') {
          return 'Success!';
        }
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON Inactive suggestion API: $e");
      throw "$e";
    }
  }
}
