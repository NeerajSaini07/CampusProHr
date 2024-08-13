import 'dart:convert';
import 'dart:io';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/downloadAppUserDataModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class DownloadAppUserDataApi {
  Future<List<DownloadAppUserDataModel>> downloadAppUserData(
      Map<String, String?> requestPayload) async {
    print("DownloadAppUserData before API: $requestPayload");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.downloadAppUserDataApi),
        body: requestPayload,
        headers: headers,
        encoding: encoding,
      );

      print("DownloadAppUserData Status Code: ${response.statusCode}");
      print("DownloadAppUserData API Body: ${response.body}");

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
      print("DownloadAppUserData Response from API: $respMap");

      if (response.statusCode == 200) {
        final list = (respMap["Data"] as List)
            .map((e) => DownloadAppUserDataModel.fromJson(e))
            .toList();
        return list;
      }
      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON DownloadAppUserData: $e");
      throw e;
    }
  }
}
