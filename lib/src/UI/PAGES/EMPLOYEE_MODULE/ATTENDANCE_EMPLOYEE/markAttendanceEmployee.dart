import 'dart:convert';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/getSchoolSettingApi.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/FILL_PERIOD_ATTENDANCE_CUBIT/fill_period_attendance_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/MARK_ATTENDANCE_LIST_EMPLOYEE_CUBIT/mark_attendance_list_employee_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/MARK_ATTENDANCE_PERIOD_EMPLOYEE_CUBIT/mark_attendance_employee_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/MARK_ATTENDANCE_SAVE_ATTENDANCE_CUBIT/mark_attendance_save_attendance_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/MARK_ATTENDANCE_UPDATE_ATTENDANCE_CUBIT/mark_attendance_update_attendance_employee_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/RESULT_ANNOUNCE_CLASS_CUBIT/result_announce_class_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/markAttendacePeriodsEmployeeModel.dart';
import 'package:campus_pro/src/DATA/MODELS/markAttendanceListEmployeeModel.dart';
import 'package:campus_pro/src/DATA/MODELS/resultAnnounceClassModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonSnackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class MarkAttendance extends StatefulWidget {
  static const routeName = "/mark-attendance-employee";

  @override
  _MarkAttendanceState createState() => _MarkAttendanceState();
}

class _MarkAttendanceState extends State<MarkAttendance> {
  int present = 0;
  int absent = 0;
  int leave = 0;

  bool? checkStatus;

  String? periodType = "";
  //List<ClassListEmployeeModel>? classItem = [];
  List<ResultAnnounceClassModel>? classItem = [];

  List<MarkAttendacePeriodsEmployeeModel> periodsItem = [];

  List<MarkAttendanceListEmployeeModel> studentList = [];

  bool showDatePickerBySetting = false;
  DateTime attendanceDate = DateTime.now();

  static const sortItem = <String>['Name', 'Adm No', 'RollNo'];

  final List<DropdownMenuItem<String>> _dropDownSortITem = sortItem
      .map(
        (String value) => DropdownMenuItem<String>(
          child: Text(value),
          value: value,
        ),
      )
      .toList();

  ResultAnnounceClassModel? selectedClass;

  MarkAttendacePeriodsEmployeeModel? selectedPeriod;

  String? classId;
  String? periodId;

  String? btnSortSelectedVal;
  List<Map<String, String?>>? studentListFinal;

  // getEmployeeClass() async {
  //   final uid = await UserUtils.idFromCache();
  //   final token = await UserUtils.userTokenFromCache();
  //   final userData = await UserUtils.userTypeFromCache();
  //   final getEmpClassData = {
  //     "OUserId": uid!,
  //     "Token": token!,
  //     "OrgId": userData!.organizationId,
  //     "Schoolid": userData.schoolId,
  //     "SessionId": userData.currentSessionid,
  //     "EmpID": userData.stuEmpId,
  //   };
  //   print('Get EmployeeClass $getEmpClassData');
  //   context
  //       .read<ClassListEmployeeCubit>()
  //       .classListEmployeeCubitCall(getEmpClassData);
  // }

  // new class api
  getClassList({String? classteacher}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final sendingClassData = {
      "OUserId": uid,
      "Token": token,
      "EmpID": userData!.stuEmpId,
      "OrgId": userData.organizationId,
      "Schoolid": userData.schoolId,
      "usertype": userData.ouserType,
      "classonly": "0",
      //daily wise = classteacher=>1 or classteacher=>0
      "classteacher": classteacher,
      "SessionId": userData.currentSessionid,
    };
    context
        .read<ResultAnnounceClassCubit>()
        .resultAnnounceClassCubitCall(sendingClassData);
  }

  getEmployeePeriod({String? classid, int? number}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final getEmpPeriodData = {
      "OUserId": uid!,
      "Token": token!,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "SessionId": userData.currentSessionid,
      "EmpID": userData.stuEmpId,
      "ClassIds": classid.toString(),
      'UserType': userData.ouserType,
    };
    print('Get Employee Periods $number');
    context
        .read<MarkAttendancePeriodsEmployeeCubit>()
        .markAttendancePeriodsEmployeeCubitCall(getEmpPeriodData, number);
  }

