import 'dart:convert';
import 'dart:io';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/nearByBusesModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class NearByBusesApi {
  Future<List<NearByBusesModel>> nearByBusesData(
      Map<String, String?> requestPayload) async {
    print("NearByBuses before API: $requestPayload");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.nearByBusesApi),
        body: requestPayload,
        headers: headers,
        encoding: encoding,
      );

      print("NearByBuses Status Code: ${response.statusCode}");
      print("NearByBuses API Body: ${response.body}");

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
      print("NearByBuses Response from API: $respMap");

      if (response.statusCode == 200) {
        final busesList = (respMap['Data'] as List)
            .map((e) => NearByBusesModel.fromJson(e))
            .toList();
        return busesList;
      }
      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON NearByBuses API: $e");
      throw "$e";
    }
  }
}
