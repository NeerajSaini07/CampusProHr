import 'dart:convert';
import 'dart:io';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/employeeInfoForSearchModel.dart';
import 'package:http/http.dart' as http;
import '../../UTILS/api_endpoints.dart';

class EmployeeInfoForSearchApi {
  Future<EmployeeInfoForSearchModel> getEmployeeInfoForSearch(
      Map<String, String> employeeData) async {
    print("EmployeeInfoForSearch data before API: $employeeData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.employeeInfoForSearchApi),
        body: employeeData,
        headers: headers,
        encoding: encoding,
      );

      print("GET OUR EmployeeInfoForSearch DATA: ${response.statusCode}");
      print("GET OUR EmployeeInfoForSearch BODY: ${response.body}");

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      Map<String, dynamic> respMap = json.decode(response.body);
      print("EmployeeInfoForSearch Response from API: $respMap");
      if (response.statusCode == 200) {
        final employeeInfoForSearchData =
            EmployeeInfoForSearchModel.fromJson(respMap["Data"][0]);
        // final EmployeeInfoForSearchData = (respMap["Data"] as List).map((e) => EmployeeInfoForSearchModel.fromJson(e)).toList();
        return employeeInfoForSearchData;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON EmployeeInfoForSearch API: $e");
      throw "$e";
    }
  }
}
