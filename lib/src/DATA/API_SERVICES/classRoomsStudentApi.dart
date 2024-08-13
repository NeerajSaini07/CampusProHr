import 'dart:io';

import 'dart:convert';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/classRoomsStudentModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class ClassRoomsStudentApi {
  Future<List<ClassRoomsStudentModel>> classRoomsData(
      Map<String, String?> classData) async {
    print(" ClassRoomsStudent before API: $classData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.classroomsApi),
        body: classData,
        headers: headers,
        encoding: encoding,
      );

      print("ClassRoomsStudent Status Code: ${response.statusCode}");
      print("ClassRoomsStudent API Body: ${response.body}");

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
            .map((e) => ClassRoomsStudentModel.fromJson(e))
            .toList();
        // List<ClassRoomsStudentModel> list = json.decode(respMap['Data']);
        List<ClassRoomsStudentModel> classroomList = [];
        list.map((data) => classroomList.add(data)).toList();

        return classroomList;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON  ClassRoomsStudentAPI: $e");
      throw "$e";
    }
  }
}
