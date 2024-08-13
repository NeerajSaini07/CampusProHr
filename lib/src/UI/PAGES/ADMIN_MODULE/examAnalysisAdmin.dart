import 'package:campus_pro/src/DATA/BLOC_CUBIT/EXAMS_LIST_EXAM_ANALYSIS_CUBIT/exams_list_exam_analysis_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/EXAM_ANALYSIS_CHART_ADMIN_CUBIT/exam_analysis_chart_admin_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/RESULT_ANNOUNCE_CLASS_CUBIT/result_announce_class_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/SECTION_LIST_ATTENDANCE_ADMIN_CUBIT/section_list_attendance_admin_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/SUBJECT_LIST_EXAM_ANALYSIS_CUBIT/subject_list_exam_analysis_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/YEAR_SESSION_CUBIT/year_session_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/examAnalysisChartAdminModel.dart';
import 'package:campus_pro/src/DATA/MODELS/examsListExamAnalysisModel.dart';
import 'package:campus_pro/src/DATA/MODELS/resultAnnounceClassModel.dart';
import 'package:campus_pro/src/DATA/MODELS/sectionListAttendanceAdminModel.dart';
import 'package:campus_pro/src/DATA/MODELS/subjectListExamAnalysisModel.dart';
import 'package:campus_pro/src/DATA/MODELS/userTypeModel.dart';
import 'package:campus_pro/src/DATA/MODELS/yearSessionModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/WIDGETS/CHARTS/barPieCommonChart.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/drawerWidget.dart';
import 'package:campus_pro/src/UI/WIDGETS/sessionCreator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ExamAnalysisAdmin extends StatefulWidget {
  static const routeName = "/exam-analysis-admin";
  const ExamAnalysisAdmin({Key? key}) : super(key: key);

  @override
  _ExamAnalysisAdminState createState() => _ExamAnalysisAdminState();
}

class _ExamAnalysisAdminState extends State<ExamAnalysisAdmin> {
  List<CommonListGraph> subjectList = [];

  List<ExamAnalysisChartAdminModel> examAnalysisChartAdminData = [];

  String? uid = "";
  String? token = "";
  UserTypeModel? userData;

  YearSessionModel? selectedSession;
  List<YearSessionModel>? sessionDropdown = [];

  ResultAnnounceClassModel? selectedClass;
  List<ResultAnnounceClassModel>? classDropdown = [];

  SectionListAttendanceAdminModel? selectedSection;
  List<SectionListAttendanceAdminModel>? sectionDropdown = [];

  ExamsListExamAnalysisModel? selectedExam;
  List<ExamsListExamAnalysisModel>? examDropdown = [];

  SubjectListExamAnalysisModel? selectedSubject;
  List<SubjectListExamAnalysisModel>? subjectDropdown = [];

  @override
  void initState() {
    getDataFromCache();
    super.initState();
  }

  getDataFromCache() async {
    uid = await UserUtils.idFromCache();
    token = await UserUtils.userTokenFromCache();
    userData = await UserUtils.userTypeFromCache();
    getSession();
  }

  getSession() async {
    final sendingSessionData = {
      "OUserId": uid,
      "Token": token,
      "EmpId": userData!.stuEmpId,
      "OrgID": userData!.organizationId,
      "SchoolID": userData!.schoolId,
      "UserType": userData!.ouserType,
    };
    print('Sending YearSession data $sendingSessionData');
    context.read<YearSessionCubit>().yearSessionCubitCall(sendingSessionData);
  }

  getClassList() async {
    final sendingClassData = {
      "OUserId": uid,
      "Token": token,
      "EmpID": userData!.stuEmpId,
      "OrgId": userData!.organizationId,
      "Schoolid": userData!.schoolId,
      "usertype": userData!.ouserType,
      "classonly": "1",
      "classteacher": "0",
      "SessionId": selectedSession!.id,
    };
    context
        .read<ResultAnnounceClassCubit>()
        .resultAnnounceClassCubitCall(sendingClassData);
  }

