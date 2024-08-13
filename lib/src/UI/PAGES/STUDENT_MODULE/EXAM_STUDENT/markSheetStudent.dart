import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/CLASS_LIST_CUBIT/class_list_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/MARK_SHEET_STUDENT_CUBIT/mark_sheet_student_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/OPEN_MARKSHEET_CUBIT/open_marksheet_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/STUDENT_CHOICE_SESSION_CUBIT/student_choice_session_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/STUDENT_SESSION_CUBIT/student_session_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/classListModel.dart';
import 'package:campus_pro/src/DATA/MODELS/markSheetModel.dart';
import 'package:campus_pro/src/DATA/MODELS/studentInfoModel.dart';
import 'package:campus_pro/src/DATA/MODELS/studentSessionModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonSnackbar.dart';
import 'package:campus_pro/src/UI/WIDGETS/drawerWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class MarkSheetStudent extends StatefulWidget {
  static const routeName = "/marksheet-student";
  final String? userType;
  MarkSheetStudent({this.userType});
  @override
  _MarkSheetStudentState createState() => _MarkSheetStudentState();
}

class _MarkSheetStudentState extends State<MarkSheetStudent> {
  StudentInfoModel? studentInfo;

  // String? _selectedYearSession = '2018-2019';
  // String? _selectedClass = 'VI - A2';

  // List<String> yearSessionDropdown = [
  //   '2018-2019',
  //   '2019-2020',
  //   '2020-2021',
  //   '2021-2022',
  //   '2022-2023',
  //   '2023-2024'
  // ];
  // List<String> classDropdown = [
  //   'VI - A2',
  //   'VI - A3',
  //   'VII - A1',
  //   'VII - B2',
  //   'VII - B1',
  //   'VII - B3'
  // ];

  String? sessionId;

  String? choiceClass;

  StudentSessionModel? selectedStudentSession;
  List<StudentSessionModel>? studentSessionDropdown;

  ClassListModel? selectedClass;
  List<ClassListModel>? classDropdown;

  @override
  void initState() {
    super.initState();
    selectedStudentSession =
        StudentSessionModel(id: "", sessionFrom: "", status: "");
    studentSessionDropdown = [];
    selectedClass = ClassListModel(
        classDisplayOrder: "", classId: "", classname: "", iD: "");
    classDropdown = [];
    getSession();
    // fetchClass();
    // markSheet();
  }

