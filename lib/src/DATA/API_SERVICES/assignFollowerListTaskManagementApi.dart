import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/DATA/MODELS/assignFollowerListTaskManagementModel.dart';
import 'package:http/http.dart' as http;
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';

class AssignFollowerListTaskManagementApi {
  Future<List<AssignFollowerListTaskManagementModel>> assignList(
      Map<String, String?> payload) async {
    try {
      http.Response response = await http.post(
          Uri.parse(ApiEndpoints.getTaskDataTaskManagement),
          body: payload,
          headers: headers,
          encoding: encoding);

      print('status of GetTaskData ${response.statusCode}');
      print('body of GetTaskData ${response.body}');

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
        var data = (respMap["Data"] as List)
            .map((e) => AssignFollowerListTaskManagementModel.fromJson(e))
            .toList();
        return data;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print('error on GetTaskData $e');
      throw e;
    }
  }
}
