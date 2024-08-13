import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/feeTypeModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class FeeTypeApi {
  Future<List<FeeTypeModel>> feeType(Map<String, String?> feeTypeData) async {
    print("FeeType before API: $feeTypeData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.feeTypeApi),
        body: feeTypeData,
        headers: headers,
        encoding: encoding,
      );

      print("FeeType Status Code: ${response.statusCode}");
      print("FeeType API Body: ${response.body}");

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
        final feeTypeList =
            (respMap as List).map((e) => FeeTypeModel.fromJson(e)).toList();
        return feeTypeList;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON FeeType API: $e");
      throw "$e";
    }
  }
}
