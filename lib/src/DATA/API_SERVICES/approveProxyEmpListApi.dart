import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/approveProxyEmpListModal.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class ApproveProxyEmpListApi {
  Future<List<ApproveProxyEmpListModal>> approveProxyEmpCalApi(
      {String? status,
      String? empName,
      String? date,
      String? itemsShow}) async {
    try {
      final uid = await UserUtils.idFromCache();
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
        "CreatedDate": date != null ? date : "",
        "ShowTop": itemsShow != null ? itemsShow : "10",
        "UserType": userData.ouserType,
      };

      print("sending data for approve proxy $data");

      http.Response response = await http.post(
          Uri.parse(ApiEndpoints.approveProxyListApi),
          body: data,
          encoding: encoding,
          headers: headers);

      print("status code of approve proxy api ${response.statusCode}");
      print("body of approve proxy api ${response.body}");

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
            .map((e) => ApproveProxyEmpListModal.fromJson(e))
            .toList();
        return data;
      }
      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("error on approve proxy api $e");
      throw NO_INTERNET;
    } catch (e) {
      print("error on approve proxy api $e");
      throw e;
    }
  }
}
