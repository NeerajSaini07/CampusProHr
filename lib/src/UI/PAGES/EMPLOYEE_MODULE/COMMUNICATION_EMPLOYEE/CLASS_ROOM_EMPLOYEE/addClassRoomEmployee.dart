import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/DATA/BLOC_CUBIT/CLASS_LIST_EMPLOYEE_CUBIT/class_list_employee_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/SAVE_CLASS_ROOM_CUBIT/save_class_room_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/STUDENT_LIST_MEETING_CUBIT/student_list_meeting_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/SUBJECT_LIST_EMPLOYEE_CUBIT/subject_list_employee_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/SubjectListEmployeeModel.dart';
import 'package:campus_pro/src/DATA/MODELS/classListEmployeeModel.dart';
import 'package:campus_pro/src/DATA/MODELS/searchEmployeeFromRecordsCommonModel.dart';
import 'package:campus_pro/src/DATA/MODELS/studentListMeetingModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonSnackbar.dart';
import 'package:campus_pro/src/UI/WIDGETS/searchEmployeeFromRecordsCommon.dart';
import 'package:campus_pro/src/UTILS/fieldValidators.dart';
import 'package:campus_pro/src/UTILS/filePicker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddClassRoom extends StatefulWidget {
  static const routeName = '/Add-Class-Room-Employee';
  const AddClassRoom({Key? key}) : super(key: key);

  @override
  _AddClassRoomState createState() => _AddClassRoomState();
}

class _AddClassRoomState extends State<AddClassRoom> {
  TextEditingController _textController = TextEditingController();

  //Subject Dropdown
  List<SubjectListEmployeeModel> subjectList = [];
  late SubjectListEmployeeModel selectSubject;
  String? subjectId;

  int noOfMaleTeacher = 0;
  int noOfFemaleTeacher = 0;
  List<File> _selectedImage = [];

  GlobalKey<FormFieldState> _classSelectKey = GlobalKey<FormFieldState>();
  GlobalKey<FormFieldState> _teacherSelectKey = GlobalKey<FormFieldState>();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //MultiSelect Class
  List<ClassListEmployeeModel>? classList = [];
  List finalClassList = [];
  List allClassList = [];
  //

  //MultiSelect Teacher
  List<StudentListMeetingModel>? teacherList = [];
  List finalTeacherList = [];
  //

  List<Map<String, String>> studentList = [];

  //
  List<String> classIds = [];
  List streamIds = [];
  List sectionIds = [];
  List yearIds = [];
  //

  String? userType = '';
  bool? classCheck = false;
  //EmployeeInfoForSearchModel? selectedEmployee;
  SearchEmployeeFromRecordsCommonModel? selectedEmployee;
  bool buttonLoader = false;
  String? empIdForAdminSearch;

  List<bool> customStudentListBool = [];

  getEmployeeClass({String? empIdForAdmin}) async {
    print(empIdForAdmin);
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final getEmpClassData = {
      "OUserId": uid!,
      "Token": token!,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "SessionId": userData.currentSessionid,
      "EmpID": empIdForAdmin != null
          ? empIdForAdmin
          : userData.ouserType!.toLowerCase() == 'e'
              ? userData.stuEmpId
              : null,
    };
    print('Employee Class List $getEmpClassData');
    context
        .read<ClassListEmployeeCubit>()
        .classListEmployeeCubitCall(getEmpClassData);
  }

