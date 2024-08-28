import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/deleteLeaveEmpCalApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/dropDownForProxyApplyApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/dropDownIndexProxyApply.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/employeeCalendarAllDateApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/employeeCalendarDateDetailsApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/getInOutTimeForCalApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/saveProxyRequestApi.dart';
import 'package:campus_pro/src/DATA/MODELS/EmployeeCalendarDateDetailsModal.dart';
import 'package:campus_pro/src/DATA/MODELS/EmployeeCalendarProxyDetail2Model.dart';
import 'package:campus_pro/src/DATA/MODELS/dropDownForProxyApplyModal.dart';
import 'package:campus_pro/src/DATA/MODELS/employeeCalendarProxyDetailModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/PAGES/EMPLOYEE_MODULE/EMPLOYEE_CALENDAR/applyLeaveEmployeeCal.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonSnackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
// import 'package:table_calendar/table_calendar.dart';

class EmployeeCalendar extends StatefulWidget {
  static const routeName = "/calendar-employeeCalendar";
  const EmployeeCalendar({Key? key}) : super(key: key);

  @override
  _EmployeeCalendarState createState() => _EmployeeCalendarState();
}

class _EmployeeCalendarState extends State<EmployeeCalendar>
    with SingleTickerProviderStateMixin {
  // CalendarController calendarController = CalendarController();

  AnimationController? animationController;

  DateTime current = DateTime.now();

  Map<DateTime, List<dynamic>> events = {};

  ScrollController? controllerScroll;
  bool isVisible = true;

  var _futureForCalDateDetails;

  TimeOfDay? checkInTime;
  TimeOfDay? checkOutTime;
  TextEditingController controller = TextEditingController();

  List<DropDownForProxyApplyModal> attendanceForDropDown = [];
  DropDownForProxyApplyModal? selectedDropDown;

  getLeaveList() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final data = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "StuEmpId": userData.stuEmpId,
      "UserType": userData.ouserType,
      "Flag": "EventList",
      "EmpID": userData.stuEmpId,
      "Year": "",
      "Month": "",
      "Date": "",
      "Extra": "",
    };

    print("sending data for dates $data");

    EmployeeCalendarAllDateApi().getEmployeeCalendarApi(data).then((value) {
      if (value[0].id == "-1") {
        UserUtils.unauthorizedUser(context);
      }
      setState(() {
        value.forEach((element) {
          print(element.date);
          events.addAll({
            DateTime.parse(element.date!): [
              element.id,
              element.type,
              element.duration!.trim(),
            ]
          });
        });
        // for (int i = 1; i < 10; i++) {
        //   events.addAll({
        //     DateTime.parse("2022-02-0$i"): [
        //       i,
        //       i == 1 ? "Leave" : "Attendance",
        //       i == 1
        //           ? "L"
        //           : i == 2
        //               ? "F"
        //               : i == 3
        //                   ? "H"
        //                   : i == 4
        //                       ? "Q"
        //                       : i == 5
        //                           ? "A"
        //                           : i == 6
        //                               ? "FH"
        //                               : ""
        //     ]
        //   });
        // }
      });
    });
  }

  // void _onVisibleDaysChanged(
  //     DateTime first, DateTime last, CalendarFormat format) {
  //   // setState(() {
  //   //   current = first;
  //   // });
  //   setState(() {
  //     isVisible = true;
  //   });
  //   print('CALLBACK: _onVisibleDaysChanged first ${first.toIso8601String()}');
  // }

  getAllDates() async {
    try {
      await getLeaveList();
    } catch (e) {
      setState(() {
        events = {};
      });
      print("No Records");
    }
  }

  getCheckInOutTime({DateTime? date}) async {
    try {
      await GetInOutTimeForCalApi()
          .getInOutTime(date: date != null ? date : DateTime.now())
          .then((value) {
        TimeOfDay inTime = TimeOfDay(
          hour: int.parse(value["Data"][0]["intime"].split(":")[0]),
          minute: int.parse(value["Data"][0]["intime"].split(":")[1]),
        );
        TimeOfDay outTime = TimeOfDay(
          hour: int.parse(value["Data"][0]["outtime"].split(":")[0]),
          minute: int.parse(value["Data"][0]["outtime"].split(":")[1]),
        );
        setState(() {
          checkInTime = inTime;
          checkOutTime = outTime;
        });
      });
    } catch (e) {
      print("error on get in out time api $e");
      setState(() {
        // checkInTime = TimeOfDay(hour: 9, minute: 30);
        // checkOutTime = TimeOfDay(hour: 18, minute: 00);
        checkInTime = TimeOfDay(hour: 00, minute: 00);
        checkOutTime = TimeOfDay(hour: 00, minute: 00);
      });
    } finally {
      try {
        await DropDownIndexProxyApply()
            .dropDownIndex(inTime: checkInTime, outTime: checkOutTime)
            .then((value) {
          if (attendanceForDropDown.length > 0) {
            attendanceForDropDown.forEach((element) {
              if (element.id == value["Data"][0]["AttendaceFor"]) {
                setState(() {
                  selectedDropDown = element;
                });
              }
            });
          }
        });
      } catch (e) {
        print("error on dropDownProxyApply $e");
      }
    }
  }

  getDropDown() async {
    try {
      await DropDownForProxyApplyApi().getDropDown().then((value) {
        value.insert(0,
            DropDownForProxyApplyModal(name: "Please Select Time", id: "-1"));
        value.forEach((element) {
          attendanceForDropDown.add(element);
        });
        selectedDropDown = value[0];
      });
    } catch (e) {}
  }

  @override
  void initState() {
    getCheckInOutTime();
    getDropDown();
    controllerScroll = ScrollController();
    controllerScroll!.addListener(() {
      if (controllerScroll!.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (isVisible == true) {
          setState(() {
            isVisible = false;
          });
        }
      } else {
        if (controllerScroll!.position.userScrollDirection ==
            ScrollDirection.forward) {
          if (isVisible == false) {
            setState(() {
              isVisible = true;
            });
          }
        }
      }
    });
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 100));
    animationController!.forward();
    getAllDates();
    _futureForCalDateDetails = EmployeeCalendarDateDetailsApi()
        .getCalendarDateDetailsApi(
            date: DateFormat("dd-MMM-yyyy").format(DateTime.now()));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
        context,
        title: "Employee Leave",
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButton: Visibility(
        visible: isVisible,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return EmployeeLeaveCal();
                },
              ),
            );
          },
          child: Icon(Icons.add),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // buildTableCalendar(context),
            Divider(
              thickness: 1,
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "${DateFormat("MMMM d,yyyy").format(current)}",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Container(
                height: MediaQuery.of(context).size.height * 0.45,
                child: Column(
                  children: [
                    buildFutureBuilderForDate(),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  FutureBuilder<dynamic> buildFutureBuilderForDate() {
    return FutureBuilder(
      future: _futureForCalDateDetails,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            margin: EdgeInsets.all(8),
            child: Center(
              child: LinearProgressIndicator(),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            if (snapshot.error == "false") {
              UserUtils.unauthorizedUser(context);
            }
            print("error on leave balance api ${snapshot.error}");
            return Center(
              child: Container(
                child: Text(
                  "${snapshot.error}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            );
          } else {
            if (!snapshot.hasData) {
              return Center(
                child: Container(
                  child: Text(
                    "$NO_RECORD_FOUND",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              );
            } else {
              print("this is snapshot ${snapshot.data["Data"]}");

              List<EmployeeCalendarDateDetailsModal> data =
                  (snapshot.data["Data"]["Table"] as List)
                      .map((e) => EmployeeCalendarDateDetailsModal.fromJson(e))
                      .toList();

              List<EmployeeCalendarProxyDetailModel> data1 =
                  (snapshot.data["Data"]["Table1"] as List)
                      .map((e) => EmployeeCalendarProxyDetailModel.fromJson(e))
                      .toList();

              List<EmployeeCalendarProxyDetail2Model> data2 =
                  (snapshot.data["Data"]["Table2"] as List)
                      .map((e) => EmployeeCalendarProxyDetail2Model.fromJson(e))
                      .toList();

              return currentDateView(
                  detailData: data, detailData1: data1, detailData2: data2);
            }
          }
        }
        return Container();
      },
    );
  }

  Widget currentDateView(
      {List<EmployeeCalendarDateDetailsModal>? detailData,
      List<EmployeeCalendarProxyDetailModel>? detailData1,
      List<EmployeeCalendarProxyDetail2Model>? detailData2}) {
    return detailData!.length > 0
        ? Expanded(
            child: CupertinoScrollbar(
              child: ListView.separated(
                controller: controllerScroll,
                separatorBuilder: (context, index) => Divider(
                  height: 5,
                ),
                itemCount: detailData.length,
                itemBuilder: (context, index) {
                  var item = detailData[index];
                  return item.name != ""
                      ? Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Text("${item.date2}"),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 12,
                                        height: 12,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          color: item.name == "Quarter"
                                              ? Colors.yellow
                                              : item.name == "Proxy For Quarter"
                                                  ? Colors.lightBlueAccent
                                                  : item.name == "Half"
                                                      ? Colors.blue
                                                      : item.name ==
                                                              "Sick Leave"
                                                          ? Color(0xFF755eb5)
                                                          : item.name ==
                                                                  "Absent"
                                                              ? Colors.red
                                                              : Colors.green,
                                        ),
                                        child: Text(""),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "${item.name}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  item.badge == "Proxy Details"
                                      ? buildProxyDetailButton(context,
                                          typeProxy: "Proxy Details")
                                      : item.badge == "Leave Details"
                                          ? buildProxyDetailButton(context,
                                              typeProxy: "Leave Details")
                                          : item.badge == "Apply Proxy"
                                              ? buildProxyApplyButton(context,
                                                  id: item.id)
                                              : item.badge == "Delete Leave"
                                                  ? buildProxyDeleteButton(
                                                      context,
                                                      id: item.id)
                                                  : item.badge == "Present"
                                                      ? Container()
                                                      : buildProxyAppliedButton(
                                                          context),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${item.description!.replaceAll("<br/>", "\n").replaceAll(" Check", "Check")}",
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  item.badge == "Proxy Details" ||
                                          item.badge == "Leave Details" ||
                                          item.badge == "Delete Leave"
                                      ? buildProxyStatus(context,
                                          status: item.statusval)
                                      : Container(),
                                ],
                              ),

                              item.badge == "Present"
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Check In Time : ${detailData1![0].checkInTime}",
                                          style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          "Check Out Time : ${detailData1[0].checkOutTime}",
                                          style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    )
                                  : Container(),

                              item.badge == "Proxy Details" ||
                                      item.badge == "Leave Details"
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        item.badge == "Proxy Details"
                                            ? Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Check In Time : ${detailData1![0].checkInTime}",
                                                    style: TextStyle(
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  Text(
                                                    "Check Out Time : ${detailData1[0].checkOutTime}",
                                                    style: TextStyle(
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  Text(
                                                    "Reason : ${detailData1[0].reasons}",
                                                    style: TextStyle(
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : Text(
                                                "Description : ${detailData1![0].description}",
                                                style: TextStyle(
                                                  fontStyle: FontStyle.italic,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),

                                        /// For Table 2
                                        Container(
                                          padding: EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            border: Border.all(width: 1),
                                            color:
                                                Color(0xFF755eb5).withOpacity(
                                              0.4,
                                            ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Approver :\n ${detailData2![0].approverName}",
                                                    style: TextStyle(
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  // buildProxyStatus(context,
                                                  //     status: detailData2[0]
                                                  //         .status),
                                                ],
                                              ),
                                              detailData2[0].approvedDate == ""
                                                  ? Container()
                                                  : Container(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                              "${detailData2[0].approvedDate} (${detailData2[0].approvedDay})"),
                                                          Text(
                                                              "Remark : ${detailData2[0].remark}"),
                                                        ],
                                                      ),
                                                    ),
                                            ],
                                          ),
                                        ),

                                        ///
                                      ],
                                    )
                                  : Container(),
                            ],
                          ),
                        )
                      : Container();
                },
              ),
            ),
          )
        : Center(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Color.fromRGBO(135, 115, 193, .15),
                border: Border.all(
                  width: 1,
                  color: Color(0xFF755eb5),
                ),
              ),
              child: Text(
                "No event for this day.. so take a rest! :)",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF755eb5),
                ),
              ),
            ),
          );
  }

  ElevatedButton buildProxyApplyButton(BuildContext context, {String? id}) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        backgroundColor: MaterialStateProperty.all(
          Color(0xff8773c1),
        ),
      ),
      onPressed: () async {
        controller.text = "";
        await getCheckInOutTime(date: current);
        showAlertDialog(context, id: id);
      },
      child: Text(
        "Apply Proxy",
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
      ),
    );
  }

  ElevatedButton buildProxyDetailButton(BuildContext context,
      {String? typeProxy}) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        backgroundColor: typeProxy == "Proxy Details"
            ? MaterialStateProperty.all(
                Theme.of(context).colorScheme.background)
            : MaterialStateProperty.all(Color(0xFF755eb5)),
      ),
      onPressed: () {},
      child: Text(
        // "Proxy Details",
        "$typeProxy",
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11),
      ),
    );
  }

  ElevatedButton buildProxyAppliedButton(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        backgroundColor: MaterialStateProperty.all(
          Color(0xFF755eb5),
        ),
      ),
      onPressed: () {},
      child: Text(
        "Proxy Applied",
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11),
      ),
    );
  }

  ElevatedButton buildProxyDeleteButton(BuildContext context, {String? id}) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        backgroundColor: MaterialStateProperty.all(Color(0xff8773c1)),
      ),
      onPressed: () async {
        try {
          await DeleteLeaveEmpCalApi().deleteLeaveEmpCal(id: id).then((value) {
            if (int.parse(value["Data"][0]["Status"]) == 1) {
              ScaffoldMessenger.of(context).showSnackBar(
                commonSnackBar(title: "Deleted Successfully"),
              );
              Navigator.pushReplacementNamed(
                  context, EmployeeCalendar.routeName);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                commonSnackBar(title: "$SOMETHING_WENT_WRONG"),
              );
            }
          });
        } catch (e) {
          print("error on delete emp leave api $e");
        }
      },
      child: Text(
        "Delete Leave",
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
      ),
    );
  }

  Widget buildProxyStatus(BuildContext context, {String? status}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: status == "Pending"
            ? Colors.blue
            : status == "Approved"
                ? Colors.green
                : Colors.red,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        "$status",
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 12,
          color: Colors.white,
        ),
      ),
    );
  }

  // TableCalendar buildTableCalendar(BuildContext context) {
  //   return TableCalendar(
  //     calendarController: calendarController,
  //     events: events,
  //     initialCalendarFormat: CalendarFormat.month,
  //     startingDayOfWeek: StartingDayOfWeek.sunday,
  //     formatAnimation: FormatAnimation.slide,
  //     availableCalendarFormats: {CalendarFormat.month: ""},
  //     calendarStyle: CalendarStyle(
  //       outsideDaysVisible: false,
  //       weekdayStyle: GoogleFonts.quicksand(
  //           fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
  //       weekendStyle: GoogleFonts.quicksand(
  //           fontSize: 18, color: Colors.red, fontWeight: FontWeight.bold),
  //       holidayStyle: GoogleFonts.quicksand(
  //           fontSize: 18, color: Colors.red, fontWeight: FontWeight.bold),
  //     ),
  //     daysOfWeekStyle: DaysOfWeekStyle(
  //       weekendStyle: GoogleFonts.quicksand(
  //         fontSize: 18.0,
  //         fontWeight: FontWeight.bold,
  //         color: Colors.red,
  //       ),
  //       weekdayStyle: GoogleFonts.quicksand(
  //         fontSize: 18.0,
  //         fontWeight: FontWeight.bold,
  //         color: Colors.black,
  //       ),
  //     ),
  //     headerStyle: HeaderStyle(
  //       centerHeaderTitle: true,
  //       formatButtonVisible: true,
  //       titleTextStyle: GoogleFonts.quicksand(
  //         fontSize: 24.0,
  //         fontWeight: FontWeight.bold,
  //         color: Color(0xff3A3A3A),
  //       ),
  //     ),
  //     onDaySelected: (date, events, _) {
  //       print(date);
  //       setState(() {
  //         _futureForCalDateDetails = EmployeeCalendarDateDetailsApi()
  //             .getCalendarDateDetailsApi(
  //                 date: DateFormat("dd-MMM-yyyy").format(date));
  //       });
  //       setState(() {
  //         current = date;
  //       });
  //       setState(() {
  //         isVisible = true;
  //       });
  //     },
  //     onVisibleDaysChanged: _onVisibleDaysChanged,
  //     builders: CalendarBuilders(
  //       selectedDayBuilder: (context, date, _) {
  //         return FadeTransition(
  //           opacity: Tween(begin: 0.0, end: 1.0).animate(animationController!),
  //           child: Container(
  //             margin: const EdgeInsets.all(8.0),
  //             alignment: Alignment.center,
  //             decoration: BoxDecoration(
  //                 color: Theme.of(context).primaryColor,
  //                 borderRadius: BorderRadius.circular(12.0),
  //                 border: Border.all(color: Theme.of(context).primaryColor)),
  //             child: Text(
  //               '${date.day}',
  //               style: TextStyle().copyWith(
  //                   // fontSize: 20.0,
  //                   color: Colors.white,
  //                   fontWeight: FontWeight.bold),
  //             ),
  //           ),
  //         );
  //       },
  //       todayDayBuilder: (context, date, _) {
  //         return Container(
  //           margin: const EdgeInsets.all(8.0),
  //           alignment: Alignment.center,
  //           decoration: BoxDecoration(
  //               // color: Theme.of(context).primaryColor,
  //               borderRadius: BorderRadius.circular(12.0),
  //               border: Border.all(
  //                   width: 2, color: Theme.of(context).primaryColor)),
  //           child: Text('${date.day}',
  //               style: TextStyle(
  //                   color: Theme.of(context).primaryColor,
  //                   fontWeight: FontWeight.bold,
  //                   fontSize: 16)),
  //         );
  //       },
  //       markersBuilder: (context, date, events, holidays) {
  //         final children = <Widget>[];
  //
  //         if (events.isNotEmpty) {
  //           children.add(
  //             Positioned(
  //               child: _buildEventsMarker(date, events),
  //             ),
  //           );
  //         }
  //         if (holidays.isNotEmpty) {
  //           children.add(
  //             Positioned(
  //               right: -2,
  //               top: -2,
  //               child: _buildHolidaysMarker(),
  //             ),
  //           );
  //         }
  //         return children;
  //       },
  //     ),
  //     onHeaderTapped: (_) {
  //       print("onHeaderTapped");
  //       showMonthPicker(
  //               context: context,
  //               firstDate: DateTime(DateTime.now().year - 10, 5),
  //               lastDate: DateTime(DateTime.now().year + 1, 9),
  //               initialDate: current)
  //           .then((date) {
  //         setState(() => current = date!);
  //         calendarController.setFocusedDay(current);
  //       });
  //     },
  //   );
  // }

  Widget _buildEventsMarker(DateTime date, List events) {
    print(events);
    Color color;
    color = events[1] == "Leave"
        ? Colors.lightBlueAccent
        : events[2] == "F"
            ? Colors.green
            : events[2] == "H"
                ? Colors.orange
                : events[2] == "Q"
                    ? Colors.purpleAccent
                    : events[2] == "A"
                        ? Colors.red
                        : events[2] == "FH"
                            ? Colors.yellow
                            : Colors.white;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.all(8.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        // color: Color(0xffffb703),
        color: color,
      ),
      child: Center(
          child: Text(
        "${date.day}",
        style: TextStyle(
            color: events[2] != "" ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16),
      )),
    );
  }

  Widget _buildHolidaysMarker() {
    return Icon(
      Icons.add_box,
      size: 20.0,
      color: Colors.blueGrey[800],
    );
  }

  Future<Widget> showAlertDialog(context, {String? id}) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            scrollable: true,
            insetPadding: EdgeInsets.only(top: 40),
            title: Container(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Color(0xff8773c1),
              ),
              child: Center(
                child: Text(
                  "Apply Proxy",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.white),
                ),
              ),
            ),
            content: StatefulBuilder(
              builder: (context, setInnerState) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        checkInTimePicker(setInnerState),
                        checkOutTimePicker(setInnerState),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Reason",
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(width: 0.1),
                      ),
                      child: TextFormField(
                        controller: controller,
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 4, vertical: 0),
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Attendance For",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    buildAttendanceForDropDown(setInnerState),
                    SizedBox(
                      height: 30,
                    ),
                    saveDialogButton(id: id),
                  ],
                );
              },
            ),
          );
        });
  }

  Center saveDialogButton({String? id}) {
    return Center(
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(Colors.green),
        ),
        onPressed: () async {
          print("$checkInTime");
          print("$checkOutTime");

          if (controller.text != "" &&
              selectedDropDown!.name != "Please Select Time") {
            try {
              await SaveProxyRequestApi()
                  .saveProxyRequest(
                      inTime: checkInTime,
                      outTime: checkOutTime,
                      date: current,
                      reason: controller.text,
                      attType: selectedDropDown!.id,
                      attId: id)
                  .then((value) {
                if (value["Data"][0]["Status"].toString() == "1") {
                  ScaffoldMessenger.of(context).showSnackBar(
                    commonSnackBar(
                      title: "${value["Data"][0]["Message"]}",
                      duration: Duration(
                        seconds: 2,
                      ),
                    ),
                  );
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(
                      context, EmployeeCalendar.routeName);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    commonSnackBar(
                      title: "${value["Data"][0]["Message"]}",
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              });
            } catch (e) {
              print("error on save proxy api $e");
            }
          } else {
            ScaffoldMessenger.of(context)
                .showSnackBar(commonSnackBar(title: "Please Enter Reason"));
          }
        },
        child: Text(
          "Save",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
      ),
    );
  }

  Widget buildAttendanceForDropDown(StateSetter setInnerState) {
    return IgnorePointer(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 0.1),
          borderRadius: BorderRadius.circular(4),
        ),
        child: StatefulBuilder(builder: (context, setState) {
          return DropdownButton<DropDownForProxyApplyModal>(
            isExpanded: true,
            underline: Container(),
            items: attendanceForDropDown
                .map((e) => DropdownMenuItem(
                      child: Text("${e.name}"),
                      value: e,
                    ))
                .toList(),
            value: selectedDropDown,
            onChanged: (val) {
              setInnerState(() {
                selectedDropDown = val;
              });
            },
          );
        }),
      ),
    );
  }

  Widget checkInTimePicker(StateSetter setInnerState) {
    // checkInTime = TimeOfDay(hour: 9, minute: 30);
    // checkOutTime = TimeOfDay(hour: 00, minute: 00);
    return Column(
      children: [
        Text(
          "Check In Time",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        StatefulBuilder(builder: (context, setState) {
          return GestureDetector(
            onTap: () async {
              TimeOfDay? time = await showTimePicker(
                  context: context,
                  initialTime: checkInTime!,
                  initialEntryMode: TimePickerEntryMode.dial);
              print(time);
              if (time != null && checkInTime != time) {
                setInnerState(() {
                  checkInTime = time;
                });
              }

              try {
                await DropDownIndexProxyApply()
                    .dropDownIndex(inTime: checkInTime, outTime: checkOutTime)
                    .then((value) {
                  if (attendanceForDropDown.length > 0) {
                    attendanceForDropDown.forEach((element) {
                      if (element.id == value["Data"][0]["AttendaceFor"]) {
                        setInnerState(() {
                          selectedDropDown = element;
                        });
                      }
                    });
                  }
                });
              } catch (e) {
                print("error on dropDownProxyApply $e");
              }

              print(checkInTime);
            },
            child: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                border: Border.all(width: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Text('${checkInTime!.hour}:${checkInTime!.minute}'),
                  Icon(
                    Icons.timer,
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget checkOutTimePicker(StateSetter setInnerState) {
    // checkInTime = TimeOfDay(hour: 9, minute: 30);
    // checkOutTime = TimeOfDay(hour: 00, minute: 00);
    return Column(
      children: [
        Text(
          "Check Out Time",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        StatefulBuilder(builder: (context, setState) {
          return GestureDetector(
            onTap: () async {
              TimeOfDay? time = await showTimePicker(
                  context: context,
                  initialTime: checkOutTime!,
                  initialEntryMode: TimePickerEntryMode.dial);
              print(time);
              if (time != null && checkInTime != time) {
                setInnerState(() {
                  checkOutTime = time;
                });
              }
              try {
                await DropDownIndexProxyApply()
                    .dropDownIndex(inTime: checkInTime, outTime: checkOutTime)
                    .then((value) {
                  if (attendanceForDropDown.length > 0) {
                    attendanceForDropDown.forEach((element) {
                      if (element.id == value["Data"][0]["AttendaceFor"]) {
                        setInnerState(() {
                          selectedDropDown = element;
                        });
                      }
                    });
                  }
                });
              } catch (e) {
                print("error on dropDownProxyApply $e");
              }
            },
            child: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                border: Border.all(width: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Text('${checkOutTime!.hour}:${checkOutTime!.minute}'),
                  Icon(
                    Icons.timer,
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}
