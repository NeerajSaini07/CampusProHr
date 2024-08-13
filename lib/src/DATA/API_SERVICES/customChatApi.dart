import 'dart:convert';
import 'dart:io';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/customChatModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class CustomChatApi {
  Future<List<CustomChatModel>> customChatData(
      Map<String, String?> chatData) async {
    print("CustomChat before API: $chatData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.customChatApi),
        body: chatData,
        headers: headers,
        encoding: encoding,
      );

      print("CustomChat Status Code: ${response.statusCode}");
      print("CustomChat API Body: ${response.body}");

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
        final chatList = (respMap['Data'] as List)
            .map((e) => CustomChatModel.fromJson(e))
            .toList();

        return chatList;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON customChat Api: $e");
      throw "$e";
    }
  }
}
