import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/EXAM_MARKS_CHART_CUBIT/exam_marks_chart_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/EXAM_MARKS_CUBIT/exam_marks_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/EXAM_SELECTED_LIST_CUBIT/exam_selected_list_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/YEAR_SESSION_CUBIT/year_session_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/examMarksModel.dart';
import 'package:campus_pro/src/DATA/MODELS/examSelectedListModel.dart';
import 'package:campus_pro/src/DATA/MODELS/userTypeModel.dart';
import 'package:campus_pro/src/DATA/MODELS/yearSessionModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/WIDGETS/CHARTS/examDetailChart.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/drawerWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExamTestResultStudent extends StatefulWidget {
  static const routeName = "/exam-test-result-Student";
  @override
  _ExamTestResultStudentState createState() => _ExamTestResultStudentState();
}

class _ExamTestResultStudentState extends State<ExamTestResultStudent> {
  String? uid;

  String? token;

  String? sessionId;

  UserTypeModel? userData;

  YearSessionModel? selectedYearSession;
  List<YearSessionModel>? yearSessionDropdown;

  ExamSelectedListModel? selectedExam;
  List<ExamSelectedListModel>? examDropdown;

  @override
  void initState() {
    selectedYearSession = YearSessionModel(id: "", sessionFrom: "", status: "");
    yearSessionDropdown = [];
    selectedExam =
        ExamSelectedListModel(displayOrder: "", exam: "", examID: "");
    examDropdown = [];
    getDataFromCache();
    super.initState();
  }

  getDataFromCache() async {
    uid = await UserUtils.idFromCache();
    token = await UserUtils.userTokenFromCache();
    userData = await UserUtils.userTypeFromCache();
    getSession();
  }

  void getSession() async {
    final requestPayload = {
      // "OUserId": uid!,
      // "Token": token!,
      // "OrgId": userData!.organizationId,
      // "SchoolId": userData!.schoolId!,
      "OUserId": uid,
      "Token": token,
      "EmpId": userData!.stuEmpId,
      "OrgID": userData!.organizationId,
      "SchoolID": userData!.schoolId,
      "UserType": userData!.ouserType,
    };
    print("Sending YearSession data => $requestPayload");
    context.read<YearSessionCubit>().yearSessionCubitCall(requestPayload);
  }

  void getExamSelected() async {
    final requestPayload = {
      "OUserId": uid!,
      "Token": token!,
      "OrgId": userData!.organizationId,
      "Schoolid": userData!.schoolId!,
      "StudentId": userData!.stuEmpId!,
      "SessionId": sessionId,
      "StuEmpId": userData!.stuEmpId,
      "UserType": userData!.ouserType,
    };
    print("Sending ExamSelectedList data => $requestPayload");
    context
        .read<ExamSelectedListCubit>()
        .examSelectedListCubitCall(requestPayload);
  }

  void getExamMarks(String? examID) async {
    final requestPayload = {
      "OUserId": uid!,
      "Token": token!,
      "OrgId": userData!.organizationId,
      "Schoolid": userData!.schoolId!,
      "SessionId": sessionId,
      "StudentId": userData!.stuEmpId!,
      "StuEmpId": userData!.stuEmpId!,
      "UserType": userData!.ouserType!,
      "ExamID": examID,
    };
    print("Sending ExamMarks data => $requestPayload");
    context.read<ExamMarksCubit>().examMarksCubitCall(requestPayload);
  }

  void getMarksGraph(String? examID) async {
    final requestPayload = {
      "OUserId": uid!,
      "Token": token!,
      "OrgId": userData!.organizationId,
      "Schoolid": userData!.schoolId!,
      "SessionId": sessionId,
      "StudentId": userData!.stuEmpId!,
      "StuEmpId": userData!.stuEmpId!,
      "UserType": userData!.ouserType!,
      "ExamId": examID,
    };
    print("Sending ExamMarksGraph data => $requestPayload");
    context.read<ExamMarksChartCubit>().examMarksChartCubitCall(requestPayload);
  }

