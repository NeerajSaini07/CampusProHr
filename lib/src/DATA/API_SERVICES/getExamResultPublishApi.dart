import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:campus_pro/src/DATA/MODELS/getExamResultPublishModel.dart';

class GetExamResultPublishApi {
  Future<List<GetExamResultPublishModel>> getStudentList(
      Map<String, dynamic> request) async {
    print('get exam result publish before api $request');

    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.getResultAnnounceStudentListApi),
        body: request,
        encoding: encoding,
        headers: headers,
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

      print('studentList response ${response.statusCode}');
      //print('studentList body ${response.body}');

      Map<String, dynamic> respMap =
          jsonDecode(response.body.replaceAll("\'", ""));

      List<dynamic> respMap1 = json.decode(respMap['Data'][0]);
      print('Response Map after decode ${respMap1[0]}');

      if (response.statusCode == 200) {
        final studentList = (respMap1)
            .map((e) => GetExamResultPublishModel.fromJson(e))
            .toList();
        return studentList;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON studentList API: $e");
      throw '$e';
    }
  }
}
