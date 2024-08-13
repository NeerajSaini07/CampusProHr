import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/DATA/MODELS/setPlateformModel.dart';
import 'package:http/http.dart' as http;
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';

class SetPlateformApi {
  Future<dynamic> getPlatform(Map<String, String?> request) async {
    //print('teststssg ${request['Mode']}');
    try {
      http.Response response = await http.post(Uri.parse(ApiEndpoints.savePlatformApi),
          encoding: encoding, body: request, headers: headers);

      print('status of save platform api ${response.statusCode}');
      print('body of save platform api ${response.body}');

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
        if (request['Mode'] == "0") {
          var data = (respMap['Data'] as List)
              .map((e) => SetPlateformModel.fromJson(e))
              .toList();
          return data;
        } else {
          return 'Success';
        }
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print('error on save platform api $e');
      throw e;
    }
  }
}
