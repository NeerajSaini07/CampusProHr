import 'dart:convert';
import 'dart:io';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/markSheetModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class MarkSheetStudentApi {
  Future<List<MarkSheetStudentModel>> loadMarkSheetData(
      Map<String, String?> requestPayload) async {
    print(" MarkSheet before API: $requestPayload");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.markSheetStudentApi),
        body: requestPayload,
        headers: headers,
        encoding: encoding,
      );

      print(" MarkSheet Status Code: ${response.statusCode}");
      print(" MarkSheet API Body: ${response.body}");

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
        final markSheetList = (respMap["Data"] as List)
            .map((e) => MarkSheetStudentModel.fromJson(e))
            .toList();
        return markSheetList;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON  MarkSheetStudentApi API: $e");
      throw "$e";
    }
  }
}
