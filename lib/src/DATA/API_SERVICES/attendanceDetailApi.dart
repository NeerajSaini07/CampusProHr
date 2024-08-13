import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/attendanceDetailModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';

import 'package:http/http.dart' as http;

class AttendanceDetailApi {
  Future<List<AttendanceDetailModel>> attendanceDetail(
      Map<String, String?> requestPayload) async {
    print("attendance Detail before API: $requestPayload");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.getAttendanceDetailApi),
        body: requestPayload,
        headers: headers,
        encoding: encoding,
      );
      print("attendance Detail Status Code: ${response.statusCode}");
      print("attendance Detail API Body: ${response.body}");

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
      var respMap = json.decode(response.body);
      print("Get  attendance Detail Response from API: $respMap");
      List<dynamic> respMap1 = respMap['Data'];
      print("Get  attendanceList Response from API: $respMap1");
      if (response.statusCode == 200) {
        final attendanceList =
            (respMap1).map((e) => AttendanceDetailModel.fromJson(e)).toList();
        return attendanceList;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON  attendance Detail List API: $e");
      throw "$e";
    }
  }
}
