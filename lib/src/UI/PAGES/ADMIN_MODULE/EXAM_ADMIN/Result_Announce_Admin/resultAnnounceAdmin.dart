import 'dart:convert';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/GET_EXAM_RESULT_PUBLISH_CUBIT/get_exam_result_publish_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/GET_STUDENT_LIST_RESULT_ANNOUNCE_CUBIT/get_student_list_result_announce_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/PUBLISH_RESULT_ANNOUNCE_ADMIN/publish_result_admin_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/RESULT_ANNOUNCE_CLASS_CUBIT/result_announce_class_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/RESULT_ANNOUNCE_EXAM_CUBIT/result_announce_exam_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/YEAR_SESSION_CUBIT/year_session_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/getExamResultPublishModel.dart';
import 'package:campus_pro/src/DATA/MODELS/getStudentListResultAnnounceModel.dart';
import 'package:campus_pro/src/DATA/MODELS/resultAnnounceClassModel.dart';
import 'package:campus_pro/src/DATA/MODELS/resultAnnounceExamModel.dart';
import 'package:campus_pro/src/DATA/MODELS/yearSessionModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/PAGES/ADMIN_MODULE/EXAM_ADMIN/Result_Announce_Admin/resultAnnounceStudentMarks.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonSnackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

class ResultAnnounce extends StatefulWidget {
  static const routeName = '/Result-Announce';
  const ResultAnnounce({Key? key}) : super(key: key);

  @override
  _ResultAnnounceState createState() => _ResultAnnounceState();
}

class _ResultAnnounceState extends State<ResultAnnounce> {
  //session
  List<YearSessionModel>? sessionItems = [];
  YearSessionModel? selectedSession;

  //class
  List<ResultAnnounceClassModel> classItems = [];
  ResultAnnounceClassModel? selectedClass;

  //exam
  List<ResultAnnounceExamModel>? examItems = [];
  ResultAnnounceExamModel? selectedExam;

  //
  String? classId;
  String? examId;
  String? sessionId;
  //List<Map<String, dynamic>?> checkBoxList = [];
  List<Map<String, String?>>? publishResultJson;
  List<GetExamResultPublishModel>? studentList = [];
  bool isApplyChecked = false;

  //
  bool isPublished = false;
//
  int noOfMaleStudent = 0;
  int noOfFemaleStudent = 0;

  // student list
  List<GetStudentListResultAnnounceModel>? classStudentList;
  List<GetStudentListResultAnnounceModel>? finalStudentList;
  GlobalKey<FormFieldState> _studentSelectKey = GlobalKey<FormFieldState>();
  List<Map<String, String?>>? sendingStudentList = [];

  // final List<DropdownMenuItem<String>> sessionItem = item
  //     .map((String e) => DropdownMenuItem<String>(value: e, child: Text('$e')))
  //     .toList();

  // final List<DropdownMenuItem<String>> classItem = item1
  //     .map((String e) => DropdownMenuItem<String>(value: e, child: Text('$e')))
  //     .toList();

  // final List<DropdownMenuItem<String>> examItem = item2
  //     .map((String e) => DropdownMenuItem<String>(value: e, child: Text('$e')))
  //     .toList();

  // List? classListItem = [
  //   [
  //     'X1',
  //     '47',
  //     true,
  //     [
  //       ['eng', 'sandeep', '45', '45'],
  //       ['math', 'sandeep', '45', '45'],
  //       ['science', 'sandeep', '7', '7'],
  //     ]
  //   ],
  //   [
  //     'X',
  //     '47',
  //     false,
  //     [
  //       ['eng', 'sandeep', '45', '45'],
  //       ['math', 'sandeep', '45', '45'],
  //       ['science', 'sandeep', '7', '7'],
  //     ]
  //   ],
  //   [
  //     'X11',
  //     '47',
  //     true,
  //     [
  //       ['eng', 'sandeep', '45', '45'],
  //       ['math', 'sandeep', '45', '45'],
  //       ['science', 'sandeep', '7', '7'],
  //     ]
  //   ],
  // ];

