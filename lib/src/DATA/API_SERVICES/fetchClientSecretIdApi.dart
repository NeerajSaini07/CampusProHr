import 'dart:convert';
import 'dart:io';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/fetchClientSecretIdModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class FetchClientSecretIdApi {
  Future<FetchClientSecretIdModel> fetchIDs(Map<String, String?> data) async {
    print("FetchClientSecretId before API: $data");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.fetchClientSecretIdApi),
        body: data,
        headers: headers,
        encoding: encoding,
      );

      print("FetchClientSecretId Status Code: ${response.statusCode}");
      print("FetchClientSecretId API Body: ${response.body}");

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
      print("FetchClientSecretId Response from API: $respMap");

      if (response.statusCode == 200) {
        final clientId = FetchClientSecretIdModel();
        return clientId;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON SaveScheduleMeeting API: $e");
      throw "$e";
    }
  }
}
