import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/loadAddressGroupModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class LoadAddressGroupApi {
  Future<List<LoadAddressGroupModel>> getAddress(
      Map<String, String?> request) async {
    try {
      http.Response response = await http.post(Uri.parse(ApiEndpoints.getAddressAdmin),
          body: request, encoding: encoding, headers: headers);

      print('status of address api ${response.statusCode}');
      print('body of address api ${response.body}');

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      List<dynamic> respMap = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final data =
            respMap.map((e) => LoadAddressGroupModel.fromJson(e)).toList();
        return data;
      }
      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print('error on address api $e');
      throw e;
    }
  }
}
