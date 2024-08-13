import 'dart:io';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class MarkVisitorExitApi {
  Future<String> markExit(Map<String, String?> subjectList, int num) async {
    print("MarkVisitorExitApi before API: $subjectList");
    try {
      http.Response response = await http.post(
        Uri.parse(num == 0 ? ApiEndpoints.markVisitorExitApi : ApiEndpoints.markGatePassExitApi),
        body: subjectList,
        headers: headers,
        encoding: encoding,
      );

      print(" MarkVisitorExitApi Status Code: ${response.statusCode}");
      print(" MarkVisitorExitApi API Body: ${response.body}");

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      // var respMap = json.decode(response.body);

      if (response.statusCode == 200) {
        return "Success";
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON  MarkVisitorExitApi : $e");
      throw "$e";
    }
  }
}
