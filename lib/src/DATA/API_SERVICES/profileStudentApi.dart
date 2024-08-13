import 'dart:convert';
import 'dart:io';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/profileStudentModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class ProfileStudentApi {
  Future<List<ProfileStudentModel>> profileData(
      Map<String, String?> requestPayload) async {
    print(" ProfileStudentApi before API: $requestPayload");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.viewProfileApi),
        body: requestPayload,
        headers: headers,
        encoding: encoding,
      );

      print(" ProfileStudentApi Status Code: ${response.statusCode}");
      print(" ProfileStudentApi API Body: ${response.body}");

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      Map<String, dynamic> respMap = json.decode(response.body);
      print("ProfileStudentApi Response from API: $respMap");

      final profileStdData = (respMap["Data"] as List)
          .map((e) => ProfileStudentModel.fromJson(e))
          .toList();
      return profileStdData;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON  ProfileStudentApi API: $e");
      throw "$e";
    }
  }
}
