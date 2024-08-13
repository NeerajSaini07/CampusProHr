import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/CLASS_FOR_COORDINATOR_CUBIT/classes_for_coordinator_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/GET_EXAM_MARKS_FOR_TEACHER_CUBIT/get_exam_marks_for_teacher_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/GET_EXAM_TYPE_ADMIN_CUBIT/get_exam_type_admin_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/GET_MIN_MAX_MARKS_CUBIT/get_min_max_marks_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/GET_SUBJECT_ADMIN_CUBIT/get_subject_admin_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/LOAD_CLASS_FOR_SMS_CUBIT/load_class_for_sms_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/classesForCoordinatorModel.dart';
import 'package:campus_pro/src/DATA/MODELS/getExamMarksForTeacherModel.dart';
import 'package:campus_pro/src/DATA/MODELS/getExamTypeAdminModel.dart';
import 'package:campus_pro/src/DATA/MODELS/getSubjectAdminModel.dart';
import 'package:campus_pro/src/DATA/MODELS/loadClassForSmsModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/PAGES/ADMIN_MODULE/EXAM_ADMIN/Exam_Marks/examMarksAdminDetail.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExamMarksAdmin extends StatefulWidget {
  static const routeName = '/Exam-Marks-Admin';
  const ExamMarksAdmin({Key? key}) : super(key: key);

  @override
  _ExamMarksAdminState createState() => _ExamMarksAdminState();
}

class _ExamMarksAdminState extends State<ExamMarksAdmin> {
  //Coordinator class
  List<ClassesForCoordinatorModel> classListCoordinator = [];
  ClassesForCoordinatorModel? _selectedClassCoordinator;

  List<LoadClassForSmsModel>? classItems = [];
  LoadClassForSmsModel? selectedClass;
  String? classId;

  List<GetExamTypeAdminModel>? examItems = [];
  GetExamTypeAdminModel? selectedExam;
  int? examId;

  List<GetSubjectAdminModel> subjectItems = [];
  GetSubjectAdminModel? selectedSubject;
  String? subjectId;

  bool? practicalBoolVal = false;
  bool? internalBoolVal = false;
  bool? homeworkBoolVal = false;
  String? minMarks;
  String? maxMarks;
  List<GetExamMarksForTeacherModel>? examMarksList = [];

  String? UserType;
  // List classListItem = [
  //   ['121', 'test1', '121', 'namannananana', '0', '10', '20', '30'],
  //   ['121', 'test2', '121', 'naman', '0', '10', '20', '30'],
  //   ['121', 'test3', '121', 'naman', '0', '10', '20', '30'],
  //   ['121', 'test4', '121', 'naman', '0', '10', '20', '30']
  // ];

  // List<DropdownMenuItem<String>>? classItem = item
  //     .map((String e) => DropdownMenuItem<String>(
  //           child: Text(e),
  //           value: e,
  //         ))
  //     .toList();

  // List<DropdownMenuItem<String>> examItem = item1
  //     .map((String e) => DropdownMenuItem<String>(
  //           child: Text(e),
  //           value: e,
  //         ))
  //     .toList();

  // List<DropdownMenuItem<String>> subjectItem = item2
  //     .map((String e) => DropdownMenuItem<String>(
  //           child: Text(e),
  //           value: e,
  //         ))
  //     .toList();

