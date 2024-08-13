import 'dart:convert';
import 'dart:io';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/models.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class AccountTypeApi {
  Future<List<AccountType>> getAccountTypes(Map<String, String> userTypeData) async {
    print("AccountType data before API: $userTypeData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.accountTypes),
        body: userTypeData,
        headers: headers,
        encoding: encoding,
      );

      print("AccountTypeApi data status code: ${response.statusCode}");
      print("AccountTypeApi data body: ${response.body}");

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      if (response.statusCode == 503) {
        throw UnderConstruction;
      }

      final userTypes = accountTypesFromJson(json.decode(response.body));
      return userTypes;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON Account TYPE API: $e");
      throw "$e";
    }
  }
}