  void getSession() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final requestPayload = {
      "OUserId": uid!,
      "Token": token!,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId!,
      "StudentId": userData.stuEmpId!,
    };
    print("Sending student session data => $requestPayload");
    context.read<StudentSessionCubit>().studentSessionCubitCall(requestPayload);
  }

  void fetchCurrentClass() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final myClassData = {
      "OUserId": uid!,
      "Token": token!,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId!,
      "SessionID": sessionId,
      "StudentId": userData.stuEmpId!,
    };
    print("Sending StudentChoiceSession data => $myClassData");
    context
        .read<StudentChoiceSessionCubit>()
        .studentChoiceSessionCubitCall(myClassData);
  }

  void fetchClass() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final fetchClassesRequest = {
      "OUserId": uid!,
      "Token": token!,
      "OrgId": userData!.organizationId,
      "SchoolId": userData.schoolId!,
    };
    print("Sending classList data => $fetchClassesRequest");
    context.read<ClassListCubit>().classListCubitCall(fetchClassesRequest);
  }

  Map<String, String?> markSheetRequest = new Map();

  void getMarksheetList() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    markSheetRequest = {
      'OUserId': uid,
      'Token': token,
      'OrgId': userData!.organizationId,
      'Schoolid': userData.schoolId,
      'SessionID': sessionId,
      'ClassId': choiceClass!.split('#')[0],
      'StreamId': choiceClass!.split('#')[1],
      'SectionId': choiceClass!.split('#')[2],
      'YearId': choiceClass!.split('#')[3],
    };
    print("Sending MarkSheet data => $markSheetRequest");
    context
        .read<MarkSheetStudentCubit>()
        .loadMarkSheetCubitCall(markSheetRequest);
  }

  getMarksheetUrl(MarkSheetStudentModel? marksheet) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final testData = {
      "OUserId": uid!,
      "Token": token!,
      "OrgId": userData!.organizationId!,
      "Schoolid": userData.schoolId!,
      "SessionId": userData.currentSessionid!,
      "StuEmpId": userData.stuEmpId!,
      "UserType": userData.ouserType!,
      "AppUrl": userData.appUrl!,
      "Flag": "F",
      "MarksheetId": marksheet!.tempMarkSheetId!,
    };
    print("Sending OpenMarksheet data => $testData");
    context.read<OpenMarksheetCubit>().openMarksheetCubitCall(testData);
  }

  _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000)).then((value) {
      selectedStudentSession =
          StudentSessionModel(id: "", sessionFrom: "", status: "");
      studentSessionDropdown = [];
      selectedClass = ClassListModel(
          classDisplayOrder: "", classId: "", classname: "", iD: "");
      classDropdown = [];
      getSession();
    });
  }

  void _launchURL(String? _url) async => await canLaunch(_url!)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        drawer: DrawerWidget(),
        appBar: commonAppBar(context, title: "Marksheet"),
        body: RefreshIndicator(
          onRefresh: () => _onRefresh(),
          child: MultiBlocListener(
            listeners: [
              BlocListener<OpenMarksheetCubit, OpenMarksheetState>(
                listener: (context, state) {
                  if (state is OpenMarksheetLoadFail) {
                    if (state.failReason == "false") {
                      UserUtils.unauthorizedUser(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          commonSnackBar(title: "$SOMETHING_WENT_WRONG"));
                    }
                  }
                  if (state is OpenMarksheetLoadSuccess) {
                    print("open url data ${state.marksheetURL}");
                    _launchURL(state.marksheetURL);
                  }
                },
              ),
              BlocListener<StudentChoiceSessionCubit,
                  StudentChoiceSessionState>(
                listener: (context, state) {
                  if (state is StudentChoiceSessionLoadFail) {
                    if (state.failReason == "false") {
                      UserUtils.unauthorizedUser(context);
                    }
                  }
                  if (state is StudentChoiceSessionLoadSuccess) {
                    setState(() {
                      choiceClass = state.myClass;
                    });
                    fetchClass();
                  }
                },
              ),
            ],
            child: Column(
              children: [
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                //   child: Row(
                //     children: [
                //       BlocConsumer<YearSessionCubit, YearSessionState>(
                //           listener: (context, state) {
                //         if (state is YearSessionLoadSuccess) {
                //           fetchClass();
                //         }
                //       }, builder: (context, state) {
                //         if (state is YearSessionLoadInProgress) {
                //           return Container();
                //         } else if (state is YearSessionLoadSuccess) {
                //           return buildDropdown(
                //               index: 0,
                //               label: "Session:",
                //               selectedSession: state.yearSessionList[0],
                //               yearSessionDropdown: state.yearSessionList);
                //         } else if (state is YearSessionLoadFail) {
                //           return Container();
                //         } else {
                //           return Container();
                //         }
                //       }),
                //       SizedBox(width: 20),
                //       BlocConsumer<ClassListCubit, ClassListState>(
                //           listener: (context, state) {},
                //           builder: (context, state) {
                //             if (state is ClassListLoadInProgress) {
                //               return Container();
                //             } else if (state is ClassListLoadSuccess) {
                //               return buildDropdown(
                //                   index: 1,
                //                   label: "Class:",
                //                   selectedClass: state.classList[0],
                //                   classListDropdown: state.classList);
                //             } else if (state is ClassListLoadFail) {
                //               return Container();
                //             } else {
                //               return Container();
                //             }
                //           }),
                //     ],
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      BlocConsumer<StudentSessionCubit, StudentSessionState>(
                        listener: (context, state) {
                          if (state is StudentSessionLoadSuccess) {
                            setState(() {
                              sessionId = state.sessionData[0].id;
                              selectedStudentSession = state.sessionData[0];
                              studentSessionDropdown = state.sessionData;
                            });
                            fetchCurrentClass();
                            // fetchClass();
                            // getRemarksFromApi();
                          }
                          if (state is StudentSessionLoadFail) {
                            if (state.failReason == "false") {
                              UserUtils.unauthorizedUser(context);
                            } else {
                              setState(() {
                                selectedStudentSession = StudentSessionModel(
                                    id: "", sessionFrom: "", status: "");
                                studentSessionDropdown = [];
                              });
                            }
                          }
                        },
                        builder: (context, state) {
                          if (state is StudentSessionLoadInProgress) {
                            return buildStudentSessionDropdown(context);
                          } else if (state is StudentSessionLoadSuccess) {
                            return buildStudentSessionDropdown(context);
                          } else if (state is StudentSessionLoadFail) {
                            return buildStudentSessionDropdown(context);
                          } else {
                            return Container();
                          }
                        },
                      ),
                      SizedBox(width: 20),
                      BlocConsumer<ClassListCubit, ClassListState>(
                        listener: (context, state) {
                          if (state is ClassListLoadSuccess) {
                            setState(() {
                              final classSelect = state.classList
                                  .where((element) =>
                                      element.classId == choiceClass)
                                  .toList();
                              selectedClass = classSelect[0];
                              classDropdown = state.classList;
                            });
                            getMarksheetList();
                          }
                          if (state is ClassListLoadFail) {
                            if (state.failReason == "false") {
                              UserUtils.unauthorizedUser(context);
                            } else {
                              setState(() {
                                selectedClass = ClassListModel(
                                    iD: "",
                                    classDisplayOrder: "",
                                    classId: "",
                                    classname: "");
                                classDropdown = [];
                              });
                            }
                          }
                        },
                        builder: (context, state) {
                          if (state is ClassListLoadInProgress) {
                            return buildClassListDropdown(context);
                          } else if (state is ClassListLoadSuccess) {
                            return buildClassListDropdown(context);
                          } else if (state is ClassListLoadFail) {
                            return buildClassListDropdown(context);
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                BlocBuilder<MarkSheetStudentCubit, MarkSheetStudentState>(
                  builder: (context, state) {
                    if (state is MarkSheetStudentLoadInProgress) {
                      return Container();
                    } else if (state is MarkSheetStudentLoadSuccess) {
                      return buildMarksheetBody(context,
                          markSheetList: state.markSheetList);
                    } else if (state is MarkSheetStudentLoadFail) {
                      return buildMarksheetBody(context, markSheetList: []);
                    } else {
                      return Container();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Expanded buildStudentSessionDropdown(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          buildLabels('Session :'),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xffECECEC)),
              // borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButton<StudentSessionModel>(
              isDense: true,
              value: selectedStudentSession!,
              key: UniqueKey(),
              isExpanded: true,
              underline: Container(),
              items: studentSessionDropdown!
                  .map((item) => DropdownMenuItem<StudentSessionModel>(
                      child: Text(
                        item.sessionFrom!,
                      ),
                      value: item))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  sessionId = val!.id;
                  selectedStudentSession = val;
                });
                fetchCurrentClass();
                // fetchClass();
              },
            ),
          )
        ],
      ),
    );
  }

  Expanded buildClassListDropdown(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          buildLabels('Class :'),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xffECECEC)),
              // borderRadius: BorderRadius.circular(4),
            ),
            child: IgnorePointer(
              ignoring: true,
              child: DropdownButton<ClassListModel>(
                isDense: true,
                value: selectedClass!,
                key: UniqueKey(),
                isExpanded: true,
                underline: Container(),
                items: classDropdown!
                    .map((item) => DropdownMenuItem<ClassListModel>(
                        child: Text(
                          item.classname!,
                        ),
                        value: item))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    selectedClass = val!;
                    print("selectedClass: $val");
                  });
                  // getExamMarks(val!.examID);
                  // getMarksGraph(val!.classId);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding buildLabels(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(label,
          style: TextStyle(
            fontSize: 16,
          )),
    );
  }

  Expanded buildMarksheetBody(BuildContext context,
      {List<MarkSheetStudentModel>? markSheetList}) {
    return Expanded(
      child: Container(
        child: markSheetList!.isEmpty
            ? Center(
                child: Text(
                  NO_RECORD_FOUND,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                  ),
                ),
              )
            : ListView.separated(
                separatorBuilder: (context, index) => SizedBox(height: 10),
                itemCount: markSheetList.length,
                itemBuilder: (BuildContext context, int i) {
                  var item = markSheetList[i];
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffECECEC)),
                    ),
                    child: ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item.marksheetType!,
                            // textScaleFactor: 1.4,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(fontSize: 16),
                          ),
                          GestureDetector(
                            onTap: () {
                              getMarksheetUrl(item);
                            },
                            child: Icon(Icons.print,
                                color: Theme.of(context).primaryColor),
                          ),
                        ],
                      ),
                      subtitle: Text(
                        item.format!,
                        // textScaleFactor: 1.2,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: Colors.grey, fontSize: 15),
                      ),
                    ),
                  );
                }),
      ),
    );
  }
}

