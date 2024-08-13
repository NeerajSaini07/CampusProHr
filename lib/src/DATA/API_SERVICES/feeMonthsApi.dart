import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/feeMonthsModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class FeeMonthsApi {
  Future<List<FeeMonthsModel>> feeMonths(
      Map<String, String?> feeMonthsData) async {
    print("FeeMonths before API: $feeMonthsData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.feeMonthsApi),
        body: feeMonthsData,
        headers: headers,
        encoding: encoding,
      );

      print("FeeMonths Status Code: ${response.statusCode}");
      print("FeeMonths API Body: ${response.body}");

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
        final feeMonthList = (respMap['Data'] as List)
            .map((e) => FeeMonthsModel.fromJson(e))
            .toList();
        return feeMonthList;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON FeeMonths API: $e");
      throw "$e";
    }
  }
}