  getEmployeeSectionAdmin() async {
    final getEmpSectionData = {
      "OUserId": uid!,
      "Token": token!,
      "OrgId": userData!.organizationId,
      "Schoolid": userData!.schoolId,
      "ClassId": selectedClass!.id,
      "UserType": userData!.ouserType,
      "EmpStuId": userData!.stuEmpId,
    };

    print('Sending SectionListAttendanceAdmin Data => $getEmpSectionData');
    context
        .read<SectionListAttendanceAdminCubit>()
        .sectionListAttendanceAdminCubitCall(getEmpSectionData);
  }

  getExamSelected() async {
    final examData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData!.schoolId,
      "SessionId": selectedSession!.id,
      "ClassId": selectedClass!.id,
      "StuEmpId": userData!.stuEmpId,
      "UserType": userData!.ouserType,
    };
    print("Sending ExamsListExamAnalysis data => $examData");
    context
        .read<ExamsListExamAnalysisCubit>()
        .examListExamAnalysisCubitCall(examData);
  }

  getSubjectList() async {
    final subjectData = {
      'OUserId': uid,
      'Token': token,
      'OrgId': userData!.organizationId,
      'SchoolId': userData!.schoolId,
      // 'SessionId': userData!.currentSessionid,
      'EmpId': userData!.stuEmpId,
      'UserType': userData!.ouserType,
      'SessionId': selectedSession!.id,
      'ClassId': selectedClass!.id,
    };
    print("Sending SubjectListExamAnalysis data => $subjectData");
    context
        .read<SubjectListExamAnalysisCubit>()
        .subjectListExamAnalysisCubitCall(subjectData);
  }

  getChartData() async {
    final chartData = {
      'OUserId': uid,
      'Token': token,
      'OrgId': userData!.organizationId,
      'Schoolid': userData!.schoolId,
      'SessionId': selectedSession!.id,
      'ClassId': selectedClass!.id,
      // 'SectionId': "0",
      'SectionId': selectedSection!.id,
      // 'ExamId': "167",
      'ExamId': selectedExam == null ? "" : selectedExam!.examid.toString(),
      'UserType': userData!.ouserType,
      'StuEmpId': userData!.stuEmpId,
      // 'SubjectId': "0",
      'SubjectId': selectedSubject!.id.toString(),
    };
    print("Sending SubjectListExamAnalysis data => $chartData");
    context
        .read<ExamAnalysisChartAdminCubit>()
        .examAnalysisChartAdminCubitCall(chartData);
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
    //
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
    //
    //
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
    //
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

  setExamAnalysisListDataAdmin() {
    setState(() {
      int length = examAnalysisChartAdminData[0].combnames!.split(",").length;
      print(examAnalysisChartAdminData);
      print('examAnalysisListAdmin length $length');
      print(colors.length);
      examAnalysisChartAdminData.forEach((element) {
        print(element.between75to100);
      });
      for (int i = 0; i < length; i++)
        subjectList.add(
          CommonListGraph(
            iD: 0,
            title: examAnalysisChartAdminData[0].combnames!.split(",")[i],
            value: double.parse(
                examAnalysisChartAdminData[0].between75to100!.split(",")[i]),
            // color: Colors.red[200],
            color: colors[i],
          ),
        );
      for (int i = 0; i < length; i++)
        subjectList.add(
          CommonListGraph(
            iD: 1,
            title: examAnalysisChartAdminData[0].combnames!.split(",")[i],
            value: double.parse(
                examAnalysisChartAdminData[0].between50to75!.split(",")[i]),
            // color: Colors.red[200],
            color: colors[i],
          ),
        );
      for (int i = 0; i < length; i++)
        subjectList.add(
          CommonListGraph(
            iD: 2,
            title: examAnalysisChartAdminData[0].combnames!.split(",")[i],
            value: double.parse(
                examAnalysisChartAdminData[0].between25to50!.split(",")[i]),
            // color: Colors.red[200],
            color: colors[i],
          ),
        );
      for (int i = 0; i < length; i++)
        subjectList.add(
          CommonListGraph(
            iD: 3,
            title: examAnalysisChartAdminData[0].combnames!.split(",")[i],
            value: double.parse(
                examAnalysisChartAdminData[0].below25!.split(",")[i]),
            // color: Colors.red[200],
            color: colors[i],
          ),
        );
      print('examAnalysisListAdmin Final List => $subjectList');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: commonAppBar(context, title: "Exam Analysis"),
      // bottomNavigationBar: buildTopBar(),
      body: MultiBlocListener(
        listeners: [
          BlocListener<YearSessionCubit, YearSessionState>(
            listener: (context, state) {
              if (state is YearSessionLoadSuccess) {
                final session = getCustomYear();
                Future.delayed(Duration(microseconds: 300));
                setState(() {
                  sessionDropdown = state.yearSessionList;
                  final index = sessionDropdown!
                      .indexWhere((element) => element.sessionFrom == session);
                  selectedSession = sessionDropdown![index];
                  print("yearDropdown![index] : ${sessionDropdown![index]}");
                });

                getClassList();
              }
              if (state is YearSessionLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                } else {
                  setState(() {
                    sessionDropdown = [];
                    selectedSession = null;
                  });
                }
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
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                } else {
                  setState(() {
                    classDropdown = [];
                    selectedClass = null;
                  });
                }
              }
            },
          ),
          BlocListener<SectionListAttendanceAdminCubit,
              SectionListAttendanceAdminState>(
            listener: (context, state) {
              if (state is SectionListAttendanceAdminLoadSuccess) {
                setState(() {
                  sectionDropdown = state.sectionList;
                  if (sectionDropdown![0].classSection != 'Select') {
                    sectionDropdown!.insert(
                        0,
                        SectionListAttendanceAdminModel(
                            id: "0", classSection: "Select"));
                  }
                  selectedSection = sectionDropdown!.first;
                });
              }
              if (state is SectionListAttendanceAdminLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                } else {
                  setState(() {
                    sectionDropdown = [];
                    selectedSection = null;
                  });
                }
              }
            },
          ),
          BlocListener<ExamsListExamAnalysisCubit, ExamsListExamAnalysisState>(
            listener: (context, state) {
              if (state is ExamsListExamAnalysisLoadSuccess) {
                setState(() {
                  examDropdown = state.examsList;
                  if (examDropdown![0].exam != 'Select') {
                    examDropdown!.insert(0,
                        ExamsListExamAnalysisModel(examid: 0, exam: "Select"));
                  }
                  selectedExam = examDropdown!.first;
                });
              }
              if (state is ExamsListExamAnalysisLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                } else {
                  setState(() {
                    examDropdown = [];
                    selectedExam = null;
                  });
                }
              }
            },
          ),
          BlocListener<SubjectListExamAnalysisCubit,
              SubjectListExamAnalysisState>(
            listener: (context, state) {
              if (state is SubjectListExamAnalysisLoadSuccess) {
                setState(() {
                  subjectDropdown = state.subjectList;
                  if (subjectDropdown![0].subjecthead != 'Select') {
                    subjectDropdown!.insert(
                        0,
                        SubjectListExamAnalysisModel(
                            id: 0, subjecthead: "Select"));
                  }
                  selectedSubject = subjectDropdown!.first;
                });
              }
              if (state is SubjectListExamAnalysisLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                } else {
                  setState(() {
                    subjectDropdown = [];
                    selectedSubject = null;
                  });
                }
              }
            },
          ),
          BlocListener<ExamAnalysisChartAdminCubit,
              ExamAnalysisChartAdminState>(
            listener: (context, state) {
              if (state is ExamAnalysisChartAdminLoadInProgress) {
                setState(() {
                  examAnalysisChartAdminData = [];
                  subjectList = [];
                  examAnalysisChartAdminData = [];
                });
                //setExamAnalysisListDataAdmin();
              }
              if (state is ExamAnalysisChartAdminLoadSuccess) {
                setState(() {
                  examAnalysisChartAdminData = [];
                  subjectList = [];
                  examAnalysisChartAdminData = state.chartData;
                });
                setExamAnalysisListDataAdmin();
              }
              if (state is ExamAnalysisChartAdminLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                } else {
                  setState(() {
                    examAnalysisChartAdminData = [];
                    subjectList = [];
                  });
                }
              }
            },
          ),
        ],
        child: Column(
          children: [
            Divider(color: Color(0xffECECEC), thickness: 2, height: 0),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  buildSessionDropdown(),
                  buildClassDropdown(),
                  buildSectionDropdown(),
                ],
              ),
            ),
            Divider(color: Color(0xffECECEC), thickness: 2, height: 0),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  buildExamDropdown(),
                  buildSubjectDropdown(),
                ],
              ),
            ),
            Divider(color: Color(0xffECECEC), thickness: 2, height: 0),
            buildTopBar(),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Column(
            //       children: [
            //         Container(
            //             margin: EdgeInsets.symmetric(horizontal: 5),
            //             child: Text(
            //               'Tap on left bar to move \n left.',
            //               style: TextStyle(
            //                   fontWeight: FontWeight.w600, fontSize: 15),
            //             )),
            //         Icon(
            //           Icons.arrow_left,
            //           color: Colors.red,
            //           size: 30,
            //         ),
            //       ],
            //     ),
            //     Column(
            //       children: [
            //         Container(
            //             margin: EdgeInsets.symmetric(horizontal: 5),
            //             child: Text(
            //               'Tap to right bar to move \n right.',
            //               style: TextStyle(
            //                   fontWeight: FontWeight.w600, fontSize: 15),
            //             )),
            //         Icon(
            //           Icons.arrow_right,
            //           color: Colors.red,
            //           size: 30,
            //         )
            //       ],
            //     ),
            //   ],
            // ),
            // Container(
            //   child: Column(
            //     children: [
            //       Row(
            //         children: [
            //           buildIndicator(
            //               title: "< 33 %", color: Colors.blue.withOpacity(0.5)),
            //           buildIndicator(
            //               title: "33 - 50 %",
            //               color: Colors.green.withOpacity(0.5)),
            //         ],
            //       ),
            //       Row(
            //         children: [
            //           buildIndicator(
            //               title: "50 - 75 %",
            //               color: Colors.orange.withOpacity(0.5)),
            //           buildIndicator(
            //               title: "75 -100 %",
            //               color: Colors.red.withOpacity(0.5)),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
            // BarPieCommonChart(
            //   height: MediaQuery.of(context).size.height / 2,
            //   subjectName: "",
            //   chartType: 'stacked bar chart',
            //   // color: Colors.red[200],
            //   // graphTitle: 'Last 7 Days Enquiry',
            //   commonDataList: subjectList,
            // ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocBuilder<ExamAnalysisChartAdminCubit,
                        ExamAnalysisChartAdminState>(
                      builder: (context, state) {
                        if (state is ExamAnalysisChartAdminLoadInProgress) {
                          return Text(
                            "Loading...",
                            textScaleFactor: 1.5,
                          );
                        } else if (state is ExamAnalysisChartAdminLoadSuccess) {
                          return Container(
                            // width: subjectList.length > 1
                            //     ? subjectList.length * 20
                            //     : MediaQuery.of(context).size.width,
                            child: BarPieCommonChart(
                              height: MediaQuery.of(context).size.height / 1.6,
                              // width: MediaQuery.of(context).size.width,
                              subjectName: "",
                              chartType: 'stacked bar chart',
                              // color: Colors.red[200],
                              // graphTitle: 'Last 7 Days Enquiry',
                              commonDataList: subjectList,
                            ),
                          );
                          // return Container();
                        } else if (state is ExamAnalysisChartAdminLoadFail) {
                          return Container();
                        } else {
                          return Container();
                        }
                      },
                    ),
                    // Container(
                    //   margin: const EdgeInsets.all(20.0),
                    //   child: Column(
                    //     children: [
                    //       buildIndicator(
                    //           title: "< 33 %",
                    //           color: Colors.blue.withOpacity(0.5)),
                    //       buildIndicator(
                    //           title: "33 - 50 %",
                    //           color: Colors.green.withOpacity(0.5)),
                    //       buildIndicator(
                    //           title: "50 - 75 %",
                    //           color: Colors.orange.withOpacity(0.5)),
                    //       buildIndicator(
                    //           title: "75 -100 %",
                    //           color: Colors.red.withOpacity(0.5)),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Container buildTopBar() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              buildIndicator(
                  title: "< 33 %", color: Colors.red.withOpacity(0.5)),
              buildIndicator(
                  title: "33 - 50 %", color: Colors.orange.withOpacity(0.5)),
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            children: [
              buildIndicator(
                  title: "50 - 75 %", color: Colors.green.withOpacity(0.5)),
              buildIndicator(
                  title: "75 -100 %", color: Colors.blue.withOpacity(0.5)),
            ],
          ),
        ],
      ),
    );
  }

  Container buildIndicator({String? title, Color? color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      width: MediaQuery.of(context).size.width / 2,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 20.0,
            width: 20.0,
            margin: const EdgeInsets.only(right: 10.0),
            color: color,
          ),
          Text(
            title!,
            textScaleFactor: 1.2,
            style: GoogleFonts.quicksand(
              fontWeight: FontWeight.bold,
              // color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Flexible buildSessionDropdown() {
    return Flexible(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            buildLabels("Session"),
            Container(
              child: DropdownButton<YearSessionModel>(
                isDense: true,
                value: selectedSession,
                key: UniqueKey(),
                isExpanded: true,
                underline: Container(),
                items: sessionDropdown!
                    .map((item) => DropdownMenuItem<YearSessionModel>(
                        child: Text(item.sessionFrom!,
                            style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold)),
                        value: item))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    examAnalysisChartAdminData = [];
                    selectedClass = null;
                    classDropdown = [];
                    selectedSection = null;
                    sectionDropdown = [];
                    selectedExam = null;
                    examDropdown = [];
                    selectedSubject = null;
                    selectedSession = val;
                  });
                  getClassList();
                },
              ),
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Flexible buildClassDropdown() {
    return Flexible(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(width: 2, color: Color(0xffECECEC)),
            right: BorderSide(width: 2, color: Color(0xffECECEC)),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            buildLabels("Class"),
            Container(
              child: DropdownButton<ResultAnnounceClassModel>(
                hint: Text("Select",
                    style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold)),
                isDense: true,
                value: selectedClass,
                key: UniqueKey(),
                isExpanded: true,
                underline: Container(),
                items: classDropdown!
                    .map((item) => DropdownMenuItem<ResultAnnounceClassModel>(
                        child: Text(item.className!,
                            style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold)),
                        value: item))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    examAnalysisChartAdminData = [];
                    selectedSection = null;
                    sectionDropdown = [];
                    selectedExam = null;
                    examDropdown = [];
                    selectedSubject = null;
                    selectedClass = val;
                  });
                  getEmployeeSectionAdmin();
                  getExamSelected();
                  getSubjectList();
                  Future.delayed(Duration(seconds: 3))
                      .then((value) => getChartData());
                },
              ),
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Flexible buildSectionDropdown() {
    return Flexible(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            buildLabels("Section"),
            Container(
              child: DropdownButton<SectionListAttendanceAdminModel>(
                hint: Text("Select",
                    style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold)),
                isDense: true,
                value: selectedSection,
                key: UniqueKey(),
                isExpanded: true,
                underline: Container(),
                items: sectionDropdown!
                    .map((item) =>
                        DropdownMenuItem<SectionListAttendanceAdminModel>(
                            child: Text(item.classSection!,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold)),
                            value: item))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    examAnalysisChartAdminData = [];
                    selectedSection = val;
                  });
                  getChartData();
                },
              ),
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Flexible buildExamDropdown() {
    return Flexible(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            buildLabels("Exam"),
            Container(
              child: DropdownButton<ExamsListExamAnalysisModel>(
                hint: Text("Select",
                    style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold)),
                isDense: true,
                value: selectedExam,
                key: UniqueKey(),
                isExpanded: true,
                underline: Container(),
                items: examDropdown!
                    .map((item) => DropdownMenuItem<ExamsListExamAnalysisModel>(
                        child: Text(item.exam!,
                            style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold)),
                        value: item))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    examAnalysisChartAdminData = [];
                    selectedExam = val;
                  });
                  getChartData();
                },
              ),
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Flexible buildSubjectDropdown() {
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
            buildLabels("Subject"),
            Container(
              child: DropdownButton<SubjectListExamAnalysisModel>(
                hint: Text("Select",
                    style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold)),
                isDense: true,
                value: selectedSubject,
                key: UniqueKey(),
                isExpanded: true,
                underline: Container(),
                items: subjectDropdown!
                    .map((item) =>
                        DropdownMenuItem<SubjectListExamAnalysisModel>(
                            child: Text(item.subjecthead!,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold)),
                            value: item))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    examAnalysisChartAdminData = [];
                    selectedSubject = val;
                  });
                  getChartData();
                },
              ),
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Padding buildLabels(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        label,
        style: TextStyle(
          // color: Theme.of(context).primaryColor,
          color: Color(0xff313131),
        ),
      ),
    );
  }
}
