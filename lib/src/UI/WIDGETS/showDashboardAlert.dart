import 'dart:io';

import 'package:campus_pro/src/DATA/BLOC_CUBIT/NOTIFY_COUNTER_CUBIT/notify_counter_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/notifyCounterModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/PAGES/STUDENT_MODULE/COMMUNICATION_STUDENT/circularStudent.dart';
import 'package:campus_pro/src/UI/PAGES/STUDENT_MODULE/COMMUNICATION_STUDENT/classRoomsStudent.dart';
import 'package:campus_pro/src/UI/PAGES/STUDENT_MODULE/COMMUNICATION_STUDENT/homeWorkStudent.dart';
import 'package:campus_pro/src/UI/PAGES/STUDENT_MODULE/activityStudent.dart';
import 'package:campus_pro/src/UTILS/appImages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

showAlert(BuildContext context, List<NotifyCounterModel>? notifyList) async {
  await showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog();
      // (
      // height: 100,
      // width: 100,

      // color: Colors.white,
      // child: Container(
      //   margin: const EdgeInsets.all(20.0),
      //   height: MediaQuery.of(context).size.height - 20,
      //   width: MediaQuery.of(context).size.width - 20,
      //   color: Colors.white,
      // ),
      // child: ListView.separated(
      //   separatorBuilder: (context, i) => Divider(),
      //   itemCount: notifyList!.length,
      //   itemBuilder: (context, i) {
      //     var item = notifyList[i];
      //     return item.count > 0
      //         ? GestureDetector(
      //             onTap: () {
      //               // getNotifyCounterList(item.title.split("Count")[0]);
      //               switch (item.title.split("Count")[0].toLowerCase()) {
      //                 case "homework":
      //                   Navigator.pushNamed(
      //                           context, HomeWorkStudent.routeName)
      //                       .then((value) => Navigator.pop(context));
      //                   break;
      //                 case "classroom":
      //                   Navigator.pushNamed(
      //                           context, ClassRoomsStudent.routeName)
      //                       .then((value) => Navigator.pop(context));
      //                   break;
      //                 case "circular":
      //                   Navigator.pushNamed(
      //                           context, CircularStudent.routeName)
      //                       .then((value) => Navigator.pop(context));
      //                   break;
      //                 case "activity":
      //                   Navigator.pushNamed(
      //                           context, ActivityStudent.routeName)
      //                       .then((value) => Navigator.pop(context));
      //                   break;
      //                 default:
      //                   break;
      //               }
      //             },
      //             child: Column(
      //               children: [
      //                 Container(
      //                   // width: MediaQuery.of(context).size.width * 3,
      //                   // padding: const EdgeInsets.symmetric(vertical: 30),
      //                   child: Row(
      //                     children: [
      //                       // Image.asset(
      //                       //     getNotificationIcon(item.title.split("Count")[0]),
      //                       //     width: 18),
      //                       SizedBox(width: 8.0),
      //                       Text(
      //                         "You have ${item.count} new ${item.title.split("Count")[0]}",
      //                         textScaleFactor: 1.5,
      //                         style: GoogleFonts.quicksand(
      //                           fontSize: 10.0,
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //                 Divider(),
      //               ],
      //             ),
      //           )
      //         : PopupMenuItem<NotifyCounterModel>(
      //             value: item,
      //             child: Column(
      //               children: [
      //                 Container(
      //                   // width: MediaQuery.of(context).size.width * 3,
      //                   // padding: const EdgeInsets.symmetric(vertical: 30),
      //                   child: Text(
      //                     "",
      //                     textScaleFactor: 1.5,
      //                     style: GoogleFonts.quicksand(
      //                       fontSize: 10.0,
      //                     ),
      //                   ),
      //                 ),
      //                 Divider(color: Colors.transparent),
      //               ],
      //             ),
      //           );
      //   },
      // ),
      // child: CupertinoAlertDialog(

      // title: Text("Are you sure to cancel payment?"),
      // content: Expanded(
      //   child: ListView.separated(
      //     separatorBuilder: (context, i) => Divider(),
      //     itemCount: notifyList!.length,
      //     itemBuilder: (context, i) {
      //       var item = notifyList[i];
      //       return item.count > 0
      //           ? GestureDetector(
      //               onTap: () {
      //                 // getNotifyCounterList(item.title.split("Count")[0]);
      //                 switch (item.title.split("Count")[0].toLowerCase()) {
      //                   case "homework":
      //                     Navigator.pushNamed(
      //                             context, HomeWorkStudent.routeName)
      //                         .then((value) => Navigator.pop(context));
      //                     break;
      //                   case "classroom":
      //                     Navigator.pushNamed(
      //                             context, ClassRoomsStudent.routeName)
      //                         .then((value) => Navigator.pop(context));
      //                     break;
      //                   case "circular":
      //                     Navigator.pushNamed(
      //                             context, CircularStudent.routeName)
      //                         .then((value) => Navigator.pop(context));
      //                     break;
      //                   case "activity":
      //                     Navigator.pushNamed(
      //                             context, ActivityStudent.routeName)
      //                         .then((value) => Navigator.pop(context));
      //                     break;
      //                   default:
      //                     break;
      //                 }
      //               },
      //               child: Column(
      //                 children: [
      //                   Container(
      //                     // width: MediaQuery.of(context).size.width * 3,
      //                     // padding: const EdgeInsets.symmetric(vertical: 30),
      //                     child: Row(
      //                       children: [
      //                         // Image.asset(
      //                         //     getNotificationIcon(item.title.split("Count")[0]),
      //                         //     width: 18),
      //                         SizedBox(width: 8.0),
      //                         Text(
      //                           "You have ${item.count} new ${item.title.split("Count")[0]}",
      //                           textScaleFactor: 1.5,
      //                           style: GoogleFonts.quicksand(
      //                             fontSize: 10.0,
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                   ),
      //                   Divider(),
      //                 ],
      //               ),
      //             )
      //           : PopupMenuItem<NotifyCounterModel>(
      //               value: item,
      //               child: Column(
      //                 children: [
      //                   Container(
      //                     // width: MediaQuery.of(context).size.width * 3,
      //                     // padding: const EdgeInsets.symmetric(vertical: 30),
      //                     child: Text(
      //                       "",
      //                       textScaleFactor: 1.5,
      //                       style: GoogleFonts.quicksand(
      //                         fontSize: 10.0,
      //                       ),
      //                     ),
      //                   ),
      //                   Divider(color: Colors.transparent),
      //                 ],
      //               ),
      //             );
      //     },
      //   ),
      // ),
      // actions: <Widget>[
      //   new Container(
      //     margin: EdgeInsets.all(8.0),
      //     child: RaisedButton(
      //       padding: EdgeInsets.all(12.0),
      //       onPressed: () {
      //         Navigator.pop(context);
      //       },
      //       color: Colors.red[900],
      //       child: Text(
      //         'no',
      //         style: TextStyle(color: Colors.white, fontSize: 24.0),
      //       ),
      //     ),
      //   ),
      //   new Container(
      //     margin: EdgeInsets.all(8.0),
      //     child: RaisedButton(
      //       padding: EdgeInsets.all(12.0),
      //       onPressed: () {
      //         Navigator.pop(context);
      //         Navigator.pop(context);
      //       },
      //       color: Colors.blue[900],
      //       child: Text(
      //         'yes',
      //         style: TextStyle(color: Colors.white, fontSize: 24.0),
      //       ),
      //     ),
      //   ),
      // ],
      // ),
      // );
    },
  );

  String getNotificationIcon(String? smsType) {
    switch (smsType!.toLowerCase()) {
      case "homework":
        return AppImages.homeworkNotifyIcon;
      case "circular":
        return AppImages.bellIcon;
      case "activity":
        return AppImages.commonSmsIcon;
      case "classroom":
        return AppImages.classroomImage;
      default:
        return AppImages.bellIcon;
    }
  }

  void getNotifyCounterList(String flag) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final stuInfo = await UserUtils.stuInfoDataFromCache();
    final requestPayload = {
      'OUserId': uid,
      'Token': token,
      'OrgId': userData!.organizationId,
      'Schoolid': userData.schoolId,
      'SessionId': userData.currentSessionid,
      'ClassId': stuInfo!.classId,
      'SectionId': stuInfo.classSectionId,
      'StreamId': stuInfo.streamId,
      'YearId': stuInfo.yearId,
      'StuEmpId': userData.stuEmpId,
      'Flag': flag,
      'UserType': userData.ouserType,
    };
    context.read<NotifyCounterCubit>().notificationCubitCall(requestPayload);
  }
}
