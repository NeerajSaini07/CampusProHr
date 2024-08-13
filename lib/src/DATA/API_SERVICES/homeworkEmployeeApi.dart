import 'dart:convert';
import 'dart:io';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/homeworkEmployeeModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class HomeworkEmployeeApi {
  Future<List<HomeworkEmployeeModel>> homeworkData(
      Map<String, String?> classData) async {
    print("HomeworkEmployee before API: $classData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.homeworkEmployeeApi),
        body: classData,
        headers: headers,
        encoding: encoding,
      );

      print("HomeworkEmployee Status Code: ${response.statusCode}");
      print("HomeworkEmployee API Body: ${response.body}");

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      final respMap = json.decode(response.body);

      if (response.statusCode == 200) {
        final homeworkList = (respMap["Data"] as List)
            .map((e) => HomeworkEmployeeModel.fromJson(e))
            .toList();

        return homeworkList;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON  HomeworkEmployeeAPI: $e");
      throw "$e";
    }
  }
}
