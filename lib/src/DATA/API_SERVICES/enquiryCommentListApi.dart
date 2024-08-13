import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/enquiryCommentListModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class EnquiryCommentListApi {
  Future<List<EnquiryCommentListModel>> enquiryCommentList(
      Map<String, String?> commentData) async {
    print("EnquiryCommentList before API: $commentData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.enquiryCommentListApi),
        body: commentData,
        headers: headers,
        encoding: encoding,
      );

      print("EnquiryCommentList Status Code: ${response.statusCode}");
      print("EnquiryCommentList API Body: ${response.body}");

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

      print("EnquiryCommentList Response from API: $respMap");

      if (response.statusCode == 200) {
        final commentList = (respMap['Data'] as List)
            .map((e) => EnquiryCommentListModel.fromJson(e))
            .toList();
        return commentList;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON EnquiryCommentList API: $e");
      throw "$e";
    }
  }
}
