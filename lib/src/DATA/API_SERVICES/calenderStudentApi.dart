import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/calenderStudentModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class CalenderStudentApi {
  Future<List<CalenderStudentModel>> calenderStudent(
      Map<String, String?> requestPayload) async {
    print("CalenderStudent before API: $requestPayload");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.calenderStudentApi),
        body: requestPayload,
        headers: headers,
        encoding: encoding,
      );
      // http.Response response = http.Response(jsonString, 200);

      print("CalenderStudent Status Code: ${response.statusCode}");
      print("CalenderStudent API Body: ${response.body}");

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

      if (response.statusCode == 200) {
        final calenderData = (respMap as List)
            .map((e) => CalenderStudentModel.fromJson(e))
            .toList();
        return calenderData;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON CalenderStudent API: $e");
      throw "$e";
    }
  }
}

String jsonString = '''
    [
  {
    "date": "2020-09-01T11:15:00Z",
    "date_change": "2018-05-14T10:17:40Z",
    "date_create": "2018-05-14T10:17:40Z",
    "detail": "Inflisaport Insertion",
    "duration": 15,
    "id": "2",
    "note": "Looking forward to see you! Take care",
    "status": "CONFIRMED",
    "title": "Sports day",
    "uid": "1"
  },
  {
    "date": "2020-09-22T01:15:00Z",
    "date_change": "2018-05-14T10:17:40Z",
    "date_create": "2018-05-14T10:17:40Z",
    "detail": "Inflisaport Insertion",
    "duration": 15,
    "id": "2",
    "note": "Looking forward to see you! Take care",
    "status": "CONFIRMED",
    "title": "Diwali",
    "uid": "1"
  },
  {
    "date": "2020-10-01T07:15:00Z",
    "date_change": "2018-05-14T10:17:40Z",
    "date_create": "2018-05-14T10:17:40Z",
    "detail": "Inflisaport Insertion",
    "duration": 15,
    "id": "2",
    "note": "Looking forward to see you! Take care",
    "status": "CONFIRMED",
    "title": "Holi",
    "uid": "1"
  },
  {
    "date": "2020-10-22T09:15:00Z",
    "date_change": "2018-05-14T10:17:40Z",
    "date_create": "2018-05-14T10:17:40Z",
    "detail": "Inflisaport Insertion",
    "duration": 15,
    "id": "2",
    "note": "Looking forward to see you! Take care",
    "status": "CONFIRMED",
    "title": "Christmas",
    "uid": "1"
  },
  {
    "date": "2020-10-30T10:15:00Z",
    "date_change": "2018-05-14T10:17:40Z",
    "date_create": "2018-05-14T10:17:40Z",
    "detail": "Inflisaport Insertion",
    "duration": 15,
    "id": "2",
    "note": "Looking forward to see you! Take care",
    "status": "CONFIRMED",
    "title": "New Year",
    "uid": "1"
  }
]
    ''';

// getSameMonthAppointments() async {
//   http.Response response = http.Response(jsonString, 200);
//   if (response.statusCode == 200) {
//     _samemonthevents = appointmentFromJson(response.body);
//   }
// }

// List<CalenderStudentModel> appointmentFromJson(String str) =>
//     List<CalenderStudentModel>.from(
//         json.decode(str).map((x) => CalenderStudentModel.fromJson(x)));

// String appointmentToJson(List<CalenderStudentModel> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
