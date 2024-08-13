import 'dart:io';

import 'package:campus_pro/src/DATA/MODELS/circularStudentModel.dart';
import 'dart:convert';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class CircularStudentApi {
  Future<List<CircularStudentModel>> circularStudentData(
      Map<String, String?> requestPayload) async {
    print(" circulatStudent before API: $requestPayload");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.circularStudentApi),
        body: requestPayload,
        headers: headers,
        encoding: encoding,
      );

      print(" circulatStudent Status Code: ${response.statusCode}");
      print(" circulatStudent API Body: ${response.body}");

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
      print("Get  circulatStudent Response from API: $respMap");

      if (response.statusCode == 200) {
        final circulatStudentList = (respMap["Data"] as List)
            .map((e) => CircularStudentModel.fromJson(e))
            .toList();
        return circulatStudentList;
      }
      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON  CircularApi: $e");
      throw e;
    }
  }
}
