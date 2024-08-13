import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class GotoWebAppApi {
  Future<String> gotoWebAppApi(Map<String, String?> request) async {
    final headerToken = await UserUtils.headerTokenFromCache();
    final apiHeaders = headers;
    apiHeaders.addAll({'HeaderToken': headerToken!});
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.gotoWebAppApi),
        body: request,
        encoding: encoding,
        headers: headers,
      );

      print('status code of goto web app ${response.statusCode}');
      print('body of goto web app ${response.body}');

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
        return respMap["Url"] + ",," + respMap["PageName"];
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("error on goto web app $e");
      throw e;
    }
  }
}
