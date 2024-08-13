import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:campus_pro/src/DATA/MODELS/loadClassForSubjectAdminModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';

class LoadClassForSubjectAdminApi {
  Future<List<LoadClassForSubjectAdminModel>> getClass(
      Map<String, String?> request) async {
    try {
      http.Response response = await http.post(
          Uri.parse(ApiEndpoints.classForSubjectAdmin),
          body: request,
          headers: headers,
          encoding: encoding);

      print('status of class 4 subject api ${response.statusCode}');
      print('body of class 4 subject api ${response.body}');

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
        final data = (respMap['Data'] as List)
            .map((e) => LoadClassForSubjectAdminModel.fromJson(e))
            .toList();
        return data;
      }
      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print('error on class 4 subject api $e');
      throw e;
    }
  }
}
