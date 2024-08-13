import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/approveLeaveListModal.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:http/http.dart' as http;
import 'package:campus_pro/src/UTILS/api_endpoints.dart';

class ApproveLeaveListApi {
  Future<List<ApproveLeaveListModal>> getLeaveList(
      {String? status,
      String? empName,
      String? createdDate,
      String? showTop}) async {
    try {
      var uid = await UserUtils.idFromCache();
      final token = await UserUtils.userTokenFromCache();
      final userData = await UserUtils.userTypeFromCache();

      final data = {
        "OUserId": uid,
        "Token": token,
        "OrgId": userData!.organizationId,
        "Schoolid": userData.schoolId,
        "flag": "S",
        "EmpID": userData.stuEmpId,
        "Status": status != null ? status : "",
        "EmpName": empName != null ? empName : "",
        "CreatedDate": createdDate != null ? createdDate : "",
        "ShowTop": showTop != null ? showTop : "10",
        "UserType": userData.ouserType,
      };

      print("sending data for approve leave leave list api $data");

      http.Response response = await http.post(
          Uri.parse(ApiEndpoints.approveLeaveListApi),
          body: data,
          encoding: encoding,
          headers: headers);

      print("status code of approve leave list api ${response.statusCode}");
      print("body of approve leave list api ${response.body}");

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      var respMap = jsonDecode(response.body);

      if (response.statusCode == 200) {
        var data = (respMap["Data"] as List)
            .map((e) => ApproveLeaveListModal.fromJson(e))
            .toList();
        return data;
      }
      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("No Internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("error on approve leave list api $e");
      throw e;
    }
  }
}
