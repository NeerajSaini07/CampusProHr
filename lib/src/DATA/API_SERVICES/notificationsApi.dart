import 'dart:convert';
import 'dart:io';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/notificationsModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class NotificationsApi {
  Future<List<NotificationsModel>> notificationData(
      Map<String, String?> requestPayload) async {
    print(" Notification before API: $requestPayload");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.notificationApi),
        body: requestPayload,
        headers: headers,
        encoding: encoding,
      );

      print(" Notification Status Code: ${response.statusCode}");
      print(" Notification API Body: ${response.body}");

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
      print("Get  Notification Response from API: $respMap");

      final notificationList = (respMap["Data"] as List)
          .map((e) => NotificationsModel.fromJson(e))
          .toList();
      return notificationList;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON  Notification API: $e");
      throw "$e";
    }
  }
}
