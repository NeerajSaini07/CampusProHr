import 'dart:convert';
import 'dart:io';
import 'package:campus_pro/src/DATA/MODELS/getMinMaxmarksModel.dart';
import 'package:http/http.dart' as http;
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';

class GetMinMaxMarksApi {
  Future<List<GetMinMaxmarksModel>> getMinMaxMarks(
      Map<String, String?> request) async {
    try {
      http.Response response = await http.post(
          Uri.parse(ApiEndpoints.getMinMaxExamAdmin),
          body: request,
          headers: headers,
          encoding: encoding);

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }
      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }
      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      print('status for min marks api ${response.statusCode}');
      print('body for min marks api ${response.body}');

      List<dynamic> respMap = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final data =
            (respMap).map((e) => GetMinMaxmarksModel.fromJson(e)).toList();
        return data;
      }
      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print('error on min max marks $e');
      throw e;
    }
  }
}
