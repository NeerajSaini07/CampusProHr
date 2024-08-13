import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/subjectListMeetingModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class SubjectListMeetingApi {
  Future<List<SubjectListMeetingModel>> subjectList(
      Map<String, String?> subjectData) async {
    print("SubjectListMeeting before API: $subjectData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.subjectListMeetingApi),
        body: subjectData,
        headers: headers,
        encoding: encoding,
      );

      print("SubjectListMeeting Status Code: ${response.statusCode}");
      print("SubjectListMeeting API Body: ${response.body}");

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
        final subjectList = (respMap['Data'][0] as List)
            .map((e) => SubjectListMeetingModel.fromJson(e))
            .toList();
        return subjectList;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON SubjectListMeeting API: $e");
      throw "$e";
    }
  }
}