  _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000)).then((value) {
      selectedYearSession =
          YearSessionModel(id: "", sessionFrom: "", status: "");
      yearSessionDropdown = [];
      selectedExam =
          ExamSelectedListModel(displayOrder: "", exam: "", examID: "");
      examDropdown = [];
      getDataFromCache();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: commonAppBar(context, title: "Exam Details"),
      body: RefreshIndicator(
        onRefresh: () => _onRefresh(),
        child: ListView(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        BlocConsumer<YearSessionCubit, YearSessionState>(
                          listener: (context, state) {
                            if (state is YearSessionLoadSuccess) {
                              setState(() {
                                sessionId = state.yearSessionList[0].id;
                                selectedYearSession = state.yearSessionList[0];
                                yearSessionDropdown = state.yearSessionList;
                              });
                              getExamSelected();
                              // getRemarksFromApi();
                            }
                            if (state is YearSessionLoadFail) {
                              if (state.failReason == "false") {
                                UserUtils.unauthorizedUser(context);
                              } else {
                                setState(() {
                                  selectedYearSession = YearSessionModel(
                                      id: "", sessionFrom: "", status: "");
                                  yearSessionDropdown = [];
                                });
                              }
                            }
                          },
                          builder: (context, state) {
                            if (state is YearSessionLoadInProgress) {
                              return buildYearSessionDropdown(context);
                            } else if (state is YearSessionLoadSuccess) {
                              return buildYearSessionDropdown(context);
                            } else if (state is YearSessionLoadFail) {
                              return buildYearSessionDropdown(context);
                            } else {
                              return Container();
                            }
                          },
                        ),
                        SizedBox(width: 20),
                        BlocConsumer<ExamSelectedListCubit,
                            ExamSelectedListState>(
                          listener: (context, state) {
                            if (state is ExamSelectedListLoadSuccess) {
                              setState(() {
                                selectedExam = state.marksList[0];
                                examDropdown = state.marksList;
                              });
                              // getExamMarks(state.marksList[0].examID);
                              getMarksGraph(state.marksList[0].examID);
                              getExamMarks(state.marksList[0].examID);
                            }
                            if (state is ExamSelectedListLoadFail) {
                              if (state.failreason == "false") {
                                UserUtils.unauthorizedUser(context);
                              } else {
                                setState(() {
                                  selectedExam = ExamSelectedListModel(
                                      displayOrder: "", exam: "", examID: "");
                                  examDropdown = [];
                                });
                                getMarksGraph('-1');
                                getExamMarks('-1');
                              }
                            }
                          },
                          builder: (context, state) {
                            if (state is ExamSelectedListLoadInProgress) {
                              return buildExamDropdown(context);
                            } else if (state is ExamSelectedListLoadSuccess) {
                              return buildExamDropdown(context);
                            } else if (state is ExamSelectedListLoadFail) {
                              return buildExamDropdown(context);
                            } else {
                              return Container();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 20),
                  BlocConsumer<ExamMarksChartCubit, ExamMarksChartState>(
                    listener: (context, state) {
                      if (state is ExamMarksChartLoadFail) {
                        if (state.failReason == "false") {
                          UserUtils.unauthorizedUser(context);
                        }
                      }
                    },
                    builder: (context, state) {
                      if (state is ExamMarksChartLoadInProgress) {
                        return Container();
                      } else if (state is ExamMarksChartLoadSuccess) {
                        // return BarPieCommonChart(
                        //   chartType: 'bar chart',
                        //   graphTitle: "Today's Enquiry",
                        //   commonDataList: state.chartList,
                        // );
                        return ExamDetailChart(examMarksChart: state.chartList);
                      } else if (state is ExamMarksChartLoadFail) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Center(
                            child: Text(
                              state.failReason,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                  SizedBox(height: 10),
                  Divider(color: Color(0xffECECEC), thickness: 6),
                  BlocConsumer<ExamMarksCubit, ExamMarksState>(
                    listener: (context, state) {
                      if (state is ExamMarksLoadFail) {
                        if (state.failReason == "false") {
                          UserUtils.unauthorizedUser(context);
                        }
                      }
                    },
                    builder: (context, state) {
                      if (state is ExamMarksLoadInProgress) {
                        // return CircularProgressIndicator();
                        return LinearProgressIndicator();
                      } else if (state is ExamMarksLoadSuccess) {
                        return buildExamMarksTable(context,
                            marksList: state.marksList);
                      } else if (state is ExamMarksLoadFail) {
                        return Container();
                      } else {
                        return Container();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildExamMarksTable(BuildContext context,
      {List<ExamMarksModel>? marksList}) {
    return Container(
      child: marksList!.isEmpty
          ? Center(child: Text(NO_RECORD_FOUND))
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "${selectedExam!.exam} Result [${selectedYearSession!.sessionFrom}]",
                    // textScaleFactor: 1.5,
                    // style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Subject",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(
                      width: 150,
                    ),
                    Text("Max Marks",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        )),
                    SizedBox(
                      width: 30,
                    ),
                    Text("Total Marks -\n Grade",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        )),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Table(
                    columnWidths: {
                      0: FlexColumnWidth(MediaQuery.of(context).size.width / 2),
                      1: FlexColumnWidth(
                          (MediaQuery.of(context).size.width / 2) / 2),
                      2: FlexColumnWidth(
                          (MediaQuery.of(context).size.width / 2) / 2),
                    },
                    // textDirection: TextDirection.rtl,
                    // defaultVerticalAlignment: TableCellVerticalAlignment.top,
                    // border: TableBorder.all(width: 2.0, color: Colors.red),
                    children: [
                      for (int i = 0; i < marksList.length; ++i)
                        buildTableRows(
                          subjectName: marksList[i].subjectName,
                          maxMarks: marksList[i].maxmarks,
                          studentMarks: marksList[i].total,
                          grade: marksList[i].grades,
                        ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Expanded buildYearSessionDropdown(BuildContext context) {
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
            child: DropdownButton<YearSessionModel>(
              isDense: true,
              value: selectedYearSession!,
              key: UniqueKey(),
              isExpanded: true,
              underline: Container(),
              items: yearSessionDropdown!
                  .map((item) => DropdownMenuItem<YearSessionModel>(
                      child: Text(
                        item.sessionFrom!,
                      ),
                      value: item))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  selectedYearSession = val;
                  sessionId = val!.id;
                  print("selectedYearSession: $val");
                });
                getExamSelected();
              },
            ),
          )
        ],
      ),
    );
  }

  Expanded buildExamDropdown(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          buildLabels('Exam :'),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xffECECEC)),
              // borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButton<ExamSelectedListModel>(
              isDense: true,
              value: selectedExam!,
              key: UniqueKey(),
              isExpanded: true,
              underline: Container(),
              items: examDropdown!
                  .map((item) => DropdownMenuItem<ExamSelectedListModel>(
                      child: Text(item.exam!), value: item))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  selectedExam = val!;
                  print("selectedExam: $val");
                });
                getMarksGraph(val!.examID);
                getExamMarks(val.examID);
              },
            ),
          ),
        ],
      ),
    );
  }

  TableRow buildTableRows(
      {String? subjectName,
      String? maxMarks,
      String? studentMarks,
      String? grade}) {
    return TableRow(
      decoration: BoxDecoration(
          // color: Colors.blue,
          ),
      children: [
        buildTableRowText(
            title: subjectName,
            color: Colors.transparent,
            alignment: Alignment.centerLeft),
        buildTableRowText(
            title: maxMarks,
            color: Colors.blue[50],
            fontWeight: FontWeight.w600,
            alignment: Alignment.center),
        buildTableRowText(
            title: "$studentMarks - $grade",
            color: Colors.green[100],
            fontWeight: FontWeight.w700,
            alignment: Alignment.center),
      ],
    );
  }

  Container buildTableRowText(
          {String? title,
          FontWeight? fontWeight,
          Color? color,
          AlignmentGeometry? alignment}) =>
      Container(
        color: color,
        padding: const EdgeInsets.all(4),
        child: Align(
          alignment: alignment!,
          child: Text(title!,
              // textScaleFactor: 1.5,
              style: TextStyle(fontWeight: fontWeight ?? FontWeight.normal)),
        ),
      );

  Padding buildLabels(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }
}
