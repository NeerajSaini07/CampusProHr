import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/DATA/MODELS/dropDownForProxyApplyModal.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:http/http.dart' as http;
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';

class DropDownForProxyApplyApi {
  Future<List<DropDownForProxyApplyModal>> getDropDown() async {
    try {
      final uid = await UserUtils.idFromCache();
      final token = await UserUtils.userTokenFromCache();
      final userData = await UserUtils.userTypeFromCache();

      final data = {
        "OUserId": uid,
        "Token": token,
        "OrgId": userData!.organizationId,
        "Schoolid": userData.schoolId,
        "SessionId": userData.currentSessionid,
        "StuEmpId": userData.stuEmpId,
        "UserType": userData.ouserType,
        "Flag": "BindAttFor",
        "Id": "",
      };

      http.Response response = await http.post(
          Uri.parse(ApiEndpoints.getEmployeeTaskManagement),
          body: data,
          encoding: encoding,
          headers: headers);

      print(
          "status code of drop down for proxy apply api ${response.statusCode}");
      print("body of drop down for proxy apply api ${response.body}");

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
            .map((e) => DropDownForProxyApplyModal.fromJson(e))
            .toList();
        return data;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("error on drop down for proxy api $e");
      throw e;
    } catch (e) {
      print("error on drop down for proxy api $e");
      throw e;
    }
  }
}
