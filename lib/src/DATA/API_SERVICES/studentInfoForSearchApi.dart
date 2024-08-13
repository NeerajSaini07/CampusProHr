import 'dart:convert';
import 'dart:io';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/studentInfoForSearchModel.dart';
import 'package:http/http.dart' as http;
import '../../UTILS/api_endpoints.dart';

class StudentInfoForSearchApi {
  Future<StudentInfoForSearchModel> getStudentInfoForSearch(
      Map<String, String> studentData) async {
    print("StudentInfoForSearch data before API: $studentData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.studentInfoForSearchApi),
        body: studentData,
        headers: headers,
        encoding: encoding,
      );

      print("GET OUR StudentInfoForSearch DATA: ${response.statusCode}");
      print("GET OUR StudentInfoForSearch BODY: ${response.body}");

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      Map<String, dynamic> respMap = json.decode(response.body);
      print("StudentInfoForSearch Response from API: $respMap");
      if (response.statusCode == 200) {
        final studentInfoForSearchData =
            StudentInfoForSearchModel.fromJson(respMap["Data"][0]);
        // final StudentInfoForSearchData = (respMap["Data"] as List).map((e) => StudentInfoForSearchModel.fromJson(e)).toList();
        return studentInfoForSearchData;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON StudentInfoForSearch API: $e");
      throw "$e";
    }
  }
}
