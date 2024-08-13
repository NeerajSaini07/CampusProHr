import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class CheckAppRestrictionApi {
  Future<bool> checkAppRestriction(Map<String, String?> meetings) async {
    print("CheckAppRestriction before API: $meetings");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.checkAppRestrictionApi),
        body: meetings,
        headers: headers,
        encoding: encoding,
      );

      print("CheckAppRestriction Status Code: ${response.statusCode}");
      print("CheckAppRestriction API Body: ${response.body}");

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
      print("CheckAppRestriction Response from API: $respMap");

      if (response.statusCode == 200) {
        final status = (respMap['Flag'] as String);
        if (status == "Y") {
          return true;
        } else {
          return false;
        }
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON CheckAppRestriction API: $e");
      throw "$e";
    }
  }
}
