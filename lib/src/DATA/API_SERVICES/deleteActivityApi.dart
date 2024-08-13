import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';

class DeleteActivityApi {
  Future<String> deleteApi(Map<String, String?> request) async {
    try {
      http.Response response = await http.post(Uri.parse(ApiEndpoints.deleteActivityApi),
          body: request, headers: headers, encoding: encoding);

      print('status of delete activity api ${response.statusCode}');
      print('body of delete activity api ${response.body}');

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }
      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }
      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      var respMap = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (respMap == 'Success') {
          return 'Success';
        }
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print('error on delete activity api $e');
      throw e;
    }
  }
}
