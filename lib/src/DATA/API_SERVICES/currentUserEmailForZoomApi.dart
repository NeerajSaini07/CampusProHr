import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/currentUserEmailForZoomModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class CurrentUserEmailForZoomApi {
  Future<List<CurrentUserEmailForZoomModel>> emailId(
      Map<String, String?> emailData) async {
    print("CurrentUserEmailForZoom before API: $emailData");
    try {
      final userData = await UserUtils.userTypeFromCache();
      print("CurrentUserEmailForZoom USERTYPE : ${userData!.ouserType!}");
      http.Response response = await http.post(
        Uri.parse(
          userData.ouserType!.toLowerCase() == "e"
              ? ApiEndpoints.currentUserEmailForZoomApi
              : ApiEndpoints.currentUserEmailForZoomAppManagersApi,
        ),
        body: emailData,
        headers: headers,
        encoding: encoding,
      );

      print("CurrentUserEmailForZoom Status Code: ${response.statusCode}");
      print("CurrentUserEmailForZoom API Body: ${response.body}");

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      final respMap = json.decode(response.body);
      print("Get CurrentUserEmailForZoom Response from API: $respMap");

      if (response.statusCode == 200) {
        final emailList = (respMap['Data'][0] as List)
            .map((e) => CurrentUserEmailForZoomModel.fromJson(e))
            .toList();
        return emailList;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON CurrentUserEmailForZoom API: $e");
      throw "$e";
    }
  }
}
