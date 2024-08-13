import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/DATA/MODELS/coordinatorListDetailModel.dart';
import 'package:http/http.dart' as http;
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';

class CoordinatorListDetailApi {
  Future<List<CoordinatorListDetailModel>> getCoordinator(
      Map<String, String?> request) async {
    try {
      http.Response response = await http.post(
          Uri.parse(ApiEndpoints.coordinatorListDetailApi),
          body: request,
          headers: headers,
          encoding: encoding);

      print('status of CoordinatorListDetail ${response.statusCode}');
      print('body of CoordinatorListDetail ${response.body}');

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
            .map((e) => CoordinatorListDetailModel.fromJson(e))
            .toList();
        return data;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print('status of CoordinatorListDetail $e');
      throw e;
    }
  }
}
