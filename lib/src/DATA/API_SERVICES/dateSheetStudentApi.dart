import 'dart:convert';
import 'dart:io';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/dateSheetStudentModel.dart';

import 'package:http/http.dart' as http;
import '../../UTILS/api_endpoints.dart';

class DateSheetStudentApi {
  Future<List<DateSheetStudentModel>> getDateSheet(
      Map<String, String?> dateSheetRequest) async {
    print("Exam date sheet before API: $dateSheetRequest");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.dateSheetStudentApi),
        body: dateSheetRequest,
        headers: headers,
        encoding: encoding,
      );

      print("GET OUR Exam date sheet DATA: ${response.statusCode}");
      print("GET OUR Exam date sheet BODY: ${response.body}");

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
        final dateSheetData = (respMap['Data'] as List)
            .map((e) => DateSheetStudentModel.fromJson(e))
            .toList();
        return dateSheetData;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON GET OUR Exam date sheet API: $e");
      throw "$e";
    }
  }
}
