import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/admissionStatusModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class AdmissionStatusApi {
  Future<AdmissionStatusModel> admissionStatus(
      Map<String, String?> admissionData) async {
    print("AdmissionStatus before API: $admissionData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.admissionStatusApi),
        body: admissionData,
        headers: headers,
        encoding: encoding,
      );

      print("AdmissionStatus Status Code: ${response.statusCode}");
      print("AdmissionStatus API Body: ${response.body}");

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
        final data = AdmissionStatusModel.fromJson(respMap[0]);
        return data;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON AdmissionStatus API: $e");
      throw "$e";
    }
  }
}
