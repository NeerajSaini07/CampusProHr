import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/DATA/MODELS/getSmsTypeSmsConfigModel.dart';
import 'package:http/http.dart' as http;
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';

class GetSmsTypeSmsConfigApi {
  Future<List<GetSmsTypeSmsConfigModel>> getSmsType(
      Map<String, String?> request) async {
    try {
      http.Response response = await http.post(
          Uri.parse(ApiEndpoints.getSmsTypeSmsConfigApi),
          body: request,
          encoding: encoding,
          headers: headers);

      print('status of get user type sms config ${response.statusCode}');
      print('body of get user type sms congif ${response.body}');

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
        var data = (respMap as List)
            .map((e) => GetSmsTypeSmsConfigModel.fromJson(e))
            .toList();
        return data;
      }
      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print('error on get user type sms config $e ');
      throw e;
    }
  }
}
