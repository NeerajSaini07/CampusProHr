import 'package:campus_pro/src/DATA/BLOC_CUBIT/NOTIFICATIONS_CUBIT/notifications_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/notificationsModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonSnackbar.dart';
import 'package:campus_pro/src/UI/WIDGETS/drawerWidget.dart';
import 'package:campus_pro/src/UTILS/appImages.dart';
import 'package:campus_pro/src/WIDGETS_STYLE/style_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'dart:async';

import 'package:flutter_tts/flutter_tts.dart';

class Notifications extends StatefulWidget {
  static const routeName = "/notifications";
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  FlutterTts? flutterTts;
  DateTime selectedFromDate = DateTime.now();
  //.subtract(Duration(days: 7));
  DateTime selectedToDate = DateTime.now();

  @override
  void initState() {
    getNotifications("1");
    super.initState();
  }

  getNotifications(String? onLoad) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final notifyData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId!,
      "StuEmpId": userData.stuEmpId,
      "UserType": userData.ouserType,
      "From": DateFormat("dd MMM yyyy").format(selectedFromDate),
      "To": DateFormat("dd MMM yyyy").format(selectedToDate),
      "Onload": onLoad,
    };
    context.read<NotificationsCubit>().notificationCubitCall(notifyData);
  }

  Future<void> _selectDate(BuildContext context, {int? index}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedFromDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      helpText: index == 0 ? "SELECT FROM DATE" : "SELECT TO DATE",
    );
    if (picked != null)
      setState(() {
        if (index == 0) {
          selectedFromDate = picked;
        } else {
          selectedToDate = picked;
        }
      });
  }

  _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000)).then((value) {
      getNotifications("0");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: commonAppBar(context, title: "Notifications"),
      body: RefreshIndicator(
        onRefresh: () => _onRefresh(),
        child: BlocConsumer<NotificationsCubit, NotificationsState>(
          listener: (context, state) {
            if (state is NotificationsLoadFail) {
              if (state.failReason == "false") {
                UserUtils.unauthorizedUser(context);
              } else {
                //toast(state.failReason);
                ScaffoldMessenger.of(context).showSnackBar(commonSnackBar(
                    title: "${state.failReason}",
                    duration: Duration(seconds: 1)));
                setState(() {
                  notificationList = [];
                });
              }
            }
            if (state is NotificationsLoadSuccess) {
              setState(() {
                notificationList = state.notificationList;
              });
            }
          },
          builder: (context, state) {
            if (state is NotificationsLoadInProgress) {
              // return Center(child: CircularProgressIndicator());
              return Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: LinearProgressIndicator());
            } else if (state is NotificationsLoadSuccess) {
              return buildNotificationBody(context);
            } else if (state is NotificationsLoadFail) {
              return buildNotificationBody(context);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  List<NotificationsModel>? notificationList = [];
  int maxLength = 100;
  int maxLine = 3;

  Widget buildNotificationBody(BuildContext context) {
    return Column(
      children: [
        buildTopDateFilter(context),
        Divider(
          thickness: 1,
          color: Theme.of(context).primaryColor,
        ),
        if (notificationList == null || notificationList!.isEmpty)
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.notifications,
                  color: Theme.of(context).primaryColor,
                  size: 80,
                ),
                Text(
                  "No Notifications",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          )
        else
          Expanded(
            child: ListView.separated(
                separatorBuilder: (context, index) => SizedBox(height: 10),
                shrinkWrap: true,
                itemCount: notificationList!.length,
                itemBuilder: (context, i) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xffE1E3E8),
                      ),
                    ),
                    child: ListTile(
                        leading: Image.asset(
                            getNotificationIcon(notificationList![i].smsType!),
                            width: 24),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              notificationList![i].alertMessage!,
                              style: TextStyle(fontSize: 14),
                              maxLines: maxLine,
                              overflow: TextOverflow.ellipsis,
                            ),
                            notificationList![i].alertMessage!.length > 100
                                ? maxLine == 3
                                    ? GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            print("more");
                                            setState(() {
                                              maxLength = 1000;
                                              maxLine = 10;
                                            });
                                            print(maxLine);
                                          });
                                          // if (maxLength == 100) {
                                          //   print("more");
                                          //   setState(() {
                                          //     maxLength = 1000;
                                          //     maxLine = 10;
                                          //   });
                                          //   print(maxLine);
                                          // } else {
                                          //   print("less");
                                          //   setState(() {
                                          //     maxLength = 100;
                                          //     maxLine = 3;
                                          //   });
                                          // }
                                        },
                                        child: Text(
                                          "Show More ...",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 13),
                                        ),
                                      )
                                    : GestureDetector(
                                        onTap: () {
                                          print("less");
                                          setState(() {
                                            maxLength = 100;
                                            maxLine = 3;
                                          });
                                        },
                                        child: Text(
                                          "Show Less ...",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 13),
                                        ),
                                      )
                                : Text("")
                          ],
                        ),
                        subtitle: Row(
                          children: [
                            Expanded(child: Container()),
                            Text(
                              notificationList![i].alertDate!,
                              // style: Theme.of(context)
                              //     .textTheme
                              //     .subtitle1!
                              //     .copyWith(color: Colors.grey, fontSize: 10),
                            ),
                          ],
                        )),
                  );
                }),
          )
      ],
    );
  }

  InkWell buildDateSelector({String? selectedDate, int? index}) {
    return InkWell(
      onTap: () => _selectDate(context, index: index),
      child: internalTextForDateTime(context, selectedDate: selectedDate),
    );
  }

  Container buildTopDateFilter(BuildContext context) {
    return Container(
      // color: Colors.white,
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: buildDateSelector(
                  index: 0,
                  selectedDate:
                      DateFormat("dd MMM yyyy").format(selectedFromDate),
                ),
              ),
              Icon(Icons.arrow_right_alt_outlined),
              Expanded(
                child: buildDateSelector(
                  index: 1,
                  selectedDate:
                      DateFormat("dd MMM yyyy").format(selectedToDate),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () => getNotifications("0"),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Theme.of(context).primaryColor,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 10,
                            color: Colors.grey,
                            spreadRadius: 1),
                      ]),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: Text(
                    "Show",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String getNotificationIcon(String? smsType) {
    switch (smsType) {
      case "CommonSMS":
        return AppImages.commonSmsIcon;
      case "Complaint":
        return AppImages.complaintIcon;
      case "Discount":
        return AppImages.discountIcon;
      case "Exam":
        return AppImages.examIcon;
      case "Fee":
        return AppImages.feePaymentImage;
      case "FeeReminder":
        return AppImages.feePaymentImage;
      case "GatePass":
        return AppImages.gatePassIcon;
      case "Homework":
        return AppImages.homeworkNotifyIcon;
      case "Circular":
        return AppImages.circularIcon;
      case "Admission":
        return AppImages.admissionIcon;
      case "Attendance":
        return AppImages.attendanceIcon;
      case "BirthDay":
        return AppImages.birthdayIcon;
      case "Closing":
        return AppImages.circularIcon;
      case "Leave":
        return AppImages.leaveIcon;
      default:
        return AppImages.bellIcon;
    }
  }
}
