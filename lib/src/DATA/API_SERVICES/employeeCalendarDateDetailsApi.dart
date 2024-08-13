import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:http/http.dart' as http;
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';

class EmployeeCalendarDateDetailsApi {
  Future getCalendarDateDetailsApi({String? date}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final data = {
      "OUserId": uid,
      "Token": token,
      "Schoolid": userData!.schoolId,
      "OrgId": userData.organizationId,
      "Flag": "GetEmpDetails",
      "EmpID": userData.stuEmpId,
      "Year": "",
      "Month": "",
      "Date": date,
      "Extra": "",
      "UserType": userData.ouserType,
    };

    print("sending data for employee calendar date details $data");

    try {
      http.Response response = await http.post(
          Uri.parse(ApiEndpoints.employeeCalendarAllDateApi),
          body: data,
          encoding: encoding,
          headers: headers);

      print("status code of get calendar date details ${response.statusCode}");
      print("body of get calendar date details ${response.body}");

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 204) {
        throw SOMETHING_WENT_WRONG;
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
      print("error on employee calendar date detail api $e");
      throw NO_INTERNET;
    } catch (e) {
      print("error on employee calendar date detail api $e");
      throw e;
    }
  }
}
