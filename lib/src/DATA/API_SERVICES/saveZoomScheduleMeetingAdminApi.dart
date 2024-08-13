import 'dart:convert';
import 'dart:io';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:http/http.dart' as http;
import '../../UTILS/api_endpoints.dart';

class SaveZoomScheduleMeetingAdminApi {
  Future<bool> scheduleMeetingAdmin(Map<String, String?> meetingData) async {
    print("SaveZoomScheduleMeetingAdmin data before API: $meetingData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.saveZoomScheduleMeetingAdminApi),
        body: meetingData,
        headers: headers,
        encoding: encoding,
      );

      print(
          "SaveZoomScheduleMeetingAdmin status code on API: ${response.statusCode}");
      print("SaveZoomScheduleMeetingAdmin body on API: ${response.body}");

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      final respMap = json.decode(response.body);
      print("SaveZoomScheduleMeetingAdmin Response from API: $respMap");

      if (response.statusCode == 200) {
        return true;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON SaveZoomScheduleMeetingAdmin API: $e");
      throw "$e";
    }
  }
}
