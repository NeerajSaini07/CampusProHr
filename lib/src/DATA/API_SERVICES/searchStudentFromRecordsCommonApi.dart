import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/searchStudentFromRecordsCommonModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class SearchStudentFromRecordsCommonApi {
  Future<List<SearchStudentFromRecordsCommonModel>> searchStudentKey(
      Map<String, String?> remarkData) async {
    print("SearchStudentFromRecordsCommon before API: $remarkData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.searchStudentFromRecordsCommonApi),
        body: remarkData,
        headers: headers,
        encoding: encoding,
      );

      print(
          "SearchStudentFromRecordsCommon Status Code: ${response.statusCode}");
      print("SearchStudentFromRecordsCommon API Body: ${response.body}");

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
      print("SearchStudentFromRecordsCommon Response from API: $respMap");

      if (response.statusCode == 200) {
        final searchStudentList = (respMap as List)
            .map((e) => SearchStudentFromRecordsCommonModel.fromJson(e))
            .toList();
        return searchStudentList;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON SearchStudentFromRecordsCommon API: $e");
      throw "$e";
    }
  }
}
