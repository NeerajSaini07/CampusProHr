import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';

class AddNewRemarkApi {
  Future<String> addRemark(Map<String, String?> data) async {
    try {
      http.Response response = await http.post(Uri.parse(ApiEndpoints.addNewRemarkApi),
          body: data, encoding: encoding, headers: headers);

      print("status code of add new remark api ${response.statusCode}");
      print("body of add new remark api ${response.body}");

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }
      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return result;
      }
      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("error on api $e");
      throw e;
    }
  }
}
