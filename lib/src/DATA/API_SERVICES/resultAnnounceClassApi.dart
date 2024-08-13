import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/resultAnnounceClassModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';

import 'package:http/http.dart' as http;

class ResultAnnounceClassApi {
  Future<List<ResultAnnounceClassModel>> getClass(
      Map<String, dynamic> request) async {
    print('ResultAnnounceClass before api $request');

    try {
      http.Response response = await http.post(
          Uri.parse(ApiEndpoints.getResultAnnounceClassApi),
          body: request,
          headers: headers,
          encoding: encoding);

      print("ResultAnnounceClass Status Code: ${response.statusCode}");
      print("ResultAnnounceClass API Body: ${response.body}");

      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }
      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }
      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      Map<String, dynamic> respMap = jsonDecode(response.body);
      print('Response from api $respMap');
      print('${respMap['Data'][0][0]['ID'].runtimeType}');
      if (response.statusCode == 200) {
        final classList = (respMap['Data'][0] as List)
            .map((e) => ResultAnnounceClassModel.fromJson(e))
            .toList();
        return classList;
      }
      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("Error on ResultAnnounceClass api $e");
      throw e;
    }
  }
}
