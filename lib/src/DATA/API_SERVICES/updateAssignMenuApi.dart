import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class UpdateAssignMenuApi {
  Future<String> updateMenu(Map<String, String?> request) async {
    try {
      http.Response response = await http.post(
          Uri.parse(ApiEndpoints.getUpdateAssignMenuApi),
          body: request,
          headers: headers,
          encoding: encoding);

      print('status of update assign menu ${response.statusCode}');
      print('body of update assign menu ${response.body}');

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }
      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }
      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      Map<String, dynamic> respMap = jsonDecode(response.body);
      // print(respMap['Data']);
      // print(respMap);

      if (response.statusCode == 200) {
        if (respMap['Data'][0] == "Menu Updated...") {
          return "Menu Updated...";
        }
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print('Error on update assign menu $e');
      throw e;
    }
  }
}
