import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:http/http.dart' as http;

class ApproveLeaveRequestApi {
  Future approveLeaveRequest(
      {String? flag, String? ids, String? remarks}) async {
    try {
      final uid = await UserUtils.idFromCache();
      final token = await UserUtils.userTokenFromCache();
      final userData = await UserUtils.userTypeFromCache();

      var data = {
        "OUserId": uid,
        "Token": token,
        "OrgId": userData!.organizationId,
        "Schoolid": userData.schoolId,
        "flag": "U",
        "ApproverID": userData.stuEmpId,
        "Status": flag,
        "Type": "leave",
        "AutoID": ids,
        "Remarks": remarks,
        "UserType": userData.ouserType,
      };

      print("sending data for approve leave $data");

      http.Response response = await http.post(
          Uri.parse(ApiEndpoints.approveLeaveRequestApi),
          body: data,
          encoding: encoding,
          headers: headers);

      print("status code of approve leave request api ${response.statusCode}");
      print("body of approve  leave request api ${response.body}");

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
      print("no internet error $e");
      throw NO_INTERNET;
    } catch (e) {
      print("error on approve leave request api $e");
      throw e;
    }
  }
}
