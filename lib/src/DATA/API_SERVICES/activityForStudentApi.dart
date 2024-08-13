import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/DATA/MODELS/activityForStudentModel.dart';
import 'package:http/http.dart' as http;
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';

class ActivityForStudentApi {
  Future<List<ActivityForStudentModel>> getActivity(
      Map<String, String?> request) async {
    try {
      http.Response response = await http.post(
          Uri.parse(ApiEndpoints.getActivityStudentApi),
          body: request,
          headers: headers,
          encoding: encoding);

      print('status of student activity list ${response.statusCode}');
      print('body of student activity list ${response.body}');

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }
      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      print("helllllllllll");
      Map<String, dynamic> respMap = jsonDecode(response.body);

      print(respMap);

      if (response.statusCode == 200) {
        var data = (respMap['Data'] as List)
            .map((e) => ActivityForStudentModel.fromJson(e))
            .toList();
        return data;
      }
      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print('error on student api $e');
      throw e;
    }
  }
}
