import 'dart:convert';
import 'dart:io';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/fetchClientSecretIdModel.dart';
import 'package:campus_pro/src/DATA/MODELS/schoolBusDetailModel.dart';
import 'package:campus_pro/src/DATA/MODELS/schoolBusRouteModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class SchoolBusDetailApi {
  Future<SchoolBusDetailModel> busInfoData(Map<String, String?> busData) async {
    print("SchoolBusDetail before API: $busData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.schoolBusDetailApi),
        body: busData,
        headers: headers,
        encoding: encoding,
      );

      print("SchoolBusDetail Status Code: ${response.statusCode}");
      print("SchoolBusDetail API Body: ${response.body}");

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
      print("SchoolBusDetail Response from API: $respMap");

      if (response.statusCode == 200) {
        final busDetailData =
            SchoolBusDetailModel.fromJson(respMap['Data'][0][0]);
        return busDetailData;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON SchoolBusDetail API: $e");
      throw "$e";
    }
  }
}
