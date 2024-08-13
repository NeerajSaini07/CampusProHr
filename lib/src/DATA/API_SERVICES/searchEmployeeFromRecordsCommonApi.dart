import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/searchEmployeeFromRecordsCommonModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class SearchEmployeeFromRecordsCommonApi {
  Future<List<SearchEmployeeFromRecordsCommonModel>> searchEmployeeKey(
      Map<String, String?> searchKey) async {
    print("SearchEmployeeFromRecordsCommon before API: $searchKey");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.searchEmployeeFromRecordsCommonApi),
        body: searchKey,
        headers: headers,
        encoding: encoding,
      );

      print(
          "SearchEmployeeFromRecordsCommon Status Code: ${response.statusCode}");
      print("SearchEmployeeFromRecordsCommon API Body: ${response.body}");

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
      print("SearchEmployeeFromRecordsCommon Response from API: $respMap");

      if (response.statusCode == 200) {
        final searchEmployeeList = (respMap as List)
            .map((e) => SearchEmployeeFromRecordsCommonModel.fromJson(e))
            .toList();
        return searchEmployeeList;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON SearchEmployeeFromRecordsCommon API: $e");
      throw "$e";
    }
  }
}
