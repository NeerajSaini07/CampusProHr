import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class FillPeriodAttendanceApi {
  Future<String> fillPeriod(Map<String, String?> request) async {
    try {
      http.Response response = await http.post(
          Uri.parse(ApiEndpoints.getfillperiodattendancemarkAttendanceApi),
          body: request,
          encoding: encoding,
          headers: headers);

      print('status of fill period attendance ${response.statusCode}');
      print('body of fill period attendance ${response.body}');

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
      print(respMap['Data']['CheckMarkAttendance'][0]
          ['markattendanceperiodWise']);
      if (response.statusCode == 200) {
        if (respMap['Data']['CheckMarkAttendance'][0]
                ['markattendanceperiodWise'] ==
            '0') {
          return 'Success1';
        } else {
          return 'Success';
        }
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print('error on fill period attendance $e');
      throw e;
    }
  }
}