  getClass() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final sendingClassData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "StuEmpId": userData.stuEmpId,
      "Usertype": userData.ouserType,
    };

    print('Sending class data for exam marks $sendingClassData');

    context
        .read<LoadClassForSmsCubit>()
        .loadClassForSmsCubitCall(sendingClassData);
  }

  getExam({String? classId}) async {
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
      "ClassSectionId": classId.toString(),
      "UserType": userData.ouserType,
    };
    print('sending exam type data admin $sendingExamData');
    context
        .read<GetExamTypeAdminCubit>()
        .getExamTypeAdminCubitCall(sendingExamData);
  }

  getSubject({String? classid, int? examid}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final sendingSubjectData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "SessionId": userData.currentSessionid,
      "EmpId": userData.stuEmpId,
      "ClassSecId": classid.toString(),
      "ExamId": examid.toString(),
      "Usertype": userData.ouserType,
    };

    print('get subject admin $sendingSubjectData');

    context
        .read<GetSubjectAdminCubit>()
        .getSubjectAdminCubitCall(sendingSubjectData);
  }

  getExamMarks({String? classid, int? examid, String? subjectid}) async {
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
      "ClassSecId": classid.toString(),
      "ExamId": examid.toString(),
      "SubjectId": subjectid.toString(),
      "Usertype": userData.ouserType,
    };

    print('sending exam data admin $sendingGetMarksData');
    context
        .read<GetExamMarksForTeacherCubit>()
        .getExamMarksForTeacherCubitCall(sendingGetMarksData, 0, []);
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

  getCoordinatorClass() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final getClassData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "SessionId": userData.currentSessionid,
      "EmpId": userData.stuEmpId,
      "UserType": userData.ouserType,
    };

    print('sending data for class for coordinator');

    context
        .read<ClassesForCoordinatorCubit>()
        .classesForCoordinatorCubitCall(getClassData);
  }

  getUserType() async {
    final userData = await UserUtils.userTypeFromCache();
    setState(() {
      UserType = userData!.ouserType;
    });
    //print(userData!.ouserType);
  }

  void initState() {
    super.initState();
    //subjectItems = [];
    getUserType();
    minMarks = '0';
    maxMarks = '10';
    selectedClass =
        LoadClassForSmsModel(classId: "", classDisplayOrder: "", classname: "");
    classItems = [];
    classListCoordinator = [];
    _selectedClassCoordinator =
        ClassesForCoordinatorModel(className: "", classId: "");
    getClass();
    getCoordinatorClass();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, title: 'Exam Marks'),
      // bottomNavigationBar: IntrinsicHeight(
      //   child: Container(
      //     decoration: BoxDecoration(
      //       border: Border.all(width: 0.7),
      //       //color: Colors.grey,
      //       color: Colors.lightBlueAccent,
      //     ),
      //     width: MediaQuery.of(context).size.width,
      //     margin: EdgeInsets.only(left: 0, bottom: 0, top: 4, right: 0),
      //     padding: EdgeInsets.all(8),
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //       children: [
      //         Container(
      //           padding: EdgeInsets.only(top: 4, bottom: 4, left: 6, right: 6),
      //           decoration: BoxDecoration(
      //             border: Border.all(width: 0.1),
      //             color: internalBoolVal == true ? Colors.green : Colors.black,
      //             borderRadius: BorderRadius.circular(8),
      //           ),
      //           child: InkWell(
      //             onTap: () {
      //               setState(() {
      //                 internalBoolVal = internalBoolVal == false ? true : false;
      //               });
      //               print(internalBoolVal);
      //             },
      //             child: Text(
      //               'Internal',
      //               style: TextStyle(
      //                   color: Colors.white,
      //                   fontSize: MediaQuery.of(context).size.width * 0.05),
      //             ),
      //           ),
      //         ),
      //         VerticalDivider(
      //           thickness: 3,
      //           //color: Colors.cyanAccent,
      //           color: Colors.black,
      //         ),
      //         Container(
      //           padding: EdgeInsets.only(top: 4, bottom: 4, left: 6, right: 6),
      //           decoration: BoxDecoration(
      //             border: Border.all(width: 0.1),
      //             color:
      //                 practicalBoolVal == false ? Colors.black : Colors.green,
      //             borderRadius: BorderRadius.circular(8),
      //           ),
      //           child: InkWell(
      //             onTap: () {
      //               setState(() {
      //                 practicalBoolVal =
      //                     practicalBoolVal == false ? true : false;
      //               });
      //               print(practicalBoolVal);
      //             },
      //             child: Text(
      //               'Practical',
      //               style: TextStyle(
      //                   color: Colors.white,
      //                   fontSize: MediaQuery.of(context).size.width * 0.05),
      //             ),
      //           ),
      //         ),
      //         VerticalDivider(
      //           thickness: 3,
      //           // color: Colors.cyanAccent,
      //           color: Colors.black,
      //         ),
      //         Container(
      //           padding: EdgeInsets.only(top: 4, bottom: 4, left: 6, right: 6),
      //           decoration: BoxDecoration(
      //             border: Border.all(width: 0.1),
      //             color: homeworkBoolVal != true ? Colors.black : Colors.green,
      //             borderRadius: BorderRadius.circular(8),
      //           ),
      //           child: InkWell(
      //             onTap: () {
      //               setState(() {
      //                 homeworkBoolVal = homeworkBoolVal == false ? true : false;
      //               });
      //               print(homeworkBoolVal);
      //             },
      //             child: Text(
      //               'HomeWork',
      //               style: TextStyle(
      //                   color: Colors.white,
      //                   fontSize: MediaQuery.of(context).size.width * 0.05),
      //             ),
      //           ),
      //         ),
      //         // TextButton(
      //         //   onPressed: () {
      //         //     print(
      //         //       'test',
      //         //     );
      //         //   },
      //         //   child: Text(
      //         //     '1',
      //         //     style: TextStyle(
      //         //       color: Colors.white,
      //         //       fontSize: MediaQuery.of(context).size.width * 0.04,
      //         //     ),
      //         //   ),
      //         // ),
      //         // TextButton(
      //         //   onPressed: () {
      //         //     print('test');
      //         //   },
      //         //   child: Text('2'),
      //         // ),
      //         // TextButton(
      //         //   onPressed: () {
      //         //     print('test');
      //         //   },
      //         //   child: Text('3'),
      //         // ),
      //       ],
      //     ),
      //   ),
      // ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<GetMinMaxMarksCubit, GetMinMaxMarksState>(
              listener: (context, state) {
            if (state is GetMinMaxMarksLoadSuccess) {
              setState(() {
                minMarks = state.marksList[0].minMarks;
                maxMarks = state.marksList[0].maxMarks;
              });
            }
          }),
        ],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Row(
                children: [
                  UserType == "A" || UserType == "P"
                      ? BlocConsumer<LoadClassForSmsCubit,
                          LoadClassForSmsState>(
                          listener: (context, state) {
                            if (state is LoadClassForSmsLoadSuccess) {
                              setState(() {
                                selectedClass = state.classList[0];
                                classItems = state.classList;
                                classId = state.classList[0].classId;
                              });
                              getExam(classId: classId);
                            }
                            if (state is LoadClassForSmsLoadFail) {
                              if (state.failReason == 'false') {
                                UserUtils.unauthorizedUser(context);
                              }
                              setState(() {
                                selectedClass = LoadClassForSmsModel(
                                    classId: "",
                                    classDisplayOrder: "",
                                    classname: "");
                                classItems = [];
                              });
                            }
                          },
                          builder: (context, state) {
                            if (state is LoadClassForSmsLoadInProgress) {
                              return buildClassDropDown();
                            } else if (state is LoadClassForSmsLoadSuccess) {
                              return buildClassDropDown();
                            } else if (state is LoadClassForSmsLoadFail) {
                              return buildClassDropDown();
                            } else {
                              return Container();
                            }
                          },
                        )
                      : BlocConsumer<ClassesForCoordinatorCubit,
                          ClassesForCoordinatorState>(
                          listener: (context, state) {
                            if (state is ClassesForCoordinatorLoadSuccess) {
                              print(state.classList[0].className);
                              setState(() {
                                classListCoordinator = state.classList;
                                _selectedClassCoordinator = state.classList[0];
                              });
                              //print(dropDownClassValue!.className);
                              getExam(
                                  classId: _selectedClassCoordinator!.classId);
                            }
                            if (state is ClassesForCoordinatorLoadFail) {
                              setState(() {
                                // dropDownClassValue =
                                //     ClassListEmployeeModel(iD: "", className: "");
                                classListCoordinator = [];
                                _selectedClassCoordinator =
                                    ClassesForCoordinatorModel(
                                        className: "", classId: "");
                              });
                              if (state.failReason == 'false') {
                                UserUtils.unauthorizedUser(context);
                              }
                            }
                          },
                          builder: (context, state) {
                            if (state is ClassesForCoordinatorLoadInProgress) {
                              // return testContainer();
                              return buildCoordinatorClassDropDown();
                            } else if (state
                                is ClassesForCoordinatorLoadSuccess) {
                              return buildCoordinatorClassDropDown();
                            } else if (state is ClassesForCoordinatorLoadFail) {
                              return buildCoordinatorClassDropDown();
                            } else {
                              return Container();
                            }
                          },
                        ),
                  //buildClassDropDown(),
                  //buildExamDropDown(),
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Min-marks:',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.025,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.15,
                        height: MediaQuery.of(context).size.height * 0.04,
                        margin: const EdgeInsets.symmetric(horizontal: 20.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border.all(width: 0.2),
                        ),
                        child: Center(
                            child: Text(
                          '$minMarks',
                          style: TextStyle(fontSize: 16),
                        )),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Max-marks:',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.025,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.15,
                        height: MediaQuery.of(context).size.height * 0.04,
                        margin: const EdgeInsets.symmetric(horizontal: 20.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border.all(width: 0.2),
                        ),
                        child: Center(
                          child: Text(
                            '$maxMarks',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              children: [
                BlocConsumer<GetExamTypeAdminCubit, GetExamTypeAdminState>(
                    listener: (context, state) {
                  if (state is GetExamTypeAdminLoadSuccess) {
                    setState(() {
                      selectedExam =
                          GetExamTypeAdminModel(exam: "", examId: -1);
                      examItems = [];
                      selectedExam = state.examList[0];
                      examItems = state.examList;
                      examId = state.examList[0].examId;
                    });
                    getSubject(
                        classid: UserType!.toUpperCase() == "A"
                            ? classId
                            : _selectedClassCoordinator!.classId,
                        examid: examId);
                  }
                  if (state is GetExamTypeAdminLoadFail) {
                    if (state.failReason == 'false') {
                      UserUtils.unauthorizedUser(context);
                    }
                    setState(() {
                      selectedExam =
                          GetExamTypeAdminModel(exam: "", examId: -1);
                      examItems = [];
                    });
                  }
                }, builder: (context, state) {
                  if (state is GetExamTypeAdminLoadInProgress) {
                    return buildExamDropDown();
                  } else if (state is GetExamTypeAdminLoadSuccess) {
                    return buildExamDropDown();
                  } else if (state is GetExamTypeAdminLoadFail) {
                    return buildExamDropDown();
                  } else {
                    return Container();
                  }
                }),
                //buildExamDropDown(),
                BlocConsumer<GetSubjectAdminCubit, GetSubjectAdminState>(
                  listener: (context, state) {
                    if (state is GetSubjectAdminLoadSuccess) {
                      setState(() {
                        selectedSubject =
                            GetSubjectAdminModel(id: "", subjectName: "");
                        subjectItems = [];
                        selectedSubject = state.subjectList[0];
                        subjectItems = state.subjectList;
                        subjectId = state.subjectList[0].id;
                      });
                      getExamMarks(
                          classid: UserType == "A"
                              ? classId
                              : _selectedClassCoordinator!.classId,
                          examid: examId,
                          subjectid: subjectId);
                      getMinMaxMarks(
                          classid: UserType == "A"
                              ? classId
                              : _selectedClassCoordinator!.classId,
                          examid: examId,
                          subjectid: subjectId);
                    }
                    if (state is GetSubjectAdminLoadFail) {
                      if (state.failReason == "false") {
                        UserUtils.unauthorizedUser(context);
                      } else {
                        setState(() {
                          selectedSubject =
                              GetSubjectAdminModel(id: "", subjectName: "");
                          subjectItems = [];
                        });
                      }
                    }
                  },
                  builder: (context, state) {
                    if (state is GetSubjectAdminLoadInProgress) {
                      return buildSubjectDropDown();
                    } else if (state is GetSubjectAdminLoadSuccess) {
                      return buildSubjectDropDown();
                    } else if (state is GetSubjectAdminLoadFail) {
                      return buildSubjectDropDown();
                    } else {
                      return Container();
                    }
                  },
                ),
                //buildSubjectDropDown(),
                // Column(
                //   children: [
                //     SizedBox(
                //       height: MediaQuery.of(context).size.height * 0.039,
                //     ),
                //     Container(
                //       decoration: BoxDecoration(border: Border.all(width: 0.2)),
                //       margin: EdgeInsets.only(
                //           left: 20, right: 19, top: 8, bottom: 10),
                //       width: MediaQuery.of(context).size.width * 0.4,
                //       height: MediaQuery.of(context).size.height * 0.055,
                //       child: Row(
                //         children: [
                //           Checkbox(
                //             value: internalBoolVal,
                //             onChanged: (val) {
                //               setState(
                //                 () {
                //                   internalBoolVal = val;
                //                 },
                //               );
                //             },
                //           ),
                //           Text('Internal'),
                //         ],
                //       ),
                //     ),
                //   ],
                // )
              ],
            ),
            // Row(
            //   children: [
            //     // Column(
            //     //   children: [
            //     //     Container(
            //     //       margin: const EdgeInsets.symmetric(horizontal: 19.0),
            //     //       child: Text(
            //     //         'Max-marks:',
            //     //         style: Theme.of(context).textTheme.headline6,
            //     //       ),
            //     //     ),
            //     //     SizedBox(
            //     //       height: MediaQuery.of(context).size.height * 0.02,
            //     //     ),
            //     //     Container(
            //     //       width: MediaQuery.of(context).size.width * 0.24,
            //     //       height: MediaQuery.of(context).size.height * 0.04,
            //     //       margin: const EdgeInsets.symmetric(horizontal: 20.0),
            //     //       decoration: BoxDecoration(
            //     //         shape: BoxShape.rectangle,
            //     //         border: Border.all(width: 0.2),
            //     //       ),
            //     //       child: Center(
            //     //         child: Text(
            //     //           '123',
            //     //           style: Theme.of(context).textTheme.headline6,
            //     //         ),
            //     //       ),
            //     //     ),
            //     //   ],
            //     // ),
            //     // SizedBox(
            //     //   width: MediaQuery.of(context).size.width * 0.155,
            //     // ),
            //     // Column(
            //     //   children: [
            //     //     SizedBox(
            //     //       height: MediaQuery.of(context).size.height * 0.039,
            //     //     ),
            //     //     Container(
            //     //       decoration: BoxDecoration(border: Border.all(width: 0.2)),
            //     //       margin: EdgeInsets.only(
            //     //           left: 20, right: 19, top: 8, bottom: 10),
            //     //       width: MediaQuery.of(context).size.width * 0.4,
            //     //       height: MediaQuery.of(context).size.height * 0.055,
            //     //       child: Row(
            //     //         children: [
            //     //           Checkbox(
            //     //             value: practicalBoolVal,
            //     //             onChanged: (val) {
            //     //               setState(
            //     //                 () {
            //     //                   practicalBoolVal = val;
            //     //                 },
            //     //               );
            //     //             },
            //     //           ),
            //     //           Text('practical'),
            //     //         ],
            //     //       ),
            //     //     ),
            //     //   ],
            //     // )
            //   ],
            // ),
            // Row(
            //   children: [
            //     // Column(
            //     //   children: [
            //     //     Container(
            //     //       margin: const EdgeInsets.symmetric(horizontal: 19.0),
            //     //       child: Text(
            //     //         'Min-marks:',
            //     //         style: Theme.of(context).textTheme.headline6,
            //     //       ),
            //     //     ),
            //     //     SizedBox(
            //     //       height: MediaQuery.of(context).size.height * 0.02,
            //     //     ),
            //     //     Container(
            //     //       width: MediaQuery.of(context).size.width * 0.24,
            //     //       height: MediaQuery.of(context).size.height * 0.04,
            //     //       margin: const EdgeInsets.symmetric(horizontal: 20.0),
            //     //       decoration: BoxDecoration(
            //     //         shape: BoxShape.rectangle,
            //     //         border: Border.all(width: 0.2),
            //     //       ),
            //     //       child: Center(
            //     //           child: Text(
            //     //         '123',
            //     //         style: Theme.of(context).textTheme.headline6,
            //     //       )),
            //     //     ),
            //     //   ],
            //     // ),
            //     // SizedBox(
            //     //   width: MediaQuery.of(context).size.width * 0.155,
            //     // ),
            //     // Column(
            //     //   children: [
            //     //     SizedBox(
            //     //       height: MediaQuery.of(context).size.height * 0.039,
            //     //     ),
            //     //     Container(
            //     //       decoration: BoxDecoration(border: Border.all(width: 0.2)),
            //     //       margin: EdgeInsets.only(
            //     //           left: 20, right: 19, top: 8, bottom: 10),
            //     //       width: MediaQuery.of(context).size.width * 0.4,
            //     //       height: MediaQuery.of(context).size.height * 0.055,
            //     //       child: Row(
            //     //         children: [
            //     //           Checkbox(
            //     //             value: homeworkBoolVal,
            //     //             onChanged: (val) {
            //     //               setState(
            //     //                 () {
            //     //                   homeworkBoolVal = val;
            //     //                 },
            //     //               );
            //     //             },
            //     //           ),
            //     //           Text('HomeWork'),
            //     //         ],
            //     //       ),
            //     //     ),
            //     //   ],
            //     // )
            //   ],
            // ),
            Divider(
              thickness: 5,
            ),
            subjectItems.length != 0
                ? Center(
                    child: Text(
                      'Tap To See more Details',
                      style: TextStyle(
                        color:
                            // Colors.red,
                            Color(0xffFFF55E53),
                        fontWeight: FontWeight.w600,
                        fontSize: 13.0,
                      ),
                    ),
                  )
                : Center(
                    child: Text(''),
                  ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            subjectItems.length != 0
                ? BlocConsumer<GetExamMarksForTeacherCubit,
                    GetExamMarksForTeacherState>(
                    listener: (context, state) {
                      if (state is GetExamMarksForTeacherLoadSuccess) {
                        setState(() {
                          examMarksList = state.examList;
                        });
                      }
                    },
                    builder: (context, state) {
                      if (state is GetExamMarksForTeacherLoadInProgress) {
                        return LinearProgressIndicator();
                        // return Center(
                        //   child: Container(
                        //     width: 10,
                        //     height: 10,
                        //     child: CircularProgressIndicator(),
                        //   ),
                        // );
                      } else if (state is GetExamMarksForTeacherLoadSuccess) {
                        //return checkList(examList: state.examList);
                        return checkList(examList: examMarksList);
                      } else if (state is GetExamMarksForTeacherLoadFail) {
                        return checkList(error: state.failReason);
                      } else {
                        return Container();
                      }
                    },
                  )
                : Expanded(
                    child: Center(
                      child: Text(
                        '$NO_RECORD_FOUND',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )
            //buildExamMarksList()
          ],
        ),
      ),
    );
  }

  Expanded checkList(
      {List<GetExamMarksForTeacherModel>? examList, String? error}) {
    if (examList == null || examList.isEmpty) {
      if (error == null) {
        return Expanded(
          child: Center(
            child: Text(
              //subjectItems.length == 0 ? 'NO_RECORD' : 'Wait',
              'Wait',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.04,
                fontWeight: FontWeight.w700,
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
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      }
    } else {
      return buildExamMarksList(examList: examList);
    }
  }

  Expanded buildExamMarksList({List<GetExamMarksForTeacherModel>? examList}) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(
          height: 10,
        ),
        itemCount: examList!.length,
        itemBuilder: (context, index) {
          var item = examList[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ExamMarksDetailAdmin(
                      name: item.studentName,
                      admNo: item.admNo,
                      rollNo: item.examRollNo,
                      markObt: item.marksObt,
                      internalMarks: item.internalMarks,
                      practicalMarks: item.practical,
                      homeWorkMarks: item.homeWork,
                      fatherName: item.fatherName,
                    );
                  },
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 10),
              padding:
                  EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
              decoration: BoxDecoration(
                border: Border.all(width: 0.2),
              ),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.baseline,
                      // textBaseline: TextBaseline.ideographic,
                      children: [
                        Text(
                          '(${item.admNo}) ',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w600),
                        ),
                        Flexible(
                          child: Text(
                            ' ${item.studentName!.toUpperCase()}',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.deepOrangeAccent),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Container(
                  //   width: MediaQuery.of(context).size.width * 0.95,
                  //   child: Row(
                  //     children: [
                  //       Flexible(
                  //           child: Text(
                  //         '${itm[3]}',
                  //         style: TextStyle(
                  //             fontSize: 15, fontWeight: FontWeight.w600),
                  //       )),
                  //       SizedBox(
                  //         width: MediaQuery.of(context).size.width * 0.03,
                  //       ),
                  //       Column(
                  //         children: [
                  //           Text(
                  //             'Marks \n'
                  //             ' Obt.',
                  //             style: TextStyle(fontWeight: FontWeight.w600),
                  //           ),
                  //           Text(
                  //             '${itm[4]}',
                  //             style: TextStyle(fontWeight: FontWeight.w600),
                  //           )
                  //         ],
                  //       ),
                  //       SizedBox(
                  //         width: MediaQuery.of(context).size.width * 0.02,
                  //       ),
                  //       internalBoolVal == true
                  //           ? Column(
                  //               children: [
                  //                 Text(
                  //                   'Internal \n '
                  //                   'Marks',
                  //                   style: TextStyle(
                  //                       fontWeight: FontWeight.w600),
                  //                 ),
                  //                 Text(
                  //                   '${itm[5]}',
                  //                   style: TextStyle(
                  //                       fontWeight: FontWeight.w600),
                  //                 )
                  //               ],
                  //             )
                  //           : Container(),
                  //       SizedBox(
                  //         width: MediaQuery.of(context).size.width * 0.02,
                  //       ),
                  //       practicalBoolVal == true
                  //           ? Column(
                  //               children: [
                  //                 Text(
                  //                   'Practical \n '
                  //                   'Marks',
                  //                   style: TextStyle(
                  //                       fontWeight: FontWeight.w600),
                  //                 ),
                  //                 Text(
                  //                   '${itm[6]}',
                  //                   style: TextStyle(
                  //                       fontWeight: FontWeight.w600),
                  //                 )
                  //               ],
                  //             )
                  //           : Container(),
                  //       SizedBox(
                  //         width: MediaQuery.of(context).size.width * 0.02,
                  //       ),
                  //       homeworkBoolVal == true
                  //           ? Column(
                  //               children: [
                  //                 Text(
                  //                   'Homework\n'
                  //                   'Marks',
                  //                   style: TextStyle(
                  //                       fontWeight: FontWeight.w600),
                  //                 ),
                  //                 Text(
                  //                   '${itm[7]}',
                  //                   style: TextStyle(
                  //                       fontWeight: FontWeight.w600),
                  //                 )
                  //               ],
                  //             )
                  //           : Container(),
                  //     ],
                  //   ),
                  // )
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.004,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Marks '
                            ' Obt. : ',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 15),
                          ),
                          Text(
                            '${item.marksObt != null ? item.marksObt : ""}',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 15),
                          ),
                        ],
                      ),
                      Text(
                        'Exam Roll No. : ${item.examRollNo}',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.02,
                  ),
                  internalBoolVal == true
                      ? Row(
                          children: [
                            Text(
                              'Internal'
                              'Marks : ',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            Text(
                              '${item.internalMarks}',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            )
                          ],
                        )
                      : Container(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.02,
                  ),
                  practicalBoolVal == true
                      ? Row(
                          children: [
                            Text(
                              'Practical'
                              'Marks : ',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            Text(
                              '${item.practical}',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            )
                          ],
                        )
                      : Container(),
                  homeworkBoolVal == true
                      ? Row(
                          children: [
                            Text(
                              'Homework'
                              'Marks : ',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            Text(
                              '${item.homeWork}',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            )
                          ],
                        )
                      : Container(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Container buildClassDropDown() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 19, top: 8, bottom: 10),
      width: MediaQuery.of(context).size.width * 0.35,
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
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xffECECEC)),
              borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButton<LoadClassForSmsModel>(
              isDense: true,
              value: selectedClass,
              key: UniqueKey(),
              isExpanded: true,
              underline: Container(),
              items: classItems!
                  .map((e) => DropdownMenuItem(
                        child: Text(
                          '${e.classname}',
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                        value: e,
                      ))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  selectedClass = val;
                  classId = val!.classId;
                });
                setState(() {
                  examMarksList = [];
                });
                getExam(classId: classId);
              },
            ),
          ),
        ],
      ),
    );
  }

  Container buildCoordinatorClassDropDown() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 19, top: 8, bottom: 10),
      width: MediaQuery.of(context).size.width * 0.35,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Class',
            // style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xffECECEC)),
              // borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButton<ClassesForCoordinatorModel>(
              isDense: true,
              value: _selectedClassCoordinator,
              key: UniqueKey(),
              isExpanded: true,
              underline: Container(),
              items: classListCoordinator
                  .map((e) => DropdownMenuItem(
                        child: Text('${e.className}'),
                        value: e,
                      ))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  _selectedClassCoordinator = val;
                  // classId = val!.classId;
                });
                setState(() {
                  examMarksList = [];
                });
                getExam(classId: _selectedClassCoordinator!.classId);
              },
            ),
          ),
        ],
      ),
    );
  }

  Container buildExamDropDown() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 19, top: 8, bottom: 10),
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
            child: DropdownButton<GetExamTypeAdminModel>(
              isDense: true,
              value: selectedExam,
              key: UniqueKey(),
              isExpanded: true,
              underline: Container(),
              items: examItems!
                  .map((e) => DropdownMenuItem(
                        child: Text(
                          '${e.exam}',
                          style: TextStyle(fontSize: 14),
                        ),
                        value: e,
                      ))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  selectedExam = val;
                  examId = val!.examId;
                });
                setState(() {
                  examMarksList = [];
                });
                getSubject(
                    classid: UserType!.toUpperCase() == "A"
                        ? classId
                        : _selectedClassCoordinator!.classId,
                    examid: examId);
              },
            ),
          ),
        ],
      ),
    );
  }

  Container buildSubjectDropDown() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 19, top: 8, bottom: 10),
      width: MediaQuery.of(context).size.width * 0.4,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Subject',
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
            child: DropdownButton<GetSubjectAdminModel>(
              isDense: true,
              value: selectedSubject,
              key: UniqueKey(),
              isExpanded: true,
              underline: Container(),
              items: subjectItems
                  .map((e) => DropdownMenuItem(
                        child: Text('${e.subjectName}'),
                        value: e,
                      ))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  selectedSubject = val;
                  subjectId = val!.id;
                });
                setState(() {
                  examMarksList = [];
                });
                getExamMarks(
                    classid: classId, examid: examId, subjectid: subjectId);
                getMinMaxMarks(
                    classid: classId, examid: examId, subjectid: subjectId);
              },
            ),
          ),
        ],
      ),
    );
  }

  Container testContainer() {
    return Container(
      child: Text("Select Classes"),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(border: Border.all(width: 0.05)),
      padding: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * 0.3,
      height: MediaQuery.of(context).size.height * 0.055,
    );
  }
}
