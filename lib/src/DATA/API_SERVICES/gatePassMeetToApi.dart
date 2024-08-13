import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/DATA/MODELS/gatePassMeetToModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';

class GatePassMeetToApi {
  Future<List<GatePassMeetToModel>> getData(
      Map<String, String?> payload, int? num) async {
    try {
      http.Response response = await http.post(
          Uri.parse(num == 0 ? ApiEndpoints.gatePassMeetToApi : ApiEndpoints.gatePassPurposeApi),
          body: payload,
          headers: headers,
          encoding: encoding);

      print("status of gatePassMeet of api ${response.statusCode}");
      print("body of gatePassMeet of api ${response.body}");

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      var respMap = jsonDecode(response.body);

      if (response.statusCode == 200) {
        var data = (respMap["Data"] as List)
            .map((e) => GatePassMeetToModel.fromJson(e))
            .toList();
        return data;
      }
      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("error on gate pass Meet to $e");
      throw e;
    }
  }
}
