import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';

class GetStudentMonthlyAmountApi {
  Future<String> getAmount(Map<String, String?> request) async {
    try {
      http.Response response = await http.post(
          Uri.parse(ApiEndpoints.getStudentMonthlyAmountApi),
          body: request,
          encoding: encoding,
          headers: headers);

      print('status of monthly amount ${response.statusCode}');
      print('body of monthly amount ${response.body}');

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
        var data = respMap['Data'][0]['Amount'];
        return data;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print('error on monthly amount api $e');
      throw e;
    }
  }
}
