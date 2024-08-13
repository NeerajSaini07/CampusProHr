import 'dart:convert';
import 'dart:io';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/payModeWiseFeeModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class PayModeWiseFeeApi {
  Future<PayModeWiseFeeModel> payModeWiseFeeData(
      Map<String, String?> requestPayload) async {
    print("PayModeWiseFee before API: $requestPayload");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.payModeWiseFeeApi),
        body: requestPayload,
        headers: headers,
        encoding: encoding,
      );

      print("PayModeWiseFee Status Code: ${response.statusCode}");
      print("PayModeWiseFee API Body: ${response.body}");

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
      print("PayModeWiseFee Response from API: $respMap");

      if (response.statusCode == 200) {
        final payData = PayModeWiseFeeModel.fromJson(respMap[0]);
        return payData;
      }
      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON PayModeWiseFee API: $e");
      throw "$e";
    }
  }
}
