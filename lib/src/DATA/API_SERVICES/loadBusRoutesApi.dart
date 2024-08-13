import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/loadBusRoutesModel.dart';
import 'package:http/http.dart' as http;
import 'package:campus_pro/src/UTILS/api_endpoints.dart';

class LoadBusRoutesApi {
  Future<List<LoadBusRoutesModel>> getBusRoutes(
      Map<String, String?> request) async {
    try {
      http.Response response = await http.post(Uri.parse(ApiEndpoints.getBusRoutesAdmin),
          body: request, headers: headers, encoding: encoding);

      print('response of bus routes ${response.statusCode}');
      print('body of bus routes ${response.body}');

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }
      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }
      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      Map<String, dynamic> respMap = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final data = (respMap['Data'][0] as List)
            .map((e) => LoadBusRoutesModel.fromJson(e))
            .toList();
        return data;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print('error on load bus api $e');
      throw e;
    }
  }
}
