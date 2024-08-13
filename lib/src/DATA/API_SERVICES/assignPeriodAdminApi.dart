import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:http/http.dart' as http;

class AssignPeriodAdminApi {
  Future<String> assignPeriod(Map<String, String?> request) async {
    try {
      http.Response response = await http.post(Uri.parse(ApiEndpoints.AssignPeriodAdmin),
          body: request, encoding: encoding, headers: headers);

      print('status code of assign period api ${response.statusCode}');
      print('body of assign period api ${response.body}');

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }
      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      Map<String, dynamic> respMap = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (respMap['Data'][0] == 'period assigned successfully...') {
          return 'Success';
        }
      }
      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print('error assign period api $e');
      throw e;
    }
  }
}
