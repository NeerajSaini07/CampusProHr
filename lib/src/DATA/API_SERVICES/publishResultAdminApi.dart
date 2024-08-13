import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class PublishResultAdminApi {
  Future<String> getResultPublish(Map<String, String?> request) async {
    print('Sending data before api result announce $request');
    try {
      http.Response response = await http.post(
          Uri.parse(ApiEndpoints.resultAnnounceAdmin),
          body: request,
          headers: headers,
          encoding: encoding);

      if (response.statusCode == 500) {
        return SOMETHING_WENT_WRONG;
      }
      if (response.statusCode == 401) {
        return UNAUTHORIZED_USER;
      }
      if (response.statusCode == 204) {
        return NO_RECORD_FOUND;
      }

      print('status code of publish result ${response.statusCode}');
      print('body of publish result ${response.body}');

      if (response.statusCode == 200) {
        // if (response.body == "Success") {
        //   return 'Success';
        // }
        return "Success";
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print('Error in publish api $e}');
      throw e;
    }
  }
}
