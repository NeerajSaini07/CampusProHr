import 'package:campus_pro/src/DATA/BLOC_CUBIT/ATTENDANCE_EMPLOYEE_CUBIT/attendance_employee_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/ATTENDANCE_OF_EMPLOYEE_ADMIN_CUBIT/attendance_of_employee_admin_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/attendanceEmployeeModel.dart';
import 'package:campus_pro/src/DATA/MODELS/attendanceOfEmployeeAdminModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/PAGES/EMPLOYEE_MODULE/ATTENDANCE_EMPLOYEE/attendanceDetail.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/WIDGETS_STYLE/style_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class AttendanceEmployee extends StatefulWidget {
  static const routeName = "/attendance-employee";
  @override
  _AttendanceEmployeeState createState() => _AttendanceEmployeeState();
}

class _AttendanceEmployeeState extends State<AttendanceEmployee> {
  DateTime selectedDate = DateTime.now();
  String? UserType;
  bool? isChecked;

  // List empListItem = [
  //   ['test1', 'department', 'designation', '121323', 'P'],
  //   ['test2', 'department', 'designation', '1231231', 'A'],
  //   ['test3', 'department', 'designation', '123123', 'P'],
  //   ['test4', 'department', 'designation', '123123', 'L'],
  //   ['test5', 'department', 'designation', '123123', 'A'],
  // ];

