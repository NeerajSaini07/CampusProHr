import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/DATA/MODELS/loadAllottedSubjectsModel.dart';
import 'package:http/http.dart' as http;
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';

class LoadAllottedSubjectsApi {
  Future<List<LoadAllottedSubjectsModel>> getAllotedSubject(
      Map<String, String?> request) async {
    try {
      http.Response response = await http.post(
          Uri.parse(ApiEndpoints.getAllottedSubjectAdmin),
          body: request,
          encoding: encoding,
          headers: headers);

      print('status of get allotted subject ${response.statusCode}');
      print('body of get allotted subject ${response.body}');

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }
      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }
      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      Map<String, dynamic> respMap = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final data = (respMap['Data'][0] as List)
            .map((e) => LoadAllottedSubjectsModel.fromJson(e))
            .toList();
        return data;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print('error on load allotted subject $e');
      throw e;
    }
  }
}
