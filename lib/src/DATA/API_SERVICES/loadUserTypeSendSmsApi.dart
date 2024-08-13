import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/DATA/MODELS/loadUserTypeSendSmsModel.dart';
import 'package:http/http.dart' as http;
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';

class LoadUserTypeSendSmsApi {
  Future<List<LoadUserTypeSendSmsModel>> getUserType(
      Map<String, String?> request) async {
    try {
      http.Response response = await http.post(
          Uri.parse(ApiEndpoints.getLoadUserTypeApi),
          body: request,
          headers: headers,
          encoding: encoding);

      print('status of load user Type api ${response.statusCode}');
      print('body of load user Type api ${response.body}');

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
        var data = (respMap as List)
            .map((e) => LoadUserTypeSendSmsModel.fromJson(e))
            .toList();
        return data;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print('error on load user type api $e');
      throw e;
    }
  }
}
