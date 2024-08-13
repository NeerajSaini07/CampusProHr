import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';

class SendingOtpGatePassApi {
  Future<String?> getData(Map<String, String?> data) async {
    try {
      http.Response response = await http.post(
          Uri.parse(ApiEndpoints.sendingOtpGatePassApi),
          body: data,
          encoding: encoding,
          headers: headers);

      print('response of sending otp gatepass ${response.statusCode}');
      print('body of sending otp gatepass ${response.body}');

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
        var data = respMap['VisitorId'];
        return data;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("error on gate pass otp to $e");
      throw e;
    }
  }
}
