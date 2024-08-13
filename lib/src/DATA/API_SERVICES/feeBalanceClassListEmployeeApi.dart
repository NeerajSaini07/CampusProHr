import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/feeBalanceClassListEmployeeModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class FeeBalanceClassListEmployeeApi {
  Future<List<FeeBalanceClassListEmployeeModel>> getClass(
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
    print(" classList before API: $classList");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.feeBalanceClassListEmployeeApi),
        body: classList,
        headers: headers,
        encoding: encoding,
      );

      print(" classList Status Code: ${response.statusCode}");
      print(" classList API Body: ${response.body}");

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      Map<String, dynamic> respMap = json.decode(response.body);
      print("Get  classList Response from API: $respMap");
      List<dynamic> respMap1 = respMap['Data'];

      if (response.statusCode == 200) {
        // if (respMap["Data"][0]["AuthCheck"] == "Failed") {
        //   throw SOMETHING_WENT_WRONG;
        // } else {
        final classList = (respMap1)
            .map((e) => FeeBalanceClassListEmployeeModel.fromJson(e))
            .toList();
        return classList;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON  ClassList API: $e");
      throw "$e";
    }
  }
}
