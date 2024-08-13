import 'dart:convert';

import 'package:campus_pro/src/DATA/BLOC_CUBIT/CLASS_LIST_EMPLOYEE_CUBIT/class_list_employee_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/GET_EXAM_MARKS_FOR_TEACHER_CUBIT/get_exam_marks_for_teacher_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/GET_EXAM_TYPE_ADMIN_CUBIT/get_exam_type_admin_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/GET_MIN_MAX_MARKS_CUBIT/get_min_max_marks_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/SAVE_EXAM_MARKS_CUBIT/save_exam_marks_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/SUBJECT_EXAM_MARKS_CUBIT/subject_exam_marks_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/classListEmployeeModel.dart';
import 'package:campus_pro/src/DATA/MODELS/getExamMarksForTeacherModel.dart';
import 'package:campus_pro/src/DATA/MODELS/getExamTypeAdminModel.dart';
import 'package:campus_pro/src/DATA/MODELS/subjectExamMarkModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/noRecordFound.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

SelectedSortModel selectedSort =
    SelectedSortModel(iD: "1", sortName: "Exam Roll No", isAccending: true);

class ExamMarkEntryEmployee extends StatefulWidget {
  static const routeName = "/exam-mark-entry-employee";
  const ExamMarkEntryEmployee({Key? key}) : super(key: key);

  @override
  _ExamMarkEntryEmployeeState createState() => _ExamMarkEntryEmployeeState();
}

class _ExamMarkEntryEmployeeState extends State<ExamMarkEntryEmployee> {
  TextEditingController marksController = TextEditingController();

  final _endDrawerKey = GlobalKey<ScaffoldState>();

  ClassListEmployeeModel? selectedClass;
  List<ClassListEmployeeModel>? classDropdown = [];

  GetExamTypeAdminModel? selectedExam;
  List<GetExamTypeAdminModel>? examDropdown = [];

  SubjectExamMarksModel? selectedSubject;
  List<SubjectExamMarksModel>? subjectDropdown = [];

  String? minMarks = "0";
  String? maxMarks = "0";
  @override
  void initState() {
    stuMarksList = [];
    getEmployeeClass();
    super.initState();
  }

