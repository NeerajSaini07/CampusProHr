import 'dart:convert';
import 'dart:io';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/classroomEmployeeModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class ClassroomEmployeeApi {
  Future<List<ClassroomEmployeeModel>> classroomData(
      Map<String, String?> classData) async {
    print("ClassroomEmployee before API: $classData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.classroomEmployeeApi),
        body: classData,
        headers: headers,
        encoding: encoding,
      );

      print("ClassroomEmployee Status Code: ${response.statusCode}");
      print("ClassroomEmployee API Body: ${response.body}");

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
        final list = (respMap as List)
            .map((e) => ClassroomEmployeeModel.fromJson(e))
            .toList();
        List<ClassroomEmployeeModel> classroomList = [];
        list.map((data) => classroomList.add(data)).toList();

        return classroomList;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON  ClassroomEmployeeAPI: $e");
      throw "$e";
    }
  }
}
