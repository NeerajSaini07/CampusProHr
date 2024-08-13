import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/DATA/MODELS/getGatePassHistoryModal.dart';
import 'package:http/http.dart' as http;
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';

class GetGatePassHistoryApi {
  Future<List<GetGatePassHistoryModal>> getGatePassHistory(
      Map<String, String?> request) async {
    try {
      http.Response response = await http.post(
          Uri.parse(ApiEndpoints.getGatePassHistoryApi),
          body: request,
          encoding: encoding,
          headers: headers);

      print("status code of gate pass history list ${response.statusCode}");
      print("body of gate pass history list ${response.body}");

      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      var respMap = jsonDecode(response.body);

      if (response.statusCode == 200) {
        var data = (respMap["Data"] as List)
            .map((e) => GetGatePassHistoryModal.fromJson(e))
            .toList();
        return data;
      }
      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("error on gate pass history api $e");
      throw e;
    }
  }
}