  getEmployeeClass() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final getEmpClassData = {
      "OUserId": uid!,
      "Token": token!,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "SessionId": userData.currentSessionid,
      "EmpID": userData.stuEmpId,
    };
    print('Get EmployeeClass $getEmpClassData');
    context
        .read<ClassListEmployeeCubit>()
        .classListEmployeeCubitCall(getEmpClassData);
  }

  getExam() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final sendingExamData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "SessionId": userData.currentSessionid,
      "StuEmpId": userData.stuEmpId,
      "ClassSectionId": selectedClass!.iD,
      "UserType": userData.ouserType,
    };
    print('sending exam type data admin $sendingExamData');
    context
        .read<GetExamTypeAdminCubit>()
        .getExamTypeAdminCubitCall(sendingExamData);
  }

  getSubjects() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final sendingSubject = {
      'OUserId': uid,
      'Token': token,
      'OrgId': userData!.organizationId,
      'Schoolid': userData.schoolId,
      'SessionId': userData.currentSessionid,
      'EmpId': userData.stuEmpId,
      'ClassSecId': selectedClass!.iD,
      'ExamId': selectedExam!.examId.toString(),
      'UserType': userData.ouserType,
    };
    print('sending exam type data admin $sendingSubject');
    context
        .read<SubjectExamMarksCubit>()
        .subjectExamMarksCubitCall(sendingSubject);
  }

  getExamMarks() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final sendingGetMarksData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "SessionId": userData.currentSessionid,
      "StuEmpId": userData.stuEmpId,
      "ClassSecId": selectedClass!.iD,
      "ExamId": selectedExam!.examId.toString(),
      "SubjectId": selectedSubject!.id,
      "Usertype": userData.ouserType,
    };

    print('sending GetExamMarksForTeacher => $sendingGetMarksData');
    context
        .read<GetExamMarksForTeacherCubit>()
        .getExamMarksForTeacherCubitCall(sendingGetMarksData, 0, []);
  }

  @override
  void dispose() {
    marksController.dispose();
    super.dispose();
  }

  saveExamMarks() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    print("OnSave Button Tap => $stuMarksList");
    List<Map<String, String>> finalExamMarksList = [];
    stuMarksList.forEach((student) {
      setState(() {
        finalExamMarksList.add({
          "AdmNo": student.admNo!,
          "subjectid": selectedSubject!.id!,
          "internalmarks": student.internalMarks!,
          "marksobtain": student.marksObt!,
          "result": "",
          "Total":
              "${int.parse(student.marksObt == "" || student.marksObt == null ? "0" : student.marksObt!) + int.parse(student.practical == "" || student.practical == null ? "0" : student.practical!) + int.parse(student.homeWork == "" || student.homeWork == null ? "0" : student.homeWork!) + int.parse(student.internalMarks == "" || student.internalMarks == null ? "0" : student.internalMarks!)}",
          "SubjectName": selectedSubject!.subjecthead!,
          "StudentName": student.studentName!,
          "Studentid": student.studentId!,
          "Practical": student.practical!,
          "Homework": student.homeWork!,
          "ExamRollNo": student.examRollNo!,
          "OptOut": "N",
          "MaxMarks": "100",
          "isAbsent":
              student.marksObt!.toUpperCase().contains("AB") ? "Y" : "N",
        });
      });
    });
    final saveExamMarks = {
      'OUserId': uid,
      'Token': token,
      'OrgId': userData!.organizationId,
      'Schoolid': userData.schoolId,
      'SessionId': userData.currentSessionid,
      'EmpId': userData.stuEmpId,
      'ClassSecId': selectedClass!.iD,
      'ExamId': selectedExam!.examId!.toString(),
      'UserType': userData.ouserType,
      'SubjectId': selectedSubject!.id,
      'Data': jsonEncode(finalExamMarksList),
    };
    print("sending SaveExamMarks Data => $saveExamMarks");
    context.read<SaveExamMarksCubit>().saveExamMarksCubitCall(saveExamMarks);
  }

  getMinMaxMarks({String? classid, int? examid, String? subjectid}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final sendingMinMaxMarks = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "SessionId": userData.currentSessionid,
      "StuEmpId": userData.stuEmpId,
      "ClassSecId": classid.toString(),
      "ExamId": examid.toString(),
      "SubjectId": subjectid.toString(),
      "Usertype": userData.ouserType,
    };

    print('sending min max marks $sendingMinMaxMarks');

    context
        .read<GetMinMaxMarksCubit>()
        .getMinMaxMarksCubitCall(sendingMinMaxMarks);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _endDrawerKey,
      appBar: commonAppBar(context,
          title: "Exam Marks Entry",
          icon: InkWell(
            onTap: () => saveExamMarks(),
            child: Center(
                child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text("Save"),
            )),
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _endDrawerKey.currentState!.openEndDrawer(),
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.filter_alt_sharp),
      ),
      endDrawer: ExamMarksFilterDrawer(),
      body: MultiBlocListener(
        listeners: [
          BlocListener<ClassListEmployeeCubit, ClassListEmployeeState>(
            listener: (context, state) {
              if (state is ClassListEmployeeLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                }
              }
              if (state is ClassListEmployeeLoadSuccess) {
                setState(() {
                  selectedClass = state.classList[0];
                  classDropdown = state.classList;
                });
                getExam();
              }
            },
          ),
          BlocListener<GetExamTypeAdminCubit, GetExamTypeAdminState>(
            listener: (context, state) {
              if (state is GetExamTypeAdminLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                }
              }
              if (state is GetExamTypeAdminLoadSuccess) {
                setState(() {
                  selectedExam = state.examList[0];
                  examDropdown = state.examList;
                });
                getSubjects();
              }
            },
          ),
          BlocListener<SubjectExamMarksCubit, SubjectExamMarksState>(
            listener: (context, state) {
              if (state is SubjectExamMarksLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                }
              }
              if (state is SubjectExamMarksLoadSuccess) {
                setState(() {
                  selectedSubject = state.subjectList[0];
                  subjectDropdown = state.subjectList;
                });
                getMinMaxMarks(
                    classid: selectedClass!.iD,
                    examid: selectedExam!.examId,
                    subjectid: selectedSubject!.id);
                getExamMarks();
              }
            },
          ),
          BlocListener<SaveExamMarksCubit, SaveExamMarksState>(
            listener: (context, state) {
              if (state is SaveExamMarksLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                }
              }
              if (state is SaveExamMarksLoadSuccess) {
                getExamMarks();
              }
            },
          ),
          BlocListener<GetExamMarksForTeacherCubit,
              GetExamMarksForTeacherState>(
            listener: (context, state) {
              if (state is GetExamMarksForTeacherLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                } else {
                  setState(() {
                    stuMarksList = [];
                  });
                }
              }
              if (state is GetExamMarksForTeacherLoadSuccess) {
                setState(() {
                  stuMarksList = [];
                  stuMarksList = state.examList;
                });
              }
            },
          ),
          BlocListener<GetMinMaxMarksCubit, GetMinMaxMarksState>(
              listener: (context, state) {
            if (state is GetMinMaxMarksLoadSuccess) {
              setState(() {
                minMarks = state.marksList[0].minMarks;
                maxMarks = state.marksList[0].maxMarks;
              });
            }
            if (state is GetMinMaxMarksLoadFail) {
              if (state.failReason == "false") {
                UserUtils.unauthorizedUser(context);
              } else {}
            }
          }),
        ],
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'For Absent Put "AB"',
                    textScaleFactor: 1.2,
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: Color(0xff313131),
                    ),
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    "Min Marks : $minMarks",
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: Color(0xff313131),
                    ),
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    "Max Marks : $maxMarks",
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: Color(0xff313131),
                    ),
                  ),
                ),
              ],
            ),
            Divider(color: Color(0xffECECEC), thickness: 2, height: 0),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  buildClassDropdown(),
                  buildExamDropdown(),
                  buildSubjectDropdown(),
                ],
              ),
            ),
            // buildTopDateFilter(context),
            Divider(color: Color(0xffECECEC), thickness: 2, height: 0),
            BlocBuilder<GetExamMarksForTeacherCubit,
                GetExamMarksForTeacherState>(
              builder: (context, state) {
                if (state is GetExamMarksForTeacherLoadInProgress) {
                  // return CircularProgressIndicator();
                  return LinearProgressIndicator();
                } else if (state is GetExamMarksForTeacherLoadSuccess) {
                  return buildExamMarksEntry(context);
                } else if (state is GetExamMarksForTeacherLoadFail) {
                  return noRecordFound();
                } else {
                  return Container();
                }
              },
            ),
            // SizedBox(height: 100.0),
          ],
        ),
      ),
    );
  }

  Expanded buildExamMarksEntry(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, i) =>
            Divider(color: Color(0xffECECEC), thickness: 6),
        shrinkWrap: true,
        itemCount: stuMarksList.length,
        itemBuilder: (context, i) {
          var stu = stuMarksList[i];
          return Column(
            key: UniqueKey(),
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text("${stu.studentName!}(${stu.examRollNo})",
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(fontSize: 18)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  "Adm no : ${stu.admNo!}",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.grey, fontSize: 15),
                ),
              ),
              Row(
                children: [
                  buildMarkTextField(
                      iD: 0,
                      index: i,
                      label: "Ob.",
                      item: stu,
                      controller: TextEditingController(text: stu.marksObt)),
                  buildMarkTextField(
                      iD: 1,
                      index: i,
                      label: "Prac.",
                      item: stu,
                      controller: TextEditingController(text: stu.practical)),
                  buildMarkTextField(
                      iD: 2,
                      index: i,
                      label: "Hw.",
                      item: stu,
                      controller: TextEditingController(text: stu.homeWork)),
                  buildMarkTextField(
                      iD: 3,
                      index: i,
                      label: "Int.",
                      item: stu,
                      controller:
                          TextEditingController(text: stu.internalMarks)),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Container buildTopDateFilter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            // color: Theme.of(context).primaryColor,
            child: Row(
              children: [
                // Text("Sort", style: Theme.of(context).textTheme.headline6),
                Icon(Icons.sort_by_alpha),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              _endDrawerKey.currentState!.openEndDrawer();
            },
            child: Container(
              // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              // color: Theme.of(context).primaryColor,
              child: Row(
                children: [
                  Text("Filter",
                      // style: Theme.of(context).textTheme.headline6
                  ),
                  Icon(Icons.filter_alt_sharp),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Flexible buildMarkTextField(
      {int? iD,
      int? index,
      String? label,
      GetExamMarksForTeacherModel? item,
      TextEditingController? controller}) {
    return Flexible(
      child: Column(
        children: [
          Text(
            label!,
            textScaleFactor: 1.0,
            style: GoogleFonts.quicksand(
                fontWeight: FontWeight.w500, fontSize: 17),
          ),
          MarksTextField(
            marks: controller!.text,
            iD: iD,
            currentIndex: index,
            marksDetails: item,
          )
        ],
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
              child: DropdownButton<ClassListEmployeeModel>(
                isDense: true,
                value: selectedClass,
                key: UniqueKey(),
                isExpanded: true,
                underline: Container(),
                items: classDropdown!
                    .map((item) => DropdownMenuItem<ClassListEmployeeModel>(
                        child: Text(item.className!,
                            style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold)),
                        value: item))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    selectedClass = val;
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
              child: DropdownButton<GetExamTypeAdminModel>(
                isDense: true,
                value: selectedExam,
                key: UniqueKey(),
                isExpanded: true,
                underline: Container(),
                items: examDropdown!
                    .map((item) => DropdownMenuItem<GetExamTypeAdminModel>(
                        child: Text(item.exam!,
                            style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold)),
                        value: item))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    selectedExam = val;
                  });
                  getSubjects();
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            buildLabels("Subject"),
            Container(
              child: DropdownButton<SubjectExamMarksModel>(
                isDense: true,
                value: selectedSubject,
                key: UniqueKey(),
                isExpanded: true,
                underline: Container(),
                items: subjectDropdown!
                    .map((item) => DropdownMenuItem<SubjectExamMarksModel>(
                        child: Text(item.subjecthead!,
                            style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold)),
                        value: item))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    selectedSubject = val;
                  });
                  getExamMarks();
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
        style: GoogleFonts.quicksand(
          fontWeight: FontWeight.w500,
          // color: Theme.of(context).primaryColor,
          color: Color(0xff313131),
        ),
      ),
    );
  }
}

class MarksTextField extends StatefulWidget {
  final String? marks;
  final int? iD;
  final int? currentIndex;
  final GetExamMarksForTeacherModel? marksDetails;
  const MarksTextField(
      {Key? key, this.marks, this.marksDetails, this.iD, this.currentIndex})
      : super(key: key);

  @override
  _MarksTextFieldState createState() => _MarksTextFieldState();
}

class _MarksTextFieldState extends State<MarksTextField> {
  TextEditingController marksController = TextEditingController();

  @override
  void initState() {
    if (widget.marks != null && widget.marks != "")
      marksController.text = widget.marks!;
    else
      marksController.text = "0";
    super.initState();
  }

  @override
  void dispose() {
    marksController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      child: TextFormField(
        controller: marksController,
        inputFormatters: [LengthLimitingTextInputFormatter(2)],
        textAlign: TextAlign.center,
        style: GoogleFonts.quicksand(
          fontWeight: FontWeight.w400,
          fontSize: 16.0,
          color: Colors.black45,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.transparent,
          border: new OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(18.0),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black26,
            ),
            gapPadding: 0.0,
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xffECECEC),
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
            ),
          ),
          hintText: "0",
          hintStyle: TextStyle(color: Color(0xffA5A5A5), fontSize: 12),
          isDense: true,
          // contentPadding:
          //     EdgeInsets.zero,
          contentPadding: const EdgeInsets.all(4),
        ),
        onChanged: (String? val) {
          print(
              'Before : ${stuMarksList[widget.currentIndex!].marksObt} & ${stuMarksList[widget.currentIndex!].practical} & ${stuMarksList[widget.currentIndex!].homeWork} & ${stuMarksList[widget.currentIndex!].internalMarks}');
          setState(() {
            if (widget.iD == 0) {
              stuMarksList[widget.currentIndex!].marksObt =
                  marksController.text;
            } else if (widget.iD == 1) {
              stuMarksList[widget.currentIndex!].practical =
                  marksController.text;
            } else if (widget.iD == 2) {
              stuMarksList[widget.currentIndex!].homeWork =
                  marksController.text;
            } else if (widget.iD == 3) {
              stuMarksList[widget.currentIndex!].internalMarks =
                  marksController.text;
            }
          });
          print(
              'After : ${stuMarksList[widget.currentIndex!].marksObt} & ${stuMarksList[widget.currentIndex!].practical} & ${stuMarksList[widget.currentIndex!].homeWork} & ${stuMarksList[widget.currentIndex!].internalMarks}');
        },
      ),
    );
  }
}

