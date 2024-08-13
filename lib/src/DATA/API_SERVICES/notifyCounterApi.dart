import 'dart:convert';
import 'dart:io';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/notifyCounterModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class NotifyCounterApi {
  Future<List<NotifyCounterModel>> notificationData(
      Map<String, String?> requestPayload) async {
    print(" Notification before API: $requestPayload");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.notifyCounterApi),
        body: requestPayload,
        headers: headers,
        encoding: encoding,
      );

      print("NotifyCounter Status Code: ${response.statusCode}");
      print("NotifyCounter API Body: ${response.body}");

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
      print("NotifyCounter Response from API: $respMap");

      if (response.statusCode == 200) {
        if (requestPayload['Flag'] == "S") {
          final notifyList = (respMap["Data"] as List);
          List<NotifyCounterModel> item = [];
          notifyList[0].forEach((title, count) =>
              item.add(NotifyCounterModel.fromJson(title, count)));
          return item;
        } else {
          throw "${requestPayload['Flag']!.toLowerCase()}";
        }
      }
      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON NotifyCounter API: $e");
      throw "$e";
    }
  }
}
