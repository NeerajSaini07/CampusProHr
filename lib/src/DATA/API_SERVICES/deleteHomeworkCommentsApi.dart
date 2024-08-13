import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class DeleteHomeworkCommentApi {
  Future<bool> deleteHomeworkComments(Map<String, String?> comments) async {
    print("DeleteHomeworkComments before API: $comments");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.deleteHomeworkCommentsApi),
        body: comments,
        headers: headers,
        encoding: encoding,
      );

      print("DeleteHomeworkComments Status Code: ${response.statusCode}");
      print("DeleteHomeworkComments API Body: ${response.body}");

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
      print("DeleteHomeworkComments Response from API: $respMap");
      print("response.body from API: ${response.body}");
      // String json.decode(response.body);

      if (response.statusCode == 200) {
        return true;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON DeleteHomeworkComments API: $e");
      throw "$e";
    }
  }
}
