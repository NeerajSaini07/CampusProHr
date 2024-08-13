import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/sectionListAttendanceAdminModel.dart';
import 'package:campus_pro/src/DATA/MODELS/sectionListAttendanceModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class SectionListAttendanceAdminApi {
  Future<List<SectionListAttendanceAdminModel>> getSection(
      Map<String, String?> SectionList) async {
    print(" sectionList Admin before API: $SectionList");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.getClassSectionAttendanceReportApi),
        body: SectionList,
        headers: headers,
        encoding: encoding,
      );

      print(" sectionList Admin Status Code: ${response.statusCode}");
      print(" sectionList Admin API Body: ${response.body}");

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      List<dynamic> respMap = json.decode(response.body);
      print("Get  sectionList Admin Response from API: $respMap");

      if (response.statusCode == 200) {
        // if (respMap["Data"][0]["AuthCheck"] == "Failed") {
        //   throw SOMETHING_WENT_WRONG;
        // } else {
        final sectionList = (respMap)
            .map((e) => SectionListAttendanceAdminModel.fromJson(e))
            .toList();
        return sectionList;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON  sectionList  Admin API: $e");
      throw "$e";
    }
  }
}
