import 'dart:convert';

import 'package:campus_pro/src/CONSTANTS/themeData.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/FILL_PERIOD_ATTENDANCE_CUBIT/fill_period_attendance_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/MARK_ATTENDANCE_PERIOD_EMPLOYEE_CUBIT/mark_attendance_employee_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/MARK_ATTENDANCE_SAVE_ATTENDANCE_CUBIT/mark_attendance_save_attendance_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/MARK_ATTENDANCE_UPDATE_ATTENDANCE_CUBIT/mark_attendance_update_attendance_employee_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/MEETING_DETAILS_ADMIN_CUBIT/meeting_details_admin_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/MEETING_RECIPIENT_LIST_ADMIN/meeting_recipient_list_admin_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/MEETING_STATUS_LIST_ADMIN/meeting_status_list_admin_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/RESULT_ANNOUNCE_CLASS_CUBIT/result_announce_class_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/SUBJECT_LIST_EMPLOYEE_CUBIT/subject_list_employee_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/TEACHERS_LIST_CUBIT/teachers_list_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/WEEK_PLAN_SUBJECT_LIST_CUBIT/week_plan_subject_list_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/SubjectListEmployeeModel.dart';
import 'package:campus_pro/src/DATA/MODELS/dummyData.dart';
import 'package:campus_pro/src/DATA/MODELS/markAttendacePeriodsEmployeeModel.dart';
import 'package:campus_pro/src/DATA/MODELS/meetingRecipientListAdminModel.dart';
import 'package:campus_pro/src/DATA/MODELS/meetingStatusListAdminModel.dart';
import 'package:campus_pro/src/DATA/MODELS/resultAnnounceClassModel.dart';
import 'package:campus_pro/src/DATA/MODELS/userTypeModel.dart';
import 'package:campus_pro/src/DATA/MODELS/weekPlanSubjectListModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/drawerWidget.dart';
import 'package:campus_pro/src/UI/WIDGETS/noRecordFound.dart';
import 'package:campus_pro/src/UTILS/appImages.dart';
import 'package:campus_pro/src/UTILS/fieldValidators.dart';
import 'package:campus_pro/src/UTILS/joinMeeting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class MeetingStatus extends StatefulWidget {
  static const routeName = "/meeting-status";
  const MeetingStatus({Key? key}) : super(key: key);

  @override
  _MeetingStatusState createState() => _MeetingStatusState();
}

class _MeetingStatusState extends State<MeetingStatus> {
  ResultAnnounceClassModel? selectedClass;
  List<ResultAnnounceClassModel>? classDropdown = [];

  WeekPlanSubjectListModel? selectedTeacher;
  List<WeekPlanSubjectListModel>? teacherDropdown = [];

  bool showFilters = false;

  int? selectedHour = 00;
  List<int> hourDropdown = [for (var i = 0; i <= 23; i++) i];

  DateTime selectedDate = DateTime.now();

  String? meetingIdOnTap = "";

