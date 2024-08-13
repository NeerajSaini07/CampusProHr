import 'dart:convert';
import 'dart:io';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class CreateUserStudentStatusApi {
  Future<bool> createUserStudentStatus(
      Map<String, String?> createUserData) async {
    print("CreateUserStudentStatusApi before API: $createUserData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.createUserStudentStatusApi),
        body: createUserData,
        headers: headers,
        encoding: encoding,
      );

      print(
          "CreateUserStudentStatusApi API Status Code: ${response.statusCode}");
      print("CreateUserStudentStatusApi API Body: ${response.body}");

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      Map<String, dynamic> respMap = json.decode(response.body);

      print("CreateUserStudentStatusApi Response from API: $respMap");

      if (response.statusCode == 200) {
        return true;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON CreateUserStudentStatusApi: $e");
      throw "$e";
    }
  }
}
