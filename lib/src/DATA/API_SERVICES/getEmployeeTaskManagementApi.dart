import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/DATA/MODELS/getEmployeeTaskManagementModel.dart';
import 'package:http/http.dart' as http;
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';

class GetEmployeeTaskManagementApi {
  Future<List<GetEmployeeTaskManagementModel>> getEmployee(
      Map<String, String?> payload) async {
    try {
      http.Response response = await http.post(
          Uri.parse(ApiEndpoints.getEmployeeTaskManagement),
          body: payload,
          headers: headers,
          encoding: encoding);

      print('status of GetEmployeeTaskManagement ${response.statusCode}');
      print('body of GetEmployeeTaskManagement ${response.body}');

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
            .map((e) => GetEmployeeTaskManagementModel.fromJson(e))
            .toList();
        return data;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print('error on GetEmployeeTaskManagement $e');
      throw e;
    }
  }
}
