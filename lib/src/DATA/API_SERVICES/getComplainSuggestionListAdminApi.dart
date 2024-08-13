import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/getComplainSuggestionListAdminModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class GetComplainSuggestionListAdminApi {
  Future<List<GetComplainSuggestionListAdminModel>> getSuggestionList(
      Map<String, String?> requestPayload) async {
    print("getSuggestionList before API: $requestPayload");

    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.getSuggestionComplainListApi),
        body: requestPayload,
        headers: headers,
        encoding: encoding,
      );

      print("getSuggestionList Status Code: ${response.statusCode}");
      print("getSuggestionList API Body: ${response.body}");
      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      Map<String, dynamic> respMap = json.decode(response.body);
      print("getSuggestionList Response from API: $respMap");
      print(response.statusCode);

      if (response.statusCode == 200) {
        final dataList = (respMap['Data'] as List)
            .map((e) => GetComplainSuggestionListAdminModel.fromJson(e))
            .toList();
        return dataList;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON Send getSuggestionList API: $e");
      throw "$e";
    }
  }
}
