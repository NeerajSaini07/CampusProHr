import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class GetInOutTimeForCalApi {
  Future getInOutTime({DateTime? date}) async {
    try {
      final uid = await UserUtils.idFromCache();
      final token = await UserUtils.userTokenFromCache();
      final userData = await UserUtils.userTypeFromCache();

      var data = {
        "OUserId": uid,
        "Token": token,
        "OrgId": userData!.organizationId,
        "Schoolid": userData.schoolId,
        "Flag": "GetInOutTime",
        "EmpID": userData.stuEmpId,
        "Date": DateFormat("MMMM dd,yyyy").format(date!),
        "UserType": userData.ouserType,
      };

      print("sending data for get in and out time $data");

      http.Response response = await http.post(Uri.parse(ApiEndpoints.getInOutTimeApi),
          body: data, encoding: encoding, headers: headers);

      print("status code of get in and out time ${response.statusCode}");
      print("body of get in and out time ${response.body}");

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
      print("error on get in and out api $e");
      throw e;
    } catch (e) {
      print("error on get in and out api $e");
      throw e;
    }
  }
}
