import 'dart:convert';
import 'dart:io';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/partyTypeBillApproveModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class PartyTypeBillApproveApi {
  Future<List<PartyTypeBillApproveModel>> partyTypeBillApproveData(
      Map<String, String?> requestPayload) async {
    print("PartyTypeBillApprove before API: $requestPayload");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.partyTypeBillApproveApi),
        body: requestPayload,
        headers: headers,
        encoding: encoding,
      );

      print("PartyTypeBillApprove Status Code: ${response.statusCode}");
      print("PartyTypeBillApprove API Body: ${response.body}");

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
      print("PartyTypeBillApprove Response from API: $respMap");

      if (response.statusCode == 200) {
        final payList = (respMap as List)
            .map((e) => PartyTypeBillApproveModel.fromJson(e))
            .toList();
        return payList;
      }
      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON PartyTypeBillApprove API: $e");
      throw "$e";
    }
  }
}
