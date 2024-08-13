import 'dart:convert';
import 'dart:io';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/teacherRemarksListModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class TeacherRemarksListApi {
  Future<List<TeacherRemarksListModel>> remarkData(
      Map<String, String?> requestPayload) async {
    print("TeacherRemarksList before API: $requestPayload");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.teacherRemarksListApi),
        body: requestPayload,
        headers: headers,
        encoding: encoding,
      );

      print("TeacherRemarksList Status Code: ${response.statusCode}");
      print("TeacherRemarksList API Body: ${response.body}");

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
        final remarkList = (respMap as List)
            .map((e) => TeacherRemarksListModel.fromJson(e))
            .toList();
        return remarkList;
      }
      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON TeacherRemarksList: $e");
      throw e;
    }
  }
}
