import 'dart:convert';
import 'dart:io';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/appUserListModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class AppUserListApi {
  Future<List<AppUserListModel>> appUserList(
      Map<String, String?> requestPayload, bool coordinator) async {
    print("AppUserList before API: $requestPayload");
    try {
      http.Response response = await http.post(
        Uri.parse(
            coordinator ? ApiEndpoints.appUserListForCordinatorApi : ApiEndpoints.appUserListApi),
        body: requestPayload,
        headers: headers,
        encoding: encoding,
      );

      print("AppUserList Status Code: ${response.statusCode}");
      print("AppUserList API Body: ${response.body}");

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
      print("AppUserList Response from API: $respMap");

      if (response.statusCode == 200) {
        final list =
            (respMap as List).map((e) => AppUserListModel.fromJson(e)).toList();
        return list;
      }
      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON AppUserList: $e");
      throw e;
    }
  }
}
