import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:http/http.dart' as http;
import 'package:campus_pro/src/DATA/MODELS/drawerModel.dart';

import '../../UTILS/api_endpoints.dart';

class DrawerApi {
  Future<List<DrawerModel>> getDrawerItems(Map<String, String> drawerData, String headerToken) async {
    print("drawerData before API: $drawerData");

    final apiHeaders = headers;
    apiHeaders.addAll({
      'HeaderToken': headerToken
    });
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.drawerApi),
        body: drawerData,
        headers: apiHeaders,
        encoding: encoding,
      );

      print("Drawer API Status Code: ${response.statusCode}");
      print("Drawer API Body: ${response.body}");

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
      // if (response.statusCode == 200) {
      print("Drawer Response from API: $respMap");

      if (response.statusCode == 200) {
        //if (respMap['Data'].length > 1) {
        final drawerItems = (respMap['Data'] as List).map((e) => DrawerModel.fromJson(e)).toList();

        //print("drawerItems[3] from API: ${respMap['Data'][2]}");
        return drawerItems;
        // }
      }

      throw respMap['message'] as String;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON DRAWER API: $e");
      throw "$e";
    }
  }
}