  getEmployeeSubject(
      {@required String? classId,
      @required String? streamId,
      @required String? sectionId,
      @required String? yearID}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final getEmpSubData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "ClassID": classId.toString(),
      "StreamID": streamId.toString(),
      "SectionID": sectionId.toString(),
      "YearID": yearID.toString(),
      "Schoolid": userData.schoolId,
      "SessionId": userData.currentSessionid,
      "EmpId": userData.stuEmpId,
      "UserType": userData.ouserType,
      "TeacherId": userData.stuEmpId,
    };
    print('Get Employee Subject $getEmpSubData');
    context
        .read<SubjectListEmployeeCubit>()
        .subjectListEmployeeCubitCall(getEmpSubData);
  }

  getStudentsList({
    @required String? classId,
    @required String? streamId,
    @required String? sectionId,
    @required String? yearId,
    @required int? subjectId,
  }) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final getStudentData = {
      "OUserId": uid!,
      "Token": token!,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "SessionId": userData.currentSessionid,
      "ClassId": classId,
      "StreamId": streamId,
      "SectionId": sectionId,
      "YearId": yearId,
      "StuEmpId": userData.stuEmpId,
      "UserType": userData.ouserType,
      "SubjectId": subjectId.toString(),
    };

    print(getStudentData['ClassId']);

    print('Sending Student ListMeeting data $getStudentData');
    if (getStudentData['ClassId'] != "") {
      context
          .read<StudentListMeetingCubit>()
          .studentListMeetingCubitCall(getStudentData);
    }
  }

  saveClassRoom(
      {String? subjectid,
      String? circularcontent,
      String? classid,
      List<Map<String, String>>? studentids}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final sendingClassRoomData = {
      "UserId": uid!,
      "Token": token!,
      "OrgId": userData!.organizationId!,
      "SchoolId": userData.schoolId!,
      "SessionId": userData.currentSessionid!,
      "CircularDate":
          DateFormat('dd-MMM-yyyy').format(DateTime.now()).toString(),
      "CirNo": "",
      "CirSubject": subjectid!,
      "CirContent": circularcontent!,
      "FileFormat": "",
      "For": 'S',
      "ForAll": '0',
      "EmpId": userData.stuEmpId!,
      "StuId": "",
      "ClassId": classid.toString(),
      "StudentIds": jsonEncode(studentids),
      "GroupId": "0",
      "UserType": userData.ouserType!,
    };
    print('sending data for save class room $sendingClassRoomData');

    context
        .read<SaveClassRoomCubit>()
        .saveClassRoomCubitCall(sendingClassRoomData, _selectedImage);
  }

  getUserType() async {
    final userData = await UserUtils.userTypeFromCache();
    setState(() {
      userType = userData!.ouserType;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserType();
    classList = [];
    finalClassList = [];
    // if (userType!.toLowerCase() == 'e') {
    //   getEmployeeClass();
    // }
    getEmployeeClass();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, title: 'Add ClassRoom'),
      body: MultiBlocListener(
        listeners: [
          // BlocListener<EmployeeInfoForSearchCubit, EmployeeInfoForSearchState>(
          //   listener: (context, state) {
          //     if (state is EmployeeInfoForSearchLoadFail) {
          //       if (state.failReason == "false") {
          //         UserUtils.unauthorizedUser(context);
          //       }
          //     }
          //     if (state is EmployeeInfoForSearchLoadSuccess) {
          //       setState(() {
          //         //selectedEmployee = state.employeeInfoData;
          //         empIdForAdminSearch = state.employeeInfoData.empId.toString();
          //       });
          //       getEmployeeClass(empIdForAdmin: empIdForAdminSearch);
          //     }
          //     if (state is EmployeeInfoForSearchLoadFail) {
          //       if (state.failReason == 'false') {
          //         UserUtils.unauthorizedUser(context);
          //       }
          //     }
          //   },
          // ),
          BlocListener<SaveClassRoomCubit, SaveClassRoomState>(
              listener: (context, state) async {
            if (state is SaveClassRoomLoadInProgress) {
              setState(() {
                buttonLoader = true;
              });
            }
            if (state is SaveClassRoomLoadSuccess) {
              setState(() {
                buttonLoader = false;
                _textController.text = "";
                finalClassList = [];
                classList = [];
                allClassList = [];
                teacherList = [];
                finalTeacherList = [];
                subjectList = [];
                _selectedImage = [];
                noOfMaleTeacher = 0;
                noOfFemaleTeacher = 0;
                studentList = [];
                customStudentListBool = [];
                //
                selectedEmployee = null;
              });

              print(finalClassList);
              ScaffoldMessenger.of(context).showSnackBar(commonSnackBar(
                title: 'ClassRoom Sent',
                duration: Duration(seconds: 1),
              ));
              getEmployeeClass();

              ///

              // final uid = await UserUtils.idFromCache();
              // final token = await UserUtils.userTokenFromCache();
              // final userData = await UserUtils.userTypeFromCache();
              //
              // final classData = {
              //   'OUserId': uid,
              //   'Token': token,
              //   'OrgId': userData!.organizationId,
              //   'Schoolid': userData.schoolId,
              //   'NoRows': "20",
              //   'Counts': "0",
              //   'EmpId': userData.stuEmpId,
              //   'SubjectId': "",
              //   'ClassId': "",
              //   'StreamId': "",
              //   'SectionId': "",
              //   'YearId': "",
              //   'LastId': "",
              //   'SessionId': userData.currentSessionid,
              //   'UserType': userData.ouserType,
              //   'TeacherId': userData.ouserType!.toLowerCase() == "e"
              //       ? userData.stuEmpId
              //       : selectedEmployee!.empId.toString(),
              // };
              // context
              //     .read<ClassroomEmployeeCubit>()
              //     .classroomEmployeeCubitCall(classData);

              ///
            }
            if (state is SaveClassRoomLoadFail) {
              if (state.failReason == 'false') {
                UserUtils.unauthorizedUser(context);
              }
            }
          }),
        ],
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: userType!.toLowerCase() == 'a' ? 10 : 0,
                ),
                userType!.toLowerCase() == 'e'
                    ? Container()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(
                              'Search Employee',
                              // style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          GestureDetector(
                            onTap: () async {
                              var data = await Navigator.pushNamed(context,
                                      SearchEmployeeFromRecordsCommon.routeName)
                                  as SearchEmployeeFromRecordsCommonModel;

                              setState(() {
                                noOfMaleTeacher = 0;
                                noOfFemaleTeacher = 0;
                                studentList = [];
                                selectSubject = SubjectListEmployeeModel(
                                    subjectId: -1, subjectHead: "");
                                subjectList = [];
                              });

                              setState(() {
                                selectedEmployee = data;

                                empIdForAdminSearch = data.empId.toString();
                              });
                              print('going $data');
                              getEmployeeClass(
                                  empIdForAdmin: empIdForAdminSearch);
                            },
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black12),
                              ),
                              child: Text("Search Employee Here..."),
                            ),
                          ),
                          if (selectedEmployee != null)
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(
                                "● ${selectedEmployee!.name!} - ${selectedEmployee!.mobileNo!}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                        ],
                      ),
                SizedBox(
                  height: userType!.toLowerCase() == 'a' ? 15 : 0,
                ),
                BlocConsumer<ClassListEmployeeCubit, ClassListEmployeeState>(
                  listener: (context, state) {
                    if (state is ClassListEmployeeLoadSuccess) {
                      setState(() {
                        noOfMaleTeacher = 0;
                        noOfFemaleTeacher = 0;
                        studentList = [];
                        customStudentListBool = [];
                      });
                      setState(() {
                        classList = state.classList;
                      });
                    }
                    if (state is ClassListEmployeeLoadFail) {
                      if (state.failReason == "false") {
                        UserUtils.unauthorizedUser(context);
                      }
                      setState(() {
                        classList = [];
                      });
                    }
                  },
                  builder: (context, state) {
                    if (state is ClassListEmployeeLoadInProgress) {
                      return testContainer();
                    } else if (state is ClassListEmployeeLoadSuccess) {
                      return buildClassMultiSelect();
                    } else if (state is ClassListEmployeeLoadFail) {
                      return buildClassMultiSelect();
                    } else {
                      return Container();
                    }
                  },
                ),
                // buildClassMultiSelect(),
                //loadStateContainer(label: 'Class'),
                SizedBox(
                  height: subjectList.length > 0
                      ? MediaQuery.of(context).size.height * 0.015
                      : 0,
                ),
                // Container(
                //   margin: EdgeInsets.symmetric(horizontal: 20),
                //   child: Text(
                //     'Subject',
                //     style: TextStyle(
                //       fontWeight: FontWeight.w600,
                //       fontSize: 15,
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   height: MediaQuery.of(context).size.height * 0.01,
                // ),
                BlocConsumer<SubjectListEmployeeCubit,
                    SubjectListEmployeeState>(
                  listener: (context, state) {
                    if (state is SubjectListEmployeeLoadSuccess) {
                      setState(() {
                        selectSubject = state.subjectList[0];
                        subjectList = state.subjectList;
                        subjectId = state.subjectList[0].subjectId.toString();
                      });

                      getStudentsList(
                        classId: classIds.join(','),
                        streamId: streamIds.join(','),
                        sectionId: sectionIds.join(','),
                        yearId: yearIds.join(','),
                        subjectId:
                            int.parse(selectSubject.subjectId!.toString()),
                      );
                      //
                    }
                    if (state is SubjectListEmployeeLoadFail) {
                      if (state.failReason == "false") {
                        UserUtils.unauthorizedUser(context);
                      }
                      setState(() {
                        subjectList = [];
                        selectSubject = SubjectListEmployeeModel(
                            subjectHead: "", subjectId: -1);
                        teacherList = [];
                        noOfMaleTeacher = 0;
                        noOfFemaleTeacher = 0;
                      });
                    }
                  },
                  builder: (context, state) {
                    if (state is SubjectListEmployeeLoadInProgress) {
                      return buildSubjectDropDown();
                    } else if (state is SubjectListEmployeeLoadSuccess) {
                      return buildSubjectDropDown();
                    } else if (state is SubjectListEmployeeLoadFail) {
                      return buildSubjectDropDown();
                    } else {
                      return Container();
                    }
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                //loadStateContainer(label: 'Teacher'),
                BlocConsumer<StudentListMeetingCubit, StudentListMeetingState>(
                  listener: (context, state) {
                    if (state is StudentListMeetingLoadSuccess) {
                      //
                      state.studentList.insert(
                          0,
                          StudentListMeetingModel(
                            classid: -1,
                            yearid: -1,
                            streamid: -1,
                            stName: "",
                            studentId: -1,
                            onlyStName: "All",
                            classsectionid: -1,
                            clsName: "",
                            isSelected: false,
                            admno: "",
                            emailid: "",
                            gender: "",
                            fatherName: "",
                            guardianMobileNo: "",
                          ));

                      for (int v = 0; v < state.studentList.length; v++) {
                        setState(() {
                          customStudentListBool.add(true);
                        });
                      }

                      setState(() {
                        teacherList = state.studentList;
                        finalTeacherList = state.studentList;
                      });
                      // teacherList!.forEach((element) {
                      //   print(element.stName);
                      // });
                      print(state.studentList.length);
                      setState(() {
                        noOfFemaleTeacher = 0;
                        noOfMaleTeacher = 0;
                      });
                      setState(() {
                        state.studentList.forEach((element) {
                          if (element.gender!.toLowerCase() == "male") {
                            noOfMaleTeacher += 1;
                          } else if (element.gender!.toLowerCase() ==
                              "female") {
                            noOfFemaleTeacher += 1;
                          }
                        });
                      });
                      setState(() {
                        studentList = [];
                      });

                      state.studentList.forEach((element) {
                        setState(() {
                          if (element.stName != "All") {
                            studentList.add(
                                {"StudentID": element.studentId.toString()});
                          }
                        });
                      });
                      //
                    }
                    if (state is StudentListMeetingLoadFail) {
                      if (state.failReason == "false") {
                        UserUtils.unauthorizedUser(context);
                      } else {
                        setState(() {
                          teacherList = [];
                        });
                      }
                    }
                  },
                  builder: (context, state) {
                    if (state is StudentListMeetingLoadInProgress) {
                      return testTeacher();
                    } else if (state is StudentListMeetingLoadSuccess) {
                      // return buildTeacherMultiSelect();
                      return buttonModalBottomSheet(classList: teacherList);
                    } else if (state is StudentListMeetingLoadFail) {
                      // return buildTeacherMultiSelect();
                      return buildTeacherMultiSelect();
                    } else {
                      return Container();
                    }
                  },
                ),
                // buildTeacherMultiSelect(),
                SizedBox(
                  height: teacherList!.length > 0
                      ? MediaQuery.of(context).size.height * 0.02
                      : 0,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Content',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                buildContextFormField(context),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                _selectedImage.length == 0
                    ? buildAddFileButton(context)
                    : Center(
                        child: Column(
                          children: [
                            SizedBox(
                                width: _selectedImage[0]
                                            .path
                                            .split('.')
                                            .last
                                            .toLowerCase() !=
                                        'pdf'
                                    ? MediaQuery.of(context).size.width * 0.2
                                    : MediaQuery.of(context).size.width *
                                        0.055),
                            _selectedImage[0]
                                        .path
                                        .split('.')
                                        .last
                                        .toLowerCase() !=
                                    'pdf'
                                ? Container(
                                    height: 150,
                                    width: 150,
                                    decoration: BoxDecoration(
                                        border: Border.all(width: 0.2)),
                                    child: Image.file(
                                      _selectedImage[0],
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Row(
                                    children: [
                                      SizedBox(
                                        width: 25,
                                      ),
                                      Icon(
                                        Icons.picture_as_pdf,
                                        size: 45,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(width: 0.01),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        // margin: EdgeInsets.all(10),
                                        padding: EdgeInsets.all(4),
                                        height: 50,
                                        width: 180,
                                        child: Center(
                                          child: Text(
                                            '${_selectedImage[0].path.split('/')[7].split('.')[0]}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                            SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedImage = [];
                                });
                              },
                              child: PhysicalModel(
                                color: Colors.transparent,
                                elevation: 20,
                                shadowColor: Colors.white10,
                                child: Container(
                                  color: Colors.white24,
                                  // decoration: BoxDecoration(
                                  //
                                  //   border: Border.all(width: 0.1),
                                  //   borderRadius: BorderRadius.circular(4),
                                  // ),
                                  margin: EdgeInsets.all(10),
                                  padding: EdgeInsets.all(8),
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                    size: 30,
                                  ),
                                  // Text(
                                  //   'Remove Image',
                                  //   style: TextStyle(
                                  //       color: Colors.white,
                                  //       fontWeight: FontWeight.w600),
                                  // ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                buttonLoader == false
                    ? buildPostButton(context)
                    : Center(
                        child: CircularProgressIndicator(),
                      ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column buildSubjectDropDown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Subject',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
        Container(
          height: 40,
          margin: EdgeInsets.symmetric(horizontal: 20),
          padding: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
              border: Border.all(width: 0.1),
              borderRadius: BorderRadius.circular(4)),
          child: DropdownButton<SubjectListEmployeeModel>(
            value: selectSubject,
            isExpanded: true,
            underline: Container(),
            items: subjectList
                .map((e) => DropdownMenuItem<SubjectListEmployeeModel>(
                      child: Text('${e.subjectHead}'),
                      value: e,
                    ))
                .toList(),
            onChanged: (val) {
              setState(() {
                selectSubject = val!;
                subjectId = val.subjectId.toString();
              });
              getStudentsList(
                classId: classIds.join(','),
                streamId: streamIds.join(','),
                sectionId: sectionIds.join(','),
                yearId: yearIds.join(','),
                subjectId: int.parse(subjectId!),
              );
            },
          ),
        ),
      ],
    );
  }

  GestureDetector buildPostButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_formKey.currentState!.validate()) {
          print('Hello');
          if (studentList.length > 0) {
            saveClassRoom(
                subjectid: subjectId,
                circularcontent: _textController.text,
                classid: allClassList.join(','),
                studentids: studentList);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              commonSnackBar(
                title: "Choose Atleast One Student",
                duration: Duration(seconds: 1),
              ),
            );
          }
        }
      },
      child: Center(
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(width: 0.2),
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).primaryColor),
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.only(left: 25.0, right: 25, top: 10.0, bottom: 7),
          child: Text(
            'POST',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16),
          ),
        ),
      ),
    );
  }

  GestureDetector buildAddFileButton(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        List<File>? file = await showFilePicker(allowMultiple: false);
        if (file != null) {
          setState(() {
            _selectedImage = file;
          });
        }
      },
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.3,
          decoration: BoxDecoration(
              border: Border.all(width: 0.2),
              borderRadius: BorderRadius.circular(20),
              color: Colors.green),
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(8),
          child: Center(
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              // Text(
              //   '  + ',
              //   style: TextStyle(
              //       color: Colors.white,
              //       fontWeight: FontWeight.w900,
              //       fontSize: 20),
              // ),

              RichText(
                text: TextSpan(
                  text: '  + ',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 20),
                ),
              ),
              RichText(
                text: TextSpan(
                  text: 'Add File',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }

  Container buildContextFormField(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        controller: _textController,
        style: TextStyle(color: Colors.black),
        validator: FieldValidators.globalValidator,
        maxLines: 5,
        decoration: InputDecoration(
          hintText: 'Content',
          hintStyle: TextStyle(color: Color(0xffA5A5A5)),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          border: new OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(18.0),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xffECECEC),
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
        ),
      ),
    );
  }

  Container loadStateContainer({String? label}) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.06,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
          border: Border.all(width: 0.1),
          borderRadius: BorderRadius.circular(4)),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: EdgeInsets.all(10),
      child: Text(
        '$label',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget buildClassMultiSelect() {
    return Container(
      alignment: Alignment.center,
      // padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: MultiSelectBottomSheetField(
        autovalidateMode: AutovalidateMode.disabled,
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xffECECEC)),
        ),
        key: _classSelectKey,
        initialChildSize: 0.7,
        maxChildSize: 0.95,
        searchIcon: Icon(Icons.ac_unit),
        title: Text("All Classes",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 18)),
        buttonText: Text(
          "Select Classes",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        items: classList!.map((e) => MultiSelectItem(e, e.className!)).toList(),
        searchable: false,
        validator: (values) {
          if (values == null || values.isEmpty || finalClassList.isEmpty) {
            return "Required Field";
          }
          return null;
        },
        onConfirm: (values) {
          setState(() {
            allClassList = [];
          });
          setState(() {
            finalClassList = [];
          });
          setState(() {
            finalClassList = values;
          });

          setState(() {
            classIds = [];
            sectionIds = [];
            streamIds = [];
            yearIds = [];
          });

          finalClassList.forEach((element) {
            setState(() {
              classIds.add(element.iD!.split('#')[0]);
              streamIds.add(element.iD!.split('#')[1]);
              sectionIds.add(element.iD!.split('#')[2]);
              yearIds.add(element.iD!.split('#')[4]);
            });
          });

          finalClassList.forEach((element) {
            setState(() {
              allClassList.add(element.iD);
            });
          });

          // Multi select class
          setState(() {
            noOfMaleTeacher = 0;
            noOfFemaleTeacher = 0;
            studentList = [];
            customStudentListBool = [];
          });
          //

          getEmployeeSubject(
            classId: classIds.join(','),
            streamId: streamIds.join(','),
            sectionId: sectionIds.join(','),
            yearID: yearIds.join(','),
          );
        },
        chipDisplay: MultiSelectChipDisplay(
          onTap: (value) {
            //
            setState(() {
              allClassList = [];
            });
            // setState(() {
            //   finalClassList = [];
            // });
            //
            setState(() {
              finalClassList.remove(value);
            });

            setState(() {
              classIds = [];
              sectionIds = [];
              streamIds = [];
              yearIds = [];
            });

            finalClassList.forEach((element) {
              setState(() {
                classIds.add(element.iD!.split('#')[0]);
                streamIds.add(element.iD!.split('#')[1]);
                sectionIds.add(element.iD!.split('#')[2]);
                yearIds.add(element.iD!.split('#')[4]);
              });
            });

            finalClassList.forEach((element) {
              setState(() {
                allClassList.add(element.iD);
              });
            });

            // Multi select class
            setState(() {
              noOfMaleTeacher = 0;
              noOfFemaleTeacher = 0;
              studentList = [];
              customStudentListBool = [];
            });
            //

            getEmployeeSubject(
              classId: classIds.join(','),
              streamId: streamIds.join(','),
              sectionId: sectionIds.join(','),
              yearID: yearIds.join(','),
            );
          },
          shape: RoundedRectangleBorder(),
          textStyle: TextStyle(
              fontWeight: FontWeight.w900,
              color: Theme.of(context).primaryColor),
        ),
      ),
    );
  }

  Widget buildTeacherMultiSelect() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Select Student (B:$noOfMaleTeacher)/(G:$noOfFemaleTeacher)',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          // padding: EdgeInsets.symmetric(horizontal: 10),
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: MultiSelectBottomSheetField<StudentListMeetingModel>(
              initialValue: teacherList!,
              autovalidateMode: AutovalidateMode.disabled,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xffECECEC)),
              ),
              key: _teacherSelectKey,
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
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              items: teacherList!
                  .map((e) => MultiSelectItem(e, e.stName!))
                  .toList(),
              searchable: false,
              validator: (values) {
                if (values == null ||
                    values.isEmpty ||
                    finalTeacherList.isEmpty) {
                  return "Required Field";
                }
                return null;
              },
              onConfirm: (values) {
                setState(() {
                  finalTeacherList = [];
                });
                setState(() {
                  finalTeacherList = values;
                });

                setState(() {
                  studentList = [];
                });
                values.forEach((element) {
                  setState(() {
                    studentList
                        .add({"StudentID": element.studentId.toString()});
                  });
                });

                setState(() {
                  noOfFemaleTeacher = 0;
                  noOfMaleTeacher = 0;
                });

                values.forEach((element) {
                  setState(() {
                    if (element.gender!.toLowerCase() == "male") {
                      noOfMaleTeacher += 1;
                    } else {
                      noOfFemaleTeacher += 1;
                    }
                  });
                });
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

  //Todo:Custom multi select
  Widget buttonModalBottomSheet({List<StudentListMeetingModel>? classList}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Select Student (B:$noOfMaleTeacher)/(G:$noOfFemaleTeacher)',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
        Center(
          child: GestureDetector(
            onTap: () async {
              await customMultiSelect(classList: classList);
              setState(() {
                noOfMaleTeacher = noOfMaleTeacher;
                noOfFemaleTeacher = noOfFemaleTeacher;
              });
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(border: Border.all(width: 0.05)),
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.055,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Select Student",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Icon(Icons.arrow_downward)
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<Widget?> customMultiSelect(
      {List<StudentListMeetingModel>? classList}) {
    //showModalBottomSheet
    return showModalBottomSheet<Widget>(
        context: context,
        isDismissible: false,
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                children: [
                  Center(
                    child: Text(
                      'Class List',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(
                        height: 2,
                      ),
                      itemCount: classList!.length,
                      itemBuilder: (context, index) {
                        var item = classList[index];
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  '${item.onlyStName} ${item.onlyStName != "All" ? "(${item.fatherName})" : ""}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Checkbox(
                                value: customStudentListBool[index],
                                onChanged: (val) {
                                  setState(
                                    () {
                                      // customClassListBool[index] =
                                      //     !customClassListBool[index];
                                      if (item.onlyStName == "All") {
                                        if (customStudentListBool[index] ==
                                            true) {
                                          for (int i = 0;
                                              i < customStudentListBool.length;
                                              i++) {
                                            customStudentListBool[i] = false;
                                          }
                                        } else {
                                          for (int i = 0;
                                              i < customStudentListBool.length;
                                              i++) {
                                            customStudentListBool[i] = true;
                                          }
                                        }
                                      } else {
                                        customStudentListBool[index] =
                                            !customStudentListBool[index];
                                      }
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          width: 0.2,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: Center(
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(
                                    //color: Colors.black,
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              finalTeacherList = [];
                            });

                            setState(() {
                              studentList = [];
                            });

                            for (int i = 0; i < teacherList!.length; i++) {
                              if (customStudentListBool[i] == true) {
                                if (teacherList![i].onlyStName != "All") {
                                  setState(() {
                                    studentList.add({
                                      "StudentID":
                                          "${teacherList![i].studentId.toString()}"
                                    });
                                    finalTeacherList.add(teacherList![i]);
                                  });
                                }
                              }
                            }

                            setState(() {
                              noOfFemaleTeacher = 0;
                              noOfMaleTeacher = 0;
                            });

                            for (int i = 0; i < teacherList!.length; i++) {
                              if (customStudentListBool[i] == true) {
                                setState(() {
                                  if (teacherList![i].gender!.toLowerCase() ==
                                      "male") {
                                    noOfMaleTeacher += 1;
                                  } else if (teacherList![i]
                                          .gender!
                                          .toLowerCase() ==
                                      "female") {
                                    noOfFemaleTeacher += 1;
                                  }
                                });
                              }
                            }
                            Navigator.pop(context);
                          },
                          child: Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: Center(
                                child: Text(
                                  'OK',
                                  style: TextStyle(
                                    //color: Colors.black,
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )),
                        ),
                      ],
                    ),
                  )
                ],
              );
            },
          );
        });
  }

  ///

  Column testContainer() {
    return Column(
      children: [
        Container(
          child: Text(
            "Select Classes",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          decoration: BoxDecoration(border: Border.all(width: 0.05)),
          padding: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.062,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        )
      ],
    );
  }

  Column testTeacher() {
    return Column(
      children: [
        Container(
          child: Text(
            "Select Teacher",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          decoration: BoxDecoration(border: Border.all(width: 0.05)),
          padding: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width * 0.9,
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
