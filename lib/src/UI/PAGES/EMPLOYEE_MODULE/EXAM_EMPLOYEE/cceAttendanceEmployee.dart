import 'dart:convert';

import 'package:campus_pro/src/DATA/BLOC_CUBIT/CCE_ATTENDANCE_CLASS_DATA_CUBIT/cce_attendance_class_data_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/RESULT_ANNOUNCE_CLASS_CUBIT/result_announce_class_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/SAVE_CCE_ATTENDANCE_CUBIT/save_cce_attendance_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/cceAttendanceClassDataModel.dart';
import 'package:campus_pro/src/DATA/MODELS/resultAnnounceClassModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonSnackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CCEAttendance extends StatefulWidget {
  static const routeName = '/CCE-Attendance';
  const CCEAttendance({Key? key}) : super(key: key);

  @override
  _CCEAttendanceState createState() => _CCEAttendanceState();
}

class _CCEAttendanceState extends State<CCEAttendance> {
  //static const item = ['1', '11', '111', 'V1', 'V'];

  static const item1 = [
    '1 Term',
    '2 Term',
  ];
  String selectedTerm = '1 Term';

  TextEditingController _controllerNumber = TextEditingController();

  List<TextEditingController>? rollNoController;

  List<Map<String, String>> finalClassList = [];
  List<CceAttendanceClassDataModel> testClassList = [];

  // [
  //   ['name', 'admNo', '1', '122'],
  //   [
  //     'name1',
  //     'admNo1',
  //     '2',
  //     '133',
  //   ],
  //   [
  //     'name2',
  //     'admNo2',
  //     '3',
  //     '144',
  //   ],
  //   [
  //     'name3',
  //     'admNo3',
  //     '4',
  //     '15',
  //   ],
  // ];

  //class
  ResultAnnounceClassModel? selectedClass;
  List<ResultAnnounceClassModel>? classItems = [];

  //
  String? classId = "";

  List<DropdownMenuItem<String>> termItems = item1
      .map((String e) => DropdownMenuItem(
            child: Text(e),
            value: e,
          ))
      .toList();

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

    print('sending class data for cce attendance $sendingClassData');

