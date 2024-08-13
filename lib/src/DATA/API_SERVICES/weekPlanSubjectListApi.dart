import 'dart:convert';
import 'dart:io';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/SubjectListEmployeeModel.dart';
import 'package:campus_pro/src/DATA/MODELS/classListEmployeeModel.dart';
import 'package:campus_pro/src/DATA/MODELS/weekPlanSubjectListModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class WeekPlanSubjectListApi {
  Future<List<WeekPlanSubjectListModel>> getSubject(
      Map<String, String?> subjectList) async {
    print(" WeekPlanSubjectList before API: $subjectList");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.weekPlanSubjectListEmployeeApi),
        body: subjectList,
        headers: headers,
        encoding: encoding,
      );

      print(" WeekPlanSubjectList Status Code: ${response.statusCode}");
      print(" WeekPlanSubjectList API Body: ${response.body}");

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      //Map<String, dynamic> respMap = json.decode(response.body);

      List<dynamic> respMap = json.decode(response.body);
      // print(respMap);
      // List<dynamic> respMap1 = respMap['Data'][0];
      // print("Get  SubjectList Response from API: $respMap1");

      if (response.statusCode == 200) {
        final subjectList =
            (respMap).map((e) => WeekPlanSubjectListModel.fromJson(e)).toList();
        return subjectList;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON  WeekPlanSubjectList List API: $e");
      throw "$e";
    }
  }
}