List<FilterTypeModel> filterTypeList = [
  FilterTypeModel(iD: "0", filterType: "Adm No", value: true),
  FilterTypeModel(iD: "1", filterType: "Exam Roll No", value: false),
  FilterTypeModel(iD: "2", filterType: "Student Name", value: false),
  FilterTypeModel(iD: "3", filterType: "Father's Name", value: false),
];

List<FilterTypeModel> sortTypeList = [
  FilterTypeModel(iD: "0", filterType: "Ascending A-Z", value: true),
  FilterTypeModel(iD: "1", filterType: "Descending Z-A", value: false),
];

class ExamMarksFilterDrawer extends StatefulWidget {
  @override
  _ExamMarksFilterDrawerState createState() => _ExamMarksFilterDrawerState();
}

class _ExamMarksFilterDrawerState extends State<ExamMarksFilterDrawer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 100,
      child: Drawer(
        child: Scaffold(
          appBar: AppBar(toolbarHeight: 0.0),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                color: Theme.of(context).primaryColor,
                child: Text(
                  "Category",
                  style: GoogleFonts.quicksand(
                      color: Colors.white,
                      // fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Sort Type",
                style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Divider(),
              ListView.builder(
                shrinkWrap: true,
                itemCount: filterTypeList.length,
                itemBuilder: (context, i) {
                  var item = filterTypeList[i];
                  return CheckboxListTile(
                    activeColor: Theme.of(context).primaryColor,
                    value: item.value,
                    title: Text(
                      item.filterType!,
                      style: GoogleFonts.quicksand(
                          fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    onChanged: (val) {
                      setState(() {
                        filterTypeList.forEach((element) {
                          element.value = false;
                        });

                        filterTypeList[i] = FilterTypeModel(
                            iD: item.iD,
                            filterType: item.filterType,
                            value: true);
                      });
                    },
                  );
                },
              ),
              Divider(),
              Text(
                "Sort By",
                style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Divider(),
              ListView.builder(
                shrinkWrap: true,
                itemCount: sortTypeList.length,
                itemBuilder: (context, i) {
                  var item = sortTypeList[i];
                  return CheckboxListTile(
                    activeColor: Theme.of(context).primaryColor,
                    value: item.value,
                    title: Text(
                      item.filterType!,
                      style: GoogleFonts.quicksand(
                          fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    onChanged: (val) {
                      setState(() {
                        sortTypeList.forEach((element) {
                          element.value = false;
                        });
                        sortTypeList[i] = FilterTypeModel(
                            iD: item.iD,
                            filterType: item.filterType,
                            value: true);
                      });
                    },
                  );
                },
              ),
              TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor)),
                onPressed: () {
                  setState(() {
                    final filterType = filterTypeList
                        .where((element) => element.value == true);
                    final sortType =
                        sortTypeList.where((element) => element.value == true);
                    selectedSort = SelectedSortModel(
                      iD: filterType.first.iD,
                      sortName: filterType.first.filterType,
                      isAccending: sortType.first.iD == "0" ? true : false,
                    );
                    print("selectedSort => $selectedSort");
                    switch (selectedSort.iD) {
                      case "0":
                        stuMarksList
                            .sort((a, b) => a.admNo!.compareTo(b.admNo!));
                        break;
                      case "1":
                        stuMarksList.sort(
                            (a, b) => a.examRollNo!.compareTo(b.examRollNo!));
                        break;
                      case "2":
                        stuMarksList.sort(
                            (a, b) => a.studentName!.compareTo(b.studentName!));
                        break;
                      case "3":
                        stuMarksList.sort(
                            (a, b) => a.fatherName!.compareTo(b.fatherName!));
                        break;
                      default:
                        break;
                    }
                    selectedSort.isAccending!
                        ? print("stuMarksList : $stuMarksList")
                        : print(
                            "stuMarksList.reversed ${stuMarksList.reversed}");
                    selectedSort.isAccending!
                        ? context
                            .read<GetExamMarksForTeacherCubit>()
                            .getExamMarksForTeacherCubitCall(
                                {}, 1, stuMarksList)
                        : context
                            .read<GetExamMarksForTeacherCubit>()
                            .getExamMarksForTeacherCubitCall(
                                {}, 1, stuMarksList.reversed.toList());
                    Navigator.pop(context);
                  });
                },
                child: Text(
                  "Sort",
                  style: GoogleFonts.quicksand(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FilterTypeModel {
  String? iD = '';
  String? filterType = '';
  bool? value = false;

  FilterTypeModel({this.iD, this.filterType, this.value});
}

class DrawerItem {
  String? itemName;
  String? icon;

  DrawerItem({this.itemName, this.icon});
}

class StudentMarkModel {
  int? admNo;
  int? examRollNo;
  String? stName = '';
  String? fName = '';
  String? obtainMarks = '';
  String? practicalMarks = '';
  String? homeworkMarks = '';
  String? internalMarks = '';

  StudentMarkModel(
      {this.admNo,
      this.examRollNo,
      this.stName,
      this.fName,
      this.obtainMarks,
      this.practicalMarks,
      this.homeworkMarks,
      this.internalMarks});

  @override
  String toString() {
    return "{admNo : $admNo, examRollNo : $examRollNo, stName : $stName, fName : $fName, obtainMarks : $obtainMarks, practicalMarks : $practicalMarks, homeworkMarks : $homeworkMarks, internalMarks : $internalMarks}, ";
  }
}

List<GetExamMarksForTeacherModel> stuMarksList = [];

// List<StudentMarkModel> stMarksList = [
//   StudentMarkModel(
//       admNo: 1,
//       examRollNo: 12,
//       stName: "Z",
//       fName: "B",
//       obtainMarks: "60",
//       practicalMarks: "55",
//       homeworkMarks: "70",
//       internalMarks: "66"),
//   StudentMarkModel(
//       admNo: 2,
//       examRollNo: 11,
//       stName: "X",
//       fName: "C",
//       obtainMarks: "40",
//       practicalMarks: "35",
//       homeworkMarks: "60",
//       internalMarks: "42"),
//   StudentMarkModel(
//       admNo: 3,
//       examRollNo: 10,
//       stName: "Y",
//       fName: "A",
//       obtainMarks: "40",
//       practicalMarks: "35",
//       homeworkMarks: "60",
//       internalMarks: "42"),
// ];

class SelectedSortModel {
  String? iD = '';
  String? sortName = '';
  bool? isAccending;

  SelectedSortModel({this.iD, this.sortName, this.isAccending});

  @override
  String toString() {
    return "{iD : $iD, sortName : $sortName, isAccending : $isAccending}, ";
  }
}

bool? isAccending = true;

class SaveExamMarksModel {
  String? admNo;
  String? subjectId;
  String? internalMarks;
  String? obtainMarks;
  String? result;
  String? total;
  String? subjectName;
  String? studentName;
  String? studentId;
  String? practicalMarks;
  String? homeworkMarks;
  String? examRollNo;
  String? optOut;
  String? maxMarks;
  String? isAbsent;

  SaveExamMarksModel(
      {this.admNo,
      this.subjectId,
      this.internalMarks,
      this.obtainMarks,
      this.result,
      this.total,
      this.subjectName,
      this.studentName,
      this.studentId,
      this.practicalMarks,
      this.homeworkMarks,
      this.examRollNo,
      this.optOut,
      this.maxMarks,
      this.isAbsent});

  @override
  String toString() {
    return "{admNo: $admNo, subjectId: $subjectId, internalMarks: $internalMarks, obtainMarks: $obtainMarks, result: $result, total: $total, subjectName: $subjectName, studentName: $studentName, studentId: $studentId, practicalMarks: $practicalMarks, homeworkMarks: $homeworkMarks, examRollNo: $examRollNo, optOut: $optOut, maxMarks: $maxMarks, isAbsent: $isAbsent}, ";
  }
}
