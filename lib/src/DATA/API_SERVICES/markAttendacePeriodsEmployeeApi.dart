import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/markAttendacePeriodsEmployeeModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class MarkAttendancePeriodsEmployeeApi {
  Future<List<MarkAttendacePeriodsEmployeeModel>> getPeriod(
      Map<String, String?> periodList, int? number) async {
    print(" PeriodList before API: $periodList");
    try {
      http.Response response = await http.post(
        number == 0
            ? Uri.parse(ApiEndpoints.getPeriodsMarkAttendance)
            : Uri.parse(ApiEndpoints.getPeriodsMarkAttendance1),
        body: periodList,
        headers: headers,
        encoding: encoding,
      );

      print(" PeriodList Status Code: ${response.statusCode}");
      print(" PeriodList API Body: ${response.body}");

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      var respMap = json.decode(response.body);
      print("Get  PeriodList Response from API: $respMap");
      var respMap1 = respMap["Data"];
      if (response.statusCode == 200) {
        // if (respMap["Data"][0]["AuthCheck"] == "Failed") {
        //   throw SOMETHING_WENT_WRONG;
        // } else {
        final periodList = (respMap1 as List)
            .map((e) => MarkAttendacePeriodsEmployeeModel.fromJson(e))
            .toList();
        return periodList;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON  PeriodList API: $e");
      throw "$e";
    }
  }
}