  getAttendance({String? date}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final attendanceData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId!,
      "SessionID": userData.currentSessionid!,
      "AttDate": date.toString(),
      "EmpID": userData.stuEmpId,
      "UserType": userData.ouserType,
    };
    print("get attendance = > $attendanceData");
    context
        .read<AttendanceEmployeeCubit>()
        .attendanceEmployeeCubitCall(attendanceData);
  }

  getUserType() async {
    final userData = await UserUtils.userTypeFromCache();
    setState(() {
      UserType = userData!.ouserType;
    });
    print(userData!.ouserType);
  }

  _launchPhoneURL(String phoneNumber) async {
    String url = 'tel:' + phoneNumber;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  getEmployeeAttendance({String? date}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final attendanceData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId!,
      "AttDate": date.toString(),
      "empid": userData.stuEmpId,
      "usertype": userData.ouserType,
    };
    print("get attendance Employee = > $attendanceData");
    context
        .read<AttendanceOfEmployeeAdminCubit>()
        .attendanceOfEmployeeAdminCubitCall(attendanceData);
  }

  @override
  void initState() {
    getUserType();
    isChecked = true;
    selectedDate = DateTime.now();
    getAttendance(
        date: DateFormat("yyyy-MM-dd").format(selectedDate).toString());
    getEmployeeAttendance(
        date: DateFormat('dd-MMM-yyyy').format(selectedDate).toString());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 1)).then((value) {
      getUserType();
      isChecked = true;
      selectedDate = DateTime.now();
      getAttendance(
          date: DateFormat("yyyy-MM-dd").format(selectedDate).toString());
      getEmployeeAttendance(
          date: DateFormat('dd-MMM-yyyy').format(selectedDate).toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, title: 'Attendance'),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Date:",
                          style: TextStyle(
                            // color: Theme.of(context).primaryColor,
                            color: Color(0xff3A3A3A),
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 8),
                        buildDateSelector(
                          selectedDate:
                              DateFormat("dd MMM yyyy").format(selectedDate),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(right: 12, top: 12, bottom: 12, left: 10),
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.3,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: InkWell(
                    hoverColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      print('Test');
                      print(DateFormat("yyyy-MMM-dd")
                          .format(selectedDate)
                          .toString());
                      // selectedDate.toString();
                      getAttendance(
                          date: DateFormat("yyyy-MM-dd")
                              .format(selectedDate)
                              .toString());
                      getEmployeeAttendance(
                          date: DateFormat('dd-MMM-yyyy')
                              .format(selectedDate)
                              .toString());
                    },
                    child: Center(
                      child: Text(
                        'Search',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            // Table(
            //   columnWidths: {
            //     0: FlexColumnWidth(MediaQuery.of(context).size.width * 0.3),
            //     1: FlexColumnWidth(MediaQuery.of(context).size.width * 0.2),
            //     2: FlexColumnWidth(MediaQuery.of(context).size.width * 0.2),
            //     3: FlexColumnWidth(MediaQuery.of(context).size.width * 0.2),
            //   },
            //   children: [
            //     TableRow(
            //       children: [
            //         buildTableRowText(
            //             title: 'Class Name',
            //             fontWeight: FontWeight.bold,
            //             color: Colors.blue[50],
            //             alignment: Alignment.centerLeft),
            //         buildTableRowText(
            //             title: 'Present',
            //             fontWeight: FontWeight.bold,
            //             color: Colors.blue[50],
            //             alignment: Alignment.center),
            //         buildTableRowText(
            //             title: 'Absent',
            //             fontWeight: FontWeight.bold,
            //             color: Colors.blue[50],
            //             alignment: Alignment.center),
            //         buildTableRowText(
            //             title: 'Leave',
            //             fontWeight: FontWeight.bold,
            //             color: Colors.blue[50],
            //             alignment: Alignment.center),
            //       ],
            //     )
            //   ],
            // ),
            Divider(
              thickness: 5,
            ),
            UserType == 'A' || UserType == 'P' || UserType == 'M'
                ? Container(
                    //margin: EdgeInsets.symmetric(horizontal: 20),
                    margin:
                        EdgeInsets.only(left: 22, right: 22, top: 5, bottom: 0),
                    decoration: BoxDecoration(border: Border.all(width: 0.1)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isChecked == true
                                  ? Colors.blueAccent
                                  : Colors.white,
                              border: Border.all(width: 0.1)),
                          width: MediaQuery.of(context).size.width * 0.06,
                          height: MediaQuery.of(context).size.height * 0.05,
                          margin: EdgeInsets.all(4),
                          child: TextButton(
                            style: ButtonStyle(
                                overlayColor: MaterialStateProperty.all(
                                    Colors.transparent)),
                            onPressed: () {
                              setState(() {
                                isChecked = true;
                              });
                            },
                            child: Text(''),
                          ),
                        ),
                        Text('Student'),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isChecked == false
                                  ? Colors.blueAccent
                                  : Colors.white,
                              border: Border.all(width: 0.1)),
                          width: MediaQuery.of(context).size.width * 0.06,
                          height: MediaQuery.of(context).size.height * 0.05,
                          margin: EdgeInsets.all(4),
                          child: TextButton(
                            style: ButtonStyle(
                                overlayColor: MaterialStateProperty.all(
                                    Colors.transparent)),
                            onPressed: () {
                              setState(() {
                                isChecked = false;
                              });
                            },
                            child: Text(''),
                          ),
                        ),
                        Text('Employee')
                      ],
                    ),
                  )
                : Container(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            isChecked == true
                ? BlocConsumer<AttendanceEmployeeCubit,
                    AttendanceEmployeeState>(
                    listener: (context, state) {
                      if (state is AttendanceEmployeeLoadFail) {
                        if (state.failReason == "false") {
                          UserUtils.unauthorizedUser(context);
                        }
                      }
                    },
                    builder: (context, state) {
                      if (state is AttendanceEmployeeLoadInProgress) {
                        // return CircularProgressIndicator();
                        return LinearProgressIndicator();
                      } else if (state is AttendanceEmployeeLoadSuccess) {
                        return checkList(attendanceList: state.AttendanceList);
                        // return buildAttendanceList(
                        //     attendanceList: state.AttendanceList);
                      } else if (state is AttendanceEmployeeLoadFail) {
                        return checkList(error: state.failReason);
                        //return buildAttendanceList();
                      } else {
                        return Container();
                      }
                    },
                  )
                : BlocConsumer<AttendanceOfEmployeeAdminCubit,
                    AttendanceOfEmployeeAdminState>(
                    listener: (context, state) {
                      if (state is AttendanceOfEmployeeAdminLoadFail) {
                        if (state.failReason == "false") {
                          UserUtils.unauthorizedUser(context);
                        }
                      }
                    },
                    builder: (context, state) {
                      if (state is AttendanceOfEmployeeAdminLoadInProgress) {
                        // return CircularProgressIndicator();
                        return LinearProgressIndicator();
                      } else if (state
                          is AttendanceOfEmployeeAdminLoadSuccess) {
                        return checkEmployeeAttList(
                            empAttList: state.AttendanceList);
                      } else if (state is AttendanceOfEmployeeAdminLoadFail) {
                        return checkEmployeeAttList(error: state.failReason);
                      } else {
                        return Container();
                      }
                    },
                  ),
            //buildEmpAttendanceList(),
            //Todo
            //buildAttendanceList()

            // Container(
            //   width: MediaQuery.of(context).size.width,
            //   height: MediaQuery.of(context).size.height * 0.06,
            //   color: Theme.of(context).primaryColor,
            //   child: Center(
            //     child: Text(
            //       'Student Attendance',
            //       style: TextStyle(color: Colors.white, fontSize: 22),
            //     ),
            //   ),
            // ),
            // Container(
            //   width: MediaQuery.of(context).size.width * 1,
            //   color: Colors.grey,
            //   child: Text(
            //     '  Details',
            //     style: TextStyle(color: Colors.white, fontSize: 22),
            //   ),
            // ),
            //ListView.builder(itemBuilder: ,itemCount: ,)
            //ListView.separated(itemBuilder: itemBuilder, separatorBuilder: separatorBuilder, itemCount: itemCount)
            // Expanded(
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Icon(
            //         Icons.notifications,
            //         color: Colors.grey,
            //         size: 80,
            //       ),
            //       Text("No Notifications"),
            //     ],
            //   ),
            // )
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Expanded checkEmployeeAttList(
      {List<AttendanceOfEmployeeAdminModel>? empAttList, String? error}) {
    if (empAttList == null || empAttList.isEmpty) {
      return Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(error!),
          ],
        ),
      );
    } else {
      return buildEmpAttendanceList(empAttList: empAttList);
    }
  }

  Expanded buildEmpAttendanceList(
      {List<AttendanceOfEmployeeAdminModel>? empAttList}) {
    return Expanded(
      child: Scrollbar(
        child: ListView.separated(
            separatorBuilder: (context, index) => SizedBox(
                  height: 10,
                ),
            itemCount: empAttList!.length,
            itemBuilder: (context, index) {
              var item = empAttList[index];
              return Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 5),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(border: Border.all(width: 0.1)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                child: Text(
                                  '${item.name!.toUpperCase()}',
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          child: Text(
                            '${item.desigName != "" ? item.desigName!.toUpperCase() : "Designation - ?"}',
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.016,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${item.department != "" ? item.department : 'Department - ?'}',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w600),
                        ),
                        Row(
                          children: [
                            Text(
                              ' [${item.attStatus}]',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: item.attStatus == 'P'
                                      ? Colors.green
                                      : item.attStatus == 'A'
                                          ? Colors.red
                                          : Colors.orange),
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.007,
                                ),
                                item.mobileNo != ""
                                    ? GestureDetector(
                                        onTap: () {
                                          _launchPhoneURL(
                                              item.mobileNo.toString());
                                        },
                                        child: Icon(
                                          Icons.phone,
                                          size: 20,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      )
                                    : Container(),
                              ],
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }

  Expanded checkList(
      {String? error, List<AttendanceEmployeeModel>? attendanceList}) {
    if (attendanceList == null || attendanceList.isEmpty)
      return Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(error!),
          ],
        ),
      );
    else
      return buildAttendanceList(attendanceList: attendanceList);
  }

  Expanded buildAttendanceList(
      {List<AttendanceEmployeeModel>? attendanceList}) {
    return Expanded(
      child: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(height: 10),
          shrinkWrap: true,
          itemCount: attendanceList!.length,
          itemBuilder: (context, index) {
            var itm = attendanceList[index];
            return InkWell(
              onTap: () {
                //Navigator.pushNamed(context, AttendanceDetail.routeName);
                // print(itm.classIds);
                // print(itm.classSection);
                //print(DateFormat('dd-MMM-yyyy').format(selectedDate));
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return AttendanceDetail(
                        classId: itm.classIds,
                        classSection: itm.classSection,
                        date: DateFormat('dd-MMM-yyyy').format(selectedDate),
                      );
                    },
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(width: 0.2),
                ),
                //height: MediaQuery.of(context).size.height * 0.07,
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        child: Text(
                          //itm.data![index].classSection.toString(),
                          itm.classSection.toString(),
                          //item[index][0],
                          textScaleFactor: 1.0,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                      // SizedBox(
                      //   width: MediaQuery.of(context).size.width * 0.2,
                      // ),
                      Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                //item[index][1],
                                itm.present.toString(),
                                style: TextStyle(
                                    color: Colors.green[800],
                                    fontWeight: FontWeight.w700,
                                    fontSize: 25),
                              ),
                              Text(
                                'Present',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.03),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.1,
                          ),
                          Column(
                            children: [
                              Text(
                                itm.absent.toString(),
                                //item[index][2],
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 25),
                              ),
                              Text(
                                'Absent',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.03),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.1,
                          ),
                          Column(
                            children: [
                              Text(
                                itm.leave.toString(),
                                //item[index][3],
                                style: TextStyle(
                                    color: Color.fromRGBO(250, 196, 47, 1.0),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 25),
                              ),
                              Text(
                                'Leave',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.03),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                // child: Table(
                //   columnWidths: {
                //     0: FlexColumnWidth(
                //         MediaQuery.of(context).size.width * 0.3),
                //     1: FlexColumnWidth(
                //         MediaQuery.of(context).size.width * 0.2),
                //     2: FlexColumnWidth(
                //         MediaQuery.of(context).size.width * 0.2),
                //     3: FlexColumnWidth(
                //         MediaQuery.of(context).size.width * 0.2),
                //   },
                //   children: [
                //     // TableRow(
                //     //   children: [
                //     //     buildTableRowText(
                //     //         title: 'Class Name',
                //     //         fontWeight: FontWeight.bold,
                //     //         color: Colors.blue[50],
                //     //         alignment: Alignment.centerLeft),
                //     //     buildTableRowText(
                //     //         title: 'Present',
                //     //         fontWeight: FontWeight.bold,
                //     //         color: Colors.blue[50],
                //     //         alignment: Alignment.center),
                //     //     buildTableRowText(
                //     //         title: 'Absent',
                //     //         fontWeight: FontWeight.bold,
                //     //         color: Colors.blue[50],
                //     //         alignment: Alignment.center),
                //     //     buildTableRowText(
                //     //         title: 'Leave',
                //     //         fontWeight: FontWeight.bold,
                //     //         color: Colors.blue[50],
                //     //         alignment: Alignment.center),
                //     //   ],
                //     //),
                //     buildTableRows(
                //         className: item[index][0],
                //         present: item[index][1],
                //         absent: item[index][2],
                //         leave: item[index][3]),
                //   ],
                // ),
              ),
            );
          }),
    );
  }

  // TableRow buildTableRows(
  //     {String? className, String? present, String? absent, String? leave}) {
  //   return TableRow(
  //     decoration: BoxDecoration(
  //         // color: Colors.blue,
  //         ),
  //     children: [
  //       buildTableRowText(
  //           title: className,
  //           color: Colors.transparent,
  //           alignment: Alignment.centerLeft),
  //       buildTableRowText(
  //           title: present,
  //           txtColor: Colors.green[800],
  //           fontWeight: FontWeight.w600,
  //           alignment: Alignment.center),
  //       buildTableRowText(
  //           title: absent,
  //           txtColor: Colors.red,
  //           fontWeight: FontWeight.w600,
  //           alignment: Alignment.center),
  //       buildTableRowText(
  //           title: leave,
  //           txtColor: Color.fromRGBO(250, 196, 47, 1.0),
  //           fontWeight: FontWeight.w600,
  //           alignment: Alignment.center)
  //     ],
  //   );
  // }
  //
  // Container buildTableRowText(
  //         {String? title,
  //         FontWeight? fontWeight,
  //         Color? color,
  //         Color? txtColor,
  //         AlignmentGeometry? alignment}) =>
  //     Container(
  //       padding: const EdgeInsets.all(4),
  //       decoration: BoxDecoration(
  //         color: color,
  //         border: Border(
  //           bottom: BorderSide(
  //             color: Color(0xffECECEC),
  //           ),
  //         ),
  //       ),
  //       child: Align(
  //         alignment: alignment!,
  //         child: Column(
  //           children: [
  //             Text(
  //               title!,
  //               textScaleFactor: 1.5,
  //               style: TextStyle(
  //                   fontWeight: fontWeight ?? FontWeight.normal,
  //                   color: txtColor ?? Colors.black),
  //             ),
  //             title == 'present'
  //                 ? Text(
  //                     'Present',
  //                     style: TextStyle(
  //                       fontWeight: fontWeight ?? FontWeight.normal,
  //                       color: Colors.green[800],
  //                     ),
  //                   )
  //                 : title == 'absent'
  //                     ? Text(
  //                         'Absent',
  //                         style: TextStyle(
  //                             fontWeight: fontWeight ?? FontWeight.normal,
  //                             color: Colors.red),
  //                       )
  //                     : Text(
  //                         'Leave',
  //                         style: TextStyle(
  //                           fontWeight: fontWeight ?? FontWeight.normal,
  //                           color: Color.fromRGBO(250, 196, 47, 1.0),
  //                         ),
  //                       )
  //           ],
  //         ),
  //       ),
  //     );

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1947),
      lastDate: DateTime(2101),
    );
    if (picked != null)
      setState(() {
        print(picked);
        selectedDate = picked;
        // getAttendance(
        //     date: DateFormat("yyyy-MM-dd").format(selectedDate).toString());
      });
  }

  InkWell buildDateSelector({String? selectedDate, int? index}) {
    return InkWell(
      onTap: () => _selectDate(context),
      child: internalTextForDateTime(context,
          width: MediaQuery.of(context).size.width * 0.4,
          selectedDate: selectedDate),
      // Container(
      //   width: MediaQuery.of(context).size.width * 0.4,
      //   padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      //   decoration: BoxDecoration(
      //     border: Border.all(color: Color(0xffECECEC)),
      //   ),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       Container(
      //           width: MediaQuery.of(context).size.width * 0.25,
      //           child: RichText(
      //             text: TextSpan(
      //               text: '$selectedDate',
      //               style: TextStyle(
      //                 fontSize: 16,
      //                 color: Colors.black,
      //               ),
      //             ),
      //           )
      //           // Text(
      //           //   selectedDate!,
      //           //   overflow: TextOverflow.visible,
      //           //   maxLines: 1,
      //           // ),
      //           ),
      //       Icon(Icons.today, color: Theme.of(context).primaryColor)
      //     ],
      //   ),
      // ),
    );
  }
}