    context
        .read<ResultAnnounceClassCubit>()
        .resultAnnounceClassCubitCall(sendingClassData);
  }

  getClassData({String? classid, String? termid}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final sendingClassData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "SchoolId": userData.schoolId,
      "SessionId": userData.currentSessionid,
      "EmpId": userData.stuEmpId,
      "ClassData": classid,
      "UserType": userData.ouserType,
      "TermID": termid,
    };

    print('sending data of cce attendance $sendingClassData');

    context
        .read<CceAttendanceClassDataCubit>()
        .cceAttendanceClassDataCubitCall(sendingClassData);
  }

  saveCceAttendance(
      {String? totaldays,
      String? term,
      List<Map<String, String>>? classdata}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final sendingSaveAttendanceData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "SchoolId": userData.schoolId,
      "SessionId": userData.currentSessionid,
      "EmpId": userData.stuEmpId,
      "JsonData": jsonEncode(classdata),
      "UserType": userData.ouserType,
      "TermID": term,
      "TotalDays": totaldays,
    };

    print('sending data for cce attendance $sendingSaveAttendanceData');
    context
        .read<SaveCceAttendanceCubit>()
        .saveCceAttendanceCubitCall(sendingSaveAttendanceData);
  }

  @override
  void initState() {
    super.initState();
    _controllerNumber.text = '0';
    rollNoController = [];
    selectedClass =
        ResultAnnounceClassModel(id: "", className: "", classDisplayOrder: -1);
    classItems = [];
    getClassList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, title: 'CCE Attendance'),
      body: MultiBlocListener(
        listeners: [
          BlocListener<SaveCceAttendanceCubit, SaveCceAttendanceState>(
              listener: (context, state) {
            if (state is SaveCceAttendanceLoadSuccess) {
              setState(() {
                rollNoController = [];
              });
              setState(() {
                print(classItems!.length);
                finalClassList = [];

                //classItems = [];
                testClassList = [];
                _controllerNumber.text = "0";
              });
              getClassList();
              ScaffoldMessenger.of(context).showSnackBar(
                commonSnackBar(
                    title: 'Attendance Marked', duration: Duration(seconds: 1)),
              );
              FocusScope.of(context).unfocus();
            }
            if (state is SaveCceAttendanceLoadFail) {
              if (state.failReason == 'false') {
                UserUtils.unauthorizedUser(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  commonSnackBar(
                      title: '${state.failReason}',
                      duration: Duration(seconds: 1)),
                );
              }
            }
          }),
        ],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                BlocConsumer<ResultAnnounceClassCubit,
                    ResultAnnounceClassState>(
                  listener: (context, state) {
                    if (state is ResultAnnounceClassLoadSuccess) {
                      setState(() {
                        selectedClass = state.classList[0];
                        classItems = state.classList;
                        classId = state.classList[0].id;
                      });

                      getClassData(
                          classid: classId,
                          termid: selectedTerm == '1 Term' ? "1" : "2");
                    }
                    if (state is ResultAnnounceClassLoadFail) {
                      if (state.failReason == 'false') {
                        UserUtils.unauthorizedUser(context);
                      } else {
                        setState(() {
                          selectedClass = ResultAnnounceClassModel(
                              id: "", classDisplayOrder: -1, className: "");
                          classItems = [];
                        });
                      }
                    }
                  },
                  builder: (context, state) {
                    if (state is ResultAnnounceClassLoadInProgress) {
                      return buildClassDropDown(context);
                    } else if (state is ResultAnnounceClassLoadSuccess) {
                      return buildClassDropDown(context);
                    } else if (state is ResultAnnounceClassLoadFail) {
                      return buildClassDropDown(context);
                    } else {
                      return Container();
                    }
                  },
                ),
                //buildClassDropDown(context),
                buildPeriodDropDown(context),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            FittedBox(
                fit: BoxFit.fitWidth, child: buildTotalDayAndButton(context)),
            SizedBox(
              height: 5,
            ),
            Divider(
              thickness: 5,
            ),
            SizedBox(
              height: 5,
            ),
            BlocConsumer<CceAttendanceClassDataCubit,
                CceAttendanceClassDataState>(
              listener: (context, state) {
                if (state is CceAttendanceClassDataLoadSuccess) {
                  setState(() {
                    rollNoController = [];
                    testClassList = state.classData;
                  });

                  ///
                  testClassList.forEach((element) {
                    if (element.attendance != null) {
                      rollNoController!.add(
                          TextEditingController(text: element.cceAttendance));
                    } else {
                      rollNoController!.add(TextEditingController(text: ""));
                    }
                  });
                }
                if (state is CceAttendanceClassDataLoadFail) {
                  if (state.failReason == 'false') {
                    UserUtils.unauthorizedUser(context);
                  } else {
                    setState(() {
                      testClassList = [];
                    });
                  }
                }
              },
              builder: (context, state) {
                if (state is CceAttendanceClassDataLoadInProgress) {
                  // return Center(
                  //   child: Container(
                  //     width: 10,
                  //     height: 10,
                  //     child: CircularProgressIndicator(),
                  // ),
                  // );
                  return LinearProgressIndicator();
                } else if (state is CceAttendanceClassDataLoadSuccess) {
                  return checkList(classList: testClassList);
                } else if (state is CceAttendanceClassDataLoadFail) {
                  return checkList(error: state.failReason);
                } else {
                  return Container();
                }
              },
            ),
            // buildStudentList()
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  Widget checkList(
      {List<CceAttendanceClassDataModel>? classList, String? error}) {
    if (classList == null || classList.isEmpty) {
      if (error == null || error.isEmpty) {
        return Center(
          child: Text(
            'Wait',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
        );
      } else {
        return Center(
          child: Text(
            '$error',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      }
    } else {
      return buildStudentList(classList: classList);
    }
  }

  Expanded buildStudentList({
    List<CceAttendanceClassDataModel>? classList,
  }) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(
          height: 10,
        ),
        itemCount: classList!.length,
        itemBuilder: (context, index) {
          // print(rollNoController!.length);
          var item = classList[index];
          // if (item.attendance != null) {
          //   rollNoController!.add(TextEditingController(text: item.attendance));
          // } else {
          //   rollNoController!.add(TextEditingController(text: ""));
          // }
          var _controller = rollNoController![index];
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              border: Border.all(width: 0.1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: RichText(
                      text: TextSpan(
                        text: '${item.stName!.toUpperCase()}\n',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: 'RollNo: ${item.rollNo}',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    )),
                Container(
                  width: MediaQuery.of(context).size.width * 0.42,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.height * 0.06,
                        margin: EdgeInsets.symmetric(horizontal: 2),
                        padding: EdgeInsets.all(5),
                        child: TextFormField(
                          enableInteractiveSelection: false,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                          controller: _controller,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(3),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Attendance',
                            hintStyle: TextStyle(fontSize: 10),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                          onChanged: (val) {
                            print('${_controller.text} ${item.stName}');
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Row buildTotalDayAndButton(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 5,
              ),
              child: Text(
                'Total Days',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.2,
              height: MediaQuery.of(context).size.height * 0.06,
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.all(5),
              child: TextFormField(
                controller: _controllerNumber,
                scrollPadding: EdgeInsets.all(5),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(3),
                  FilteringTextInputFormatter.digitsOnly,
                ],
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
                  ),
                ),
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            print('Get Details');
            getClassData(
                classid: classId, termid: selectedTerm == '1 Term' ? "1" : "2");
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.3,
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            margin: EdgeInsets.only(
              left: 0,
              top: 30,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              border: Border.all(width: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                'Get Details',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            print('Save');

            bool test = false;
            // if (rollNoController!.length > 0) {
            //   print(rollNoController!.length);
            //   rollNoController!.forEach((element) {
            //     print(element.text);
            //     if (element.text.isNotEmpty) {
            //       if (int.parse(_controllerNumber.text) >
            //           int.parse(element.text)) {
            //       } else {
            //         test = true;
            //       }
            //     }
            //   });
            //   if (test == false) {
            //     ScaffoldMessenger.of(context).showSnackBar(
            //       commonSnackBar(
            //           title: 'Attendance Marked',
            //           duration: Duration(seconds: 1)),
            //     );
            //   } else {
            //     ScaffoldMessenger.of(context).showSnackBar(
            //       commonSnackBar(
            //           title: 'Attendance should be Less then Days',
            //           duration: Duration(seconds: 1)),
            //     );
            //   }
            // } else {
            //   ScaffoldMessenger.of(context).showSnackBar(
            //     commonSnackBar(title: 'Add Atleast One Attendance'),
            //   );
            // }

            setState(() {
              finalClassList = [];
            });

            print(testClassList.length);
            for (var i = 0; i < testClassList.length; i++) {
              finalClassList.add({
                "StudentID": "${testClassList[i].studentId}",
                "Grade": "${rollNoController![i].text}"
              });
            }

            for (var i = 0; i < testClassList.length; i++) {
              if (rollNoController![i].text.isNotEmpty) {
                if (int.parse(rollNoController![i].text) <=
                    int.parse(_controllerNumber.text)) {
                } else {
                  test = true;
                }
              }
            }

            print(rollNoController!.length);
            if (test == false) {
              finalClassList.forEach(print);
              if (rollNoController!.length > 0) {
                saveCceAttendance(
                    classdata: finalClassList,
                    term: selectedTerm == '1 Term' ? "1" : "2",
                    totaldays: _controllerNumber.text);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  commonSnackBar(
                      title: 'No Student', duration: Duration(seconds: 1)),
                );
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                commonSnackBar(
                    title: 'Attendance should be Less then Total Days',
                    duration: Duration(seconds: 1)),
              );
            }
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.3,
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            margin: EdgeInsets.only(
              left: 20,
              top: 30,
            ),
            decoration: BoxDecoration(
              color: Colors.green,
              border: Border.all(width: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                'Save',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Column buildClassDropDown(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Text(
            'Class',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Color(0xffECECEC),
            ),
            borderRadius: BorderRadius.circular(4.0),
          ),
          margin: EdgeInsets.symmetric(horizontal: 18),
          height: MediaQuery.of(context).size.height * 0.06,
          padding: EdgeInsets.symmetric(horizontal: 10),
          width: MediaQuery.of(context).size.width * 0.4,
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
              // // getClassData(
              //     classid: classId,
              //     termid: selectedTerm == '1 Term' ? "1" : "2");
            },
          ),
        ),
      ],
    );
  }

  Column buildPeriodDropDown(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Text(
            'Period',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Color(0xffECECEC),
            ),
            borderRadius: BorderRadius.circular(4.0),
          ),
          margin: EdgeInsets.symmetric(horizontal: 18),
          height: MediaQuery.of(context).size.height * 0.06,
          padding: EdgeInsets.symmetric(horizontal: 10),
          width: MediaQuery.of(context).size.width * 0.4,
          child: DropdownButton(
            isExpanded: true,
            underline: Container(),
            value: selectedTerm,
            items: termItems,
            onChanged: (String? val) {
              setState(() {
                selectedTerm = val!;
              });
              setState(() {
                rollNoController = [];
              });
            },
          ),
        ),
      ],
    );
  }
}
