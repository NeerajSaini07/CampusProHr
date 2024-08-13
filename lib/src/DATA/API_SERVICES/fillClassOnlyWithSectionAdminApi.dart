import 'dart:convert';
import 'dart:io';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/fillClassOnlyWithSectionAdminModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class FillClassOnlyWithSectionAdminApi {
  Future<List<FillClassOnlyWithSectionAdminModel>> classList(
      Map<String, String?> requestPayload) async {
    print(" ClassList Admin before API: $requestPayload");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.fillClassOnlyWithSectionAdmin),
        body: requestPayload,
        headers: headers,
        encoding: encoding,
      );

      print(" ClassList Admin Status Code: ${response.statusCode}");
      print(" ClassList Admin API Body: ${response.body}");

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
      print("Get ClassList Admin Response from API: $respMap");

      final classesList = (respMap["Data"][0] as List)
          .map((e) => FillClassOnlyWithSectionAdminModel.fromJson(e))
          .toList();
      return classesList;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON ClassList Admin API: $e");
      throw "$e";
    }
  }
}
