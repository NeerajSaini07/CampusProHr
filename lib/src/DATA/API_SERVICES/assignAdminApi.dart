import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/assignAdminModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class AssignAdminApi {
  Future<List<AssignAdminModel>> assignAdmin(
      Map<String, String?> assignData) async {
    print("AssignAdmin before API: $assignData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.assignAdminApi),
        body: assignData,
        headers: headers,
        encoding: encoding,
      );

      print("AssignAdmin Status Code: ${response.statusCode}");
      print("AssignAdmin API Body: ${response.body}");

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
        final adminList = (respMap['Data'] as List)
            .map((e) => AssignAdminModel.fromJson(e))
            .toList();
        return adminList;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON AssignAdmin API: $e");
      throw "$e";
    }
  }
}
