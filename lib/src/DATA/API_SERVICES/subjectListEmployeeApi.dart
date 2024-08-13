import 'dart:convert';
import 'dart:io';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/SubjectListEmployeeModel.dart';
import 'package:campus_pro/src/DATA/MODELS/classListEmployeeModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class SubjectListEmployeeApi {
  Future<List<SubjectListEmployeeModel>> getSubject(
      Map<String, String?> subjectList) async {
//     var json = '''
//    [
//     {
//         "SubjectId": 4,
//         "SubjectHead": "Science"
//     }
// ]
//     ''';
//     var respMap = await jsonDecode(json);
//     print('ResponseMap $respMap');
//     final subjectList = (respMap as List)
//         .map((e) => SubjectListEmployeeModel.fromJson(e))
//         .toList();
//     return subjectList;
    print(" SubjectList before API: $subjectList");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.subjectListEmployeeApi),
        body: subjectList,
        headers: headers,
        encoding: encoding,
      );

      print(" SubjectList Status Code: ${response.statusCode}");
      print(" SubjectList API Body: ${response.body}");

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
      List<dynamic> respMap1 = respMap['Data'][0];
      print("Get  SubjectList Response from API: $respMap");

      if (response.statusCode == 200) {
        // if (respMap["Data"][0]["AuthCheck"] == "Failed") {
        //   throw SOMETHING_WENT_WRONG;
        // } else {
        //   final subjectList = (respMap)
        //       .map((e) => SubjectListEmployeeModel.fromJson(e))
        //       .toList();
        //   return subjectList;
        // }
        final subjectList = (respMap1)
            .map((e) => SubjectListEmployeeModel.fromJson(e))
            .toList();
        return subjectList;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON  Subject List API: $e");
      throw "$e";
    }
  }
}
