import 'dart:convert';
import 'dart:io';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/mainModeWiseFeeModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class MainModeWiseFeeApi {
  Future<List<MainModeWiseFeeModel>> mainModeWiseFeeData(
      Map<String, String?> requestPayload) async {
    print("MainModeWiseFee before API: $requestPayload");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.mainModeWiseFeeApi),
        body: requestPayload,
        headers: headers,
        encoding: encoding,
      );

      print("MainModeWiseFee Status Code: ${response.statusCode}");
      print("MainModeWiseFee API Body: ${response.body}");

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
      print("MainModeWiseFee Response from API: $respMap");

      if (response.statusCode == 200) {
        final payList = (respMap as List)
            .map((e) => MainModeWiseFeeModel.fromJson(e))
            .toList();
        return payList;
      }
      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON MainModeWiseFee API: $e");
      throw "$e";
    }
  }
}
