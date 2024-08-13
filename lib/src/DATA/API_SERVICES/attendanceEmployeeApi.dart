import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/attendanceEmployeeModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';

import 'package:http/http.dart' as http;

class AttendanceEmployeeApi {
  Future<List<AttendanceEmployeeModel>> attendanceEmployee(
      Map<String, String?> requestPayload) async {
    // var json =
    //     ''' [{"ClassIds":"202#202#1444#1","ClassSection":"V-A - A3","Present":0,"Absent":0,"Leave":0,"ClassID":202,"StreamId":202,"sectionid":1444,"YearId":1,"DisPlayOrderNo":7,"ClassId1":202,"StreamId1":202,"SectionId1":1444,"YearId1":1},{"ClassIds":"204#204#1418#1","ClassSection":"VII - A2","Present":0,"Absent":0,"Leave":0,"ClassID":204,"StreamId":204,"sectionid":1418,"YearId":1,"DisPlayOrderNo":9,"ClassId1":204,"StreamId1":204,"SectionId1":1418,"YearId1":1},{"ClassIds":"204#204#1445#1","ClassSection":"VII - A3","Present":0,"Absent":0,"Leave":0,"ClassID":204,"StreamId":204,"sectionid":1445,"YearId":1,"DisPlayOrderNo":9,"ClassId1":204,"StreamId1":204,"SectionId1":1445,"YearId1":1},{"ClassIds":"204#204#1445#1","ClassSection":"VII - A3","Present":0,"Absent":0,"Leave":0,"ClassID":204,"StreamId":204,"sectionid":1445,"YearId":1,"DisPlayOrderNo":9,"ClassId1":204,"StreamId1":204,"SectionId1":1445,"YearId1":1},{"ClassIds":"207#207#1421#1","ClassSection":"X - A1","Present":0,"Absent":0,"Leave":0,"ClassID":207,"StreamId":207,"sectionid":1421,"YearId":1,"DisPlayOrderNo":12,"ClassId1":207,"StreamId1":207,"SectionId1":1421,"YearId1":1}]''';
    // var resMap = jsonDecode(json);
    // print('AttendanceList Api $resMap');
    // final AttendanceList = (resMap as List)
    //     .map((e) => AttendanceEmployeeModel.fromJson(e))
    //     .toList();
    // return AttendanceList;
    print("attendance before API: $requestPayload");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.attendanceEmployee),
        body: requestPayload,
        headers: headers,
        encoding: encoding,
      );
      print("attendance Status Code: ${response.statusCode}");
      print("attendance API Body: ${response.body}");

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 401) {
        throw UNAUTHORIZED_USER;
      }

      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      //Map<String, dynamic> respMap = json.decode(response.body);
      var respMap = json.decode(response.body);
      print("Get  attendanceList Response from API: $respMap");
      List<dynamic> respMap1 = respMap['Data'];
      print("Get  attendanceList Response from API: $respMap1");
      if (response.statusCode == 200) {
        final attendanceList =
            (respMap1).map((e) => AttendanceEmployeeModel.fromJson(e)).toList();
        return attendanceList;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON  Attendance List API: $e");
      throw "$e";
    }
  }
}