  String? uid = "";
  String? token = "";
  UserTypeModel? userData;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
      helpText: "SELECT DATE",
    );
    if (picked != null)
      setState(() {
        selectedDate = picked;
      });
  }

  //Todo:
  String? selectedMeetingId = "";
  String? selectedClassId = "";
  String? selectedPeriodId = "";
  String getParticularAttendance = "";
  List<String> enteredIdOfStudent = [];
  List<Map<String, String?>> finalStudentList = [];
  //
  List<MarkAttendacePeriodsEmployeeModel> periodsItem = [];
  MarkAttendacePeriodsEmployeeModel? selectedPeriod;

  @override
  void initState() {
    selectedClass = ResultAnnounceClassModel(
        id: "0", className: "Select", classDisplayOrder: 0);
    selectedTeacher =
        WeekPlanSubjectListModel(subjectHead: "Select", subjectId: "0");
    getDataFromCache();
    super.initState();
  }

  getDataFromCache() async {
    uid = await UserUtils.idFromCache();
    token = await UserUtils.userTokenFromCache();
    userData = await UserUtils.userTypeFromCache();
    if (userData!.ouserType!.toLowerCase() == "a") {
      getMeetingStatusList("0");
    } else {
      getMeetingStatusList(userData!.stuEmpId!);
    }
    getClassList();
    // getEmployeeSubject();
  }

  getClassList() async {
    final sendingClassData = {
      "OUserId": uid,
      "Token": token,
      "EmpID": userData!.stuEmpId,
      "OrgId": userData!.organizationId,
      "Schoolid": userData!.schoolId,
      "usertype": userData!.ouserType,
      "classonly": "0",
      "classteacher": "0",
      "SessionId": userData!.currentSessionid,
    };
    context
        .read<ResultAnnounceClassCubit>()
        .resultAnnounceClassCubitCall(sendingClassData);
  }

  getEmployeeSubject() async {
    final getEmpSubData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "ClassID": selectedClass!.id!.split("#")[0],
      "StreamID": selectedClass!.id!.split("#")[1],
      "SectionID": selectedClass!.id!.split("#")[2],
      "YearID": selectedClass!.id!.split("#").last,
      "Schoolid": userData!.schoolId,
      "SessionId": userData!.currentSessionid,
      "EmpID": userData!.stuEmpId,
    };
    print('Sending WeekPlanSubjectList dat => $getEmpSubData');
    context
        .read<WeekPlanSubjectListCubit>()
        .weekPlanSubjectListCubitCall(getEmpSubData);
  }

  getClassTeachers() async {
    final teacherData = {
      'OUserId': uid,
      'Token': token,
      'OrgId': userData!.organizationId,
      'Schoolid': userData!.schoolId!,
      'SessionId': userData!.currentSessionid!,
      'StudentId': userData!.stuEmpId,
      'ClassId': selectedClass!.id!.split("#")[0],
      'SectionId': selectedClass!.id!.split("#")[2],
      'StreamId': selectedClass!.id!.split("#")[1],
      'YearId': selectedClass!.id!.split("#").last,
    };
    print("Sending TeachersList Data => $teacherData");
    context.read<TeachersListCubit>().teachersListCubitCall(teacherData);
  }

  getMeetingStatusList(String userId) async {
    String hour = "";
    if (selectedHour.toString().length == 1) {
      hour = "0$selectedHour:00";
    } else {
      hour = "$selectedHour:00";
    }
    final meetingData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData!.schoolId,
      "SessionId": userData!.currentSessionid,
      "ClassId": selectedClass!.id,
      "SubjectId": selectedTeacher!.subjectId,
      "EmpId": userId,
      // "EmpId": userData!.stuEmpId,
      "ToDate": "${DateFormat('dd-MMM-yyyy').format(selectedDate)} $hour",
      // "ToDate":DateFormat('dd-MMM-yyyy').format(selectedDate),
      "StuEmpId": userData!.stuEmpId,
      "UserType": userData!.ouserType,
      "ForUser": "s",
      "FromDate": "${DateFormat('dd-MMM-yyyy').format(selectedDate)} $hour",
      "ViewType": "Meetings",
      "MeetingId": "0",
      "VStatus": "A",
    };
    print("Sending MeetingStatusListAdmin Data => $meetingData");
    context
        .read<MeetingStatusListAdminCubit>()
        .meetingStatusListAdminCubitCall(meetingData);
  }

  getMeetingDetails({String? meetingId, String? getType}) async {
    setState(() {
      meetingIdOnTap = meetingId;
    });
    final meetingData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData!.schoolId,
      "SessionId": userData!.currentSessionid,
      "MeetingId": meetingIdOnTap,
      "StuEmpId": userData!.stuEmpId,
      "UserType": userData!.ouserType,
      "GetType": getType,
    };
    print('sending MeetingDetailsAdmin data $meetingData');
    context
        .read<MeetingDetailsAdminCubit>()
        .meetingDetailsAdminCubitCall(meetingData);
  }

  getMeetingRecipientList(
      {String? classid, String? meetingid, String? status}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final meetingData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "SessionId": userData.currentSessionid,
      "ClassId": classid,
      "SubjectId": "0",
      "EmpId": userData.stuEmpId,
      "ToDate": DateFormat('dd-MMM-yyyy').format(DateTime.now()),
      "StuEmpId": userData.stuEmpId,
      "UserType": userData.ouserType,
      "ForUser": "s",
      "FromDate": DateFormat('dd-MMM-yyyy').format(DateTime.now()),
      "ViewType": "Details",
      "MeetingId": meetingid,
      "VStatus": status,
    };
    print("Sending MeetingStatusListAdmin Data => $meetingData");
    context
        .read<MeetingRecipientListAdminCubit>()
        .meetingRecipientListAdminCubitCall(meetingData);
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
      "PeriodId": periodid.toString(),
      "EmpId": userData.stuEmpId,
      "UserType": userData.ouserType,
      "JsonString": jsonEncode(jsonstring),
    };
    print('Save Attendance Student List $saveAttendanceStuList');
    context
        .read<MarkAttendanceSaveAttendanceEmployeeCubit>()
        .markAttendanceSaveAttendanceCubitCall(saveAttendanceStuList);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: commonAppBar(context, title: "Meeting Status"),
      body: MultiBlocListener(
        listeners: [
          BlocListener<TeachersListCubit, TeachersListState>(
            listener: (context, state) {
              if (state is TeachersListLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                } else {
                  setState(() {
                    teacherDropdown = [];
                    selectedTeacher = null;
                    selectedTeacher = WeekPlanSubjectListModel(
                        subjectHead: "Select", subjectId: "0");
                  });
                }
              }
              if (state is TeachersListLoadSuccess) {
                setState(() {
                  teacherDropdown = [];
                  state.teacherData.forEach((element) {
                    teacherDropdown!.add(WeekPlanSubjectListModel(
                      subjectId: element.empId,
                      subjectHead: element.empSub,
                    ));
                  });

                  if (teacherDropdown![0].subjectHead != 'Select') {
                    teacherDropdown!.insert(
                        0,
                        WeekPlanSubjectListModel(
                            subjectHead: "Select", subjectId: "0"));
                  }
                  selectedTeacher = teacherDropdown!.first;
                });
              }
            },
          ),
          BlocListener<WeekPlanSubjectListCubit, WeekPlanSubjectListState>(
            listener: (context, state) {
              if (state is WeekPlanSubjectListLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                } else {
                  setState(() {
                    teacherDropdown = [];
                    selectedTeacher = null;
                    selectedTeacher = WeekPlanSubjectListModel(
                        subjectHead: "Select", subjectId: "0");
                  });
                }
              }
              if (state is WeekPlanSubjectListLoadSuccess) {
                setState(() {
                  teacherDropdown = [];
                  teacherDropdown = state.subjectList;
                  if (teacherDropdown![0].subjectHead != 'Select') {
                    teacherDropdown!.insert(
                        0,
                        WeekPlanSubjectListModel(
                            subjectHead: "Select", subjectId: "0"));
                  }
                  selectedTeacher = teacherDropdown!.first;
                });
              }
            },
          ),
          BlocListener<MeetingDetailsAdminCubit, MeetingDetailsAdminState>(
            listener: (context, state) {
              if (state is MeetingDetailsAdminLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                }
              }
              if (state is MeetingDetailsAdminLoadSuccess) {
                JoinMeeting().checkPlatform(
                    meetingSubject: state.meetingDetailData.meetingSubject,
                    meetingId: meetingIdOnTap);
              }
            },
          ),
          BlocListener<ResultAnnounceClassCubit, ResultAnnounceClassState>(
            listener: (context, state) {
              if (state is ResultAnnounceClassLoadSuccess) {
                setState(() {
                  classDropdown = state.classList;
                  if (classDropdown![0].className != 'Select') {
                    classDropdown!.insert(
                        0,
                        ResultAnnounceClassModel(
                            id: "0",
                            className: "Select",
                            classDisplayOrder: 0));
                  }
                  selectedClass = classDropdown!.first;
                });
              }
              if (state is ResultAnnounceClassLoadFail) {
                setState(() {
                  classDropdown = [];
                  selectedClass = null;
                });
              }
            },
          ),
          BlocListener<MeetingRecipientListAdminCubit,
              MeetingRecipientListAdminState>(listener: (context, state) {
            if (state is MeetingRecipientListAdminLoadSuccess) {
              if (getParticularAttendance == "Y") {
                state.recipientList.forEach((element) {
                  enteredIdOfStudent.add(element.sid!.toString());
                });
                setState(() {
                  getParticularAttendance = "N";
                });
                getMeetingRecipientList(
                    classid: selectedClassId,
                    meetingid: selectedMeetingId,
                    status: getParticularAttendance);
              } else {
                state.recipientList.forEach((element) {
                  setState(() {
                    finalStudentList.add({
                      "Id": element.sid.toString(),
                      "AttStatus": "N",
                    });
                  });
                });
                print("joined list $enteredIdOfStudent");

                enteredIdOfStudent.forEach((element) {
                  setState(() {
                    finalStudentList.add({
                      "Id": element.toString(),
                      "AttStatus": "Y",
                    });
                  });
                });

                // state.recipientList.forEach((element) {
                //   if (enteredIdOfStudent.contains(element.sid.toString())) {
                //     setState(() {
                //       finalStudentList.add({
                //         "Id": element.sid.toString(),
                //         "AttStatus": "Y",
                //       });
                //     });
                //   } else {
                //     setState(() {
                //       finalStudentList.add({
                //         "Id": element.sid.toString(),
                //         "AttStatus": "N",
                //       });
                //     });
                //   }
                // });

                //Todo:
                fillPeriodList();
                // getEmployeePeriod(classid: selectedClassId, number: 0);
              }
            }
            if (state is MeetingRecipientListAdminLoadFail) {
              if (state.failReason == "false") {
                UserUtils.unauthorizedUser(context);
              } else {}
            }
          }),
          BlocListener<MarkAttendancePeriodsEmployeeCubit,
              MarkAttendanceEmployeeState>(
            listener: (context, state) async {
              if (state is MarkAttendanceEmployeeLoadSuccess) {
                selectedPeriod = null;
                print("length ${state.periodList.length}");
                print("list ${state.periodList}");
                if (state.periodList.length < 2) {
                  print(state.periodList[0].periodname);
                  setState(() {
                    periodsItem = state.periodList;
                    selectedPeriod = state.periodList[0];
                  });
                  print(selectedPeriod!.periodid);
                  if (selectedPeriod!.periodid != "") {
                    saveAttendanceStuList(
                        classid: selectedClassId,
                        periodid: selectedPeriod!.periodid,
                        jsonstring: finalStudentList);
                  }
                } else {
                  await showDialog<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Select Period"),
                        content: StatefulBuilder(
                          builder:
                              (BuildContext context, StateSetter setState) {
                            return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  DropdownButton(
                                    value: selectedPeriod,
                                    items: state.periodList
                                        .map((e) => DropdownMenuItem(
                                              child: Text(
                                                '${e.periodname}',
                                              ),
                                              value: e,
                                            ))
                                        .toList(),
                                    onChanged:
                                        (MarkAttendacePeriodsEmployeeModel?
                                            val) {
                                      setState(() {
                                        selectedPeriod = val;
                                      });
                                    },
                                  )
                                ]);
                          },
                        ),
                        actions: [
                          ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.green),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "OK",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ))
                        ],
                      );
                    },
                  );

                  // await showDialog(
                  //     context: context,
                  //     builder: (context) {
                  //       return DropdownButton(
                  //         value: selectedPeriod,
                  //         items: state.periodList
                  //             .map((e) => DropdownMenuItem(
                  //                   child: Text(
                  //                     '${e.periodname}',
                  //                   ),
                  //                   value: e,
                  //                 ))
                  //             .toList(),
                  //         onChanged: (MarkAttendacePeriodsEmployeeModel? val) {
                  //           selectedPeriod = val;
                  //         },
                  //       );
                  //     });

                  setState(() {
                    selectedPeriod = selectedPeriod;
                  });

                  if (selectedPeriod != null) {
                    if (selectedPeriod!.periodid != "" &&
                        selectedPeriod!.periodid != null) {
                      saveAttendanceStuList(
                          classid: selectedClassId,
                          periodid: selectedPeriod!.periodid,
                          jsonstring: finalStudentList);
                    }
                  }
                }
              }
              if (state is MarkAttendanceEmployeeLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                } else {}
              }
            },
          ),
          BlocListener<MarkAttendanceSaveAttendanceEmployeeCubit,
                  MarkAttendanceSaveAttendanceEmployeeState>(
              listener: (context, state) {
            if (state is MarkAttendanceSaveAttendanceLoadSuccess) {
              if (state.result[0] == "Already Marked") {
                updateAttendanceStuList(
                  classid: selectedClassId,
                  periodid: selectedPeriod!.periodid,
                  jsonstring: finalStudentList,
                );
              } else {
                setState(() {
                  finalStudentList = [];
                });
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
              setState(() {
                finalStudentList = [];
              });
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
              } else {}
            }
          }),
          BlocListener<FillPeriodAttendanceCubit, FillPeriodAttendanceState>(
              listener: (context, state) {
            if (state is FillPeriodAttendanceLoadSuccess) {
              print(state.result);
              if (state.result == 'Success') {
                //Todo:
                //period wise
                getEmployeePeriod(classid: selectedClassId, number: 1);
              }
              if (state.result == 'Success1') {
                //only daily attendance
                getEmployeePeriod(classid: selectedClassId, number: 0);
              }
            }
          }),
        ],
        child: Column(
          children: [
            buildAddEnquiry(context),
            if (showFilters) buildTopFilter(context),
            BlocBuilder<MeetingStatusListAdminCubit,
                MeetingStatusListAdminState>(
              builder: (context, state) {
                if (state is MeetingStatusListAdminLoadInProgress) {
                  // return Center(child: CircularProgressIndicator());
                  return Center(child: LinearProgressIndicator());
                } else if (state is MeetingStatusListAdminLoadSuccess) {
                  return buildMeetingStatusList(context,
                      statusList: state.statusList);
                } else if (state is MeetingStatusListAdminLoadFail) {
                  return noRecordFound();
                } else {
                  return Container();
                }
              },
            ),
            // InkWell(
            //   onTap: () {
            //     showAdvanceFilters();
            //   },
            //   child: Container(
            //     color: Colors.white,
            //     width: MediaQuery.of(context).size.width,
            //     padding: const EdgeInsets.symmetric(vertical: 12.0),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         Text("Advance Filter",
            //             style: TextStyle(fontWeight: FontWeight.bold)),
            //         SizedBox(width: 8),
            //         Icon(Icons.filter_list),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Expanded buildMeetingStatusList(BuildContext context,
      {List<MeetingStatusListAdminModel>? statusList}) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (BuildContext context, int index) => Divider(),
        shrinkWrap: true,
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: statusList!.length,
        itemBuilder: (context, i) {
          var item = statusList[i];
          // print(
          //     "length ${item.subject!.split('\r\n')[0].split('-').toList()[1] == ""}");
          return ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Transform.translate(
                  offset: Offset(-10, 0),
                  child: Text(
                    "${item.subject!.split('\r\n')[0].split('-')[0]}",
                    // style: Theme.of(context)
                    //     .textTheme
                    //     .headline6!
                    //     .copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                userData!.ouserType == "E"
                    ? IconButton(
                        constraints: BoxConstraints(),
                        onPressed: () {
                          setState(() {
                            getParticularAttendance = "Y";
                            selectedMeetingId = item.id.toString();
                            selectedClassId = item.classids.toString();
                          });
                          getMeetingRecipientList(
                              meetingid: item.id.toString(),
                              classid: item.classids,
                              status: getParticularAttendance);
                        },
                        icon: Icon(
                          Icons.check_circle_outline_outlined,
                          color: Colors.blue,
                          size: 30,
                        ),
                      )
                    : Container()
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Container(
                    //   width: MediaQuery.of(context).size.width * 0.5,
                    //   child: Text(
                    //     item.subject!
                    //                     .split('\r\n')[0]
                    //                     .split('-')
                    //                     .toList()
                    //                     .length >
                    //                 1 &&
                    //             item.meetingdetails != null &&
                    //             item.meetingdetails != ""
                    //         ? item.email != "" && item.email != null
                    //             ? "${item.subject!.split('\r\n')[0].split('-')[1].replaceAll(" ", "")}\n${item.email}\n${item.meetingdetails!.split('(')[1].replaceAll('  ', ' ').replaceAll(')', '')}\n${item.meetingDatetime}"
                    //             : "${item.subject!.split('\r\n')[0].split('-')[1]}\n${item.meetingdetails!.split('(')[1].replaceAll('  ', ' ').replaceAll(')', '')}\n${item.meetingDatetime}"
                    //         : "${item.meetingDatetime}",
                    //     // item.meetingDate1!.split('on: ')[1],
                    //     style: Theme.of(context)
                    //         .textTheme
                    //         .headline6!
                    //         .copyWith(color: Colors.grey, fontSize: 12),
                    //     overflow: TextOverflow.ellipsis,
                    //   ),
                    // ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Text(
                            "${item.subject!.split('\r\n')[0].split('-').toList()[1] != "" ? item.subject!.split('\r\n')[0].split('-')[1] : "Meeting"}.",
                            // style: Theme.of(context)
                            //     .textTheme
                            //     .headline6!
                            //     .copyWith(color: Colors.grey, fontSize: 12),
                            //overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          "${item.email != null && item.email != "" ? "${item.email}\n${item.meetingdetails!.split('(')[1].replaceAll('  ', ' ').replaceAll(')', '')}\n${item.meetingDatetime}" : "${item.meetingdetails!.split('(')[1].replaceAll('  ', ' ').replaceAll(')', '')}\n${item.meetingDatetime}"}",
                          // style: Theme.of(context)
                          //     .textTheme
                          //     .headline6!
                          //     .copyWith(color: Colors.grey, fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: item.isActive == 0
                            ? Colors.red.shade300
                            : Colors.blue,
                        borderRadius: BorderRadius.circular(30.0),
                        border: Border.all(
                          width: 0.1,
                        ),
                      ),
                      child: Text(
                        "${item.isActive == 0 ? "Deleted" : "Not Deleted"}",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        buildEyeButtons(
                          value: item.admitted.toString(),
                          icon: Icons.remove_red_eye,
                          color: Colors.green[400],
                          onTap: () {
                            if (item.admitted! > 0) {
                              final data = {
                                "title": "Joined Users",
                                "classId": item.classids!,
                                "meetingId": item.id!.toString(),
                                "vStatus": "Y",
                              };
                              showAdvanceFilters(data);
                            }
                          },
                        ),
                        SizedBox(width: 8.0),
                        buildEyeButtons(
                          value: item.notAdmitted.toString(),
                          icon: Icons.remove_red_eye,
                          color: Colors.red[400],
                          onTap: () {
                            if (item.notAdmitted! > 0) {
                              final data = {
                                "title": "Not Joined Users",
                                "classId": item.classids!,
                                "meetingId": item.id!.toString(),
                                "vStatus": "N",
                              };
                              showAdvanceFilters(data);
                            }
                          },
                        ),
                      ],
                    ),
                    item.meetingLiveStatus != "N"
                        ? item.runningStatus == "Y"
                            ? buildEyeButtons(
                                value: "Join",
                                icon: Icons.videocam,
                                // icon: Icons.videocam_off,
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.8),
                                onTap: () {
                                  if (item.meetingLiveStatus!.toLowerCase() ==
                                      'y')
                                    getMeetingDetails(
                                        meetingId: item.id.toString(),
                                        getType: "ts");
                                })
                            : buildEyeButtons(
                                value: "Not Started",
                                icon: Icons.videocam,
                                // icon: Icons.videocam_off,
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.8),
                                onTap: () {})
                        : buildEyeButtons(
                            value: "Class Ended",
                            icon: Icons.videocam,
                            color: Colors.grey,
                            onTap: () {})
                  ],
                ),
              ],
            ),
            // trailing: Transform.translate(
            //   offset: Offset(10, 0),
            //   child: Row(
            //     mainAxisSize: MainAxisSize.min,
            //     children: [
            //       if (item.meetingLiveStatus!.toLowerCase() != 'y')
            //         Container(
            //           padding: const EdgeInsets.symmetric(
            //               vertical: 4.0, horizontal: 16.0),
            //           width: 100,
            //           decoration: BoxDecoration(
            //             color: Color(0xffFF5545).withOpacity(0.5),
            //             // color: Color(0xfff1f1f1),
            //             borderRadius: BorderRadius.circular(18.0),
            //           ),
            //           child: Text(
            //             "Ended",
            //             textAlign: TextAlign.center,
            //             style: GoogleFonts.quicksand(
            //                 color: Colors.black, fontWeight: FontWeight.bold),
            //           ),
            //         ),
            //       SizedBox(width: 8),
            //       InkResponse(
            //         onTap: () {
            //           // deleteMeeting(item.id.toString());
            //         },
            //         child: Icon(Icons.delete, color: Colors.red[400]),
            //       ),
            //     ],
            //   ),
            // ),
          );
        },
      ),
    );
  }

  Row buildAddEnquiry(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            setState(() => showFilters = !showFilters);
          },
          child: Container(
            padding: const EdgeInsets.all(8.0),
            // color: Theme.of(context).primaryColor,
            child: Row(
              children: [
                Icon(Icons.sort),
                Text("Filters",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ),
        // InkWell(
        //   onTap: () {
        //     // Navigator.pushNamed(context, AddNewEnquiry.routeName);
        //     // _drawerKey.currentState!.openEndDrawer();
        //   },
        //   child: Container(
        //     padding: const EdgeInsets.all(8.0),
        //     // color: Theme.of(context).primaryColor,
        //     child: Row(
        //       children: [
        //         Icon(Icons.add, color: Theme.of(context).primaryColor),
        //         Text("New Enquiry",
        //             style: TextStyle(
        //                 color: Theme.of(context).primaryColor,
        //                 fontWeight: FontWeight.bold)),
        //       ],
        //     ),
        //   ),
        // ),
      ],
    );
  }

  Container buildTopFilter(BuildContext context) {
    return Container(
      color: Color(0xffECECEC),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                buildClassDropdown(context),
                SizedBox(width: 20),
                buildTeacherDropdown(context),
              ],
            ),
          ),
          SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                buildDateContainer(context),
                SizedBox(width: 20),
                buildHoursDropdown(context),
              ],
            ),
          ),
          buildSearchBtn(),
        ],
      ),
    );
  }

  Container buildSearchBtn() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Theme.of(context).primaryColor,
      ),
      child: InkWell(
        onTap: () async {
          if (userData!.stuEmpId!.toLowerCase() == "a") {
            getMeetingStatusList(selectedTeacher!.subjectId!);
          } else {
            getMeetingStatusList(userData!.stuEmpId!);
          }
          setState(() => showFilters = !showFilters);
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.search, color: Colors.white),
            SizedBox(width: 4),
            Text(
              "Search",
              style: TextStyle(
                  fontFamily: "BebasNeue-Regular", color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Expanded buildClassDropdown(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 8),
          buildLabels(label: "Class"),
          SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButton<ResultAnnounceClassModel>(
              isDense: true,
              value: selectedClass,
              key: UniqueKey(),
              isExpanded: true,
              underline: Container(),
              items: classDropdown!
                  .map((item) => DropdownMenuItem<ResultAnnounceClassModel>(
                      child:
                          Text(item.className!, style: TextStyle(fontSize: 12)),
                      value: item))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  selectedClass = val;
                  print("selectedClass: $val");
                });
                if (userData!.ouserType!.toLowerCase() == "a") {
                  getClassTeachers();
                } else {
                  getEmployeeSubject();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Expanded buildTeacherDropdown(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 8),
          buildLabels(label: "Teacher/Subject"),
          SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButton<WeekPlanSubjectListModel>(
              isDense: true,
              value: selectedTeacher,
              key: UniqueKey(),
              isExpanded: true,
              underline: Container(),
              items: teacherDropdown!
                  .map((item) => DropdownMenuItem<WeekPlanSubjectListModel>(
                      child: Text(item.subjectHead!,
                          style: TextStyle(fontSize: 12)),
                      value: item))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  selectedTeacher = val;
                  print("selectedTeacher: $val");
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Expanded buildHoursDropdown(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 8),
          buildLabels(label: "Hours"),
          SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButton<int>(
              isDense: true,
              value: selectedHour,
              key: UniqueKey(),
              isExpanded: true,
              underline: Container(),
              items: hourDropdown
                  .map((item) => DropdownMenuItem<int>(
                      child: Text(
                          item.toString().length > 1
                              ? item.toString()
                              : "0${item.toString()}",
                          style: TextStyle(fontSize: 12)),
                      value: item))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  selectedHour = val;
                  print("selectedHour: $val");
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Expanded buildDateContainer(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 8),
          buildLabels(label: "Date"),
          SizedBox(height: 8),
          buildDateSelector(),
        ],
      ),
    );
  }

  InkWell buildDateSelector() {
    return InkWell(
      onTap: () => _selectDate(context),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Text(
                DateFormat("dd-MMM-yyyy").format(selectedDate),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Icon(Icons.today, color: Theme.of(context).primaryColor)
          ],
        ),
      ),
    );
  }

  Text buildLabels({String? label, Color? color}) {
    return Text(
      label!,
      style: TextStyle(
        color: color ?? Color(0xff313131),
        fontWeight: FontWeight.bold,
      ),
    );
  }

  InkWell buildEyeButtons(
      {String? value, IconData? icon, Color? color, void Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
        decoration: BoxDecoration(
          color: color!,
          borderRadius: BorderRadius.circular(18.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 5.0,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: Colors.white70,
            ),
            SizedBox(width: 8.0),
            Text(
              value!,
              textScaleFactor: 1.5,
              style: GoogleFonts.quicksand(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }

  showAdvanceFilters(Map<String, String> data) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return MeetingAdvanceFilters(prevData: data);
      },
    );
  }
}

