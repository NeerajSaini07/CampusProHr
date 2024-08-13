import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/classRoomCommentsModel.dart';
import 'package:campus_pro/src/DATA/MODELS/customChatModel.dart';
import 'package:campus_pro/src/DATA/MODELS/homeWorkCommentsModel.dart';
import 'package:campus_pro/src/UTILS/api_endpoints.dart';
import 'package:http/http.dart' as http;

class ChatRoomCommentsCommonApi {
  Future<List<ClassRoomCommentsModel>> classRoomComments(
      Map<String, String?> commentData) async {
    print("ClassRoomComments before API: $commentData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.classRoomCommentsApi),
        body: commentData,
        headers: headers,
        encoding: encoding,
      );

      print("ClassRoomComments Status Code: ${response.statusCode}");
      print("ClassRoomComments API Body: ${response.body}");

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
        final commentList = (respMap['Data'] as List)
            .map((e) => ClassRoomCommentsModel.fromJson(e))
            .toList();
        return commentList;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON ClassRoomComments API: $e");
      throw "$e";
    }
  }

  Future<List<CustomChatModel>> customChatData(
      Map<String, String?> chatData) async {
    print("CustomChat before API: $chatData");
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.customChatApi),
        body: chatData,
        headers: headers,
        encoding: encoding,
      );

      print("CustomChat Status Code: ${response.statusCode}");
      print("CustomChat API Body: ${response.body}");

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
        final chatList = (respMap['Data'] as List)
            .map((e) => CustomChatModel.fromJson(e))
            .toList();

        return chatList;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON customChat Api: $e");
      throw "$e";
    }
  }

  Future<HomeWorkCommentsModel> homeworkComments(
      Map<String, String?> commentData) async {
    try {
      http.Response response = await http.post(
        Uri.parse(ApiEndpoints.homeworkCommentsApi),
        body: commentData,
        headers: headers,
        encoding: encoding,
      );

      print("HomeWorkComments Status Code: ${response.statusCode}");
      print("HomeWorkComments API Body: ${response.body}");

      if (response.statusCode == 500) {
        throw SOMETHING_WENT_WRONG;
      }

      if (response.statusCode == 204) {
        throw NO_RECORD_FOUND;
      }

      final respMap = json.decode(response.body);

      if (response.statusCode == 200) {
        final homeworkComment =
            HomeWorkCommentsModel.fromJson(respMap['Data'][0]);
        // print("HomeWorkComments API LAST ITEM: ${homeworkComment.table!.last.toreplycommentId}");
        return homeworkComment;
      }

      throw SOMETHING_WENT_WRONG;
    } on SocketException catch (e) {
      print("no internet $e");
      throw NO_INTERNET;
    } catch (e) {
      print("ERROR ON HomeWorkComments API: $e");
      throw "$e";
    }
  }

  // Future<HomeWorkCommentsModel> homeworkComments(
  //     Map<String, String?> commentData) async {
  //   final respMap = json.decode(homeworkJsonString);
  //   final homeworkComment = HomeWorkCommentsModel.fromJson(respMap);
  //   return homeworkComment;
  // }
}

String homeworkJsonString = '''
{
    "Table": [
        {
            "ReplyId": 197,
            "HomeworkId": 13859,
            "CommentDate1": "Aug  2 2021 12:52PM",
            "Comment": "Hello mam",
            "isread": null,
            "toreplycommentId": 0,
            "FileUrl": "",
            "UserType": "s",
            "toreply": 0,
            "TeacherName": ""
        },
        {
            "ReplyId": 197,
            "HomeworkId": 13859,
            "CommentDate1": "Aug  3 2021 02:00PM",
            "Comment": "Hey! R u coming today?",
            "isread": null,
            "toreplycommentId": 197,
            "FileUrl": "",
            "UserType": "e",
            "toreply": 0,
            "TeacherName": ""
        }
    ],
    "Table1": [
        {
            "NoofComments": 1
        }
    ]
}
''';

String getApiUrlFromSwitch(String? screenType) {
  switch (screenType) {
    case 'classroom':
      return ApiEndpoints.classRoomCommentsApi;
    case 'homework':
      return ApiEndpoints.homeworkCommentsApi;
    default:
      return '';
  }
}

// class ClassRoomCommentsApi {
//   Future<List<ClassRoomCommentsModel>> classRoomComments(
//       {required Map<String, String?> commentData,
//       required String? screenType}) async {
//     print("ClassRoomComments before API: $commentData");
//     try {
//       http.Response response = await http.post(
//         Uri.parse(getApiUrlFromSwitch(screenType)),
//         body: commentData,
//         headers: headers,
//         encoding: encoding,
//       );

//       print("ClassRoomComments Status Code: ${response.statusCode}");
//       print("ClassRoomComments API Body: ${response.body}");

//       if (response.statusCode == 500) {
//         throw SOMETHING_WENT_WRONG;
//       }

//       if (response.statusCode == 204) {
//         throw NO_RECORD_FOUND;
//       }

//       final respMap = json.decode(response.body);

//       if (response.statusCode == 200) {
//         final commentList = (respMap['Data'] as List)
//             .map((e) => ClassRoomCommentsModel.fromJson(e))
//             .toList();
//         return commentList;
//       }

//       throw SOMETHING_WENT_WRONG;
//     } catch (e) {
//       print("ERROR ON ClassRoomComments API: $e");
//       throw "$e";
//     }
//   }
// }
