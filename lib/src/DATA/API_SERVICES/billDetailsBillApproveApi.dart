import 'dart:convert';
import 'dart:io';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/billDetailsBillApproveModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class BillDetailsBillApproveApi {
  Future<BillDetailsBillApproveModel> billDetailsBillApproveData(
      Map<String, String?> requestPayload) async {
    print("BillDetailsBillApprove before API: $requestPayload");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.billDetailsBillApproveApi),
        body: requestPayload,
        headers: headers,
        encoding: encoding,
      );

      print("BillDetailsBillApprove Status Code: ${response.statusCode}");
      print("BillDetailsBillApprove API Body: ${response.body}");

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
      print("BillDetailsBillApprove Response from API: $respMap");

      if (response.statusCode == 200) {
        final payData =
            BillDetailsBillApproveModel.fromJson(respMap['Data'][0]);
        return payData;
      }
      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON BillDetailsBillApprove API: $e");
      throw "$e";
    }
  }
}
