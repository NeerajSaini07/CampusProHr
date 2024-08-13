import 'package:campus_pro/src/CONSTANTS/themeData.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/EXAM_LIST_GRADE_ENTRY_CUBIT/exam_list_grade_entry_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/GRADES_LIST_GRADE_ENTRY_CUBIT/grades_list_grade_entry_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/GRADE_ENTRY_LIST_CUBIT/grade_entry_list_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/RESULT_ANNOUNCE_CLASS_CUBIT/result_announce_class_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/SAVE_GRADE_ENTRY_CUBIT/save_grade_entry_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/examListGradeEntryModel.dart';
import 'package:campus_pro/src/DATA/MODELS/feeDummyData.dart';
import 'package:campus_pro/src/DATA/MODELS/gradeEntryListModel.dart';
import 'package:campus_pro/src/DATA/MODELS/gradesListGradeEntryModel.dart';
import 'package:campus_pro/src/DATA/MODELS/resultAnnounceClassModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/WIDGETS/CHARTS/attendanceBarChart.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/drawerWidget.dart';
import 'package:campus_pro/src/UI/WIDGETS/noRecordFound.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class CceGradeEntry extends StatefulWidget {
  static const routeName = "/cce-grade-entry";
  const CceGradeEntry({Key? key}) : super(key: key);

  @override
  _CceGradeEntryState createState() => _CceGradeEntryState();
}

class _CceGradeEntryState extends State<CceGradeEntry> {
  var scrollController = ScrollController();

  List<GradeEntryListModel>? gradesList = [];

  bool showHelpIcon = false;

  // GradesListGradeEntryModel? _selectedStatus;

  // final List<Map<dynamic, String>> gradesList = [
  //   {"title": "A", "value": "1"},
  //   {"title": "B", "value": "2"},
  //   {"title": "C", "value": "3"},
  // ];

  ResultAnnounceClassModel? selectedClass;
  List<ResultAnnounceClassModel>? classDropdown = [];

  ExamListGradeEntryModel? selectedExam;
  List<ExamListGradeEntryModel>? examDropdown = [];

  GradesListGradeEntryModel? selectedGrade =
      GradesListGradeEntryModel(grade: "", remarks: "");
  List<GradesListGradeEntryModel>? gradeDropdown = [];

  int? selectedTerm;
  List<int>? termDropdown = [];

  @override
  void initState() {
    gradesList = [];
    getClassList();
    super.initState();
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

  getExam() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final sendingSubject = {
      'OUserId': uid,
      'Token': token,
      'OrgID': userData!.organizationId,
      'SchoolID': userData.schoolId,
      'SessionID': userData.currentSessionid,
      'EmpId': userData.stuEmpId,
      'ClassID': selectedClass!.id,
      'UserType': userData.ouserType,
    };
    print('Sending ExamListGradeEntry data : $sendingSubject');
    context
        .read<ExamListGradeEntryCubit>()
        .examListGradeEntryCubitCall(sendingSubject);
  }

