import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';

class GetSchoolSettingApi {
  Future<String> schoolSetting(Map<String, String?> payload) async {
    try {
      http.Response response = await http.post(
          Uri.parse(ApiEndpoints.getSchoolSettingApi),
          body: payload,
          headers: headers,
          encoding: encoding);

      print("status code of get school setting api ${response.statusCode}");
      print("body of get school setting api ${response.body}");

      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      var respMap = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return respMap;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet$e");
      throw NO_INTERNET;
    } catch (e) {
      print("error on get school setting api $e");
      throw e;
    }
  }
}
