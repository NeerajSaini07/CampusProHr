import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/DATA/MODELS/getSubjectAdminModel.dart';
import 'package:http/http.dart' as http;
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';

class GetSubjectAdminApi {
  Future<List<GetSubjectAdminModel>> getSubject(
      Map<String, String?> request) async {
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.getSubjectForExamMarks),
        body: request,
        headers: headers,
        encoding: encoding,
      );

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }
      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }
      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      print('status for get subject admin ${response.statusCode}');
      print('body for get subject admin ${response.body}');

      Map<String, dynamic> respMap = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final subjectList = (respMap['Data'] as List)
            .map((e) => GetSubjectAdminModel.fromJson(e))
            .toList();
        return subjectList;
      }
      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print('Error on get subject admin $e}');
      throw e;
    }
  }
}
