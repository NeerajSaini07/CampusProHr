import 'dart:convert';
import 'dart:io';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/allowDiscountListModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class AllowDiscountListApi {
  Future<List<AllowDiscountListModel>> allowDiscountListData(
      Map<String, String?> requestPayload) async {
    print("AllowDiscountList before API: $requestPayload");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.allowDiscountListApi),
        body: requestPayload,
        headers: headers,
        encoding: encoding,
      );

      print("AllowDiscountList Status Code: ${response.statusCode}");
      print("AllowDiscountList API Body: ${response.body}");

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
      print("AllowDiscountList Response from API: $respMap");

      if (response.statusCode == 200) {
        final payList = (respMap["Data"] as List)
            .map((e) => AllowDiscountListModel.fromJson(e))
            .toList();
        return payList;
      }
      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON AllowDiscountList API: $e");
      throw "$e";
    }
  }
}
