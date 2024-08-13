import 'dart:io';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class DeleteClassroomApi {
  Future<bool> classroomData(Map<String, String?> classData) async {
    print("DeleteClassroom before API: $classData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.deleteClassroomApi),
        body: classData,
        headers: headers,
        encoding: encoding,
      );

      print("DeleteClassroom Status Code: ${response.statusCode}");
      print("DeleteClassroom API Body: ${response.body}");

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      // final respMap = json.decode(response.body);

      if (response.statusCode == 200) {
        return true;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON DeleteClassroom API : $e");
      throw "$e";
    }
  }
}
