import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:campus_pro/src/DATA/MODELS/studentLeaveEmployeeHistoryModel.dart';

class StudentLeaveEmployeeHistoryApi {
  Future<List<StudentLeaveEmployeeHistoryModel>> getHistory(
      Map<String, String?> requestPayload) async {
    try {
      print(requestPayload);
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.studentLeaveEmployeeHistoryApi),
        body: requestPayload,
        headers: headers,
        encoding: encoding,
      );

      print('History response of pending student leave ${response.body}');
      print(response.statusCode);

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }
      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      List<dynamic> resMap = json.decode(response.body);
      print('Body of leave req $resMap');

      if (response.statusCode == 200) {
        if (resMap.length != 0) {
          final leaveList = resMap
              .map((e) => StudentLeaveEmployeeHistoryModel.fromJson(e))
              .toList();
          return leaveList;
        } else {
          throw NO_RECORD_FOUND;
        }
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
