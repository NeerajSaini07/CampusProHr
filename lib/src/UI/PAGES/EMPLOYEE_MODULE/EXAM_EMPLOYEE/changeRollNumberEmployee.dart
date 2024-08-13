import 'dart:convert';

import 'package:campus_pro/src/DATA/BLOC_CUBIT/RESULT_ANNOUNCE_CLASS_CUBIT/result_announce_class_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/STUDENT_LIST_FOR_CHANGE_ROLL_NO_CUBIT/student_list_for_change_roll_no_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/UPDATE_ROLL_NO_EMPLOYEE_CUBIT/update_roll_no_employee_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/resultAnnounceClassModel.dart';
import 'package:campus_pro/src/DATA/MODELS/studentListForChangeRollNoModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonSnackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeRollNumberEmployee extends StatefulWidget {
  static const routeName = '/change-roll-number-employee';
  const ChangeRollNumberEmployee({Key? key}) : super(key: key);

  @override
  _ChangeRollNumberEmployeeState createState() =>
      _ChangeRollNumberEmployeeState();
}

class _ChangeRollNumberEmployeeState extends State<ChangeRollNumberEmployee> {
  List<TextEditingController>? _controllers;
  List<TextEditingController>? _controllersOldRollNo;

  // static const item = [
  //   '1',
  //   '11',
  //   '111',
  //   'V1',
  //   'V',
  // ];

  //student
  List<StudentListForChangeRollNoModel>? studentList = [];
  // List demoList = [
  //   ['2231', 'Name', 'fatherName', '1'],
  //   ['2231', 'Name1', 'fatherName', '2'],
  //   ['2231', 'Name2', 'fatherName', '3'],
  // ];

  //class
  ResultAnnounceClassModel? selectedClass;
  List<ResultAnnounceClassModel>? classItems = [];

  //
  String? classId = "";
  //List<Map<String, String>> finalAllClassList = [];
  List<Map<String, String>>? finalAllClassList = [];
  bool isLoader = false;

