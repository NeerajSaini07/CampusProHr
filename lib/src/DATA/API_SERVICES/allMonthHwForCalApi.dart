import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/DATA/MODELS/AllMonthHwForCalModal.dart';
import 'package:http/http.dart' as http;
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';

class AllMonthHwForCalApi {
  Future<List<AllMonthHwForCalModal>> hwList(
      Map<String, String?> request) async {
    try {
      http.Response response = await http.post(
          Uri.parse(ApiEndpoints.allMonthHwForCalApi),
          body: request,
          encoding: encoding,
          headers: headers);

      print("status for all month hw for cal ${response.statusCode}");
      print("body for all month hw for cal ${response.body}");

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      var respMap = jsonDecode(response.body);

      if (response.statusCode == 200) {
        var data = (respMap["Data"] as List)
            .map((e) => AllMonthHwForCalModal.fromJson(e))
            .toList();
        return data;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("No internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("error on all month hw $e");
      throw e;
    }
  }
}
