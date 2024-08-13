import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/DATA/MODELS/cceAttendanceClassDataModel.dart';
import 'package:http/http.dart' as http;
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';

class CceAttendanceClassDataApi {
  Future<List<CceAttendanceClassDataModel>> getClassData(
      Map<String, String?> request) async {
    try {
      http.Response response = await http.post(
          Uri.parse(ApiEndpoints.getCceAttendanceClassData),
          body: request,
          encoding: encoding,
          headers: headers);

      print('status of cce attendance student list ${response.statusCode}');
      print('body of cce attendance student list ${response.body}');

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
            .map((e) => CceAttendanceClassDataModel.fromJson(e))
            .toList();
        return data;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print('error on cce attendance student list $e');
      throw e;
    }
  }
}
