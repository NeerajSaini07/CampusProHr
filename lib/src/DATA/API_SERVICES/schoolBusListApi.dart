import 'dart:convert';
import 'dart:io';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/schoolBusListModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class SchoolBusListApi {
  Future<List<SchoolBusListModel>> busInfoData(
      Map<String, String?> busData) async {
    print("SchoolBusList before API: $busData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.schoolBusListApi),
        body: busData,
        headers: headers,
        encoding: encoding,
      );

      print("SchoolBusList Status Code: ${response.statusCode}");
      print("SchoolBusList API Body: ${response.body}");

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
      print("SchoolBusList Response from API: $respMap");

      if (response.statusCode == 200) {
        final busDetailData = (respMap['Data'] as List)
            .map((e) => SchoolBusListModel.fromJson(e))
            .toList();
        return busDetailData;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON SchoolBusList API: $e");
      throw "$e";
    }
  }
}
