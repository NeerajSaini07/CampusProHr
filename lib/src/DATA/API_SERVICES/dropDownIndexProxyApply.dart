import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DropDownIndexProxyApply {
  Future dropDownIndex({TimeOfDay? inTime, TimeOfDay? outTime}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final data = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "EmpId": userData.stuEmpId,
      "Flag": "GetAttFor",
      "InTime": "${inTime!.hour}:${inTime.minute}:00",
      "OutTime": "${outTime!.hour}:${outTime.minute}:00",
      "UserType": userData.ouserType,
    };

    print("sending data for drop down index proxy apply $data");

    try {
      http.Response response = await http.post(
          Uri.parse(ApiEndpoints.dropDownIndexProxyApply),
          body: data,
          encoding: encoding,
          headers: headers);

      print(
          "status code of drop down index proxy apply ${response.statusCode}");
      print("body of drop down index proxy apply ${response.body}");

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
      print("error on dropDown index proxy Apply $e");
      throw e;
    } catch (e) {
      print("error on dropDown index proxy Apply $e");
      throw e;
    }
  }
}
