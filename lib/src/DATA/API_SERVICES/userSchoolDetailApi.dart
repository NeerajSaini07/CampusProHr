import 'dart:convert';
import 'dart:io';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/userSchoolDetailModel.dart';
import 'package:campus_pro/src/DATA/MODELS/userTypeModel.dart';
import 'package:http/http.dart' as http;
import '../../UTILS/api_endpoints.dart';

class UserSchoolDetailApi {
  Future<UserSchoolDetailModel> getUserSchool(
      Map<String, String> userData) async {
    print("UserSchoolDetail data before API: $userData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.userSchoolDetailApi),
        body: userData,
        headers: headers,
        encoding: encoding,
      );

      print("UserSchoolDetail Status on API Response: ${response.statusCode}");
      print("UserSchoolDetail Body on API Response: ${response.body}");

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      final respMap = json.decode(response.body);
      final schoolDetail =
          UserSchoolDetailModel.fromJson(respMap['Data'][0][0]);
      return schoolDetail;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON UserSchoolDetail API: $e");
      throw "$e";
    }
  }
}
