import 'package:campus_pro/src/DATA/BLOC_CUBIT/EXAMS_LIST_EXAM_ANALYSIS_CUBIT/exams_list_exam_analysis_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/EXAM_ANALYSIS_CHART_CUBIT/exam_analysis_chart_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/EXAM_ANALYSIS_LINE_CHART_CUBIT/exam_analysis_line_chart_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/YEAR_SESSION_LIST_EXAM_ANALYSIS_CUBIT/year_session_list_exam_analysis_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/examAnalysisChartModel.dart';
import 'package:campus_pro/src/DATA/MODELS/examAnalysisLineChartModel.dart';
import 'package:campus_pro/src/DATA/MODELS/examsListExamAnalysisModel.dart';
import 'package:campus_pro/src/DATA/MODELS/studentInfoModel.dart';
import 'package:campus_pro/src/DATA/MODELS/userTypeModel.dart';
import 'package:campus_pro/src/DATA/MODELS/yearSessionListExamAnalysisModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/WIDGETS/CHARTS/barPieCommonChart.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonSnackbar.dart';
import 'package:campus_pro/src/UI/WIDGETS/drawerWidget.dart';
import 'package:campus_pro/src/UI/WIDGETS/sessionCreator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:flutter/material.dart';

class ExamAnalysisStudent extends StatefulWidget {
  static const routeName = "/exam-analysis-Student";
  const ExamAnalysisStudent({Key? key}) : super(key: key);

  @override
  _ExamAnalysisStudentState createState() => _ExamAnalysisStudentState();
}

class _ExamAnalysisStudentState extends State<ExamAnalysisStudent> {
  // HDTRefreshController _hdtRefreshController = HDTRefreshController();

  // List<CommonListGraph>? subjectChartData = [
  //   CommonListGraph(title: "Exam", color: Colors.red, value: 10.0),
  //   CommonListGraph(title: "Internal Marks", color: Colors.blue, value: 8.0),
  //   CommonListGraph(title: "PT-1", color: Colors.green, value: 10.0),
  //   CommonListGraph(title: "Admin Test", color: Colors.yellow, value: 10.0),
  // ];

  List<CommonListGraph> subjectList = [];

  final List<CommonListGraph> lineChartList = [];

  List<ExamAnalysisChartModel>? examAnalysisChartData = [];

  ExamAnalysisLineChartModel? lineChartData;

  bool showBarChart = false;

  String? uid;

  String? token;

  String? sessionId;

  UserTypeModel? userData;

  StudentInfoModel? stuInfo;

  YearSessionListExamAnalysisModel? selectedYearSession;
  List<YearSessionListExamAnalysisModel>? yearSessionDropdown;

  ExamsListExamAnalysisModel? selectedExam;
  List<ExamsListExamAnalysisModel>? examDropdown;

  @override
  void initState() {
    lineChartData = ExamAnalysisLineChartModel(
        combnames: "", exams: "", marks: "", subjects: "");
    selectedYearSession =
        YearSessionListExamAnalysisModel(id: -1, sessionFrom: "");
    yearSessionDropdown = [];
    selectedExam = ExamsListExamAnalysisModel(examid: -1, exam: "");
    userData = UserTypeModel(
      buttonConfigString: "",
      schoolName: "",
      attStartTime: "",
      attCloseTime: "",
      showFeeReceipt: "",
      editAmount: "",
      incrementMonthId: "",
      currentSessionid: "",
      organizationId: "",
      schoolId: "",
      stuEmpId: "",
      stuEmpName: "",
      ouserType: "",
      headerImgPath: "",
      logoImgPath: "",
      websiteUrl: "",
      bloggerUrl: "",
      busId: "",
      sendOtpToVisitor: "",
      letPayOldFeeMonths: "",
      fillFeeAmount: "",
      testUrl: "",
      isShowMobileNo: "",
      empJoinOnPlatformApp: "",
      stuJoinOnPlatformApp: "",
      baseDomainURL: "",
      appUrl: "",
    );
    examDropdown = [];
    getDataFromCache();
    super.initState();
  }

  getDataFromCache() async {
    uid = await UserUtils.idFromCache();
    token = await UserUtils.userTokenFromCache();
    userData = await UserUtils.userTypeFromCache();
    stuInfo = await UserUtils.stuInfoDataFromCache();
    getSession();
  }

