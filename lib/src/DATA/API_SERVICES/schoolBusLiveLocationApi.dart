import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';
import 'package:campus_pro/src/DATA/MODELS/calenderStudentModel.dart';
import 'package:campus_pro/src/DATA/MODELS/schoolBusLiveLocationModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

// class SchoolBusLiveLocationApi {
//   static Future<SchoolBusLiveLocationModel> liveLocation(
//       String? vehicleNumber, String? authToken) async {
//     print("SchoolBusLiveLocation before API: $vehicleNumber");
//     print("SchoolBusLiveLocation Token before API: $authToken");
//     try {
//       print("Link URL : ${Api.schoolBusLiveLocationApi + vehicleNumber!}");
//       http.Response response = await http.get(
//         Uri.parse(Api.schoolBusLiveLocationApi + vehicleNumber),
//         headers: {"Authorization": "bJspRzvpkSzST4THARft"},
//         // headers: {"Authorization": authToken!},
//         // headers: {"Authorization": "bJspRzvpkSzST4THARft"},
//         // encoding: encoding,
//       );

//       print("SchoolBusLiveLocation Status Code: ${response.statusCode}");
//       print("SchoolBusLiveLocation API Body: ${response.body}");

//       if (response.statusCode == 500) {
//         throw SOMETHING_WENT_WRONG;
//       }

//       if (response.statusCode == 401) {
//         throw UNAUTHORIZED_USER;
//       }

//       if (response.statusCode == 204) {
//         throw NO_RECORD_FOUND;
//       }

//       final respMap = json.decode(response.body);
//       print("SchoolBusLiveLocation Response Body: $respMap");

//       if (response.statusCode == 200) {
//         final liveLocationData =
//             SchoolBusLiveLocationModel.fromJson(respMap['data']);
//         return liveLocationData;
//       }

//       throw SOMETHING_WENT_WRONG;
//     } catch (e) {
//       print("ERROR ON SchoolBusLiveLocation API: $e");
//       throw "$e";
//     }
//   }
// }

class SchoolBusLiveLocationApi {
  static Future<SchoolBusLiveLocationModel> liveLocation(
      Map<String, String>? mapData) async {
    print("SchoolBusLiveLocation before API: $mapData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.schoolBusLiveLocationApi),
        body: mapData,
        headers: headers,
        encoding: encoding,
      );

      print("SchoolBusLiveLocation Status Code: ${response.statusCode}");
      print("SchoolBusLiveLocation API Body: ${response.body}");

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
      print("SchoolBusLiveLocation Response Body: $respMap");

      if (response.statusCode == 200) {
        final liveLocationData =
            SchoolBusLiveLocationModel.fromJson(respMap['Data'][0]);
        return liveLocationData;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON SchoolBusLiveLocation API: $e");
      throw "$e";
    }
  }
}
