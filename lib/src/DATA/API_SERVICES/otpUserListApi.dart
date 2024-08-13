import 'dart:convert';
import 'dart:io';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/otpUserListModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class OtpUserListApi {
  Future<List<OtpUserListModel>> otpUserList(
      Map<String, String?> requestPayload, bool status) async {
    print("OtpUserList before API: $requestPayload");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.otpUserListApi),
        body: requestPayload,
        headers: headers,
        encoding: encoding,
      );

      print("OtpUserList Status Code: ${response.statusCode}");
      print("OtpUserList API Body: ${response.body}");

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
      print("OtpUserList Response from API: $respMap");

      if (response.statusCode == 200) {
        if (status) {
          return [];
        } else {
          final list = (respMap["Data"] as List)
              .map((e) => OtpUserListModel.fromJson(e))
              .toList();
          return list;
        }
      }
      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON OtpUserList: $e");
      throw e;
    }
  }
}
