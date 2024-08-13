import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/groupWiseEmployeeMeetingModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class GroupWiseEmployeeMeetingApi {
  Future<List<GroupWiseEmployeeMeetingModel>> getGroups(
      Map<String, String?> groupData) async {
    print("GroupWiseEmployeeMeeting before API: $groupData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.groupWiseEmployeeMeetingApi),
        body: groupData,
        headers: headers,
        encoding: encoding,
      );

      print("GroupWiseEmployeeMeeting Status Code: ${response.statusCode}");
      print("GroupWiseEmployeeMeeting API Body: ${response.body}");

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
        final groupList = (respMap as List)
            .map((e) => GroupWiseEmployeeMeetingModel.fromJson(e))
            .toList();
        return groupList;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON GroupWiseEmployeeMeeting API: $e");
      throw "$e";
    }
  }
}
