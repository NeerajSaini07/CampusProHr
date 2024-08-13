import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';

class DeleteMessagePopupApi {
  Future<String> deleteMessage(Map<String, String?> request) async {
    try {
      http.Response response = await http.post(
          Uri.parse(ApiEndpoints.deleteMessagePopupApi),
          body: request,
          encoding: encoding,
          headers: headers);

      print('status of DeleteMessagePopup api ${response.statusCode}');
      print('body of DeleteMessagePopup api ${response.body}');

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }
      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      var respMap = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (respMap['Data'] == 'Success') {
          return 'Success';
        }
      }
      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print('error on DeleteMessagePopup api $e');
      throw e;
    }
  }
}
