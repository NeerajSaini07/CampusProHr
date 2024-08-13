import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/getUserAssignMenuModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class GetUserAssignMenuApi {
  Future<List<GetUserAssignMenuModel>> getAssignMenu(
      Map<String, String?> request) async {
    try {
      http.Response response = await http.post(
          Uri.parse(ApiEndpoints.getUserAssignMenuApi),
          body: request,
          headers: headers,
          encoding: encoding);

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }
      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }
      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      print('get user assign menu status code : ${response.statusCode}');
      print('get user assign menu body : ${response.body}');

      Map<String, dynamic> respMap = jsonDecode(response.body);

      print('get user assign menu response : ${respMap['Data'][0]}');

      if (response.statusCode == 200) {
        final result = (respMap['Data'][0] as List)
            .map((e) => GetUserAssignMenuModel.fromJson(e))
            .toList();
        return result;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print('Error on Get UserAssign Menu Api $e');
      throw e;
    }
  }
}