class MeetingAdvanceFilters extends StatefulWidget {
  final Map<String, String>? prevData;

  const MeetingAdvanceFilters({Key? key, this.prevData}) : super(key: key);
  @override
  _MeetingAdvanceFiltersState createState() => _MeetingAdvanceFiltersState();
}

class _MeetingAdvanceFiltersState extends State<MeetingAdvanceFilters> {
  // "title": "Not Joined Users",
  // "classId": item.classids!,
  // "meetingId": item.id!.toString(),
  // "vStatus": "N",

  @override
  void initState() {
    getMeetingRecipientList();
    super.initState();
  }

  getMeetingRecipientList() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final meetingData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "SessionId": userData.currentSessionid,
      "ClassId": widget.prevData!['classId'],
      "SubjectId": "0",
      "EmpId": userData.stuEmpId,
      "ToDate": DateFormat('dd-MMM-yyyy').format(DateTime.now()),
      // "ToDate":DateFormat('dd-MMM-yyyy').format(selectedDate),
      "StuEmpId": userData.stuEmpId,
      "UserType": userData.ouserType,
      "ForUser": "s",
      "FromDate": DateFormat('dd-MMM-yyyy').format(DateTime.now()),
      "ViewType": "Details",
      "MeetingId": widget.prevData!['meetingId'],
      "VStatus": widget.prevData!['vStatus'],
    };
    print("Sending MeetingStatusListAdmin Data => $meetingData");
    context
        .read<MeetingRecipientListAdminCubit>()
        .meetingRecipientListAdminCubitCall(meetingData);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildTopBar(context, widget.prevData!['title']),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Divider(),
        ),
        BlocBuilder<MeetingRecipientListAdminCubit,
            MeetingRecipientListAdminState>(
          builder: (context, state) {
            if (state is MeetingRecipientListAdminLoadInProgress) {
              // return Center(child: CircularProgressIndicator());
              return Center(child: LinearProgressIndicator());
            } else if (state is MeetingRecipientListAdminLoadSuccess) {
              return buildMeetingRecipientList(context,
                  recipientList: state.recipientList);
            } else if (state is MeetingRecipientListAdminLoadFail) {
              return noRecordFound();
            } else {
              return Container();
            }
          },
        ),
      ],
    );
  }

  Widget buildMeetingRecipientList(BuildContext context,
      {List<MeetingRecipientListAdminModel>? recipientList}) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: recipientList!.length,
        itemBuilder: (context, i) {
          var user = recipientList[i];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 200,
                  child: Text(
                    "${i + 1}. ${user.admNo}",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Flexible(
                  child: Text(
                    "${user.stName}",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Padding buildTopBar(BuildContext context, String? title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Text(title!,
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 18)),
    );
  }
}

// class MeetingAdvanceFilters extends StatefulWidget {
//   @override
//   _MeetingAdvanceFiltersState createState() => _MeetingAdvanceFiltersState();
// }

// class _MeetingAdvanceFiltersState extends State<MeetingAdvanceFilters> {
//   DateTime selectedDate = DateTime.now();

//   final _filterKey = GlobalKey<FormState>();

//   TextEditingController taskNameController = TextEditingController();

//   String? _selectedClass = 'Select Class';
//   String? _selectedTeacherSubject = 'Select Status';
//   String? _selectedHours = 'Select Hours';

//   List<String> classDropdown = ['Select Class', 'I', 'II', "III"];
//   List<String> teacherSubjectDropdown = [
//     'Select Status',
//     'Suresh',
//     'Ramesh',
//     'Rahul'
//   ];
//   List<String> hoursDropdown = ['Select Hours', '1', '2', "3"];

//   @override
//   void dispose() {
//     taskNameController.dispose();
//     super.dispose();
//   }

//   GestureDetector buildDateSelector({int? index}) {
//     return GestureDetector(
//       onTap: () => _selectDate(context),
//       child: Container(
//         width: MediaQuery.of(context).size.width,
//         padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//         decoration: BoxDecoration(
//           border: Border.all(color: Color(0xffECECEC)),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Container(
//               width: MediaQuery.of(context).size.width / 4,
//               child: Text(
//                 "${selectedDate.toLocal()}".split(' ')[0],
//                 overflow: TextOverflow.visible,
//                 maxLines: 1,
//               ),
//             ),
//             Icon(Icons.today, color: Theme.of(context).primaryColor)
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: selectedDate,
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2101),
//       helpText: "SELECT START DATE",
//     );
//     if (picked != null && picked != selectedDate)
//       setState(() {
//         selectedDate = picked;
//       });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _filterKey,
//       child: Wrap(
//         children: [
//           buildTopBar(context),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Divider(),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Row(
//               children: [
//                 buildDropdown(
//                     label: "Class:",
//                     selectedValue: _selectedClass,
//                     dropdown: classDropdown),
//                 SizedBox(width: 20),
//                 buildDropdown(
//                     label: "Teacher/Subject:",
//                     selectedValue: _selectedTeacherSubject,
//                     dropdown: teacherSubjectDropdown),
//               ],
//             ),
//           ),
//           SizedBox(height: 40),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       buildLabels("Date:"),
//                       SizedBox(height: 8),
//                       buildDateSelector(index: 0),
//                     ],
//                   ),
//                 ),
//                 SizedBox(width: 20),
//                 buildDropdown(
//                     label: "Hours:",
//                     selectedValue: _selectedHours,
//                     dropdown: hoursDropdown),
//               ],
//             ),
//           ),
//           SizedBox(height: 20),
//           buildSearchButton(),
//         ],
//       ),
//     );
//   }

