import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/updatePlanEmployeeModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';

import 'package:http/http.dart' as http;

class UpdatePlanEmployeeApi {
  Future<List<UpdatePlanEmployeeModel>> updatePlanEmployee(
      Map<String, String?> requestPayload) async {
    print("update plan before API: $requestPayload");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.studentLeaveUpdatePlannerEmployeeApi),
        body: requestPayload,
        headers: headers,
        encoding: encoding,
      );
      print("update plan Code: ${response.statusCode}");
      print("update plan List API Body: ${response.body}");

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }
      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      List<dynamic> respMap = json.decode(response.body);
      print("Get  update plan List Response from API: $respMap");

      if (response.statusCode == 200) {
        final updatePlanList = await (respMap)
            .map((e) => UpdatePlanEmployeeModel.fromJson(e))
            .toList();
        return updatePlanList;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON  update plan List API: $e");
      throw "$e";
    }
  }
}
