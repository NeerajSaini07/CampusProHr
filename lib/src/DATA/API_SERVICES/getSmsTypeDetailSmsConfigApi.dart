import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/getSmsTypeDetailSmsConfigModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class GetSmsTypeDetailSmsConfigApi {
  Future<List<GetSmsTypeDetailSmsConfigModel>> getSmsTypeDetail(
      Map<String, String?> request) async {
    try {
      http.Response response = await http.post(
          Uri.parse(ApiEndpoints.getSmsTypeSmsDetailApi),
          body: request,
          headers: headers,
          encoding: encoding);

      print('status of sms type detail ${response.statusCode}');
      print('body of sms type detail ${response.body}');

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
            .map((e) => GetSmsTypeDetailSmsConfigModel.fromJson(e))
            .toList();
        return data;
      }
      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print('error on sms type detail $e');
      throw e;
    }
  }
}
