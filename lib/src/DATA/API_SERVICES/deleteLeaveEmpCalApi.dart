import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:http/http.dart' as http;
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';

class DeleteLeaveEmpCalApi {
  Future deleteLeaveEmpCal({String? id}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final data = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "flag": "D",
      "ID": id,
      "EmpId": userData.stuEmpId,
      "FromDate": "",
      "ToDate": "",
      "Description": "",
      "LeaveTypeId": "",
      "SessionId": userData.currentSessionid,
      "UserType": userData.ouserType,
    };

    print("sending data for deleteLeaveEmployee Cal $data");

    try {
      http.Response response = await http.post(
          Uri.parse(ApiEndpoints.saveLeaveEmployeeCal),
          body: data,
          encoding: encoding,
          headers: headers);

      print("status code of delete leave emp cal ${response.statusCode}");
      print("body of delete leave emp cal ${response.body}");

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
      print("error on delete leave emp cal $e");
      throw e;
    } catch (e) {
      print("error on delete leave emp cal $e");
      throw e;
    }
  }
}
