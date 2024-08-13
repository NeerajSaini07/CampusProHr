import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/feeReceiptsModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class FeeReceiptsApi {
  Future<List<FeeReceiptsModel>> feeReceipts(
      Map<String, String?> feeReceiptsData) async {
    print("FeeReceipts before API: $feeReceiptsData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.feeReceiptsApi),
        body: feeReceiptsData,
        headers: headers,
        encoding: encoding,
      );

      print("FeeReceipts Status Code: ${response.statusCode}");
      print("FeeReceipts API Body: ${response.body}");

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
        final feeReceiptsList =
            (respMap as List).map((e) => FeeReceiptsModel.fromJson(e)).toList();
        return feeReceiptsList;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON FeeReceipts API: $e");
      throw "$e";
    }
  }
}
