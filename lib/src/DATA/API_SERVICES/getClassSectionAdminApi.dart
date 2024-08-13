import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/getClassSectionAdminModel.dart';

class GetClassSectionAdminApi {
  Future<List<GetClassSectionAdminModel>> getSection(
      Map<String, String?> request) async {
    try {
      http.Response response = await http.post(
          Uri.parse(ApiEndpoints.getClassSectionAdmin),
          body: request,
          headers: headers,
          encoding: encoding);

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }
      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }
      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      print('status of class section admin ${response.statusCode}');
      print('body of class section admin ${response.body}');

      Map<String, dynamic> respMap = jsonDecode(response.body);
      print('');
      if (response.statusCode == 200) {
        final data = (respMap['Data'][0] as List)
            .map((e) => GetClassSectionAdminModel.fromJson(e))
            .toList();
        return data;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print('error on class section admin api $e');
      throw e;
    }
  }
}