  getAttendanceStudentList(
      {String? classid, String? orderby, String? periodid}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final getAttendanceStuList = {
      "OUserId": uid!,
      "Token": token!,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "SessionId": userData.currentSessionid,
      "ClassId": classid.toString(),
      "OrderBy": orderby.toString(),
      "SubjectId": "0",
      "PeriodId": periodid.toString(),
      "StuEmpId": userData.stuEmpId,
      "UserType": userData.ouserType,
      "SubjectId": "0",
      //
      "Date": "${DateFormat("dd-MMM-yyyy").format(attendanceDate)}"
    };
    print('Get Attendance Student List $getAttendanceStuList');
    context
        .read<MarkAttendanceListEmployeeCubit>()
        .markAttendanceListEmployeeCubitCall(getAttendanceStuList);
  }

  saveAttendanceStuList(
      {String? classid,
      List<Map<String, String?>>? jsonstring,
      String? periodid}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    print(jsonstring!.length);
    final saveAttendanceStuList = {
      "UserId": uid!,
      "Token": token!,
      "OrgId": userData!.organizationId,
      "SchoolId": userData.schoolId,
      "SessionId": userData.currentSessionid,
      "ClassId": classid.toString(),
      "JsonString": jsonEncode(jsonstring),
      "PeriodId": periodid.toString(),
      "EmpId": userData.stuEmpId,
      "UserType": userData.ouserType,
      //
      "Date": "${DateFormat("dd-MMM-yyyy").format(attendanceDate)}"
    };
    print('Save Attendance Student List $saveAttendanceStuList');
    context
        .read<MarkAttendanceSaveAttendanceEmployeeCubit>()
        .markAttendanceSaveAttendanceCubitCall(saveAttendanceStuList);
  }

  updateAttendanceStuList(
      {String? classid,
      List<Map<String, String?>>? jsonstring,
      String? periodid}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    print(jsonstring!.length);
    final updateAttendanceStuList = {
      "UserId": uid!,
      "Token": token!,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "SessionId": userData.currentSessionid,
      "classId": classid.toString(),
      "JsonString": jsonEncode(jsonstring),
      "PeriodId": periodid.toString(),
      "UserType": userData.ouserType,
      "StuEmpId": userData.stuEmpId,
      //
      "Date": "${DateFormat("dd-MMM-yyyy").format(attendanceDate)}"
    };
    print('update Attendance Student List $updateAttendanceStuList');
    context
        .read<MarkAttendanceUpdateAttendanceEmployeeCubit>()
        .markAttendanceUpdateAttendanceEmployeeCubitCall(
            updateAttendanceStuList);
  }

