import 'dart:io';

import 'package:campus_pro/src/DATA/MODELS/circularEmployeeModel.dart';
import 'dart:convert';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class CircularEmployeeApi {
  Future<List<CircularEmployeeModel>> circularEmployeeData(
      Map<String, String?> requestPayload) async {
    print(" circulatEmployee before API: $requestPayload");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.circularEmployeeApi),
        body: requestPayload,
        headers: headers,
        encoding: encoding,
      );

      print(" circulatEmployee Status Code: ${response.statusCode}");
      print(" circulatEmployee API Body: ${response.body}");

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      Map<String, dynamic> respMap = json.decode(response.body);
      print("Get  circulatEmployee Response from API: $respMap");

      if (response.statusCode == 200) {
        final circulatEmployeeList = (respMap["Data"] as List)
            .map((e) => CircularEmployeeModel.fromJson(e))
            .toList();
        return circulatEmployeeList;
      }
      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON  CircularEmployeeApi: $e");
      throw e;
    }
  }
}
