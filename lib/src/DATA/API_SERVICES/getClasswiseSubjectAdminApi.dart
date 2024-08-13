import 'dart:convert';
import 'dart:io';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/getClasswiseSubjectAdminModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class GetClasswiseSubjectAdminApi {
  Future<List<GetClasswiseSubjectAdminModel>> subjectList(
      Map<String, String?> requestPayload) async {
    print(" subject list Admin before API: $requestPayload");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.getClasswiseSubjectAdminApi),
        body: requestPayload,
        headers: headers,
        encoding: encoding,
      );

      print(" subject list Admin Status Code: ${response.statusCode}");
      print(" subject list Admin API Body: ${response.body}");

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
      print("Get subject list Admin Response from API: $respMap");

      final subjectList = (respMap["Data"][0] as List)
          .map((e) => GetClasswiseSubjectAdminModel.fromJson(e))
          .toList();
      return subjectList;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON subject list Admin API: $e");
      throw "$e";
    }
  }
}
