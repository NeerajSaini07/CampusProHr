import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/feeBalanceEmployeeModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class FeeBalanceEmployeeApi {
  Future<List<FeeBalanceEmployeeModel>> feeBalance(
      Map<String, String?> requestPayload) async {
    print("feebalance before API: $requestPayload");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.feeBalanceEmployeeFeeListApi),
        body: requestPayload,
        headers: headers,
        encoding: encoding,
      );

      print("feebalance Status Code: ${response.statusCode}");
      print("feebalance API Body: ${response.body}");

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      List<dynamic> respMap = json.decode(response.body);
      print("Get feebalance Response from API: $respMap");

      final feeBalList =
          (respMap).map((e) => FeeBalanceEmployeeModel.fromJson(e)).toList();
      return feeBalList;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON feebalance API: $e");
      throw "$e";
    }
  }
}
