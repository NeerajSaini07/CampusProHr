import 'dart:convert';
import 'dart:io';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/cceSubjectTeacherRemarksListModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class CceSubjectTeacherRemarksListApi {
  Future<List> remarkData(Map<String, String?> requestPayload) async {
    print("CceSubjectTeacherRemarksList before API: $requestPayload");

    try {
      List<CceSubjectTeacherRemarksListModel> finalRemarkList = [];
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.cceSubjectTeacherRemarksListApi),
        body: requestPayload,
        headers: headers,
        encoding: encoding,
      );

      // print("CceSubjectTeacherRemarksList Status Code: ${response.statusCode}");
      print("CceSubjectTeacherRemarksList API Body: ${response.body}");

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
        final remarkList = (respMap["Data"][0] as List);

        // print("remarkList : $remarkList");

        // for (var i = 0; i < remarkList.length; i++) {
        //   List<Remarks> itemList = [];
        //   List<ItemModel> item = [];

        //   remarkList[i].forEach((subject, remark) =>
        //       item.add(ItemModel.fromJson(subject, remark)));

        //   item.forEach((element) => itemList
        //       .add(Remarks(subject: element.subject, remark: element.remark)));

        //   itemList.removeAt(0);
        //   itemList.removeAt(0);

        //   finalRemarkList.add(CceSubjectTeacherRemarksListModel(
        //     iD: i,
        //     admNo: remarkList[i]["ADMNO"],
        //     name: remarkList[i]["NAME"],
        //     expanded: false,
        //     remarks: itemList,
        //   ));
        // }
        print("CceSubjectTeacherRemarksList after Modify : $finalRemarkList");
        return remarkList;
        // return finalRemarkList;
      }
      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON CceSubjectTeacherRemarksList: $e");
      throw e;
    }
  }
}

// Item model
class ItemModel {
  String subject;
  String remark;

  ItemModel.fromJson(String subItemID, String subItemDetails)
      : subject = subItemID,
        remark = subItemDetails;
}