  getSession() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final sendingSessionData = {
      "OUserId": uid,
      "Token": token,
      "EmpId": userData!.stuEmpId,
      "OrgID": userData.organizationId,
      "SchoolID": userData.schoolId,
      "UserType": userData.ouserType,
    };
    print('Sending session data $sendingSessionData');
    context.read<YearSessionCubit>().yearSessionCubitCall(sendingSessionData);
  }

  getClassList() async {
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
      "classteacher": "0",
      "SessionId": userData.currentSessionid,
    };

    context
        .read<ResultAnnounceClassCubit>()
        .resultAnnounceClassCubitCall(sendingClassData);
  }

  getClassWiseExam({String? classId, String? sessionid}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final sendingExamData = {
      "UserId": uid,
      "Token": token,
      "OrgID": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "Sessionid": sessionid.toString(),
      "StuEmpID": userData.stuEmpId,
      "Usertype": userData.ouserType,
      "ClassData": classId.toString(),
    };

    print('sending exam data $sendingExamData');

    context
        .read<ResultAnnounceExamCubit>()
        .resultAnnounceExamCubitCall(sendingExamData);
  }

  getStudentList({String? examid, String? classid}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final sendingData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "SessionId": userData.currentSessionid,
      "Examid": examid.toString(),
      "ClassData": classid.toString(),
      "EmpStuId": userData.stuEmpId,
      "Usertype": userData.ouserType,
    };
    print('Sending student list data $sendingData');
    context
        .read<GetExamResultPublishCubit>()
        .getExamResultPublishCubitCall(sendingData);
  }

  getResultAnnounce(
      {List<Map<String, String?>>? json, String? sessionid}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final resultAnnounceDataSend = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "SchoolId": userData.schoolId,
      "SessionId":
          //userData.currentSessionid,
          sessionid,
      "EmpStuId": userData.stuEmpId,
      "Usertype": userData.ouserType,
      "Json": jsonEncode(json),
      //     [
      //   {
      //     "Id": "${classId.toString()}",
      //     "IsChecked": "true",
      //     "ExamId": "${examId.toString()}"
      //   }
      // ].toString(),
      "StudentList": jsonEncode(sendingStudentList),
    };
    print('Publish result sending Data $resultAnnounceDataSend');

    context
        .read<PublishResultAdminCubit>()
        .publishResultAdminCubitCall(resultAnnounceDataSend);
  }

  getStudentListForClass(
      {String? classid,
      String? streamid,
      String? sectionid,
      String? yearid}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final sendingData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "SessionId": userData.currentSessionid,
      "ClassId": classid,
      "StreamId": streamid,
      "SectionId": sectionid,
      "YearId": yearid,
      "EmpId": userData.stuEmpId,
      "UserType": userData.ouserType,
    };
    print('sending data for result announce student list $sendingData');

    context
        .read<GetStudentListResultAnnounceCubit>()
        .getStudentListResultAnnounceCubitCall(sendingData);
  }

  @override
  void initState() {
    super.initState();
    selectedSession = YearSessionModel(id: "", status: "", sessionFrom: "");
    sessionItems = [];
    selectedClass =
        ResultAnnounceClassModel(id: "", className: "", classDisplayOrder: -1);
    classItems = [];
    selectedExam = ResultAnnounceExamModel(exam: "", examId: -1);
    examItems = [];
    classStudentList = [];
    finalStudentList = [];
    getSession();
    getClassList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
        context,
        title: 'Result Announce',
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<PublishResultAdminCubit, PublishResultAdminState>(
            listener: (context, state) {
              if (state is PublishResultAdminLoadInProgress) {
                setState(() {
                  isApplyChecked = true;
                });
              }
              if (state is PublishResultAdminLoadSuccess) {
                setState(() {
                  isApplyChecked = false;
                });
                //Todo
                // setState(() {
                //   studentList = [];
                //   publishResultJson = [];
                // });
                print('length ${studentList!.length}');
                ScaffoldMessenger.of(context).showSnackBar(
                  commonSnackBar(
                      title:
                          'Result ${isPublished ? "Published" : "UnPublished"}',
                      duration: Duration(seconds: 1)),
                );
              }
              if (state is PublishResultAdminLoadFail) {
                setState(() {
                  isApplyChecked = false;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  commonSnackBar(
                    title: '${state.failReason}',
                  ),
                );
              }
            },
          ),
        ],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                BlocConsumer<YearSessionCubit, YearSessionState>(
                  listener: (context, state) {
                    if (state is YearSessionLoadSuccess) {
                      setState(() {
                        selectedSession = state.yearSessionList[0];
                        sessionItems = state.yearSessionList;
                        sessionId = state.yearSessionList[0].id;
                      });
                      //getClassList();
                      getClassWiseExam(classId: classId, sessionid: sessionId);
                    }
                    if (state is YearSessionLoadFail) {
                      setState(() {
                        selectedSession = YearSessionModel(
                            id: "", sessionFrom: "", status: "");
                        sessionItems = [];
                      });
                    }
                  },
                  builder: (context, state) {
                    if (state is YearSessionLoadInProgress) {
                      return buildSessionDropDown();
                    } else if (state is YearSessionLoadSuccess) {
                      return buildSessionDropDown();
                    } else {
                      return Container();
                    }
                  },
                ),
                //buildSessionDropDown(),
                BlocConsumer<ResultAnnounceClassCubit,
                    ResultAnnounceClassState>(
                  listener: (context, state) {
                    if (state is ResultAnnounceClassLoadSuccess) {
                      setState(() {
                        selectedClass = state.classList[0];
                        classItems = state.classList;
                        classId = state.classList[0].id;
                      });
                      getClassWiseExam(classId: classId, sessionid: sessionId);
                      //student list for result announce
                      getStudentListForClass(
                          classid: classId!.split('#')[0],
                          streamid: classId!.split('#')[1],
                          sectionid: classId!.split('#')[2],
                          yearid: classId!.split('#')[4]);
                    }
                    if (state is ResultAnnounceClassLoadFail) {
                      if (state.failReason == 'false') {
                        UserUtils.unauthorizedUser(context);
                      }
                      setState(() {
                        selectedClass = ResultAnnounceClassModel(
                            id: "", classDisplayOrder: -1, className: "");
                        classItems = [];
                      });
                    }
                  },
                  builder: (context, state) {
                    if (state is ResultAnnounceClassLoadInProgress) {
                      return buildClassDropDown();
                    }
                    if (state is ResultAnnounceClassLoadSuccess) {
                      return buildClassDropDown();
                    } else {
                      return Container();
                    }
                  },
                ),
                //buildClassDropDown(),
              ],
            ),
            Row(
              children: [
                BlocConsumer<ResultAnnounceExamCubit, ResultAnnounceExamState>(
                    listener: (context, state) {
                  if (state is ResultAnnounceExamLoadSuccess) {
                    setState(() {
                      selectedExam = state.examList[0];
                      examItems = state.examList;
                      examId = state.examList[0].examId.toString();
                    });
                    // setState(() {
                    //   checkBoxList = [];
                    // });
                    getStudentList(examid: examId, classid: classId);
                  }
                  if (state is ResultAnnounceExamLoadFail) {
                    if (state.failReason == 'false') {
                      UserUtils.unauthorizedUser(context);
                    }
                    setState(() {
                      selectedExam =
                          ResultAnnounceExamModel(exam: "", examId: -1);
                      examItems = [];
                    });
                  }
                }, builder: (context, state) {
                  if (state is ResultAnnounceExamLoadInProgress) {
                    return buildExamDropDown();
                  } else if (state is ResultAnnounceExamLoadSuccess) {
                    return buildExamDropDown();
                  } else if (state is ResultAnnounceExamLoadFail) {
                    return buildExamDropDown();
                  } else {
                    return Container();
                  }
                }),
                BlocConsumer<GetStudentListResultAnnounceCubit,
                        GetStudentListResultAnnounceState>(
                    listener: (context, state) {
                  if (state is GetStudentListResultAnnounceLoadSuccess) {
                    setState(() {
                      classStudentList = state.stuList;
                    });
                    setState(() {
                      sendingStudentList = [];
                    });

                    classStudentList!.forEach((element) {
                      setState(() {
                        sendingStudentList!
                            .add({"StudentId": element.studentID.toString()});
                      });
                    });

                    setState(() {
                      noOfFemaleStudent = 0;
                      noOfMaleStudent = 0;
                    });

                    classStudentList!.forEach((element) {
                      setState(() {
                        if (element.gender!.toLowerCase() == "male") {
                          noOfMaleStudent += 1;
                        } else {
                          noOfFemaleStudent += 1;
                        }
                      });
                    });
                  }
                  if (state is GetStudentListResultAnnounceLoadFail) {
                    if (state.failReason == 'false') {
                      UserUtils.unauthorizedUser(context);
                    }
                    setState(() {
                      classStudentList = [];
                    });
                  }
                }, builder: (context, state) {
                  if (state is GetStudentListResultAnnounceLoadInProgress) {
                    return testTeacher();
                  } else if (state is GetStudentListResultAnnounceLoadSuccess) {
                    return buildStudentMultiSelect();
                  } else if (state is GetStudentListResultAnnounceLoadFail) {
                    return buildStudentMultiSelect();
                  } else {
                    return Container();
                  }
                }),
                // buildStudentMultiSelect
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  isApplyChecked == false
                      ? InkWell(
                          onTap: () {
                            if (studentList!.length > 0) {
                              //print(studentList!.length);
                              setState(() {
                                publishResultJson = [];
                                // print(classId);
                                // print(examId);
                                publishResultJson!.add({
                                  "Id".toString(): classId.toString(),
                                  "IsChecked".toString():
                                      isPublished ? "true" : "false",
                                  "ExamId".toString(): examId,
                                });
                              });
                              //print(checkBoxList);
                              getResultAnnounce(
                                sessionid: sessionId,
                                json: publishResultJson,
                              );
                            }
                          },
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent),
                          child: Container(
                            margin: EdgeInsets.only(
                                left: 19, right: 19, top: 8, bottom: 10),
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: MediaQuery.of(context).size.height * 0.05,
                            decoration: BoxDecoration(
                              border: Border.all(width: 0.2),
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                isPublished ? 'Publish' : "UnPublish",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        )
                      : Center(
                          child: Container(
                            width: 10,
                            height: 10,
                            child: CircularProgressIndicator(),
                          ),
                        ),
                  // : Container(
                  //     width: MediaQuery.of(context).size.width * 0.1,
                  //     child: Text("")),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              thickness: 5,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.015,
            ),
            BlocConsumer<GetExamResultPublishCubit, GetExamResultPublishState>(
              listener: (context, state) {
                if (state is GetExamResultPublishLoadSuccess) {
                  setState(() {
                    studentList = state.studentList;
                  });
                }
              },
              builder: (context, state) {
                if (state is GetExamResultPublishLoadInProgress) {
                  return checkList();
                } else if (state is GetExamResultPublishLoadSuccess) {
                  //return checkList(studentList: state.studentList);
                  return checkList(studentList: studentList);
                } else if (state is GetExamResultPublishLoadFail) {
                  return checkList(error: state.failReason);
                } else {
                  return Container();
                }
              },
            ),
            //buildStudentList(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            )
          ],
        ),
      ),
    );
  }

  Expanded checkList(
      {List<GetExamResultPublishModel>? studentList, String? error}) {
    if (studentList == null || studentList.isEmpty) {
      if (error == null) {
        return Expanded(
          child: Center(
            child: Text(
              NO_RECORD_FOUND,
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
            child: Text(
              '$error',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
        );
      }
    } else {
      return buildStudentList(studentList: studentList);
    }
  }

  Expanded buildStudentList({List<GetExamResultPublishModel>? studentList}) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(
          height: 10,
        ),
        itemCount: studentList!.length,
        itemBuilder: (context, index) {
          print(studentList.length);
          var item = studentList[index];
          var data = json.decode('${item.jsn}');
          //Todo:CheckBox
          // checkBoxList[index]!
          //     .addAll({'status': false, 'classID': item.classId.toString()});
          return InkWell(
            onTap: () {
              //print(itm[3]);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ResultAnnounceStudentMarks(
                      classItemList: data,
                    );
                  },
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 5),
              padding: EdgeInsets.only(left: 6, right: 10, top: 8, bottom: 8),
              decoration: BoxDecoration(
                border: Border.all(width: 0.2),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: isPublished,
                            onChanged: (val) {
                              setState(() {
                                isPublished = val!;
                              });
                            },
                          ),
                          Text(
                            '${item.compClass}',
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w900,
                                color: Colors.blueAccent),
                          ),
                        ],
                      ),
                      Text(
                        'Total Students : ${data[0]['TotalStudents']}',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      'Click Here To See Students With Marks.',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.red),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Container buildSessionDropDown() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 10),
      width: MediaQuery.of(context).size.width * 0.4,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Session',
            style: TextStyle(fontSize: 16),
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
            child: DropdownButton<YearSessionModel>(
              isDense: true,
              value: selectedSession,
              key: UniqueKey(),
              isExpanded: true,
              underline: Container(),
              items: sessionItems!
                  .map((e) => DropdownMenuItem(
                        child: Text('${e.sessionFrom}'),
                        value: e,
                      ))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  selectedSession = val;
                  sessionId = val!.id;
                });
                getClassWiseExam(classId: classId, sessionid: sessionId);
                getStudentListForClass(
                    classid: classId!.split('#')[0],
                    streamid: classId!.split('#')[1],
                    sectionid: classId!.split('#')[2],
                    yearid: classId!.split('#')[4]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Container buildExamDropDown() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 10),
      width: MediaQuery.of(context).size.width * 0.4,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Exam',
            style: TextStyle(fontSize: 16),
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
            child: DropdownButton<ResultAnnounceExamModel>(
              isDense: true,
              value: selectedExam,
              key: UniqueKey(),
              isExpanded: true,
              underline: Container(),
              items: examItems!
                  .map((e) => DropdownMenuItem(
                        child: Text('${e.exam}'),
                        value: e,
                      ))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  selectedExam = val;
                  examId = val!.examId.toString();
                });
                // setState(() {
                //   checkBoxList = [];
                // });
                setState(() {
                  studentList = [];
                });
                getStudentList(examid: examId, classid: classId);
              },
            ),
          ),
        ],
      ),
    );
  }

  Container buildClassDropDown() {
    return Container(
      margin: EdgeInsets.only(left: 19, right: 19, top: 8, bottom: 10),
      width: MediaQuery.of(context).size.width * 0.4,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Class',
            style: TextStyle(fontSize: 16),
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
              value: selectedClass,
              key: UniqueKey(),
              isExpanded: true,
              underline: Container(),
              items: classItems
                  .map((e) => DropdownMenuItem(
                        child: Text('${e.className}'),
                        value: e,
                      ))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  selectedClass = val;
                  classId = val!.id;
                });
                getClassWiseExam(classId: classId, sessionid: sessionId);
                getStudentListForClass(
                    classid: classId!.split('#')[0],
                    streamid: classId!.split('#')[1],
                    sectionid: classId!.split('#')[2],
                    yearid: classId!.split('#')[4]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildStudentMultiSelect() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 5,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.39,
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            '(B:$noOfMaleStudent)/(G:$noOfFemaleStudent)',
            style: TextStyle(fontSize: 16),
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width * 0.39,
          // padding: EdgeInsets.symmetric(horizontal: 10),
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: MultiSelectBottomSheetField<GetStudentListResultAnnounceModel>(
              initialValue: classStudentList!,
              autovalidateMode: AutovalidateMode.disabled,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xffECECEC)),
              ),
              key: _studentSelectKey,
              initialChildSize: 0.7,
              maxChildSize: 0.95,
              searchIcon: Icon(Icons.ac_unit),
              title: Text("All Student",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 18)),
              buttonText: Text(
                "Select Student",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              items: classStudentList!
                  .map((e) => MultiSelectItem(e, e.stName!))
                  .toList(),
              searchable: false,
              validator: (values) {
                if (values == null ||
                    values.isEmpty ||
                    finalStudentList!.isEmpty) {
                  return "Required Field";
                }
                return null;
              },
              onConfirm: (values) {
                setState(() {
                  finalStudentList = [];
                });
                setState(() {
                  finalStudentList = values;
                });

                setState(() {
                  sendingStudentList = [];
                });
                values.forEach((element) {
                  setState(() {
                    sendingStudentList!
                        .add({"StudentId": element.studentID.toString()});
                  });
                });

                setState(() {
                  noOfFemaleStudent = 0;
                  noOfMaleStudent = 0;
                });

                values.forEach((element) {
                  setState(() {
                    if (element.gender!.toLowerCase() == "male") {
                      noOfMaleStudent += 1;
                    } else {
                      noOfFemaleStudent += 1;
                    }
                  });
                });
                print('data of studets $sendingStudentList');
              },
              chipDisplay: MultiSelectChipDisplay.none()
              // MultiSelectChipDisplay(
              //   shape: RoundedRectangleBorder(),
              //   textStyle: TextStyle(
              //       fontWeight: FontWeight.w900,
              //       color: Theme.of(context).primaryColor),
              // ),
              ),
        ),
      ],
    );
  }

  Column testTeacher() {
    return Column(
      children: [
        SizedBox(
          height: 30,
        ),
        Container(
          child: Text(
            "Select Teacher",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          decoration: BoxDecoration(border: Border.all(width: 0.05)),
          padding: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width * 0.39,
          height: MediaQuery.of(context).size.height * 0.062,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        )
      ],
    );
  }
}
