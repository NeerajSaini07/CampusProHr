import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/loadClassForSmsModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class LoadClassForSmsApi {
  Future<List<LoadClassForSmsModel>> getClass(
      Map<String, String?> request) async {
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.getClassForExamMarks),
        body: request,
        headers: headers,
        encoding: encoding,
      );

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }
      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      print('body for class exam marks ${response.body}');
      print('status for class exam marks ${response.statusCode}');

      List<dynamic> respMap = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final classList =
            (respMap).map((e) => LoadClassForSmsModel.fromJson(e)).toList();
        return classList;
      }
      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print('Error on class exam marks $e');
      throw e;
    }
  }
}
