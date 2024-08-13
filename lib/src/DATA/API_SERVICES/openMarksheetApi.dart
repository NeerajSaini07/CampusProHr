import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class OpenMarksheetApi {
  Future<String> openMarksheet(Map<String, String?> marksheetData) async {
    print("OpenMarksheet before API: $marksheetData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.openMarksheetApi),
        body: marksheetData,
        headers: headers,
        encoding: encoding,
      );

      print("OpenMarksheet Status Code: ${response.statusCode}");
      print("OpenMarksheet API Body: ${response.body}");

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
      print("OpenMarksheet Response from API: $respMap");

      final marksheetURL = respMap['Url'] as String;
      return marksheetURL;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON OpenMarksheet API: $e");
      throw "$e";
    }
  }
}
