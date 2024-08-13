import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/DATA/MODELS/getPopupMessageListModel.dart';
import 'package:http/http.dart' as http;
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';

class GetPopupMessageListApi {
  Future<List<GetPopupMessageListModel>> getPopupList(
      Map<String, String?> request) async {
    try {
      http.Response response = await http.post(
          Uri.parse(ApiEndpoints.getPopupMessageListApi),
          body: request,
          headers: headers,
          encoding: encoding);

      print('status PopupMessageListApi api ${response.statusCode}');
      print('status PopupMessageListApi api ${response.body}');

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }
      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }
      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      var respMap = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final data = (respMap['Data'] as List)
            .map((e) => GetPopupMessageListModel.fromJson(e))
            .toList();
        return data;
      }
      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print('error on GetPopupMessageListModel api $e');
      throw e;
    }
  }
}
