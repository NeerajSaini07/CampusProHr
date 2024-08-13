import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:http/http.dart' as http;
import 'package:campus_pro/src/UTILS/api_endpoints.dart';

class RemoveAllottedSubjectsApi {
  Future<String> removeSubject(Map<String, String?> request) async {
    try {
      http.Response response = await http.post(
          Uri.parse(ApiEndpoints.deleteAllottedSubjectAdmin),
          body: request,
          headers: headers,
          encoding: encoding);

      print('status of remove allotted subject ${response.statusCode}');
      print('body of remove allotted subject ${response.body}');

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
        if (respMap['Data'][0] == 'Subject Removed...') {
          return 'Deleted';
        }
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print('error on remove allotted subject $e');
      throw e;
    }
  }
}