//Table(
//   columnWidths: {
//     0: FlexColumnWidth(
//         MediaQuery.of(context).size.width * 0.3),
//     1: FlexColumnWidth(
//         MediaQuery.of(context).size.width * 0.2),
//     2: FlexColumnWidth(
//         MediaQuery.of(context).size.width * 0.2),
//     3: FlexColumnWidth(
//         MediaQuery.of(context).size.width * 0.2),
//   },
//   children: [
//     // TableRow(
//     //   children: [
//     //     buildTableRowText(
//     //         title: 'Class Name',
//     //         fontWeight: FontWeight.bold,
//     //         color: Colors.blue[50],
//     //         alignment: Alignment.centerLeft),
//     //     buildTableRowText(
//     //         title: 'Present',
//     //         fontWeight: FontWeight.bold,
//     //         color: Colors.blue[50],
//     //         alignment: Alignment.center),
//     //     buildTableRowText(
//     //         title: 'Absent',
//     //         fontWeight: FontWeight.bold,
//     //         color: Colors.blue[50],
//     //         alignment: Alignment.center),
//     //     buildTableRowText(
//     //         title: 'Leave',
//     //         fontWeight: FontWeight.bold,
//     //         color: Colors.blue[50],
//     //         alignment: Alignment.center),
//     //   ],
//     //),
//     buildTableRows(
//         className: item[index][0],
//         present: item[index][1],
//         absent: item[index][2],
//         leave: item[index][3]),
//   ],
// ),
