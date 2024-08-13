import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/feeTransactionHistoryModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class FeeTransactionHistoryApi {
  Future<List<FeeTransactionHistoryModel>> feeTransactionHistory(
      Map<String, String?> feeData) async {
    print("FeeTransactionHistory before API: $feeData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.feeTransactionApi),
        body: feeData,
        headers: headers,
        encoding: encoding,
      );

      print("FeeTransactionHistory Status Code: ${response.statusCode}");
      print("FeeTransactionHistory API Body: ${response.body}");

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

      if (response.statusCode == 200) {
        final feeTransactionList = (respMap['Data'] as List)
            .map((e) => FeeTransactionHistoryModel.fromJson(e))
            .toList();
        return feeTransactionList;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON FeeTransactionHistory API: $e");
      throw "$e";
    }
  }
}
