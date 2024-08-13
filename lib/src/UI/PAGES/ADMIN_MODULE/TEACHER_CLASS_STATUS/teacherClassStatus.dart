import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/CLASS_LIST_EMPLOYEE_CUBIT/class_list_employee_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/MEETING_RECIPIENT_LIST_ADMIN/meeting_recipient_list_admin_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/TEACHERS_LIST_MEETING_CUBIT/teachers_list_meeting_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/TEACHER_STATUS_LIST_CUBIT/teacher_status_list_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/classListEmployeeModel.dart';
import 'package:campus_pro/src/DATA/MODELS/meetingRecipientListAdminModel.dart';
import 'package:campus_pro/src/DATA/MODELS/teacherStatusListModel.dart';
import 'package:campus_pro/src/DATA/MODELS/teachersListMeetingModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../globalBlocProvidersFile.dart';

class TeacherClassStatus extends StatefulWidget {
  static const routeName = "/teacher-class-status";
  const TeacherClassStatus({Key? key}) : super(key: key);

  @override
  _TeacherClassStatusState createState() => _TeacherClassStatusState();
}

class _TeacherClassStatusState extends State<TeacherClassStatus> {
  //teacherDropDown
  TeachersListMeetingModel? selectedTeacher;
  List<TeachersListMeetingModel>? teacherList = [];

  //month dropdown
  static const item1 = [
    "Jan",
    "Feb",
    "March",
    "April",
    "May",
    "June",
    "July",
    "Aug",
    "Sept",
    "Oct",
    "Nov",
    "Dec"
  ];
  String selectedMonth = "Jan";
  // List<DropdownMenuItem<String>> monthList = item1
  //     .map((e) => DropdownMenuItem<String>(
  //           child: Text('$e',
  //               style: TextStyle(
  //                   fontSize: 12,
  //                   color: Theme.of(context).primaryColor,
  //                   fontWeight: FontWeight.bold)),
  //           value: e,
  //         ))
  //     .toList();

  //class dropdown
  ClassListEmployeeModel? selectedClass;
  List<ClassListEmployeeModel>? classList = [];

  //teacherStatus List
  List<TeacherStatusListModel> teacherStatus = [];
  Map<String, List<List>> finalCollectionStatusDateWise = {};
  Map<String, int> totalClassAttendedByTeacher = {};
  int totalClasses = 0;
  int attendedClassesTotal = 0;