  void getSession() async {
    final yearData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData!.schoolId,
      "StuEmpId": userData!.stuEmpId,
      "UserType": userData!.ouserType,
    };
    print("Sending YearSessionListExamAnalysis data => $yearData");
    context
        .read<YearSessionListExamAnalysisCubit>()
        .yearSessionListExamAnalysisCubitCall(yearData);
  }

  void getExamSelected() async {
    final examData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData!.schoolId,
      "SessionId": sessionId,
      "ClassId": stuInfo!.classId,
      "StuEmpId": userData!.stuEmpId,
      "UserType": userData!.ouserType,
    };
    print("Sending ExamsListExamAnalysis data => $examData");
    context
        .read<ExamsListExamAnalysisCubit>()
        .examListExamAnalysisCubitCall(examData);
  }

  void getAllExamGraph(String? examID) async {
    final examData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData!.schoolId,
      "SessionId": sessionId,
      "ClassId": "",
      "SectionId": "",
      "ExamId": "0",
      "UserType": userData!.ouserType!.toLowerCase(),
      "StuEmpId": userData!.stuEmpId,
      "SubjectId": "",
      "StreamId": "",
      "YearId": "",
    };
    print("Sending ExamAnalysisLineChart data => $examData");
    context
        .read<ExamAnalysisLineChartCubit>()
        .examAnalysisLineChartCubitCall(examData);
  }

  void getSubjectGraph(String? examID) async {
    final examData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData!.schoolId,
      "SessionId": userData!.currentSessionid,
      "ClassId": stuInfo!.classId,
      "SectionId": stuInfo!.classSectionId,
      "ExamId": examID!,
      "UserType": userData!.ouserType!.toLowerCase(),
      "StuEmpId": userData!.stuEmpId,
      "SubjectId": "0",
      "StreamId": stuInfo!.streamId,
      "YearId": stuInfo!.yearId,
    };
    print("Sending ExamAnalysisChart data => $examData");
    context.read<ExamAnalysisChartCubit>().examAnalysisChartCubitCall(examData);
  }

  List<Color> colors = [
    Color(0xff0CECDD).withOpacity(0.2),
    Color(0xffFF2626).withOpacity(0.2),
    Color(0xffFFF338).withOpacity(0.2),
    Color(0xffFF67E7).withOpacity(0.2),
    Color(0xff865439).withOpacity(0.2),
    Color(0xffE63E6D).withOpacity(0.2),
    Color(0xffA03C78).withOpacity(0.2),
    Color(0xff7C83FD).withOpacity(0.2),
    Color(0xffFB7AFC).withOpacity(0.2),
    Color(0xffBF1363).withOpacity(0.2),
    Color(0xffFF96AD).withOpacity(0.2),
    Color(0xffE93B81).withOpacity(0.2),
    Color(0xff1EAE98).withOpacity(0.2),
    Color(0xffE1701A).withOpacity(0.2),
    Color(0xffC67ACE).withOpacity(0.2),
    Color(0xff0CECDD).withOpacity(0.2),
    Color(0xffFF2626).withOpacity(0.2),
    Color(0xffFFF338).withOpacity(0.2),
    Color(0xffFF67E7).withOpacity(0.2),
    Color(0xff865439).withOpacity(0.2),
    Color(0xffE63E6D).withOpacity(0.2),
    Color(0xffA03C78).withOpacity(0.2),
    Color(0xff7C83FD).withOpacity(0.2),
    Color(0xffFB7AFC).withOpacity(0.2),
    Color(0xffBF1363).withOpacity(0.2),
    Color(0xffFF96AD).withOpacity(0.2),
    Color(0xffE93B81).withOpacity(0.2),
    Color(0xff1EAE98).withOpacity(0.2),
    Color(0xffE1701A).withOpacity(0.2),
    Color(0xffC67ACE).withOpacity(0.2),
  ];
  // Random random = new Random();

  setExamAnalysisListData() {
    setState(() {
      int length = examAnalysisChartData![0].marks!.split(",").length;
      print('examAnalysisList length $length');
      for (int i = 0; i < length; i++) {
        subjectList.add(
          CommonListGraph(
            iD: 1,
            title: examAnalysisChartData![0].subjects!.split(",")[i],
            value: double.parse(examAnalysisChartData![0].marks!.split(",")[i]),
            // color: Colors.red[200],
            color: colors[i],
          ),
        );
      }
      print('examAnalysisList Final List => $subjectList');
    });
  }

  setLineChartListData() {
    setState(() {
      final subjects = lineChartData!.subjects!.split(",").toList();
      final marks = lineChartData!.marks!.split(",").toList();
      List<CommonListGraph> subMarks = [];
      for (int i = 0; i < subjects.length; i++) {
        print('first loop : $i');
        for (int j = i; j < marks.length; j++) {
          print('second loop : $j');
          subMarks.add(
            CommonListGraph(
              iD: 1,
              // iD: i,
              title: subjects[i],
              value: double.parse(marks[j]),
              // color: Colors.red[200],
              color: colors[i],
            ),
          );
          j = j + (subjects.length - 1);
        }
        print('lineChartData loop List => $subMarks');
      }
      setState(() => subjectList = subMarks);
      print('lineChartData Final List => $subjectList');
    });
    // setState(() {
    //   int length = lineChartData!.exams!.split(",").length;
    //   List<double> value = [20.0, 10.0, 35.0, 5.0];
    //   print('lineChartData length $length');
    //   for (int i = 0; i < length; i++) {
    //     lineChartList.add(
    //       CommonListGraph(
    //         title: lineChartData!.exams!.split(",")[i],
    //         value: value[i],
    //         // value: double.parse(lineChartData![0].marks!.split(",")[i]),
    //         color: Colors.red[200],
    //         // color: colors[i],
    //       ),
    //     );
    //     print('lineChartData $i');
    //   }
    // });
  }

  _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000)).then((value) {
      if (selectedExam!.examid == 0)
        getAllExamGraph(selectedExam!.examid.toString());
      else
        getSubjectGraph(selectedExam!.examid.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: commonAppBar(context, title: "Exam Analysis"),
      body:
          // RefreshIndicator(
          //   onRefresh: () => _onRefresh(),
          //   child:
          ListView(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      BlocConsumer<YearSessionListExamAnalysisCubit,
                          YearSessionListExamAnalysisState>(
                        listener: (context, state) {
                          if (state is YearSessionListExamAnalysisLoadSuccess) {
                            final session = getCustomYear();
                            Future.delayed(Duration(microseconds: 300));

                            setState(() {
                              yearSessionDropdown = state.yearSessionList;
                              final index = yearSessionDropdown!.indexWhere(
                                  (element) => element.sessionFrom == session);
                              selectedYearSession = yearSessionDropdown![index];
                              sessionId = selectedYearSession!.id.toString();
                              print(
                                  "yearDropdown![index] : ${yearSessionDropdown![index]}");
                            });

                            // setState(() {
                            //   yearSessionDropdown = state.yearSessionList;
                            //   selectedYearSession = state.yearSessionList[0];
                            //   sessionId = state.yearSessionList[0].id.toString();
                            // });

                            getExamSelected();
                            // getRemarksFromApi();
                          }
                          if (state is YearSessionListExamAnalysisLoadFail) {
                            if (state.failReason == "false") {
                              UserUtils.unauthorizedUser(context);
                            } else {
                              setState(() {
                                selectedYearSession =
                                    YearSessionListExamAnalysisModel(
                                  id: -1,
                                  sessionFrom: "",
                                );
                                yearSessionDropdown = [];
                                subjectList = [];
                              });
                            }
                          }
                        },
                        builder: (context, state) {
                          if (state
                              is YearSessionListExamAnalysisLoadInProgress) {
                            return buildYearSessionDropdown(context);
                          } else if (state
                              is YearSessionListExamAnalysisLoadSuccess) {
                            return buildYearSessionDropdown(context);
                          } else if (state
                              is YearSessionListExamAnalysisLoadFail) {
                            return buildYearSessionDropdown(context);
                          } else {
                            return Container();
                          }
                        },
                      ),
                      SizedBox(width: 20),
                      BlocConsumer<ExamsListExamAnalysisCubit,
                          ExamsListExamAnalysisState>(
                        listener: (context, state) {
                          if (state is ExamsListExamAnalysisLoadSuccess) {
                            setState(() {
                              examDropdown = state.examsList;
                              if (examDropdown![0].exam != 'All Exam') {
                                examDropdown!.insert(
                                    0,
                                    ExamsListExamAnalysisModel(
                                        examid: 0, exam: "All Exam"));
                              }
                              selectedExam = state.examsList[0];
                            });
                            // getAllExamGraph(
                            //     state.examsList[0].examid.toString());
                            // getSubjectGraph(
                            //     state.examsList[0].examid.toString());
                            if (selectedExam!.examid == 0) {
                              getAllExamGraph(
                                  state.examsList[0].examid.toString());
                            } else {
                              getSubjectGraph(
                                  state.examsList[0].examid.toString());
                            }
                          }
                          if (state is ExamsListExamAnalysisLoadFail) {
                            if (state.failReason == "false") {
                              UserUtils.unauthorizedUser(context);
                            } else {
                              setState(() {
                                selectedExam = ExamsListExamAnalysisModel(
                                    examid: -1, exam: "");
                                examDropdown = [];
                                subjectList = [];
                              });
                              getAllExamGraph('-1');
                              // getSubjectGraph('-1');
                              // if (selectedExam!.examid == 0) {
                              //   getAllExamGraph('-1');
                              // } else {
                              //   getSubjectGraph('-1');
                              // }
                            }
                          }
                        },
                        builder: (context, state) {
                          if (state is ExamsListExamAnalysisLoadInProgress) {
                            return buildExamDropdown(context);
                          } else if (state
                              is ExamsListExamAnalysisLoadSuccess) {
                            return buildExamDropdown(context);
                          } else if (state is ExamsListExamAnalysisLoadFail) {
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
                BlocConsumer<ExamAnalysisChartCubit, ExamAnalysisChartState>(
                  listener: (context, state) {
                    if (state is ExamAnalysisChartLoadFail) {
                      if (state.failReason == "false") {
                        UserUtils.unauthorizedUser(context);
                      } else {
                        setState(() {
                          examAnalysisChartData = [];
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                            commonSnackBar(title: "No Record Found"));
                      }
                    }
                    if (state is ExamAnalysisChartLoadSuccess) {
                      setState(() {
                        // final chartData = state.examAnalysisData[0];
                        examAnalysisChartData = state.examAnalysisData;
                      });
                      setExamAnalysisListData();
                    }
                  },
                  builder: (context, state) {
                    if (state is ExamAnalysisChartLoadInProgress) {
                      return Container();
                    } else if (state is ExamAnalysisChartLoadSuccess) {
                      return showBarChart
                          ? BarPieCommonChart(
                              subjectName: "",
                              chartType: 'bar chart',
                              // color: Colors.red[200],
                              // graphTitle: 'Last 7 Days Enquiry',
                              commonDataList: subjectList,
                            )
                          : Container();
                      // return Container();
                    } else if (state is ExamAnalysisChartLoadFail) {
                      return Container();
                    } else {
                      return Container();
                    }
                  },
                ),
                SizedBox(height: 10),
                BlocConsumer<ExamAnalysisLineChartCubit,
                    ExamAnalysisLineChartState>(
                  listener: (context, state) {
                    if (state is ExamAnalysisLineChartLoadFail) {
                      if (state.failReason == "false") {
                        UserUtils.unauthorizedUser(context);
                      } else {
                        setState(() {
                          lineChartData = ExamAnalysisLineChartModel(
                              combnames: "",
                              exams: "",
                              marks: "",
                              subjects: "");
                        });
                      }
                    }
                    if (state is ExamAnalysisLineChartLoadSuccess) {
                      setState(() {
                        // final chartData = state.examAnalysisData[0];
                        lineChartData = state.examAnalysisData;
                      });
                      setLineChartListData();
                    }
                  },
                  builder: (context, state) {
                    if (state is ExamAnalysisLineChartLoadInProgress) {
                      return Container();
                    } else if (state is ExamAnalysisLineChartLoadSuccess) {
                      return !showBarChart
                          ? Column(
                              children: [
                                BarPieCommonChart(
                                  subjectName: lineChartData!.subjects,
                                  chartType: 'line chart',
                                  // color: Colors.red[200],
                                  // graphTitle: 'Last 7 Days Enquiry',
                                  commonDataList: subjectList,
                                ),
                                SizedBox(height: 10),
                                Divider(color: Color(0xffECECEC), thickness: 6),
                                // buildLineChartTable(context),
                              ],
                            )
                          : Container();
                    } else if (state is ExamAnalysisLineChartLoadFail) {
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
      // ),
    );
  }

  // Widget buildLineChartTable(BuildContext context) {
  //   final subjects = lineChartData!.subjects!.split(",").toList();
  //   final exams = lineChartData!.exams!.split(",").toList();
  //   return Container(
  //     child: HorizontalDataTable(
  //       leftHandSideColumnWidth: (MediaQuery.of(context).size.width / 2.5),
  //       rightHandSideColumnWidth:
  //           (MediaQuery.of(context).size.width / 2.5) * exams.length,
  //       isFixedHeader: true,
  //       headerWidgets: _getTitleWidget(exams),
  //       leftSideItemBuilder: (BuildContext context, int i) =>
  //           _generateFirstColumnRow(subjects, i),
  //       rightSideItemBuilder: (BuildContext context, int i) =>
  //           _generateRightHandSideColumnRow(subjects, i),
  //       itemCount: subjects.length,
  //       // itemCount: user.userInfo.length,
  //       rowSeparatorWidget: const Divider(
  //         color: Colors.white,
  //         height: 1.0,
  //         thickness: 0.0,
  //       ),
  //       leftHandSideColBackgroundColor: Color(0xFFFFFFFF),
  //       rightHandSideColBackgroundColor: Color(0xFFFFFFFF),
  //       verticalScrollbarStyle: const ScrollbarStyle(
  //         thumbColor: Colors.yellow,
  //         isAlwaysShown: true,
  //         thickness: 4.0,
  //         radius: Radius.circular(5.0),
  //       ),
  //       horizontalScrollbarStyle: const ScrollbarStyle(
  //         thumbColor: Colors.red,
  //         isAlwaysShown: true,
  //         thickness: 4.0,
  //         radius: Radius.circular(5.0),
  //       ),
  //       enablePullToRefresh: false,
  //       // refreshIndicator: const WaterDropHeader(),
  //       refreshIndicatorHeight: 60,
  //       onRefresh: () async {
  //         //Do sth
  //         // await Future.delayed(const Duration(milliseconds: 500));
  //         // _hdtRefreshController.refreshCompleted();
  //       },
  //       // htdRefreshController: _hdtRefreshController,
  //     ),
  //     height: MediaQuery.of(context).size.height,
  //   );
  // }

  Widget _generateFirstColumnRow(List<String>? subjects, int index) {
    return Container(
      child: Text(subjects![index]),
      width: (MediaQuery.of(context).size.width / 2),
      // height: 52,
      color: colors[index],
      padding: EdgeInsets.fromLTRB(5, 8, 0, 8),
      alignment: Alignment.centerLeft,
    );
  }

  Widget _generateRightHandSideColumnRow(List<String>? subjects, int index) {
    final marksList = subjectList
        .where((element) => element.title == subjects![index])
        .toList();
    return Row(
      children: [
        for (var i = 0; i < marksList.length; i++)
          Container(
            child: Text("${marksList[i].value!.toInt()}"),
            width: (MediaQuery.of(context).size.width / 2.5),
            color: colors[index],
            padding: EdgeInsets.fromLTRB(5, 8, 0, 8),
            alignment: Alignment.centerLeft,
          ),
      ],
    );
  }

  // return Row(
  //   children: <Widget>[
  //     // for (int i = 0; i < subjects!.length; ++i)
  //     //   buildRows(
  //     //     subjectName: subjects[i],
  //     //     marksList: subjectList
  //     //         .where((element) => element.title == subjects[i])
  //     //         .toList(),
  //     //     color: colors[i],
  //     //   ),
  //     // for (int i = 0; i < subjects!.length; ++i)
  //     // subjectList
  //     //         .where((element) => element.title == subjects[i])
  //     //         .toList();

  //     //   for (var i = 0; i < !.length; i++)
  //     // Container(
  //     //   child: Text("marksList[i].value!"),
  //     //   width: 200,
  //     //   height: 52,
  //     //   color: colors[index],
  //     //   padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
  //     //   alignment: Alignment.centerLeft,
  //     // ),

  //     //   for (var i = 0; i < marksList!.length; i++)
  //     // buildTableRowText(
  //     //     title: marksList[i].value!.toInt().toString(),
  //     //     color: color ?? Colors.transparent,
  //     //     fontWeight: FontWeight.w600,
  //     //     alignment: Alignment.center),

  //     // buildTableRows(
  //     //             subjectName: subjects[i],
  //     //             marksList: subjectList
  //     //                 .where((element) => element.title == subjects[i])
  //     //                 .toList(),
  //     //             color: colors[i],
  //     //           ),

  //     Container(
  //       child: Text("registerDate"),
  //       width: 200,
  //       height: 52,
  //       padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
  //       alignment: Alignment.centerLeft,
  //     ),
  //     // Container(
  //     //   child: Text("terminationDate"),
  //     //   width: 200,
  //     //   height: 52,
  //     //   padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
  //     //   alignment: Alignment.centerLeft,
  //     // ),
  //   ],
  // );
  // }

  List<Widget> _getTitleWidget(List<String>? exams) {
    return [
      _getTitleItemWidget(
          'Subjects', (MediaQuery.of(context).size.width / 2.5)),
      for (var i = 0; i < exams!.length; i++)
        _getTitleItemWidget(
          exams[i].contains(" ")
              ? "$i (${exams[i].replaceAll(' ', '\n')})"
              : "$i (${exams[i]})",
          (MediaQuery.of(context).size.width / 2.5),
        ),
    ];
  }

  Widget _getTitleItemWidget(String label, double width) {
    return Container(
      child: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
      width: width,
      height: 56,
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
    );
  }

  // Widget buildLineChartTable(BuildContext context) {
  //   final subjects = lineChartData!.subjects!.split(",").toList();
  //   final exams = lineChartData!.exams!.split(",").toList();
  //   return Container(
  //     child: Column(
  //       children: [
  //         // Padding(
  //         //   padding: const EdgeInsets.all(8.0),
  //         //   child: Table(
  //         //     columnWidths: {
  //         //       0: FlexColumnWidth(MediaQuery.of(context).size.width / 2),
  //         //       for (int i = 1; i <= exams.length; ++i)
  //         //         i: FlexColumnWidth(
  //         //             (MediaQuery.of(context).size.width / 2) - 100),
  //         //       // 2: FlexColumnWidth((MediaQuery.of(context).size.width / 2) / 2),
  //         //     },
  //         //     // textDirection: TextDirection.rtl,
  //         //     // defaultVerticalAlignment: TableCellVerticalAlignment.top,
  //         //     // border: TableBorder.all(width: 2.0, color: Colors.red),
  //         //     children: [
  //         //       TableRow(
  //         //         decoration: BoxDecoration(
  //         //             // color: Colors.blue,
  //         //             ),
  //         //         children: [
  //         //           Container(
  //         //             padding: const EdgeInsets.all(4),
  //         //             child: Align(
  //         //               alignment: Alignment.centerLeft,
  //         //               child: Text("Subjects",
  //         //                   // textScaleFactor: 1.5,
  //         //                   style: TextStyle(fontWeight: FontWeight.bold)),
  //         //             ),
  //         //           ),
  //         //           for (var i = 0; i < exams.length; i++)
  //         //             Container(
  //         //               padding: const EdgeInsets.all(4),
  //         //               child: Align(
  //         //                 alignment: Alignment.center,
  //         //                 child: Text("$i (${exams[i]})",
  //         //                     // textScaleFactor: 1.5,
  //         //                     style: TextStyle(fontWeight: FontWeight.bold)),
  //         //               ),
  //         //             ),
  //         //         ],
  //         //       ),
  //         //       // buildTableRows(
  //         //       //   subjectName: "Subjects",
  //         //       //   marksList: [],
  //         //       // ),
  //         //     ],
  //         //   ),
  //         // ),
  //         Container(
  //           padding: const EdgeInsets.all(8.0),
  //           child: Table(
  //             columnWidths: {
  //               0: FlexColumnWidth(MediaQuery.of(context).size.width / 2),
  //               for (int i = 1; i <= exams.length; ++i)
  //                 i: FlexColumnWidth(
  //                     (MediaQuery.of(context).size.width / 2) - 100),
  //               // 2: FlexColumnWidth((MediaQuery.of(context).size.width / 2) / 2),
  //             },
  //             // textDirection: TextDirection.rtl,
  //             // defaultVerticalAlignment: TableCellVerticalAlignment.top,
  //             // border: TableBorder.all(width: 2.0, color: Colors.red),
  //             children: [
  //               for (int i = 0; i < subjects.length; ++i)
  //                 buildTableRows(
  //                   subjectName: subjects[i],
  //                   marksList: subjectList
  //                       .where((element) => element.title == subjects[i])
  //                       .toList(),
  //                   color: colors[i],
  //                 ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

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
            child: DropdownButton<YearSessionListExamAnalysisModel>(
              isDense: true,
              value: selectedYearSession!,
              key: UniqueKey(),
              isExpanded: true,
              underline: Container(),
              items: yearSessionDropdown!
                  .map((item) =>
                      DropdownMenuItem<YearSessionListExamAnalysisModel>(
                          child: Text(
                            item.sessionFrom!,
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          value: item))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  selectedYearSession = val;
                  sessionId = val!.id.toString();
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
            ),
            child: DropdownButton<ExamsListExamAnalysisModel>(
              isDense: true,
              value: selectedExam!,
              key: UniqueKey(),
              isExpanded: true,
              underline: Container(),
              items: examDropdown!
                  .map((item) => DropdownMenuItem<ExamsListExamAnalysisModel>(
                      child: Text(
                        item.exam!,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      value: item))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  selectedExam = val!;
                  print("selectedExam = ID:${val.examid}, Exam:${val.exam}");
                  if (selectedExam!.examid == 0)
                    showBarChart = false;
                  else
                    showBarChart = true;
                });
                // getAllExamGraph(selectedExam!.examid.toString());
                // getSubjectGraph(selectedExam!.examid.toString());
                if (selectedExam!.examid == 0)
                  getAllExamGraph(selectedExam!.examid.toString());
                else
                  getSubjectGraph(selectedExam!.examid.toString());
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRows(
      {String? subjectName, List<CommonListGraph>? marksList, Color? color}) {
    return Row(
      children: [
        for (var i = 0; i < marksList!.length; i++)
          buildTableRowText(
              title: marksList[i].value!.toInt().toString(),
              color: color ?? Colors.transparent,
              fontWeight: FontWeight.w600,
              alignment: Alignment.center),
      ],
    );
  }
  // TableRow buildTableRows(
  //     {String? subjectName, List<CommonListGraph>? marksList, Color? color}) {
  //   return TableRow(
  //     decoration: BoxDecoration(
  //         // color: Colors.blue,
  //         ),
  //     children: [
  //       buildTableRowText(
  //           title: subjectName,
  //           color: color ?? Colors.transparent,
  //           fontWeight: FontWeight.w600,
  //           alignment: Alignment.centerLeft),
  //       // ListView.builder(
  //       //   shrinkWrap: true,
  //       //   itemCount: marksList!.length,
  //       //   scrollDirection: Axis.horizontal,
  //       //   itemBuilder: (context, i) {
  //       //     return buildTableRowText(
  //       //         title: marksList[i].value!.toInt().toString(),
  //       //         color: color ?? Colors.transparent,
  //       //         fontWeight: FontWeight.w600,
  //       //         alignment: Alignment.center);
  //       //   },
  //       // ),
  //       // SingleChildScrollView(
  //       //   scrollDirection: Axis.horizontal,
  //       //   child: Row(
  //       //     // crossAxisAlignment: CrossAxisAlignment.start,
  //       //     children: [
  //       //       for (var i = 0; i < marksList!.length; i++)
  //       //         buildTableRowText(
  //       //             title: marksList[i].value!.toInt().toString(),
  //       //             color: color ?? Colors.transparent,
  //       //             fontWeight: FontWeight.w600,
  //       //             alignment: Alignment.center),
  //       //     ],
  //       //   ),
  //       // ),
  //       for (var i = 0; i < marksList!.length; i++)
  //         buildTableRowText(
  //             title: marksList[i].value!.toInt().toString(),
  //             color: color ?? Colors.transparent,
  //             fontWeight: FontWeight.w600,
  //             alignment: Alignment.center),
  //     ],
  //   );
  // }

  Container buildTableRowText(
          {String? title,
          FontWeight? fontWeight,
          Color? color,
          AlignmentGeometry? alignment}) =>
      Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: color,
          border: Border(
            right: BorderSide(width: 1.0, color: Colors.white),
            bottom: BorderSide(width: 1.0, color: Colors.white),
          ),
        ),
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
      child: Text(label,
          // style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}
