import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/leaveRequestModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class LeaveRequestApi {
  Future<List<LeaveRequestModel>> leaveRequest(
      Map<String, String?> requestPayload) async {
    print("LeaveRequest before API: $requestPayload");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.leaveRequestApi),
        body: requestPayload,
        headers: headers,
        encoding: encoding,
      );

      print("LeaveRequest Status Code: ${response.statusCode}");
      print("LeaveRequest API Body: ${response.body}");

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      final respMap = json.decode(response.body);

      if (response.statusCode == 200) {
        final leaveList = (respMap as List)
            .map((e) => LeaveRequestModel.fromJson(e))
            .toList();
        return leaveList;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON LeaveRequest API: $e");
      throw "$e";
    }
  }
}
