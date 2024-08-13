import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/feeBalanceMonthListEmployeeModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class FeeBalanceMonthListEmployeeApi {
  Future<List<FeeBalanceMonthListEmployeeModel>> getMonth(
      Map<String, String?> classList) async {
    // var json = '''
    //  [{"ID":"202#202#1444#1#1","ClassName":"V-A-A3"},{"ID":"204#204#1418#1#1","ClassName":"VII-A2"},{"ID":"204#204#1445#1#1","ClassName":"VII-A3"},{"ID":"207#207#1421#1#1","ClassName":"X-A1"}]
    //  ''';
    // var respMap = await jsonDecode(json);
    // print('ResponseMap $respMap');
    // final ClassList = (respMap as List)
    //     .map((e) => ClassListEmployeeModel.fromJson(e))
    //     .toList();
    // return ClassList;
    print(" monthList before API: $classList");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.feeBalanceMonthListEmployeeApi),
        body: classList,
        headers: headers,
        encoding: encoding,
      );

      print(" monthList Status Code: ${response.statusCode}");
      print(" monthList API Body: ${response.body}");

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }
      List<dynamic> respMap = json.decode(response.body);
      print("Get  monthList Response from API: $respMap");
      //List<dynamic> respMap1 = respMap['Data'];

      if (response.statusCode == 200) {
        // if (respMap["Data"][0]["AuthCheck"] == "Failed") {
        //   throw SOMETHING_WENT_WRONG;
        // } else {
        final monthList = (respMap)
            .map((e) => FeeBalanceMonthListEmployeeModel.fromJson(e))
            .toList();
        return monthList;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON  monthList API: $e");
      throw "$e";
    }
  }
}