//   Container buildSearchButton() {
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10.0),
//         gradient: LinearGradient(
//             begin: Alignment.centerLeft,
//             end: Alignment.centerRight,
//             colors: [accentColor, primaryColor]),
//       ),
//       child: FlatButton(
//         onPressed: () {
//           Navigator.pop(context);
//           // Navigator.pushNamedAndRemoveUntil(
//           //     context, HomePage.routeName, (route) => false);
//         },
//         child: Text(
//           "Get Details",
//           style:
//               TextStyle(fontFamily: "BebasNeue-Regular", color: Colors.white),
//         ),
//       ),
//     );
//   }

//   Expanded buildDropdown(
//       {String? label, String? selectedValue, List<String>? dropdown}) {
//     return Expanded(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(height: 8),
//           buildLabels(label!),
//           SizedBox(height: 8),
//           Container(
//             padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//             decoration: BoxDecoration(
//               border: Border.all(color: Color(0xffECECEC)),
//               // borderRadius: BorderRadius.circular(4),
//             ),
//             child: DropdownButton<String>(
//               isDense: true,
//               value: selectedValue,
//               key: UniqueKey(),
//               isExpanded: true,
//               underline: Container(),
//               items: dropdown!
//                   .map((item) => DropdownMenuItem<String>(
//                       child: Text(item, style: TextStyle(fontSize: 12)),
//                       value: item))
//                   .toList(),
//               onChanged: (val) {
//                 setState(() {
//                   selectedValue = val;
//                   print("selectedValue: $val");
//                 });
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Container buildCurrentTextFields(
//       {String? label,
//       TextEditingController? controller,
//       String? Function(String?)? validator}) {
//     return Container(
//       // color: Colors.white,
//       padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           buildLabels(label!),
//           buildTextField(
//             controller: controller,
//             validator: validator,
//           ),
//         ],
//       ),
//     );
//   }

//   Padding buildLabels(String label) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8.0),
//       child: Text(
//         label,
//         style: TextStyle(
//           // color: Theme.of(context).primaryColor,
//           color: Color(0xff313131),
//         ),
//       ),
//     );
//   }

//   Container buildTextField({
//     String? Function(String?)? validator,
//     @required TextEditingController? controller,
//   }) {
//     return Container(
//       child: TextFormField(
//         // obscureText: !obscureText ? false : true,
//         controller: controller,
//         validator: validator,
//         autovalidateMode: AutovalidateMode.onUserInteraction,
//         style: TextStyle(color: Colors.black),
//         decoration: InputDecoration(
//           border: new OutlineInputBorder(
//             borderRadius: const BorderRadius.all(
//               const Radius.circular(18.0),
//             ),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(
//               color: Color(0xffECECEC),
//             ),
//             gapPadding: 0.0,
//           ),
//           disabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(
//               color: Theme.of(context).primaryColor,
//             ),
//           ),
//           errorBorder: OutlineInputBorder(
//             borderSide: BorderSide(
//               color: Color(0xffECECEC),
//             ),
//           ),
//           focusedErrorBorder: OutlineInputBorder(
//             borderSide: BorderSide(
//               color: Theme.of(context).primaryColor,
//             ),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(
//               color: Theme.of(context).primaryColor,
//             ),
//           ),
//           hintText: "type here",
//           hintStyle: TextStyle(color: Color(0xffA5A5A5)),
//           contentPadding:
//               const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
//           // suffixIcon: suffixIcon
//           //     ? InkWell(
//           //         onTap: () {
//           //           setState(() {
//           //             _showPassword = !_showPassword;
//           //           });
//           //         },
//           //         child: !_showPassword
//           //             ? Icon(Icons.remove_red_eye_outlined)
//           //             : Icon(Icons.remove_red_eye),
//           //       )
//           //     : null,
//         ),
//       ),
//     );
//   }

//   Padding buildTopBar(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text("Advance Filters",
//               style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                   fontSize: 18)),
//           Text("Reset",
//               style: TextStyle(
//                   // fontWeight: FontWeight.bold,
//                   color: Theme.of(context).accentColor)),
//         ],
//       ),
//     );
//   }
// }
