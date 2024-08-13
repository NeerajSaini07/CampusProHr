import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/DATA/MODELS/loadStudentForSubjectListModel.dart';
import 'package:http/http.dart' as http;
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';

class LoadStudentForSubjectListApi {
  Future<List<LoadStudentForSubjectListModel>> studentList(
      Map<String, String?> request) async {
    try {
      http.Response response = await http.post(Uri.parse(ApiEndpoints.getStudentList),
          body: request, encoding: encoding, headers: headers);

      print('status of load student for subject ${response.statusCode}');
      print('body of load student for subject ${response.body}');

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      var respMap = jsonDecode(response.body);

      if (response.statusCode == 200) {
        var data = (respMap as List)
            .map((e) => LoadStudentForSubjectListModel.fromJson(e))
            .toList();
        return data;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print('error on load student for subject $e');
      throw e;
    }
  }
}
