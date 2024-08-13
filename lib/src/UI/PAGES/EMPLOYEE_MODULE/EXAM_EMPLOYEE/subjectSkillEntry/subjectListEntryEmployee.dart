import 'dart:convert';

import 'package:campus_pro/src/DATA/BLOC_CUBIT/GET_GRADE_CUBIT/get_grade_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/SAVE_SUBJECT_ENRICHMENT_DETAIL_CUBIT/save_subject_enrichment_detail_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/loadStudentForSubjectListModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonSnackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubjectListEntryEmployee extends StatefulWidget {
  final String? subjectId;
  final String? topicId;
  final String? skillId;
  final String? termId;
  final List<LoadStudentForSubjectListModel>? studentList;
  final bool? isCheck;
  //final Map<String, dynamic>? data;

  static const routeName = '/subject-list-entry-employee';
  SubjectListEntryEmployee({
    this.studentList,
    this.topicId,
    this.skillId,
    this.subjectId,
    this.termId,
    this.isCheck,
  });
  //SubjectListEntryEmployee({this.data});

  @override
  _SubjectListEntryEmployeeState createState() =>
      _SubjectListEntryEmployeeState();
}

class _SubjectListEntryEmployeeState extends State<SubjectListEntryEmployee> {
  // List demoList = [
  //   ['adm no', '2313131', 'name', 'fathername'],
  //   ['adm no', '1231323', 'name1', 'fathername'],
  //   ['adm no', '34535345', 'name2', 'fathername'],
  //   ['adm no', '2312313123', 'name3', 'fathername'],
  // ];

  //grade item
  String? selectedGrade;
  List<String>? gradeItems = [];
  List<String>? selectedGradeList = [];

  // static const item = ['A1', 'A2', 'B1', 'B2', 'C1', 'C2', 'D', 'E'];
  // List<String>? selectedGradeList = [];

  // String selectedGrade = 'A1';

  // List<DropdownMenuItem<String>> gradeItems = item
  //     .map((e) => DropdownMenuItem(
  //           child: Text(e),
  //           value: e,
  //         ))
  //     .toList();

  List<Map<String, String>>? sendingStudentData = [];

  bool isSave = false;
  bool isDelete = false;

