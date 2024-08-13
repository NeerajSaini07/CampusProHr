import 'dart:convert';
import 'dart:io';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/dashboardAdminModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class DashboardAdminApi {
  Future<DashboardAdminModel> dashboardAdminData(
      Map<String, String?> chatData) async {
    print("DashboardAdmin before API: $chatData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.dashboardAdminApi),
        body: chatData,
        headers: headers,
        encoding: encoding,
      );

      print("DashboardAdmin Status Code: ${response.statusCode}");
      print("DashboardAdmin API Body: ${response.body}");

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
        final data = DashboardAdminModel.fromJson(respMap['Data'][0]);
        return data;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON DashboardAdmin Api: $e");
      throw "$e";
    }
  }
}
