import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:http/http.dart' as http;
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';

class ApproveProxyRequestApi {
  Future approveProxyRequestApi(
      {String? status, String? id, String? remark}) async {
    try {
      final uid = await UserUtils.idFromCache();
      final token = await UserUtils.userTokenFromCache();
      final userData = await UserUtils.userTypeFromCache();

      var data = {
        "OUserId": uid,
        "Token": token,
        "OrgId": userData!.organizationId,
        "Schoolid": userData.schoolId,
        "flag": "I",
        "ApproverID": userData.stuEmpId,
        "Status": status,
        "Type": "Attendance",
        "AutoID": id,
        "Remarks": remark != null ? remark : "",
        "UserType": userData.ouserType,
      };

      print("sending data for approve proxy api $data");

      http.Response response = await http.post(
          Uri.parse(ApiEndpoints.approveProxyRequestApi),
          body: data,
          encoding: encoding,
          headers: headers);

      print("status code of approve proxy api ${response.statusCode}");
      print("body of approve proxy api ${response.body}");

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
      print("no internet on approve proxy api $e");
      throw NO_INTERNET;
    } catch (e) {
      print("error on approve proxy api $e");
      throw e;
    }
  }
}