  fillPeriodList() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final sendingDataforfillPeriod = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
    };

    print('sending data for fill period $sendingDataforfillPeriod');

    context
        .read<FillPeriodAttendanceCubit>()
        .fillPeriod(sendingDataforfillPeriod);
  }

  getSchoolSetting() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final sendingData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "Prefix": "MarkAttByDate",
      "Condition": "y",
    };

    try {
      print("sending data for get school setting $sendingData");

      await GetSchoolSettingApi().schoolSetting(sendingData).then((value) {
        if (value.toUpperCase() == "Y") {
          setState(() {
            showDatePickerBySetting = true;
          });
        } else {
          setState(() {
            showDatePickerBySetting = false;
          });
        }
        print("show date picker value $showDatePickerBySetting");
      });
    } catch (e) {
      print("error on get school setting api $e");
    }
  }

  @override
  void initState() {
    super.initState();
    checkStatus = false;
    studentListFinal = [];
    studentList = [];
    btnSortSelectedVal = 'Name';
    selectedClass = ResultAnnounceClassModel(id: "", className: "");
    classItem = [];
    selectedPeriod = MarkAttendacePeriodsEmployeeModel(
        periodid: "", periodname: "", periodtype: "", durationmin: "");
    periodsItem = [];

    fillPeriodList();
    //
    getSchoolSetting();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: IntrinsicHeight(
        child: Container(
          color: Theme.of(context).primaryColor,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(left: 0, bottom: 0, top: 7, right: 0),
          padding: EdgeInsets.all(8),
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Present : $present',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                  ),
                ),
                VerticalDivider(
                  color: Colors.white,
                  thickness: 1,
                ),
                Text(
                  'Total Absent : $absent',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                  ),
                ),
                VerticalDivider(
                  color: Colors.white,
                  thickness: 1,
                ),
                Text(
                  'Total Leave : $leave',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      appBar: commonAppBar(
        context,
        title: 'Attendance Mark',
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<MarkAttendanceSaveAttendanceEmployeeCubit,
                  MarkAttendanceSaveAttendanceEmployeeState>(
              listener: (context, state) {
            if (state is MarkAttendanceSaveAttendanceLoadSuccess) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
                        'Attendance Saved',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Back',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      ],
                    );
                  });
            }
            if (state is MarkAttendanceSaveAttendanceLoadFail) {
              if (state.failReason == "false") {
                UserUtils.unauthorizedUser(context);
              }
            }
          }),
          BlocListener<MarkAttendanceUpdateAttendanceEmployeeCubit,
                  MarkAttendanceUpdateAttendanceEmployeeState>(
              listener: (context, state) {
            if (state is MarkAttendanceUpdateAttendanceLoadSuccess) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
                        'Attendance Updated',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Back',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      ],
                    );
                  });
            }
            if (state is MarkAttendanceUpdateAttendanceLoadFail) {
              if (state.failReason == "false") {
                UserUtils.unauthorizedUser(context);
              } else {
                ScaffoldMessenger.of(context)
                    .showSnackBar(commonSnackBar(title: SOMETHING_WENT_WRONG));
              }
            }
          }),
          BlocListener<FillPeriodAttendanceCubit, FillPeriodAttendanceState>(
              listener: (context, state) {
            if (state is FillPeriodAttendanceLoadSuccess) {
              print(state.result);
              if (state.result == 'Success') {
                //Todo:
                //period wise
                periodType = '1';
                getClassList(classteacher: '0');
              }
              if (state.result == 'Success1') {
                //only daily attendance
                periodType = '0';
                getClassList(classteacher: '1');
              }
            }
          }),
        ],
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(12),
              child: Row(
                children: [
                  BlocConsumer<ResultAnnounceClassCubit,
                      ResultAnnounceClassState>(
                    listener: (context, state) {
                      if (state is ResultAnnounceClassLoadSuccess) {
                        print(state.classList[0].className);
                        setState(() {
                          classItem = state.classList;
                          selectedClass = state.classList[0];
                          classId = state.classList[0].id;
                          print(classId);
                          getEmployeePeriod(
                              classid: classId, number: int.parse(periodType!));
                        });
                      }
                      if (state is ResultAnnounceClassLoadFail) {
                        if (state.failReason == "false") {
                          UserUtils.unauthorizedUser(context);
                        }
                        setState(() {
                          selectedClass =
                              ResultAnnounceClassModel(id: "", className: "");
                          classItem = [];
                        });
                      }
                    },
                    builder: (context, state) {
                      if (state is ResultAnnounceClassLoadInProgress) {
                        //return CircularProgressIndicator();
                        return buildClassDropDown();
                      } else if (state is ResultAnnounceClassLoadSuccess) {
                        return buildClassDropDown();
                      } else if (state is ResultAnnounceClassLoadFail) {
                        return buildClassDropDown();
                      } else {
                        return Container();
                      }
                    },
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                  ),
                  BlocConsumer<MarkAttendancePeriodsEmployeeCubit,
                      MarkAttendanceEmployeeState>(
                    listener: (context, state) {
                      if (state is MarkAttendanceEmployeeLoadSuccess) {
                        print(state.periodList[0].periodname);
                        setState(() {
                          periodsItem = state.periodList;
                          selectedPeriod = state.periodList[0];
                          periodId = state.periodList[0].periodid;
                        });

                        getAttendanceStudentList(
                            classid: classId,
                            periodid: periodId,
                            orderby: "StName");
                      }
                      if (state is MarkAttendanceEmployeeLoadFail) {
                        if (state.failReason == "false") {
                          UserUtils.unauthorizedUser(context);
                        } else {
                          setState(() {
                            selectedPeriod = MarkAttendacePeriodsEmployeeModel(
                                periodid: "",
                                periodname: "",
                                periodtype: "",
                                durationmin: "");
                            periodsItem = [];
                          });
                        }
                      }
                    },
                    builder: (context, state) {
                      if (state is MarkAttendanceEmployeeLoadInProgress) {
                        return buildPeriodDropDown();
                      } else if (state is MarkAttendanceEmployeeLoadSuccess) {
                        return buildPeriodDropDown();
                      } else {
                        return Container();
                      }
                    },
                  ),
                ],
              ),
            ),
            checkStatus == false
                ? studentList.length > 0
                    ? Padding(
                        padding: EdgeInsets.all(12),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                buildSortDropDown(),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.1,
                                ),
                                buildDatePicker(context),
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.42,
                              height:
                                  MediaQuery.of(context).size.height * 0.058,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: InkWell(
                                hoverColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                //splashColor: Colors.transparent,
                                onTap: () {
                                  print('studentList on Save => $studentList');
                                  setState(() {
                                    studentListFinal = [];
                                  });
                                  studentList.forEach((element) {
                                    setState(() {
                                      studentListFinal!.add({
                                        "Id".toString():
                                            element.studentId.toString(),
                                        "AttStatus".toString():
                                            element.attStatus.toString(),
                                      });
                                    });
                                  });
                                  saveAttendanceStuList(
                                      classid: classId,
                                      periodid: periodId,
                                      jsonstring: studentListFinal);
                                  setState(() {
                                    checkStatus = true;
                                  });
                                },
                                child: Center(
                                  child: Text(
                                    'Save',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Center(
                        child: Text(
                          'Save',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                        ),
                      )
                : Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            buildSortDropDown(),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.1,
                            ),
                            buildDatePicker(context),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.42,
                          height: MediaQuery.of(context).size.height * 0.058,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: InkWell(
                            hoverColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () {
                              print('pro');
                              setState(() {
                                studentListFinal = [];
                              });
                              studentList.forEach((element) {
                                setState(() {
                                  studentListFinal!.add({
                                    "Id".toString():
                                        element.studentId.toString(),
                                    "AttStatus".toString():
                                        element.attStatus.toString(),
                                  });
                                });
                              });
                              print("studentListFinal $studentListFinal");
                              updateAttendanceStuList(
                                  classid: classId,
                                  periodid: periodId,
                                  jsonstring: studentListFinal);
                            },
                            child: Center(
                              child: Text(
                                'Update',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Divider(
              thickness: 10,
            ),
            BlocConsumer<MarkAttendanceListEmployeeCubit,
                MarkAttendanceListEmployeeState>(
              listener: (context, state) {
                if (state is MarkAttendanceListLoadSuccess) {
                  present = 0;
                  absent = 0;
                  leave = 0;

                  setState(() {
                    state.attendanceList[0].attStatus == ""
                        ? checkStatus = false
                        : checkStatus = true;
                  });
                  state.attendanceList.forEach((element) {
                    setState(() {
                      if (element.attStatus == "" || element.attStatus == "Y") {
                        present += 1;
                        if (element.attStatus == "") {
                          element.attStatus = "Y";
                        }
                      }
                      if (element.attStatus == "L") {
                        leave += 1;
                      }
                      if (element.attStatus == "N") {
                        absent += 1;
                      }
                    });
                  });
                  // state.attendanceList.forEach((element) {
                  //   setState(() {
                  //     studentListFinal!.add({
                  //       "Id".toString(): element.studentId.toString(),
                  //       "AttStatus".toString(): element.attStatus.toString(),
                  //     });
                  //   });
                  // });
                  studentList = state.attendanceList;

                  setState(() {
                    studentList
                        .sort((c, d) => (c.stName!).compareTo((d.stName!)));
                  });
                  // studentList
                  //     .sort((c, d) => (c.stName!).compareTo((d.stName!)));
                }
                if (state is MarkAttendanceListLoadFail) {
                  if (state.failReason == "false") {
                    UserUtils.unauthorizedUser(context);
                  } else {
                    setState(() {
                      present = 0;
                      leave = 0;
                      absent = 0;
                      studentList = [];
                    });
                  }
                }
              },
              builder: (context, state) {
                if (state is MarkAttendanceListLoadInProgress) {
                  // return CircularProgressIndicator();
                  return LinearProgressIndicator();
                } else if (state is MarkAttendanceListLoadSuccess) {
                  //return checkStudentList(stuList: state.attendanceList);
                  return checkStudentList(stuList: studentList);
                } else if (state is MarkAttendanceListLoadFail) {
                  return checkStudentList(error: state.failReason);
                } else {
                  return Container();
                }
              },
            ),
            //buildStudentList()
          ],
        ),
      ),
    );
  }

  Widget buildDatePicker(BuildContext context) {
    return IgnorePointer(
      ignoring: showDatePickerBySetting == true ? false : true,
      child: GestureDetector(
        onTap: () async {
          var date = await showDatePicker(
              context: context,
              initialDate: attendanceDate,
              firstDate: DateTime(1947),
              lastDate: DateTime.now());

          if (date != null) {
            setState(() {
              attendanceDate = date;
            });
          }
          getAttendanceStudentList(
              classid: classId, periodid: periodId, orderby: "StName");
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xffECECEC)),
            borderRadius: BorderRadius.circular(4),
          ),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            children: [
              Text(
                "${DateFormat("dd-MMM-yyyy").format(attendanceDate)}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                width: 40,
              ),
              Icon(
                Icons.date_range,
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Expanded checkStudentList(
      {List<MarkAttendanceListEmployeeModel>? stuList, String? error}) {
    if (stuList == null || stuList.isEmpty || stuList.length == 0) {
      if (error != null) {
        return Expanded(
          child: Center(
            child: Text(
              "$error",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      } else {
        return Expanded(
          child: Center(
            child: Text("Wait"),
          ),
        );
      }
    } else {
      return buildStudentList(stuList: stuList);
    }
  }

  Expanded buildStudentList({List<MarkAttendanceListEmployeeModel>? stuList}) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(
          height: 3,
        ),
        itemCount: stuList!.length,
        itemBuilder: (context, index) {
          MarkAttendanceListEmployeeModel item = stuList[index];
          return Container(
            margin: EdgeInsets.only(left: 8, right: 8, top: 6, bottom: 4),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(width: 0.2),
            ),
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.55,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Row(
                          children: [
                            Text(
                              'Adm No: ${item.admNo}',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              ' , Roll No: ${item.rollNo}',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.006,
                      ),
                      Text(
                        '${item.stName}',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.006,
                      ),
                      Text(
                        'S/O : ${item.fatherName} ',
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.089,
                  height: MediaQuery.of(context).size.height * 0.055,
                  decoration: BoxDecoration(
                    color: item.attStatus == "" || item.attStatus == "Y"
                        ? Colors.green
                        : Colors.white,
                    border: Border.all(
                      color: Color(0xffECECEC),
                    ),
                    borderRadius: BorderRadius.circular(4),
                    // borderRadius: BorderRadius.circular(50),
                    shape: BoxShape.rectangle,
                  ),
                  child: TextButton(
                    style: ButtonStyle(
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                    ),
                    onPressed: () {
                      if (item.attStatus != "Y") {
                        setState(() {
                          if (item.attStatus == "L") {
                            leave -= 1;
                          }
                          if (item.attStatus == "N") {
                            absent -= 1;
                          }
                          item.attStatus = "Y";
                          present += 1;
                        });
                      }

                      studentList[index].attStatus = item.attStatus;
                    },
                    child: Text(
                      'P',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.04,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.089,
                  height: MediaQuery.of(context).size.height * 0.055,
                  decoration: BoxDecoration(
                    color: item.attStatus == "N" ? Colors.red : Colors.white,
                    border: Border.all(
                      color: Color(0xffECECEC),
                    ),
                    borderRadius: BorderRadius.circular(4),
                    // borderRadius: BorderRadius.circular(50),
                    shape: BoxShape.rectangle,
                  ),
                  child: TextButton(
                    style: ButtonStyle(
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                    ),
                    onPressed: () {
                      if (item.attStatus != "N") {
                        setState(() {
                          if (item.attStatus == "L") {
                            leave -= 1;
                          }
                          if (item.attStatus == "Y") {
                            present -= 1;
                          }
                          item.attStatus = "N";
                          absent += 1;
                        });
                      }
                      studentList[index].attStatus = item.attStatus;
                    },
                    child: Text(
                      'A',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.04,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.089,
                  height: MediaQuery.of(context).size.height * 0.055,
                  decoration: BoxDecoration(
                    color: item.attStatus == "L" ? Colors.orange : Colors.white,
                    border: Border.all(
                      color: Color(0xffECECEC),
                    ),
                    borderRadius: BorderRadius.circular(4),
                    shape: BoxShape.rectangle,
                  ),
                  child: TextButton(
                    style: ButtonStyle(
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                    ),
                    onPressed: () {
                      if (item.attStatus != "L") {
                        setState(() {
                          if (item.attStatus == "N") {
                            absent -= 1;
                          }
                          if (item.attStatus == "Y") {
                            present -= 1;
                          }
                          item.attStatus = "L";
                          leave += 1;
                        });
                      }
                      studentList[index].attStatus = item.attStatus;
                    },
                    child: Text(
                      'L',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Expanded buildClassDropDown() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Class',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xffECECEC)),
              borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButton<ResultAnnounceClassModel>(
              isDense: true,
              value: selectedClass!,
              iconSize: 20,
              elevation: 16,
              isExpanded: true,
              dropdownColor: Color(0xffFFFFFF),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 13.0,
              ),
              underline: Container(
                color: Color(0xffFFFFFF),
              ),
              items: classItem!
                  .map((itm) => DropdownMenuItem<ResultAnnounceClassModel>(
                      value: itm,
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          itm.className!,
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.w300),
                        ),
                      )))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  selectedClass = val!;
                  print("selectedMonth: $val");
                  classId = val.id;
                });
                // getEmployeePeriod(classid: classId);
                getEmployeePeriod(
                    classid: classId, number: int.parse(periodType!));
              },
            ),
          ),
        ],
      ),
    );
  }

  Expanded buildPeriodDropDown() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Period',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xffECECEC)),
              borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButton<MarkAttendacePeriodsEmployeeModel>(
              isDense: true,
              value: selectedPeriod,
              key: UniqueKey(),
              isExpanded: true,
              underline: Container(),
              items: periodsItem
                  .map((itm) =>
                      DropdownMenuItem<MarkAttendacePeriodsEmployeeModel>(
                          value: itm,
                          child: Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text(
                              itm.periodname!,
                              style: TextStyle(
                                  fontSize: 15.0, fontWeight: FontWeight.w300),
                            ),
                          )))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  selectedPeriod = val!;
                  print("selectedMonth: $val");
                  periodId = val.periodid;
                  btnSortSelectedVal = "Name";
                });
                getAttendanceStudentList(
                    classid: classId, periodid: periodId, orderby: "StName");
              },
            ),
          ),
        ],
      ),
    );
  }

  Expanded buildSortDropDown() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sort By ',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xffECECEC)),
              borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButton(
              isDense: true,
              value: btnSortSelectedVal,
              key: UniqueKey(),
              isExpanded: true,
              underline: Container(),
              items: this._dropDownSortITem,
              onChanged: (String? val) {
                setState(() {
                  btnSortSelectedVal = val!;
                  print("selectedMonth: $val");
                });
                print(val);
                if (val == "Name") {
                  // getAttendanceStudentList(
                  //     classid: classId, periodid: periodId, orderby: "StName");

                  setState(() {
                    studentList
                        .sort((c, d) => (c.stName!).compareTo((d.stName!)));
                  });
                  print(studentList.length);
                }
                if (val == "Adm No") {
                  // getAttendanceStudentList(
                  //     classid: classId, periodid: periodId, orderby: "AdmNo");
                  setState(() {
                    studentList
                        .sort((c, d) => (c.admNo!).compareTo((d.admNo!)));
                  });
                  print(studentList.length);
                }
                if (val == "RollNo") {
                  // getAttendanceStudentList(
                  //     classid: classId, periodid: periodId, orderby: "RollNo");
                  setState(() {
                    studentList
                        .sort((c, d) => (c.rollNo!).compareTo((d.rollNo!)));
                  });
                  print(studentList.length);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

// class AttendanceButton extends StatefulWidget {
//   var selButPres;
//   var selButAbs;
//   var selButLeave;
//   final ValueChanged<String> updateInc;
//   final ValueChanged<String> updateDec;
//
//   AttendanceButton(
//       {this.selButPres,
//       this.selButAbs,
//       this.selButLeave,
//       required this.updateInc,
//       required this.updateDec});
//
//   @override
//   _AttendanceButtonState createState() => _AttendanceButtonState();
// }
//
// class _AttendanceButtonState extends State<AttendanceButton> {
//   var selectedAttendance = 4;
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Container(
//           width: MediaQuery.of(context).size.width * 0.09,
//           height: MediaQuery.of(context).size.height * 0.08,
//           decoration: BoxDecoration(
//             color: selectedAttendance == 0 ? Colors.green : Colors.white,
//             border: Border.all(
//               color: Color(0xffECECEC),
//             ),
//             // borderRadius: BorderRadius.circular(50),
//             shape: BoxShape.circle,
//           ),
//           child: FlatButton(
//             splashColor: Colors.transparent,
//             onPressed: () {
//               if (selectedAttendance != 0) {
//                 if (selectedAttendance == 1) {
//                   setState(() {
//                     widget.updateInc('p');
//                     widget.updateDec('a');
//                     selectedAttendance = 0;
//                   });
//                 }
//                 if (selectedAttendance == 2) {
//                   setState(() {
//                     widget.updateInc('p');
//                     widget.updateDec('l');
//                     selectedAttendance = 0;
//                   });
//                 }
//                 if (selectedAttendance == 4) {
//                   setState(() {
//                     widget.updateInc('p');
//                     selectedAttendance = 0;
//                   });
//                 }
//               }
//             },
//             child: Text(
//               'P',
//               textAlign: TextAlign.center,
//             ),
//           ),
//         ),
//         SizedBox(
//           width: MediaQuery.of(context).size.width * 0.06,
//         ),
//         Container(
//           width: MediaQuery.of(context).size.width * 0.09,
//           height: MediaQuery.of(context).size.height * 0.08,
//           decoration: BoxDecoration(
//             color: selectedAttendance == 1 ? Colors.red : Colors.white,
//             border: Border.all(
//               color: Color(0xffECECEC),
//             ),
//             // borderRadius: BorderRadius.circular(50),
//             shape: BoxShape.circle,
//           ),
//           child: FlatButton(
//             splashColor: Colors.transparent,
//             onPressed: () {
//               if (selectedAttendance != 1) {
//                 if (selectedAttendance == 0) {
//                   setState(() {
//                     widget.updateInc('a');
//                     widget.updateDec('p');
//                     selectedAttendance = 1;
//                   });
//                 }
//                 if (selectedAttendance == 2) {
//                   setState(() {
//                     widget.updateInc('a');
//                     widget.updateDec('l');
//                     selectedAttendance = 1;
//                   });
//                 }
//                 if (selectedAttendance == 4) {
//                   setState(() {
//                     widget.updateInc('a');
//                     selectedAttendance = 1;
//                   });
//                 }
//               }
//               // setState(() {
//               //   widget.updateInc('a');
//               //   //widget.selButAbs = widget.selButAbs + 1;
//               //   selectedAttendance = 1;
//               //   //MarkAttendance().absent = MarkAttendance().absent + 1;
//               // });
//             },
//             child: Text(
//               'A',
//               textAlign: TextAlign.center,
//             ),
//           ),
//         ),
//         SizedBox(
//           width: MediaQuery.of(context).size.width * 0.06,
//         ),
//         Container(
//           width: MediaQuery.of(context).size.width * 0.09,
//           height: MediaQuery.of(context).size.height * 0.08,
//           decoration: BoxDecoration(
//             color: selectedAttendance == 2 ? Colors.orange : Colors.white,
//             border: Border.all(
//               color: Color(0xffECECEC),
//             ),
//             // borderRadius: BorderRadius.all(
//             //   Radius.circular(20),
//             // ),
//             shape: BoxShape.circle,
//           ),
//           child: FlatButton(
//             //hoverColor: Colors.transparent,
//             splashColor: Colors.transparent,
//             //highlightColor: Colors.transparent,
//             onPressed: () {
//               if (selectedAttendance != 2) {
//                 if (selectedAttendance == 0) {
//                   setState(() {
//                     widget.updateInc('l');
//                     widget.updateDec('p');
//                     selectedAttendance = 2;
//                   });
//                 }
//                 if (selectedAttendance == 1) {
//                   setState(() {
//                     widget.updateInc('l');
//                     widget.updateDec('a');
//                     selectedAttendance = 2;
//                   });
//                 }
//                 if (selectedAttendance == 4) {
//                   setState(() {
//                     widget.updateInc('l');
//                     selectedAttendance = 2;
//                   });
//                 }
//               }
//               // setState(() {
//               //   widget.updateInc('l');
//               //   //widget.selButLeave = widget.selButLeave + 1;
//               //   selectedAttendance = 2;
//               //   //MarkAttendance().leave = MarkAttendance().leave + 1;
//               // });
//             },
//             child: Text(
//               'L',
//               textAlign: TextAlign.center,
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }
