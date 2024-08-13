import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/studentLeaveEmployeeModel.dart';

import 'package:campus_pro/src/DATA/MODELS/yearSessionModel.dart';
import 'package:campus_pro/src/DATA/MODELS/homeWorkStudentModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class StudentLeaveEmployeeApi {
  Future<List<StudentLeaveEmployeeModel>> leaveApi(
      Map<String, String?> homeworkData) async {
    // var json = '''
    // [
    //   {
    //     "LeaveDayType": "Full Day",
    //     "Name": "DEEPAK JAIN",
    //     "RequestorId": 2318,
    //     "RequestorPhone": "8447281984",
    //     "Leavetype": "s",
    //     "LeaveDescription": "Test",
    //     "FromDate": "01 Jan 1900",
    //     "ToDate": "01 Jan 1900",
    //     "LeaveStatus": "Accepted"
    //   },
    //   {
    //     "LeaveDayType": "Full Day",
    //     "Name": "Mithun Kumar",
    //     "RequestorId": 2873,
    //     "RequestorPhone": "8447281984",
    //     "Leavetype": "s",
    //     "LeaveDescription": "Test",
    //     "FromDate": "01 Jan 1900",
    //     "ToDate": "01 Jan 1900",
    //     "LeaveStatus": "Accepted"
    //   }
    // ]
    // ''';
    // var response = await jsonDecode(json);
    // print(response);
    // final LeaveList = (response as List)
    //     .map((e) => StudentLeaveEmployeeModel.fromJson(e))
    //     .toList();
    // return LeaveList;

    print(" homeWorktData before API: $homeworkData");

    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.studentLeaveEmployeeApi),
        body: homeworkData,
        headers: headers,
        encoding: encoding,
      );

      print(" LeaveHistory Status Code: ${response.statusCode}");
      print(" LeaveHistory API Body: ${response.body}");

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }
      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      //Map<String, dynamic> respMap = json.decode(response.body);
      List<dynamic> respMap = json.decode(response.body);
      print("Get  LeaveHistory Response from API: $respMap");

      if (response.statusCode == 200) {
        // if (respMap["Data"][0]["AuthCheck"] == "Failed") {
        //   throw SOMETHING_WENT_WRONG;
        // } else {
        final LeaveList = (respMap)
            .map((e) => StudentLeaveEmployeeModel.fromJson(e))
            .toList();
        return LeaveList;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON  homeWorktData API: $e");
      throw "$e";
    }
  }
}