  getTeacherList() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final sendingDataForTeacherList = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "EmpId": userData.stuEmpId,
      "UserType": userData.ouserType,
    };

    print('sending data for teacher list $sendingDataForTeacherList');

    context
        .read<TeachersListMeetingCubit>()
        .teachersListMeetingCubitCall(sendingDataForTeacherList);
  }

  getEmployeeClass({String? empId}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final getEmpClassData = {
      "OUserId": uid!,
      "Token": token!,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "SessionId": userData.currentSessionid,
      "EmpID": empId.toString(),
    };
    print('Employee Class List $getEmpClassData');
    context
        .read<ClassListEmployeeCubit>()
        .classListEmployeeCubitCall(getEmpClassData);
  }

  getTeacherSummary({String? classid, String? empid, String? monthid}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final sendingDataForTeacher = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "SessionId": userData.currentSessionid,
      "ClassId": classid,
      "SelectedEmpId": empid,
      "ForUser": "S",
      "MonthId": monthid,
      "EmpId": userData.stuEmpId,
      "UserType": userData.ouserType,
    };

    print('sending data for teacherStatusList $sendingDataForTeacher');
    context
        .read<TeacherStatusListCubit>()
        .teacherStatusListCubitCall(sendingDataForTeacher);
  }

  @override
  void initState() {
    super.initState();
    selectedTeacher = TeachersListMeetingModel(empId: "", name: "");
    selectedClass = ClassListEmployeeModel(iD: "", className: "");
    teacherList = [];
    classList = [];
    getTeacherList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, title: 'Teacher Class Details Logs'),
      body: MultiBlocListener(
        listeners: [
          BlocListener<ClassListEmployeeCubit, ClassListEmployeeState>(
            listener: (context, state) {
              if (state is ClassListEmployeeLoadSuccess) {
                setState(() {
                  selectedClass = state.classList[0];
                  classList = state.classList;
                });
                getTeacherSummary(
                    classid: selectedClass!.iD,
                    empid: selectedTeacher!.empId,
                    monthid: selectedMonth == "Jan"
                        ? "1-Jan-2022"
                        : selectedMonth == "Feb"
                            ? "1-Feb-2022"
                            : selectedMonth == "March"
                                ? "1-Mar-2022"
                                : selectedMonth == "April"
                                    ? "1-Apr-2021"
                                    : selectedMonth == "May"
                                        ? "1-May-2021"
                                        : selectedMonth == "June"
                                            ? "1-Jun-2021"
                                            : selectedMonth == "July"
                                                ? "1-Jul-2021"
                                                : selectedMonth == "Aug"
                                                    ? "1-Aug-2021"
                                                    : selectedMonth == "Sept"
                                                        ? "1-Sep-2021"
                                                        : selectedMonth == "Oct"
                                                            ? "1-Oct-2021"
                                                            : selectedMonth ==
                                                                    "Nov"
                                                                ? "1-Nov-2021"
                                                                : "1-Dec-2021");
              }
              if (state is ClassListEmployeeLoadFail) {
                if (state.failReason == 'false') {
                  UserUtils.unauthorizedUser(context);
                } else {
                  setState(() {
                    selectedClass =
                        ClassListEmployeeModel(iD: "", className: "");
                    classList = [];
                  });
                }
              }
            },
          ),
          BlocListener<TeacherStatusListCubit, TeacherStatusListState>(
              listener: (context, state) {
            if (state is TeacherStatusListLoadSuccess) {
              setState(() {
                finalCollectionStatusDateWise = {};
                totalClassAttendedByTeacher = {};
                totalClasses = 0;
                attendedClassesTotal = 0;
              });

              //
              state.statusList.forEach((element) {
                if (totalClassAttendedByTeacher
                        .containsKey(element.meetingDate) ==
                    true) {
                  print(element.tJoinTime);
                  if (element.tJoinTime != "") {
                    totalClassAttendedByTeacher.update(
                        element.meetingDate!,
                        (value) =>
                            totalClassAttendedByTeacher[element.meetingDate]! +
                            1);
                  }
                } else {
                  totalClassAttendedByTeacher
                      .addAll({"${element.meetingDate}": 0});
                  print(element.tJoinTime);
                  if (element.tJoinTime != "") {
                    totalClassAttendedByTeacher.update(
                        element.meetingDate!,
                        (value) =>
                            totalClassAttendedByTeacher[element.meetingDate]! +
                            1);
                  }
                }
              });
              //
              // state.statusList.forEach((element) {
              //   if (totalClassAttendedByTeacher
              //           .containsKey(element.meetingDate) ==
              //       true) {
              //     totalClassAttendedByTeacher.update(
              //         element.meetingDate!,
              //         (value) =>
              //             totalClassAttendedByTeacher[element.meetingDate]! +
              //             1);
              //   } else {}
              // });

              //  print(totalClassAttendedByTeacher);
              //
              state.statusList.forEach((element) {
                if (finalCollectionStatusDateWise
                        .containsKey(element.meetingDate) ==
                    true) {
                } else {
                  finalCollectionStatusDateWise
                      .addAll({"${element.meetingDate}": []});
                }
              });

              state.statusList.forEach((element) {
                if (finalCollectionStatusDateWise
                        .containsKey(element.meetingDate) ==
                    true) {
                  finalCollectionStatusDateWise[element.meetingDate]!.add([
                    element.meetingDate,
                    element.empId,
                    element.className,
                    element.id,
                    element.subjectId,
                    element.subjectHead,
                    element.classIds,
                    element.admitted,
                    element.classSection,
                    element.isActive,
                    element.meetingDate2,
                    element.meetingId,
                    element.meetingTime,
                    element.notAdmitted == null ? "0" : element.notAdmitted,
                    element.tJoinTime,
                    selectedClass!.iD,
                  ]);
                }
              });
              print(finalCollectionStatusDateWise);

              //
              // finalCollectionStatusDateWise.forEach((key, value) {
              //   print(key);
              // });

              setState(() {
                teacherStatus = state.statusList;
              });
              //end
              //

              finalCollectionStatusDateWise.forEach((key, value) {
                totalClasses =
                    totalClasses + finalCollectionStatusDateWise[key]!.length;
              });

              totalClassAttendedByTeacher.forEach((key, value) {
                attendedClassesTotal = attendedClassesTotal + value;
              });

              //
            }
            if (state is TeacherStatusListLoadFail) {
              if (state.failReason == 'false') {
                UserUtils.unauthorizedUser(context);
              } else {
                setState(() {
                  teacherStatus = [];
                });
              }
            }
          }),
        ],
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocConsumer<TeachersListMeetingCubit,
                    TeachersListMeetingState>(
                  listener: (context, state) {
                    if (state is TeachersListMeetingLoadSuccess) {
                      setState(() {
                        selectedTeacher = state.teacherList[0];
                        teacherList = state.teacherList;
                      });
                      getEmployeeClass(empId: selectedTeacher!.empId);
                    }
                    if (state is TeachersListMeetingLoadFail) {
                      if (state.failReason == 'false') {
                        UserUtils.unauthorizedUser(context);
                      } else {
                        setState(() {
                          selectedTeacher =
                              TeachersListMeetingModel(empId: "", name: "");
                          teacherList = [];
                        });
                      }
                    }
                  },
                  builder: (context, state) {
                    if (state is TeachersListMeetingLoadInProgress) {
                      return buildTeacherDropDown(context);
                    } else if (state is TeachersListMeetingLoadSuccess) {
                      return buildTeacherDropDown(context);
                    } else if (state is TeachersListMeetingLoadFail) {
                      return buildTeacherDropDown(context);
                    } else {
                      return Container();
                    }
                  },
                ),
                // buildTeacherDropDown(context),
                Divider(
                  thickness: 5,
                  color: Colors.black,
                  height: 5,
                ),
                buildMonthDropDown(context),
                buildClassDropDown(context),
              ],
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Buttons(
            //       title: 'Get Details',
            //       func: () {
            //         getTeacherSummary(
            //             classid: selectedClass!.iD,
            //             empid: selectedTeacher!.empId,
            //             monthid: selectedMonth == "Jan"
            //                 ? "1-Jan-2021"
            //                 : selectedMonth == "Feb"
            //                     ? "1-Feb-2021"
            //                     : selectedMonth == "March"
            //                         ? "1-Mar-2021"
            //                         : selectedMonth == "April"
            //                             ? "1-Apr-2021"
            //                             : selectedMonth == "May"
            //                                 ? "1-May-2021"
            //                                 : selectedMonth == "June"
            //                                     ? "1-Jun-2021"
            //                                     : selectedMonth == "July"
            //                                         ? "1-Jul-2021"
            //                                         : selectedMonth == "Aug"
            //                                             ? "1-Aug-2021"
            //                                             : selectedMonth ==
            //                                                     "Sept"
            //                                                 ? "1-Sep-2021"
            //                                                 : selectedMonth ==
            //                                                         "Oct"
            //                                                     ? "1-Oct-2021"
            //                                                     : selectedMonth ==
            //                                                             "Nov"
            //                                                         ? "1-Nov-2021"
            //                                                         : "1-Dec-2021");
            //       },
            //     ),
            //   ],
            // ),
            // SizedBox(
            //   height: 20,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Buttons(
            //       title: 'Export',
            //       func: () {},
            //     ),
            //     Buttons(
            //       title: 'Print',
            //       func: () {},
            //     ),
            //   ],
            // )
            Divider(color: Color(0xffECECEC), thickness: 2, height: 0),
            teacherStatus.length > 0
                ? Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    padding: EdgeInsets.all(6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                                child: Text(
                              'Teacher : ${selectedTeacher!.name}',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w600),
                            )),
                            Text(
                              'Month : $selectedMonth',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Total Class Attended : $attendedClassesTotal OF $totalClasses',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  )
                : Container(),
            teacherStatus.length > 0
                ? buildTeacherClassList()
                : Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 20.0),
                      child: Text(
                        "$NO_RECORD_FOUND",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Expanded buildTeacherClassList() {
    return Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: finalCollectionStatusDateWise.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                //finalCollectionStatusDateWise.values.elementAt(index)
                //   TeacherClassDateWiseDetails
                print(finalCollectionStatusDateWise.values.elementAt(index));
                // Navigator.pushNamed(
                //   context,
                //   TeacherClassDateWiseDetails.routeName,
                //   arguments: TeacherClassDateWiseDetails(
                //     classDetails:
                //         finalCollectionStatusDateWise.values.elementAt(index),
                //   ),
                // );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      print(finalCollectionStatusDateWise);
                      print(finalCollectionStatusDateWise.values);
                      return BlocProvider<MeetingRecipientListAdminCubit>(
                        create: (_) => MeetingRecipientListAdminCubit(
                            MeetingRecipientListAdminRepository(
                                MeetingRecipientListAdminApi())),
                        child: TeacherClassDateWiseDetails(
                          classDetails: finalCollectionStatusDateWise.values
                              .elementAt(index),
                          stuId: selectedTeacher!.empId,
                        ),
                      );
                    },
                  ),
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 5.0,
                ),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(width: 0.1),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Class Attended : ${totalClassAttendedByTeacher.values.elementAt(index)} OF ${finalCollectionStatusDateWise.values.elementAt(index).length}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '${finalCollectionStatusDateWise.keys.elementAt(index)}',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Tap To See All Details',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  Flexible buildClassDropDown(BuildContext context) {
    return Flexible(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(width: 2, color: Color(0xffECECEC)),
            // right: BorderSide(width: 2, color: Color(0xffECECEC)),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Text('Class List'),
            Container(
              child: DropdownButton<ClassListEmployeeModel>(
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                ),
                isDense: true,
                isExpanded: true,
                items: classList!
                    .map((e) => DropdownMenuItem(
                          child: Text('${e.className}',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold)),
                          value: e,
                        ))
                    .toList(),
                underline: Container(),
                value: selectedClass,
                onChanged: (val) {
                  setState(() {
                    selectedClass = val!;
                  });
                  getTeacherSummary(
                      classid: selectedClass!.iD,
                      empid: selectedTeacher!.empId,
                      monthid: selectedMonth == "Jan"
                          ? "1-Jan-2022"
                          : selectedMonth == "Feb"
                              ? "1-Feb-2022"
                              : selectedMonth == "March"
                                  ? "1-Mar-2022"
                                  : selectedMonth == "April"
                                      ? "1-Apr-2021"
                                      : selectedMonth == "May"
                                          ? "1-May-2021"
                                          : selectedMonth == "June"
                                              ? "1-Jun-2021"
                                              : selectedMonth == "July"
                                                  ? "1-Jul-2021"
                                                  : selectedMonth == "Aug"
                                                      ? "1-Aug-2021"
                                                      : selectedMonth == "Sept"
                                                          ? "1-Sep-2021"
                                                          : selectedMonth ==
                                                                  "Oct"
                                                              ? "1-Oct-2021"
                                                              : selectedMonth ==
                                                                      "Nov"
                                                                  ? "1-Nov-2021"
                                                                  : "1-Dec-2021");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Flexible buildMonthDropDown(BuildContext context) {
    return Flexible(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(width: 2, color: Color(0xffECECEC)),
            // right: BorderSide(width: 2, color: Color(0xffECECEC)),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Text('Month List'),
            Container(
              child: DropdownButton(
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                ),
                isDense: true,
                isExpanded: true,
                items: item1
                    .map((e) => DropdownMenuItem<String>(
                          child: Text('$e',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold)),
                          value: e,
                        ))
                    .toList(),
                value: selectedMonth,
                underline: Container(),
                onChanged: (String? val) {
                  setState(() {
                    selectedMonth = val!;
                  });
                  getTeacherSummary(
                      classid: selectedClass!.iD,
                      empid: selectedTeacher!.empId,
                      monthid: selectedMonth == "Jan"
                          ? "1-Jan-2022"
                          : selectedMonth == "Feb"
                              ? "1-Feb-2022"
                              : selectedMonth == "March"
                                  ? "1-Mar-2022"
                                  : selectedMonth == "April"
                                      ? "1-Apr-2021"
                                      : selectedMonth == "May"
                                          ? "1-May-2021"
                                          : selectedMonth == "June"
                                              ? "1-Jun-2021"
                                              : selectedMonth == "July"
                                                  ? "1-Jul-2021"
                                                  : selectedMonth == "Aug"
                                                      ? "1-Aug-2021"
                                                      : selectedMonth == "Sept"
                                                          ? "1-Sep-2021"
                                                          : selectedMonth ==
                                                                  "Oct"
                                                              ? "1-Oct-2021"
                                                              : selectedMonth ==
                                                                      "Nov"
                                                                  ? "1-Nov-2021"
                                                                  : "1-Dec-2021");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Flexible buildTeacherDropDown(BuildContext context) {
    return Flexible(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Text('Teacher List'),
            Container(
              child: DropdownButton<TeachersListMeetingModel>(
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                ),
                isDense: true,
                isExpanded: true,
                items: teacherList!
                    .map((e) => DropdownMenuItem(
                          child: Text('${e.name}',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold)),
                          value: e,
                        ))
                    .toList(),
                underline: Container(),
                value: selectedTeacher,
                onChanged: (val) {
                  setState(() {
                    selectedTeacher = val!;
                  });
                  getEmployeeClass(empId: selectedTeacher!.empId);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Buttons extends StatelessWidget {
  final VoidCallback? func;
  //final Function()? func;
  final String? title;
  const Buttons({
    Key? key,
    this.title,
    this.func,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: func!,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.35,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        margin: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          border: Border.all(width: 0.1),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            '$title',
            style: TextStyle(
                fontWeight: FontWeight.w600, fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class TeacherClassDateWiseDetails extends StatefulWidget {
  static const routeName = '/Teacher-Class-DateWise-Details';
  final List<List>? classDetails;
  final String? stuId;
  const TeacherClassDateWiseDetails(
      {Key? key, @required this.classDetails, this.stuId})
      : super(key: key);

  @override
  _TeacherClassDateWiseDetailsState createState() =>
      _TeacherClassDateWiseDetailsState();
}

class _TeacherClassDateWiseDetailsState
    extends State<TeacherClassDateWiseDetails> {
  @override
  List<List>? finalClassList = [];

  List<MeetingRecipientListAdminModel> classDetails = [];

  getMeetingRecipient(
      {String? classid,
      String? empid,
      String? meetingid,
      String? toDate,
      String? fromDate,
      String? subjectid}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final sendingDataForRecipient = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "SessionId": userData.currentSessionid,
      "ClassId": classid,
      "EmpId": empid,
      "ForUser": "S",
      "StuEmpId": userData.stuEmpId,
      "UserType": userData.ouserType,
      "ViewType": "Details",
      "MeetingId": meetingid,
      "VStatus": "Y",
      "ToDate": toDate,
      "FromDate": fromDate,
      "SubjectId": subjectid,
    };

    print('sending data for meetingStatusListAdmin $sendingDataForRecipient');

    context
        .read<MeetingRecipientListAdminCubit>()
        .meetingRecipientListAdminCubitCall(sendingDataForRecipient);
  }

  getData() async {
    setState(() {
      finalClassList = widget.classDetails;
    });
  }

  void initState() {
    print(widget.classDetails);
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context,
          title:
              'Class Details ${finalClassList!.length > 0 ? " - " : ""} ${finalClassList!.length > 0 ? finalClassList![0][0] : ""}'),
      body: MultiBlocListener(
        listeners: [
          BlocListener<MeetingRecipientListAdminCubit,
              MeetingRecipientListAdminState>(listener: (context, state) {
            if (state is MeetingRecipientListAdminLoadSuccess) {
              setState(() {
                classDetails = state.recipientList;
              });
              //buildDialogForStudents(context);
              buildBottomSheet(context);
            }
            if (state is MeetingRecipientListAdminLoadFail) {
              if (state.failReason == 'false') {
                UserUtils.unauthorizedUser(context);
              }
            }
          }),
        ],
        child: Column(
          children: [
            finalClassList != null
                ? Expanded(
                    child: buildTakenClassList(),
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  Future<dynamic> buildBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        elevation: 20,
        backgroundColor: Colors.blue.shade100,
        context: context,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(width: 0.05),
              borderRadius: BorderRadius.circular(2),
            ),
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(6),
            margin: EdgeInsets.all(4),
            child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: classDetails.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                              text:
                                  '${classDetails[index].stName!.toUpperCase()}',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                              children: [
                                TextSpan(
                                    text: '(${classDetails[index].admNo})',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black)),
                              ],
                            ),
                          ),
                          // Text('${classDetails[index].stName}'),
                          // Text('${classDetails[index].admNo}'),
                          Text(
                            '${classDetails[index].gender} ${classDetails[index].gender == 'MALE' ? "♂" : "♀"}',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Meeting Time : ${classDetails[index].meetingTime}',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        'Join Time : ${classDetails[index].jTime}',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Divider(),
                    ],
                  );
                }),
          );
        });
  }

  ListView buildTakenClassList() {
    return ListView.builder(
      itemCount: finalClassList!.length,
      itemBuilder: (context, index) {
        print("res");
        print(
          finalClassList![index][13].runtimeType,
        );
        print("type ${int.tryParse(finalClassList![index][13]).runtimeType}");
        var notAdmitted =
            int.tryParse(finalClassList![index][13]).runtimeType == Null
                ? "0"
                : finalClassList![index][13];
        return GestureDetector(
          onTap: () {
            getMeetingRecipient(
                classid: finalClassList![index][15],
                empid: widget.stuId,
                //finalClassList![index][1],
                meetingid: finalClassList![index][3],
                subjectid: finalClassList![index][4],
                toDate: finalClassList![index][0],
                fromDate: finalClassList![index][0]);

            // final data = {
            //   "title": "Joined Users",
            //   "classId": item.classids!,
            //   "meetingId": item.id!.toString(),
            //   "vStatus": "Y",
            // };
            //
            // showAdvanceFilters(data);
          },
          child: Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              border: Border.all(width: 0.1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // RichText(
                //     text: TextSpan(
                //   text:
                //       'Class : ${finalClassList![index][2]} ${finalClassList![index][8]}',
                //   style: TextStyle(
                //       fontSize: 15,
                //       fontWeight: FontWeight.w600,
                //       color: Colors.black),
                // children: [
                //
                // ]),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                          text: 'Class : ',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.red.shade300),
                          children: [
                            TextSpan(
                              text:
                                  '${finalClassList![index][2]} - ${finalClassList![index][8]}',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            )
                          ]),
                    ),
                    // Text(
                    //   'Class : ${finalClassList![index][2]} ${finalClassList![index][8]}',
                    //   style: TextStyle(
                    //     fontSize: 15,
                    //     fontWeight: FontWeight.w600,
                    //   ),
                    // ),
                    Text(
                      'Period Number : ${finalClassList![index][4]} ',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  'Subject : ${finalClassList![index][5]}',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Time : ${finalClassList![index][12]}',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                          text: 'JoinTime : ',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.red.shade300),
                          children: [
                            TextSpan(
                              text:
                                  '${finalClassList![index][14] != "" ? finalClassList![index][14] : "N/A"}',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            )
                          ]),
                    ),
                    // Text(
                    //   'joinTime : ${finalClassList![index][14] != "" ? finalClassList![index][14] : "N/A"}',
                    //   style: TextStyle(
                    //     fontSize: 15,
                    //     fontWeight: FontWeight.w600,
                    //   ),
                    // ),
                  ],
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  'Attendance : ${finalClassList![index][7]}/${int.parse(finalClassList![index][7]) + int.parse(notAdmitted)
                  // int.parse(finalClassList![index][13], onError: (e) {
                  //   return 0;
                  // })
                  }',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  // Future<dynamic> buildDialogForStudents(BuildContext context) {
  //   return showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         content: Container(
  //           height: MediaQuery.of(context).size.height * 0.8,
  //           width: MediaQuery.of(context).size.width * 0.5,
  //           padding: EdgeInsets.all(8),
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(2),
  //             border: Border.all(width: 0.1),
  //           ),
  //           child: ListView.builder(
  //               padding: EdgeInsets.zero,
  //               shrinkWrap: true,
  //               itemCount: classDetails.length,
  //               itemBuilder: (context, index) {
  //                 return Column(
  //                   // mainAxisAlignment: MainAxisAlignment.start,
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: [
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         RichText(
  //                           text: TextSpan(
  //                             text:
  //                                 '${classDetails[index].stName!.toUpperCase()}',
  //                             style: TextStyle(
  //                                 fontSize: 16,
  //                                 fontWeight: FontWeight.w600,
  //                                 color: Colors.black),
  //                             children: [
  //                               TextSpan(
  //                                   text: '(${classDetails[index].admNo})',
  //                                   style: TextStyle(
  //                                       fontSize: 14,
  //                                       fontWeight: FontWeight.w600,
  //                                       color: Colors.black)),
  //                             ],
  //                           ),
  //                         ),
  //                         // Text('${classDetails[index].stName}'),
  //                         // Text('${classDetails[index].admNo}'),
  //                         Text('${classDetails[index].gender}'),
  //                       ],
  //                     ),
  //                     Text('Meeting Time : ${classDetails[index].meetingTime}'),
  //                     Text('Join Time : ${classDetails[index].jTime2}'),
  //                     // Text('${classDetails[index].meetingTime}'),
  //                     // Text('${classDetails[index].joiningTime}'),
  //                   ],
  //                 );
  //               }),
  //         ),
  //         actions: [
  //           GestureDetector(
  //             onTap: () {
  //               Navigator.pop(context);
  //             },
  //             child: Center(
  //               child: Container(
  //                 margin: EdgeInsets.all(8),
  //                 padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
  //                 decoration: BoxDecoration(
  //                   color: Colors.green,
  //                   border: Border.all(width: 0.1),
  //                   borderRadius: BorderRadius.circular(20),
  //                 ),
  //                 child: Text(
  //                   'Back',
  //                   style: TextStyle(
  //                     fontWeight: FontWeight.w600,
  //                     fontSize: 16,
  //                     color: Colors.white,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           )
  //         ],
  //       );
  //     },
  //   );
}
