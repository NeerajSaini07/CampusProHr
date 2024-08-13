import 'dart:convert';
import 'dart:io';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class SchoolSettingAllowDiscountApi {
  Future<String> schoolSettingAllowDiscountData(
      Map<String, String?> requestPayload) async {
    print("SchoolSettingAllowDiscount before API: $requestPayload");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.schoolSettingAllowDiscountApi),
        body: requestPayload,
        headers: headers,
        encoding: encoding,
      );

      print("SchoolSettingAllowDiscount Status Code: ${response.statusCode}");
      print("SchoolSettingAllowDiscount API Body: ${response.body}");

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
      print("SchoolSettingAllowDiscount Response from API: $respMap");

      if (response.statusCode == 200) {
        return "";
      }
      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON SchoolSettingAllowDiscount API: $e");
      throw "$e";
    }
  }
}
