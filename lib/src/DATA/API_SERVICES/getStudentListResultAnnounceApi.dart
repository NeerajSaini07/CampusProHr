import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/DATA/MODELS/getStudentListResultAnnounceModel.dart';
import 'package:http/http.dart' as http;
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';

class GetStudentListResultAnnounceApi {
  Future<List<GetStudentListResultAnnounceModel>> getStudentList(
      Map<String, String?> request) async {
    try {
      http.Response response = await http.post(
          Uri.parse(ApiEndpoints.getStudentListResultAnnounce),
          body: request,
          encoding: encoding,
          headers: headers);

      print(
          'status of student List Result announce api ${response.statusCode}');
      print('body of student List Result announce api ${response.body}');

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }
      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }
      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      var respMap = jsonDecode(response.body);

      if (response.statusCode == 200) {
        var data = (respMap['Data'] as List)
            .map((e) => GetStudentListResultAnnounceModel.fromJson(e))
            .toList();
        return data;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print('error on student List Result announce api $e');
      throw e;
    }
  }
}