// Column(
//   children: [
//     BlocConsumer<GetsessionCubit, GetsessionState>(
//         listener: (context, state) {
//       if (state is GetsessionLoadInProgress) {
//       }
//       if (state is GetsessionLoadSuccess) {
//          context.read<FillclassCubit>().fetchClassCubitCall(fetchClassesRequest);
//        }

//       if (state is GetsessionLoadFail) {
//       }

//     }, builder: (context, state) {
//       if (state is GetsessionLoadInProgress) {
//         return buildExamSheet(context);
//       } else if (state is GetsessionLoadSuccess) {
//         return buildExamSheet(context);
//       } else if (state is GetsessionLoadFail) {
//         return toastFailedNotification(state.failReason);
//       } else {
//         return Center(child: CircularProgressIndicator());
//       }
//     }),
//     // BlocConsumer<FetchClassesCubit, FetchClassesState>(
//     //     listener: (context, state) {
//     //   if (state is GetsessionInProgress) {
//     //   }
//     //   if (state is GetsessionLoadFail) {
//     //     toastFailedNotification(state.failReason);
//     //   }
//     // }, builder: (context, state) {
//     //   if (state is GetsessionInProgress) {
//     //     return buildExamSheet(context);
//     //   } else if (state is GetsessionLoadSuccess) {
//     //     return buildExamSheet(context);
//     //   } else if (state is GetsessionLoadFail) {
//     //     return toastFailedNotification(state.failReason);
//     //   } else {
//     //     return Center(child: CircularProgressIndicator());
//     //   }
//     //  }
//     // ),
//   ],
// )
