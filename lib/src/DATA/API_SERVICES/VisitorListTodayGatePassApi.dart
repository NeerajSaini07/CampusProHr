import 'dart:convert';
import 'dart:io';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/visitorListTodayModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class VisitorListTodayGatePassApi {
  Future<List<VisitorListTodayGatePassModel>> getList(
      Map<String, String?> subjectList) async {
    print("VisitorListTodayGatePassApi before API: $subjectList");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.getVisitorListApi),
        body: subjectList,
        headers: headers,
        encoding: encoding,
      );

      print(" VisitorListTodayGatePassApi Status Code: ${response.statusCode}");
      print(" VisitorListTodayGatePassApi API Body: ${response.body}");

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      var respMap = json.decode(response.body);

      if (response.statusCode == 200) {
        final subjectList = (respMap['Data'] as List)
            .map((e) => VisitorListTodayGatePassModel.fromJson(e))
            .toList();
        return subjectList;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON  VisitorListTodayGatePassApi List API: $e");
      throw "$e";
    }
  }
}