  // = item
  //     .map(
  //       (String e) => DropdownMenuItem(
  //         child: Text('$e'),
  //         value: e,
  //       ),
  //     )
  //     .toList();

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
      "classteacher": "1",
      "SessionId": userData.currentSessionid,
    };

    print('sending class data for change roll no $sendingClassData');

    context
        .read<ResultAnnounceClassCubit>()
        .resultAnnounceClassCubitCall(sendingClassData);
  }

  getClassStudentChangeRollNo({String? classid}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final sendingClassStudentData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "SessionId": userData.currentSessionid,
      "EmpId": userData.stuEmpId,
      "ClassId": classid,
      "UserType": userData.ouserType,
    };

    print(
        'sending data for change roll no student List $sendingClassStudentData');

    context
        .read<StudentListForChangeRollNoCubit>()
        .studentListForChangeRollNoCubitCall(sendingClassStudentData);
  }

  saveRollNo({List<Map<String, String?>>? classlist}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final sendingSaveRollNoData = {
      "UserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "SchoolId": userData.schoolId,
      "SessionId": userData.currentSessionid,
      "EmpId": userData.stuEmpId,
      "UserType": userData.ouserType,
      "JsonString": jsonEncode(classlist),
      // [{"StudentId":"3069","NewRollNo":"1","OldRollNo":"0"},{"StudentId":"3034","NewRollNo":"2","OldRollNo":"133"},
      //   {"StudentId":"3013","NewRollNo":"3","OldRollNo":"144"},{"StudentId":"2993","NewRollNo":"4","OldRollNo":"155"},
      //   {"StudentId":"2994","NewRollNo":"5","OldRollNo":"166"},{"StudentId":"2995","NewRollNo":"6","OldRollNo":"177"}],
    };

    print('sending data for update roll no $sendingSaveRollNoData');
    context
        .read<UpdateRollNoEmployeeCubit>()
        .updateRollNoEmployeeCubitCall(sendingSaveRollNoData);
  }

  @override
  void initState() {
    _controllers = [];
    _controllersOldRollNo = [];
    studentList = [];
    classItems = [];
    selectedClass =
        ResultAnnounceClassModel(className: "", id: "", classDisplayOrder: -1);
    getClassList();
    super.initState();
  }

  @override
  void dispose() {
    _controllers = [];
    _controllersOldRollNo = [];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, title: 'Change Roll No.'),
      body: MultiBlocListener(
        listeners: [
          BlocListener<UpdateRollNoEmployeeCubit, UpdateRollNoEmployeeState>(
              listener: (context, state) {
            if (state is UpdateRollNoEmployeeLoadInProgress) {
              setState(() {
                isLoader = true;
              });
            }
            if (state is UpdateRollNoEmployeeLoadSuccess) {
              setState(() {
                isLoader = false;
              });
              setState(() {
                ScaffoldMessenger.of(context).showSnackBar(
                  commonSnackBar(
                    title: 'Successfully Roll No. Changed',
                    duration: Duration(
                      milliseconds: 1000,
                    ),
                  ),
                );
              });
              setState(() {
                _controllers = [];
                _controllersOldRollNo = [];
                studentList = [];
              });
              getClassStudentChangeRollNo(classid: classId);
            }
            if (state is UpdateRollNoEmployeeLoadFail) {
              if (state.failReason == 'false') {
                UserUtils.unauthorizedUser(context);
              } else {
                setState(() {
                  isLoader = false;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  commonSnackBar(
                    title: '${state.failReason}',
                    duration: Duration(
                      milliseconds: 1,
                    ),
                  ),
                );
              }
            }
          }),
        ],
        child: Column(
          children: [
            Row(
              children: [
                BlocConsumer<ResultAnnounceClassCubit,
                    ResultAnnounceClassState>(listener: (context, state) {
                  if (state is ResultAnnounceClassLoadSuccess) {
                    setState(() {
                      selectedClass = state.classList[0];
                      classItems = state.classList;
                      classId = state.classList[0].id;
                    });
                    getClassStudentChangeRollNo(classid: classId);
                  }
                  if (state is ResultAnnounceClassLoadFail) {
                    if (state.failReason == 'false') {
                      UserUtils.unauthorizedUser(context);
                    } else {
                      selectedClass = ResultAnnounceClassModel(
                          id: "", classDisplayOrder: -1, className: "");
                      classItems = [];
                    }
                  }
                }, builder: (context, state) {
                  if (state is ResultAnnounceClassLoadInProgress) {
                    return buildClassSectionDropDown(context);
                  } else if (state is ResultAnnounceClassLoadSuccess) {
                    return buildClassSectionDropDown(context);
                  } else if (state is ResultAnnounceClassLoadFail) {
                    return buildClassSectionDropDown(context);
                  } else {
                    return Container();
                  }
                }),
                //buildClassSectionDropDown(context),
                isLoader == false
                    ? buildUpdateButton(context)
                    : Row(
                        children: [
                          SizedBox(
                            width: 100,
                          ),
                          LinearProgressIndicator(),
                          // Container(
                          //     width: 10,
                          //     height: 10,
                          //     child: CircularProgressIndicator()),
                        ],
                      ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
            ),
            Divider(
              thickness: 5,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            BlocConsumer<StudentListForChangeRollNoCubit,
                StudentListForChangeRollNoState>(
              listener: (context, state) {
                if (state is StudentListForChangeRollNoLoadSuccess) {
                  setState(() {
                    studentList = state.studentList;
                  });

                  setState(() {
                    _controllers = [];
                  });

                  if (studentList != null) {
                    setState(() {
                      studentList!.forEach((element) {
                        _controllers!.add(TextEditingController());
                      });
                    });
                  }
                }
                if (state is StudentListForChangeRollNoLoadFail) {
                  if (state.failReason == 'false') {
                    UserUtils.unauthorizedUser(context);
                  } else {
                    studentList = [];
                  }
                }
              },
              builder: (context, state) {
                if (state is StudentListForChangeRollNoLoadInProgress) {
                  // return Container(
                  //     height: 10,
                  //     width: 10,
                  //     child: CircularProgressIndicator());
                  return LinearProgressIndicator();
                } else if (state is StudentListForChangeRollNoLoadSuccess) {
                  return checkList(studentList: studentList);
                } else if (state is StudentListForChangeRollNoLoadFail) {
                  return checkList(error: state.failReason);
                } else {
                  return Container();
                }
              },
            ),
            //buildStudentList(),
            // Center(
            //   child: Container(
            //     width: 10,
            //     height: 10,
            //     child: CircularProgressIndicator(
            //       // backgroundColor: Colors.black,
            //       color: Colors.black,
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget checkList(
      {List<StudentListForChangeRollNoModel>? studentList, String? error}) {
    if (studentList == null || studentList.isEmpty) {
      if (error == null || error.isEmpty) {
        return Center(
          child: Text(
            'Wait',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      } else {
        return Center(
          child: Text(
            '$error',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        );
      }
    } else {
      return buildStudentList(studentList: studentList);
    }
  }

  GestureDetector buildUpdateButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        int data = 0;
        setState(() {
          finalAllClassList = [];
        });
        // finalAllClassList!.add({
        //   "StudentId": "${item.studentId}",
        //   "NewRollNo": "${_controllers[index].text}",
        //   "OldRollNo": "${_controllersOldRollNo[index].text}"
        // });

        //print(_controllers.length);
        print(_controllersOldRollNo!.length);
        //print(studentList!.length - 1);
        for (var i = 0; i < studentList!.length; i++) {
          finalAllClassList!.add({
            "StudentId": "${studentList![i].studentId}",
            "NewRollNo": "${_controllers![i].text}",
            "OldRollNo": "${_controllersOldRollNo![i].text}"
          });
        }

        for (var i = 0; i < studentList!.length; i++) {
          if (_controllers![i].text != "") {
            setState(() {
              data = data + 1;
            });
          }
        }
        print(data);
        print(finalAllClassList);
        if (data > 0) {
          print('Done');
          print(finalAllClassList);
          saveRollNo(classlist: finalAllClassList);
        } else {
          print(finalAllClassList);
          ScaffoldMessenger.of(context).showSnackBar(
            commonSnackBar(
              title: 'Change Atleast One Roll No.',
              duration: Duration(
                seconds: 1,
              ),
            ),
          );
          // _controllers = [];
          // _controllersOldRollNo = [];
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.3,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 0.1),
        ),
        margin: EdgeInsets.only(top: 40, left: 50),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Center(
          child: Text(
            'Change',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Expanded buildStudentList(
      {List<StudentListForChangeRollNoModel>? studentList}) {
    return Expanded(
      child: ListView.separated(
        shrinkWrap: true,
        separatorBuilder: (context, index) => SizedBox(
          height: 10,
        ),
        itemCount: studentList!.length,
        itemBuilder: (context, index) {
          print("student length ${studentList.length}");
          print("controller length ${_controllers!.length}");
          // _controllers.add(TextEditingController());
          var item = studentList[index];

          var _controller = _controllers![index];

          _controllersOldRollNo!.add(TextEditingController(text: item.rollNo!));

          return Container(
            padding: EdgeInsets.only(left: 8, right: 0, top: 8, bottom: 8),
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              border: Border.all(
                width: 0.1,
              ),
              borderRadius: BorderRadius.circular(2),
            ),
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.55,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.onlyStName!,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'S/O: ${item.fatherName}',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        children: [
                          RichText(
                            text: TextSpan(
                              text: '${item.admNo} ',
                              children: [
                                TextSpan(
                                  text: '|',
                                  children: [
                                    TextSpan(
                                      text: ' Rollno: ${item.rollNo}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.1),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  height: 30,
                  padding: EdgeInsets.all(1),
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: TextFormField(
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    style: TextStyle(
                      fontSize: 15,
                    ),
                    controller: _controller,
                    // _controllers[index],
                    keyboardType: TextInputType.number,
                    // scrollPadding: EdgeInsets.only(left: 5),
                    decoration: InputDecoration(
                      hintText: 'Enter Roll No.',
                      hintStyle: TextStyle(
                        fontSize: 12,
                      ),
                      enabledBorder: InputBorder.none,
                      border: InputBorder.none,
                      // errorBorder: OutlineInputBorder(
                      //   borderSide: BorderSide(color: Colors.red),
                      // ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Column buildClassSectionDropDown(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Text(
            'Class/Section',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xffECECEC)),
            borderRadius: BorderRadius.circular(4.0),
          ),
          height: MediaQuery.of(context).size.height * 0.055,
          padding: EdgeInsets.symmetric(horizontal: 8),
          margin: EdgeInsets.symmetric(horizontal: 20),
          width: MediaQuery.of(context).size.width * 0.35,
          child: DropdownButton<ResultAnnounceClassModel>(
            isExpanded: true,
            underline: Container(),
            value: selectedClass,
            items: classItems!
                .map((e) => DropdownMenuItem(
                      child: Text('${e.className}'),
                      value: e,
                    ))
                .toList(),
            onChanged: (val) {
              setState(() {
                selectedClass = val!;
                classId = val.id;
              });
              getClassStudentChangeRollNo(classid: classId);
            },
          ),
        ),
      ],
    );
  }
}

// Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// RichText(
// text: TextSpan(
// text: 'F/N: HARISH KUMAR',
// style: TextStyle(
// // fontSize: 20,
// fontWeight: FontWeight.w600,
// color: Colors.black54,
// ),
// ),
// ),
// RichText(
// text: TextSpan(
// text: 'Adm No: 3149',
// style: TextStyle(
// // fontSize: 20,
// fontWeight: FontWeight.w600,
// color: Colors.black54,
// ),
// children: <TextSpan>[
// TextSpan(
// text: ' | ',
// style: TextStyle(
// // fontSize: 20,
// fontWeight: FontWeight.w600,
// color: Colors.pink,
// ),
// children: <TextSpan>[
// TextSpan(
// text: 'Roll No: 1122',
// style: TextStyle(
// // fontSize: 20,
// fontWeight: FontWeight.w600,
// color: Colors.black54,
// ),
// ),
// ],
// ),
// ],
// ),
// ),
// ],
// ),
