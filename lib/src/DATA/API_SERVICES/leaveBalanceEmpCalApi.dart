import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:http/http.dart' as http;
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';

class LeaveBalanceEmpCalApi {
  // Future getLeaveBalanceEmp(Map<String, String?> payload) async {
  Future getLeaveBalanceEmp() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final data = {
      "OUserId": uid,
      "Token": token,
      "Schoolid": userData!.schoolId,
      "OrgId": userData.organizationId,
      "Flag": "LeaveBalance",
      "EmpId": userData.stuEmpId,
      "UserType": userData.ouserType,
    };

    print("sending api for leave balance $data");
    try {
      http.Response response = await http.post(
          Uri.parse(ApiEndpoints.employeeCalendarLeaveBalanceApi),
          body: data,
          encoding: encoding,
          headers: headers);

      print(
          "status code of employee leave balance cal api ${response.statusCode}");
      print("body of employee leave balance cal api ${response.body}");

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
        // var data = (respMap["Data"] as List)
        //     .map((e) => LeaveBalanceEmpCalModal.fromJson(e))
        //     .toList();
        // return data;
        return respMap;
      }

      return SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("error on leave balance api $e");
    } catch (e) {
      print("error on leave balance api $e");
      throw e;
    }
  }
}
