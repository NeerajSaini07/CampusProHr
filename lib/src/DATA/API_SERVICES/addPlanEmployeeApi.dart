import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class AddPlanEmployeeApi {
  Future<String> addPlanEmployee(Map<String, String?> requestPayload) async {
    print("addPlan data before API: $requestPayload");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.studentLeaveSavePlannerEmployeeApi),
        body: requestPayload,
        headers: headers,
        encoding: encoding,
      );
      print("addPlan Status Code: ${response.statusCode}");
      print("addPlan API Body: ${response.body}");
      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      final respMap = json.decode(response.body);
      print("addPlan Response from API: $respMap");
      print(response.statusCode);

      // final dataList = (respMap)
      //     .map((e) => CreateHomeWorkEmployeeModel.fromJson(e))
      //     .toList();
      final dataList = respMap['Data'];
      print(dataList[0]['Status']);

      if (response.statusCode == 200) {
        if (dataList[0]['Status'] == '1') {
          return dataList[0]['Message'];
        }
      }
      if (response.statusCode == 200) {
        if (dataList[0]['Status'] == 'already applied.') {
          return dataList[0]['Message'];
        }
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON addPlan API: $e");
      throw "$e";
    }
  }
}
