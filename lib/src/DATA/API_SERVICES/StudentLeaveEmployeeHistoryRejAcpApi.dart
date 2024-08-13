import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/studentLeavePendingRejectAcceptModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class StudentLeaveEmployeeHistoryRejAcpApi {
  Future<List<studentLeavePendingRejectAcceptModel>> rejectAcceptLeaves(
      Map<String, String?> requestPayload) async {
    try {
      print(requestPayload);
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.studentLeaveEmployeeHistoryRejAcpApi),
        body: requestPayload,
        headers: headers,
        encoding: encoding,
      );

      print('History response of Rej/Acp student leave $response');
      print('Status code of Rej/Acp Api ${response.statusCode}');

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      Map<String, dynamic> resMap = json.decode(response.body);
      print('Body of Rej/Acp req $resMap');
      List<dynamic> resMap1 = resMap['Data'];
      if (response.statusCode == 200) {
        final responseRejAcp = (resMap1)
            .map((e) => studentLeavePendingRejectAcceptModel.fromJson(e))
            .toList();
        return responseRejAcp;
      }
      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON  history leave student API: $e");
      throw "$e";
    }
  }
}