  getGrade() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final sendingGradeData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "SchoolID": userData.schoolId,
      "EmpId": userData.stuEmpId,
      "UserType": userData.ouserType,
    };

    print('sending data for grade item $sendingGradeData');
    context.read<GetGradeCubit>().getGradeCubitCall(sendingGradeData);
  }

  saveDeleteSubjectDetail(
      {String? action,
      String? subjectid,
      String? topicid,
      String? skillid,
      String? termid,
      List<Map<String, String?>>? jsondata}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final sendingSubjectData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "SchoolID": userData.schoolId,
      "EmpId": userData.stuEmpId,
      "UserType": userData.ouserType,
      "SubjectID": subjectid,
      "TopicID": topicid,
      "JsonData": jsonEncode(jsondata),
      "SkillID": skillid,
      "Term": termid,
      "SessionID": userData.currentSessionid,
      "Flag": action,
    };

    print('sending data for save subject $sendingSubjectData');

    context
        .read<SaveSubjectEnrichmentDetailCubit>()
        .saveSubjectEnrichmentDetailCubitCall(sendingSubjectData);
  }

  @override
  void initState() {
    super.initState();
    selectedGrade = "";
    gradeItems = [];
    getGrade();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, title: 'Subject Enrichment Detail'),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                print('Save');
                // for (var i = 0; i < demoList.length; i++) {
                //   print(selectedGradeList![i].grade);
                // }
                //print(selectedGradeList);
                //Todo
                saveDeleteSubjectDetail(
                    action: 'S',
                    subjectid: widget.subjectId,
                    skillid: widget.skillId,
                    termid: widget.termId,
                    topicid: widget.topicId,
                    jsondata: sendingStudentData);
              },
              child: Container(
                margin: EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width * 0.3,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 0.1),
                ),
                child: Text(
                  widget.isCheck == false ? 'Save' : 'Update',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (widget.isCheck == false) {
                  //Do Nothing
                } else {
                  print('Delete');
                  saveDeleteSubjectDetail(
                      action: 'D',
                      subjectid: widget.subjectId,
                      skillid: widget.skillId,
                      termid: widget.termId,
                      topicid: widget.topicId,
                      jsondata: sendingStudentData);
                }
              },
              child: Container(
                margin: EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width * 0.3,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: widget.isCheck != false
                        ? Colors.red.shade400
                        : Colors.red.shade100,
                    border: Border.all(width: 0.1),
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  'Delete',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<GetGradeCubit, GetGradeState>(
              listener: (context, state) {
            // if (state is GetGradeLoad) {
            //   setState(() {
            //     gradeItems = [];
            //     selectedGrade = GetGradeModel(grade: "");
            //   });
            // }
            if (state is GetGradeLoadSuccess) {
              setState(() {
                // state.gradeList.forEach((element) {
                //   print(element.grade);
                // });
                state.gradeList.forEach((element) {
                  gradeItems!.add(element.grade!);
                });
                //gradeItems = state.gradeList;
                selectedGrade = state.gradeList[0].grade;
                // selectedGradeList!.forEach((element) {
                //   element = GetGradeModel(grade: "$selectedGrade");
                // });
              });
              gradeItems!.forEach((element) {
                print(element);
              });
            }
            if (state is GetGradeLoadFail) {
              if (state.failReason == 'false') {
                UserUtils.unauthorizedUser(context);
              } else {
                setState(() {
                  selectedGrade = "";
                  gradeItems = [];
                });
              }
            }
          }),
          BlocListener<SaveSubjectEnrichmentDetailCubit,
              SaveSubjectEnrichmentDetailState>(listener: (context, state) {
            if (state is SaveSubjectEnrichmentDetailLoadSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                commonSnackBar(
                  title: '${state.result}',
                  duration: Duration(seconds: 1),
                ),
              );
              Navigator.pop(context);
            }
            if (state is SaveSubjectEnrichmentDetailLoadFail) {
              if (state.failReason == 'false') {
                UserUtils.unauthorizedUser(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  commonSnackBar(
                    title: '${state.failReason}',
                    duration: Duration(seconds: 1),
                  ),
                );
              }
            }
          }),
        ],
        child: Column(
          children: [
            gradeItems!.length > 0
                ? Expanded(
                    child: ListView.builder(
                      itemCount: widget.studentList!.length,
                      //itemCount: widget.data!['stuList']!.length,
                      itemBuilder: (context, index) {
                        var item = widget.studentList![index];
                        //  String? selectedGrade = 'A1';

                        if (widget.termId == '0') {
                          (item.term1Grade != null && item.term1Grade != "-")
                              ? selectedGradeList!.add(item.term1Grade!)
                              : selectedGradeList!.add(selectedGrade!);
                        } else {
                          (item.term2Grade != null && item.term2Grade != "-")
                              ? selectedGradeList!.add(item.term2Grade!)
                              : selectedGradeList!.add(selectedGrade!);
                        }

                        //
                        // (item.term1Grade != null || item.term2Grade != null)
                        //     ? item.term1Grade != "-"
                        //         ? selectedGradeList!.add(item.term1Grade!)
                        //         : selectedGradeList!.add(item.term2Grade!)
                        //     : selectedGradeList!.add(selectedGrade!);
                        //

                        //selectedGradeList!.add(selectedGrade!);
                        sendingStudentData!.add({
                          "StudentID": "${item.studentDetailId}",
                          "Grade": "${selectedGradeList![index]}"
                        });
                        return Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 5,
                          ),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            border: Border.all(width: 0.1),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: RichText(
                                      text: TextSpan(
                                        text: '(${item.admNo}) ',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                        children: [
                                          TextSpan(
                                            text:
                                                '${item.stName!.toUpperCase()}',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      child: Center(
                                        child: Text(
                                          'Roll No: ${item.examRollNo}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    // child: Text(
                                    //   'S/O: ${item.fatherName}',
                                    //   style: TextStyle(
                                    //     fontWeight: FontWeight.w600,
                                    //     fontSize: 15,
                                    //   ),
                                    // ),
                                    child: RichText(
                                      text: TextSpan(
                                        text: 'S/O: ',
                                        style: TextStyle(
                                            fontSize: 13, color: Colors.black),
                                        children: [
                                          TextSpan(
                                            text: '${item.fatherName}',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  gradeItems!.length > 0
                                      ? buildGradeRollNo(context, index)
                                      : Container(),
                                  // BlocConsumer<GetGradeCubit, GetGradeState>(
                                  //     listener: (context, state) {},
                                  //     builder: (context, state) {
                                  //       if (state is GetGradeLoadInProgress) {
                                  //         return buildGradeRollNo(context, index);
                                  //       } else if (state is GetGradeLoadSuccess) {
                                  //         return buildGradeRollNo(context, index);
                                  //       } else if (state is GetGradeLoadFail) {
                                  //         return buildGradeRollNo(context, index);
                                  //       } else {
                                  //         return Container();
                                  //       }
                                  //     }),
                                  // buildGradeRollNo(context, index),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  )
                : Center(
                    child: Container(
                      width: 10,
                      height: 10,
                      child: CircularProgressIndicator(),
                    ),
                  )
          ],
        ),
      ),
    );
  }

  Container buildGradeRollNo(BuildContext context, int index) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 3),
      padding: EdgeInsets.all(3),
      height: 30,
      width: MediaQuery.of(context).size.width * 0.15,
      decoration: BoxDecoration(
        border: Border.all(width: 0.05),
        borderRadius: BorderRadius.circular(2),
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        underline: Container(),
        items: gradeItems!
            .map((e) => DropdownMenuItem(
                  child: Text('${e}'),
                  value: e,
                ))
            .toList(),
        value: selectedGradeList![index],
        onChanged: (val) {
          setState(() {
            selectedGradeList![index] = val!;
          });
        },
      ),
    );
  }
}