  getGardesDec() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final grades = {
      'OUserId': uid,
      'Token': token,
      'OrgID': userData!.organizationId,
      'SchoolID': userData.schoolId,
      'SessionID': userData.currentSessionid,
      'StuEmpId': userData.stuEmpId,
      'ClassID': selectedClass!.id,
      'ExamSection': selectedExam!.id,
      'UserType': userData.ouserType,
    };
    print('Sending GradesListGradeEntry data : $grades');
    context
        .read<GradesListGradeEntryCubit>()
        .gradesListGradeEntryCubitCall(grades);
  }

  getStudentGradeList() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final grades = {
      'OUserId': uid,
      'Token': token,
      'OrgID': userData!.organizationId,
      'SchoolID': userData.schoolId,
      'SessionID': userData.currentSessionid,
      'StuEmpId': userData.stuEmpId,
      'ClassID': selectedClass!.id.toString(),
      'ExamSection': selectedExam!.id,
      'UserType': userData.ouserType,
      'TermID': selectedTerm.toString(),
    };
    print('Sending GradeEntryList data : $grades');
    context.read<GradeEntryListCubit>().gradeEntryListCubitCall(grades);
  }

  clearGradeMarks() {
    setState(() {
      gradesList!.forEach((element) {
        element.grade = "";
      });
    });
  }

  saveResetGradeMarks(String? flag) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    List<String>? gradeId = [];
    List<String>? studentId = [];
    gradesList!.forEach((element) {
      setState(() {
        gradeId.add(element.grade!);
        studentId.add(element.studentId!.toString());
      });
    });
    final saveData = {
      'OUserId': uid,
      'Token': token,
      'OrgID': userData!.organizationId,
      'SchoolID': userData.schoolId,
      'SessionID': userData.currentSessionid,
      'StuEmpId': userData.stuEmpId,
      'ExamID': selectedExam!.id,
      'UserType': userData.ouserType,
      'GradeId': gradeId.join(","),
      'Flag': flag,
      'TermID': selectedTerm.toString(),
      'StudentId': studentId.join(","),
    };
    print("Sending SaveResetGradeMarks Data => $saveData");
    context.read<SaveGradeEntryCubit>().saveGradeEntryCubitCall(saveData);
  }

  @override
  void dispose() {
    gradesList = [];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: customGradient),
      child: Scaffold(
        drawer: DrawerWidget(),
        appBar: commonAppBar(
          context,
          title: "CCE Grade Entry",
          icon: showHelpIcon
              ? InkWell(
                  onTap: () {
                    showGradeSheet();
                  },
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(Icons.help),
                  )),
                )
              : null,
        ),
        bottomNavigationBar: buildBottomButtons(),
        body: MultiBlocListener(
          listeners: [
            BlocListener<SaveGradeEntryCubit, SaveGradeEntryState>(
              listener: (context, state) {
                if (state is SaveGradeEntryLoadFail) {
                  if (state.failReason == "false") {
                    UserUtils.unauthorizedUser(context);
                  }
                }
                if (state is SaveGradeEntryLoadSuccess) {
                  setState(() {
                    gradesList = [];
                    // getGardesDec();
                    getStudentGradeList();
                  });
                  // getExam();
                }
              },
            ),
            BlocListener<ResultAnnounceClassCubit, ResultAnnounceClassState>(
              listener: (context, state) {
                if (state is ResultAnnounceClassLoadFail) {
                  if (state.failReason == "false") {
                    UserUtils.unauthorizedUser(context);
                  } else {
                    setState(() {
                      selectedClass = null;
                      classDropdown = [];
                      selectedExam = null;
                      examDropdown = [];
                      selectedGrade = null;
                      gradeDropdown = [];
                      gradesList = [];
                    });
                  }
                }
                if (state is ResultAnnounceClassLoadSuccess) {
                  setState(() {
                    gradesList = [];
                    classDropdown = state.classList;
                    if (classDropdown![0].className != 'Select') {
                      classDropdown!.insert(
                          0,
                          ResultAnnounceClassModel(
                              id: "",
                              className: "Select",
                              classDisplayOrder: -1));
                    }
                    selectedClass = classDropdown![0];
                  });
                  // getExam();
                }
              },
            ),
            BlocListener<ExamListGradeEntryCubit, ExamListGradeEntryState>(
              listener: (context, state) {
                if (state is ExamListGradeEntryLoadFail) {
                  if (state.failReason == "false") {
                    UserUtils.unauthorizedUser(context);
                  } else {
                    setState(() {
                      selectedExam = null;
                      examDropdown = [];
                      selectedGrade = null;
                      gradeDropdown = [];
                      gradesList = [];
                    });
                  }
                }
                if (state is ExamListGradeEntryLoadSucccess) {
                  setState(() {
                    selectedTerm = 0;
                    termDropdown = [0, 1, 2];
                    examDropdown = state.examList;
                    if (examDropdown![0].name != 'Select') {
                      examDropdown!.insert(
                          0,
                          ExamListGradeEntryModel(
                            id: '',
                            name: 'Select',
                            displayOrder: '',
                            head: '',
                          ));
                    }
                    selectedExam = examDropdown![0];
                  });
                  getGardesDec();
                }
              },
            ),
            BlocListener<GradesListGradeEntryCubit, GradesListGradeEntryState>(
              listener: (context, state) {
                if (state is GradesListGradeEntryLoadFail) {
                  if (state.failReason == "false") {
                    UserUtils.unauthorizedUser(context);
                  } else {
                    setState(() {
                      gradesList = [];
                      showHelpIcon = false;
                    });
                  }
                }
                if (state is GradesListGradeEntryLoadSuccess) {
                  setState(() {
                    showHelpIcon = true;
                    selectedGrade = state.gradesList[0];
                    gradeDropdown = state.gradesList;
                    if (gradeDropdown![0].grade != 'None') {
                      gradeDropdown!.insert(
                          0,
                          GradesListGradeEntryModel(
                              grade: "None", remarks: ""));
                    }
                  });
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
                    buildClassDropdown(),
                    buildExamDropdown(),
                    buildTermDropdown(),
                  ],
                ),
              ),
              Divider(color: Color(0xffECECEC), thickness: 2, height: 0),
              SizedBox(height: 10.0),
              BlocConsumer<GradeEntryListCubit, GradeEntryListState>(
                listener: (context, state) {
                  if (state is GradeEntryListLoadFail) {
                    if (state.failReason == "false") {
                      UserUtils.unauthorizedUser(context);
                    } else {
                      setState(() {
                        gradesList = [];
                      });
                    }
                  }
                  if (state is GradeEntryListLoadSuccess) {
                    setState(() {
                      gradesList = [];
                      gradesList = state.gradeEntryList;
                      print("gradeDropdown : $gradeDropdown");
                      gradeDropdown!.removeAt(0);
                      // for (var i = 0; i < gradesList!.length; i++) {
                      //   if (gradeDropdown!.contains(gradesList![i].grade)) {
                      //     null;
                      //   } else {
                      //     gradesList![i].grade = "";
                      //   }
                      // }
                      // gradesList!.forEach((element) {
                      //   if (gradeDropdown!.contains(element.grade)) {
                      //     element.grade = element.grade;
                      //   } else {
                      //     element.grade = "";
                      //   }
                      // });
                    });
                  }
                },
                builder: (context, state) {
                  if (state is GradeEntryListLoadInProgress) {
                    return CircularProgressIndicator();
                  } else if (state is GradeEntryListLoadSuccess) {
                    return buildGradeBody(context);
                  } else if (state is GradeEntryListLoadFail) {
                    return noRecordFound();
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ),

        // body: NestedScrollView(
        //   controller: scrollController,
        //   physics: ScrollPhysics(parent: PageScrollPhysics()),
        //   headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        //     return <Widget>[
        //       buildTopDropdowns(),
        //     ];
        //   },
        //   body: buildGradeBody(),
        // ),
      ),
    );
  }

  Flexible buildClassDropdown() {
    return Flexible(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            buildLabels("Class"),
            Container(
              child: DropdownButton<ResultAnnounceClassModel>(
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
                    selectedExam = null;
                    examDropdown = [];
                    selectedGrade = null;
                    gradeDropdown = [];
                    selectedClass = val;
                    gradesList = [];
                  });
                  getExam();
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
            buildLabels("Exam"),
            Container(
              child: DropdownButton<ExamListGradeEntryModel>(
                isDense: true,
                value: selectedExam,
                key: UniqueKey(),
                isExpanded: true,
                underline: Container(),
                items: examDropdown!
                    .map((item) => DropdownMenuItem<ExamListGradeEntryModel>(
                        child: Text(item.name!,
                            style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold)),
                        value: item))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    selectedGrade = null;
                    gradeDropdown = [];
                    selectedTerm = 0;
                    selectedExam = val;
                    gradesList = [];
                  });
                  getGardesDec();
                },
              ),
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Flexible buildTermDropdown() {
    return Flexible(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            buildLabels("Term"),
            Container(
              child: DropdownButton<int>(
                isDense: true,
                value: selectedTerm,
                key: UniqueKey(),
                isExpanded: true,
                underline: Container(),
                items: termDropdown!
                    .map((item) => DropdownMenuItem<int>(
                        child: Text(
                            item == 1
                                ? "Ist Term"
                                : item == 2
                                    ? "IInd Term"
                                    : "Select",
                            style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold)),
                        value: item))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    selectedTerm = val;
                  });
                  if (selectedTerm != 0) getStudentGradeList();
                },
              ),
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  // SliverList buildTopDropdowns() {
  //   return SliverList(
  //     delegate: SliverChildListDelegate([
  //       Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 16.0),
  //         child: Row(
  //           children: [
  //             buildDropdown(
  //                 index: 0,
  //                 label: "Class:",
  //                 selectedValue: _selectedClass,
  //                 dropdown: classDropdown),
  //             SizedBox(width: 20),
  //             buildDropdown(
  //                 index: 1,
  //                 label: "Exam Section:",
  //                 selectedValue: _selectedExamSection,
  //                 dropdown: examSectionDropdown),
  //           ],
  //         ),
  //       ),
  //       Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 16.0),
  //         child: Row(
  //           crossAxisAlignment: CrossAxisAlignment.end,
  //           children: [
  //             buildDropdown(
  //                 index: 2,
  //                 label: "Term:",
  //                 selectedValue: _selectedTerm,
  //                 dropdown: termDropdown),
  //             SizedBox(width: 20),
  //             FlatButton(
  //               color: Colors.grey[400],
  //               onPressed: () {},
  //               child: Text(
  //                 "Clear",
  //                 style: TextStyle(color: Colors.white),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ]),
  //   );
  // }

  Container buildBottomButtons() {
    return Container(
      // padding: const EdgeInsets.all(8.0),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Expanded(
          //   flex: 1,
          //   child: FlatButton(
          //     color: Colors.transparent,
          //     onPressed: () {},
          //     child: Row(
          //       children: [
          //         Icon(Icons.refresh),
          //         Text("reset"),
          //       ],
          //     ),
          //   ),
          // ),
          buildButtons(
              title: "Reset",
              icon: Icons.refresh,
              color: Theme.of(context).primaryColor,
              onPressed: () => saveResetGradeMarks("D")),
          buildButtons(
              title: "Clear",
              icon: Icons.clear,
              color: Colors.red,
              isBorder: true,
              onPressed: () => clearGradeMarks()),
          buildButtons(
              title: "Save",
              icon: Icons.check,
              color: Colors.green,
              onPressed: () => saveResetGradeMarks("I")),
          // Expanded(
          //   flex: 1,
          //   child: FlatButton(
          //     color: Colors.transparent,
          //     onPressed: () {},
          //     child: Row(
          //       children: [
          //         Icon(Icons.check),
          //         Text("Save"),
          //       ],
          //     ),
          //   ),
          // ),
          // SizedBox(width: 10.0),
          // Expanded(
          //   flex: 1,
          //   child: FlatButton(
          //     color: Colors.green,
          //     onPressed: () {},
          //     child: Text(
          //       "Save All",
          //       style: TextStyle(color: Colors.white),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Expanded buildButtons(
      {String? title,
      IconData? icon,
      bool isBorder = false,
      Color? color,
      required void Function()? onPressed}) {
    return Expanded(
      flex: 1,
      child: Container(
        decoration: BoxDecoration(
          color: color!.withOpacity(0.7),
          border: isBorder
              ? Border(
                  left: BorderSide(width: 2, color: Color(0xffECECEC)),
                  right: BorderSide(width: 2, color: Color(0xffECECEC)),
                )
              : null,
        ),
        child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.transparent,
            ),
          // color: Colors.transparent,
          onPressed: onPressed,
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.white,
              ),
              Text(
                title!,
                textScaleFactor: 1.5,
                style: GoogleFonts.quicksand(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Expanded buildGradeBody(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(height: 10),
        physics: AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: gradesList!.length,
        itemBuilder: (context, i) {
          var item = gradesList![i];
          return PopupMenuButton(
            offset: const Offset(500, 0),
            onSelected: (GradesListGradeEntryModel choice) {
              _select(i, choice);
            },
            // onSelected: _select,
            padding: EdgeInsets.zero,
            // initialValue: choices[_selection],
            itemBuilder: (BuildContext context) {
              return gradeDropdown!.map((GradesListGradeEntryModel grade) {
                return PopupMenuItem<GradesListGradeEntryModel>(
                  value: grade,
                  child: Text(grade.grade!),
                );
              }).toList();
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              // padding: const EdgeInsets.symmetric(vertical: 10.0),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xffDBDBDB)),
              ),
              child: ListTile(
                title: Text(
                  item.stName!,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'Adm No: ${item.admNo}',
                            style: TextStyle(
                              // fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black54,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: ' | ',
                                style: TextStyle(
                                  // fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black54,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Roll No : ${item.rollNo}',
                                    style: TextStyle(
                                      // fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.teal,
                      child: Text(
                        " ${item.grade!}",
                        textScaleFactor: 1.5,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Colors.grey,
                      size: 12,
                    ),
                    SizedBox(width: 10),
                  ],
                ),
              ),
            ),
          );
        },
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

  void _select(int? currentIndex, GradesListGradeEntryModel choice) async {
    print(
        'Before : ${gradesList![currentIndex!].admNo} & ${gradesList![currentIndex].stName} & ${gradesList![currentIndex].grade}');
    setState(() {
      if (choice.grade != "None")
        gradesList![currentIndex].grade = choice.grade;
      else
        gradesList![currentIndex].grade = "";
    });
    print(
        'After : ${gradesList![currentIndex].admNo} & ${gradesList![currentIndex].stName} & ${gradesList![currentIndex].grade}');
  }

  showGradeSheet() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return GardeDescription();
      },
    );
  }
}

class GardeDescription extends StatefulWidget {
  final Map<String, String>? prevData;

  const GardeDescription({Key? key, this.prevData}) : super(key: key);
  @override
  _GardeDescriptionState createState() => _GardeDescriptionState();
}

class _GardeDescriptionState extends State<GardeDescription> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // buildTopBar(context, widget.prevData!['title']),
        SizedBox(height: 10.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  child: Text(
                    "GRADES",
                    style: GoogleFonts.quicksand(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                flex: 3,
                child: Container(
                  child: Text(
                    "DESCRIPTION",
                    style: GoogleFonts.quicksand(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  // child: Text("${user.remarks}"),
                ),
              ),
            ],
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
        //   child: Divider(),
        // ),
        BlocBuilder<GradesListGradeEntryCubit, GradesListGradeEntryState>(
          builder: (context, state) {
            if (state is GradesListGradeEntryLoadInProgress) {
              return Center(child: CircularProgressIndicator());
            } else if (state is GradesListGradeEntryLoadSuccess) {
              return buildGradeDescription(context,
                  gradesList: state.gradesList);
            } else if (state is GradesListGradeEntryLoadFail) {
              return noRecordFound();
            } else {
              return Container();
            }
          },
        ),
      ],
    );
  }

  Widget buildGradeDescription(BuildContext context,
      {List<GradesListGradeEntryModel>? gradesList}) {
    if (gradesList![0].grade == 'None') {
      gradesList.removeAt(0);
    }
    return Container(
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black38),
      ),
      child: ListView.separated(
        separatorBuilder: (context, i) => Divider(color: Colors.black38),
        shrinkWrap: true,
        itemCount: gradesList.length,
        itemBuilder: (context, i) {
          var user = gradesList[i];
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  child: Text(
                    "${user.grade}",
                    style: GoogleFonts.quicksand(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                flex: 3,
                child: Container(
                  child: Text(
                    "${user.remarks}",
                  ),
                  // child: Text("${user.remarks}"),
                ),
              ),
            ],
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
