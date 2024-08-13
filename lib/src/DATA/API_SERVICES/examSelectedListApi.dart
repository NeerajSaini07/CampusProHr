import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/examSelectedListModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class ExamSelectedListApi {
  Future<List<ExamSelectedListModel>> examSelectedList(
      Map<String, String?> examSelectedListData) async {
    print("ExamSelectedList before API: $examSelectedListData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.examSelectedListApi),
        body: examSelectedListData,
        headers: headers,
        encoding: encoding,
      );

      print("ExamSelectedList Status Code: ${response.statusCode}");
      print("ExamSelectedList API Body: ${response.body}");

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
        final examSelectedList = (respMap['Data'] as List)
            .map((e) => ExamSelectedListModel.fromJson(e))
            .toList();
        return examSelectedList;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON ExamSelectedList API: $e");
      throw "$e";
    }
  }
}
