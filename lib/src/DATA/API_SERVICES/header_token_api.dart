import 'dart:convert';
import 'dart:io';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class HeaderTokenApi {
  Future<String> getHeaderToken(Map<String, String> data) async {
    print("HeaderToken data before API: $data");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.getHeaderToken),
        body: data,
        headers: headers,
        encoding: encoding,
      );

      print("HeaderTokenApi data status code: ${response.statusCode}");
      print("HeaderTokenApi data body: ${response.body}");

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      if (response.statusCode == 503) {
        throw UnderConstruction;
      }

      final String headerToken = json.decode(response.body)['Data'].first['HeaderToken'];
      await UserUtils.cacheHeaderToken(headerToken);
      return headerToken;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON Header Token API: $e");
      throw "$e";
    }
  }
}
