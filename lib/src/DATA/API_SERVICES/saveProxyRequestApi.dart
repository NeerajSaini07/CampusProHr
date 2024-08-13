import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:http/http.dart' as http;
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:intl/intl.dart';

class SaveProxyRequestApi {
  Future saveProxyRequest(
      {TimeOfDay? inTime,
      TimeOfDay? outTime,
      DateTime? date,
      String? reason,
      String? attType,
      String? attId}) async {
    try {
      var uid = await UserUtils.idFromCache();
      final token = await UserUtils.userTokenFromCache();
      final userData = await UserUtils.userTypeFromCache();

      final data = {
        "OUserId": uid,
        "Token": token,
        "OrgId": userData!.organizationId,
        "Schoolid": userData.schoolId,
        "flag": "I",
        "ID": "",
        "Emp_id": userData.stuEmpId,
        "CheckIn_Time": "${inTime!.hour}:${inTime.minute}:00",
        "CheckOut_Time": "${outTime!.hour}:${outTime.minute}:00",
        "Att_Date": DateFormat("MMMM d,yyyy").format(date!),
        "Reasons": reason,
        "Att_Type": attType,
        "created_by": userData.stuEmpId,
        "AttID": attId,
        "UserType": userData.ouserType,
      };

      http.Response response = await http.post(
          Uri.parse(ApiEndpoints.saveProxyRequestApi),
          body: data,
          encoding: encoding,
          headers: headers);

      print("status code of saveProxy Request ${response.statusCode}");
      print("body of saveProxy Request ${response.body}");

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
      print("error on save proxy request $e");
      throw e;
    } catch (e) {
      print("error on save proxy request $e");
      throw e;
    }
  }
}
