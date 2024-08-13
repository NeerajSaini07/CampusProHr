import 'dart:convert';
import 'dart:io';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/schoolBusRouteModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class SchoolBusRouteApi {
  Future<SchoolBusRouteModel> fetchBusRoute(
      Map<String, String?> routeData) async {
    print("SchoolBusRoute before API: $routeData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.schoolBusRouteApi),
        body: routeData,
        headers: headers,
        encoding: encoding,
      );

      print("SchoolBusRoute Status Code: ${response.statusCode}");
      print("SchoolBusRoute API Body: ${response.body}");

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
      print("SchoolBusRoute Response from API: $respMap");

      if (response.statusCode == 200) {
        final busRouteData = SchoolBusRouteModel.fromJson(respMap);
        return busRouteData;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON SchoolBusRoute API: $e");
      throw "$e";
    }
  }
}
