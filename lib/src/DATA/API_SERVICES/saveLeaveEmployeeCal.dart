import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class SaveLeaveEmployeeCal {
  Future saveLeaveEmployeeCal(
      {String? fromDate, String? toDate, String? leaveId, String? desc}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final data = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "flag": "I",
      "ID": "",
      "EmpId": userData.stuEmpId,
      "FromDate": fromDate,
      "ToDate": toDate,
      "Description": desc,
      "LeaveTypeId": leaveId,
      "SessionId": userData.currentSessionid,
      "UserType": userData.ouserType,
    };

    print("sending data for saveLeaveEmployee Cal $data");

    try {
      http.Response response = await http.post(
          Uri.parse(ApiEndpoints.saveLeaveEmployeeCal),
          body: data,
          encoding: encoding,
          headers: headers);

      print("status code of saveLeaveEmployeeCal ${response.statusCode}");
      print("body of saveLeaveEmployeeCal ${response.body}");

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
        return respMap;
      }
      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("error on saveLeaveEmployeeCal $e");
      throw e;
    } catch (e) {
      print("error on saveLeaveEmployeeCal $e");
      throw e;
    }
  }
}
