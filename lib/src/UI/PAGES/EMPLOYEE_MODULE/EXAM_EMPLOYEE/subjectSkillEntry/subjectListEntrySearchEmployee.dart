import 'package:campus_pro/src/DATA/BLOC_CUBIT/GET_TOPIC_AND_SKILL_CUBIT/get_topic_and_skill_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/LOAD_STUDENT_FOR_SUBJECT_LIST_CUBIT/load_student_for_subject_list_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/RESULT_ANNOUNCE_CLASS_CUBIT/result_announce_class_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/SUBJECT_LIST_EMPLOYEE_CUBIT/subject_list_employee_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/SubjectListEmployeeModel.dart';
import 'package:campus_pro/src/DATA/MODELS/getTopicAndSkillModel.dart';
import 'package:campus_pro/src/DATA/MODELS/loadStudentForSubjectListModel.dart';
import 'package:campus_pro/src/DATA/MODELS/resultAnnounceClassModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/PAGES/EMPLOYEE_MODULE/EXAM_EMPLOYEE/subjectSkillEntry/subjectListEntryEmployee.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonSnackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubjectListEntrySearchEmployee extends StatefulWidget {
  static const routeName = '/Subject-List-Entry-Search';
  const SubjectListEntrySearchEmployee({Key? key}) : super(key: key);

  @override
  _SubjectListEntrySearchEmployeeState createState() =>
      _SubjectListEntrySearchEmployeeState();
}

class _SubjectListEntrySearchEmployeeState
    extends State<SubjectListEntrySearchEmployee> {
  // static const item3 = ['Skill', 'Skill 1'];
  // String selectedSkill = 'Skill 1';

  int? currentIndex = -1;

  static const item4 = [
    'Ist Term',
    'IInd Term',
  ];
  String selectedTerm = 'Ist Term';

  //class
  ResultAnnounceClassModel? selectedClass;
  List<ResultAnnounceClassModel> classItems = [];

  // item
  //     .map((e) => DropdownMenuItem(
  //           child: Text(e),
  //           value: e,
  //         ))
  //     .toList();

  //Subject
  List<SubjectListEmployeeModel>? subjectItems = [];
  SubjectListEmployeeModel? selectedSubject;
  // =
  //     item1.map((e) => DropdownMenuItem(child: Text(e), value: e)).toList();

  //Topic
  GetTopicAndSkillModel? selectedTopic =
      GetTopicAndSkillModel(skill: "", skillId: "", topic: "", topicId: "");
  List<GetTopicAndSkillModel>? topicDropdown = [];

  GetTopicAndSkillModel? selectedSkills =
      GetTopicAndSkillModel(skill: "", skillId: "", topic: "", topicId: "");
  List<GetTopicAndSkillModel>? skillsDropdown = [];
  // =
  //     item2.map((e) => DropdownMenuItem(child: Text(e), value: e)).toList();

  //Skill
  // List<DropdownMenuItem<String>> skillItems = item3
  //     .map((e) => DropdownMenuItem(
  //           child: Text(e),
  //           value: e,
  //         ))
  //     .toList();

  //Term
  List<DropdownMenuItem<String>> termItems =
      item4.map((e) => DropdownMenuItem(child: Text(e), value: e)).toList();

  String? subjectId = "";

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

    print('sending class data for cce attendance $sendingClassData');

    context
        .read<ResultAnnounceClassCubit>()
        .resultAnnounceClassCubitCall(sendingClassData);
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
      "Schoolid": userData.schoolId,
      "SessionId": userData.currentSessionid,
      "EmpId": userData.stuEmpId,
      "ClassID": classId.toString(),
      "SectionID": sectionId.toString(),
      "UserType": userData.ouserType,
      "StreamID": streamId.toString(),
      "YearID": yearID.toString(),
      "TeacherId": userData.stuEmpId,
    };
    print('Get Employee Subject $getEmpSubData');
    context
        .read<SubjectListEmployeeCubit>()
        .subjectListEmployeeCubitCall(getEmpSubData);
  }

  getTopicAndSkill() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final sendingDataForTopicAndSkill = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "SchoolID": userData.schoolId,
      "EmpId": userData.stuEmpId,
      "UserType": userData.ouserType,
      "SubjectID": selectedSubject!.subjectId!.toString(),
      "TopicID": currentIndex == 0 ? "0" : selectedTopic!.topicId,
    };

    print('sending data for topic and skill $sendingDataForTopicAndSkill');
    context
        .read<GetTopicAndSkillCubit>()
        .getTopicAndSkillCubitCall(sendingDataForTopicAndSkill);
  }

  getStudentList(
      {String? subjectid,
      String? classid,
      String? skillid,
      String? termid,
      String? topicid}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final sendingStudentData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "SchoolID": userData.schoolId,
      "EmpId": userData.stuEmpId,
      "UserType": userData.ouserType,
      "SubjectID": subjectid,
      "TopicID": topicid,
      "ClassData": classid,
      "SkillID": skillid,
      "Term": termid,
      "SessionID": userData.currentSessionid,
    };

    print("sending data for student list $sendingStudentData");

    context
        .read<LoadStudentForSubjectListCubit>()
        .loadStudentForSubjectListCubitCall(sendingStudentData);
  }

  @override
  void initState() {
    super.initState();
    selectedClass =
        ResultAnnounceClassModel(id: "", className: "", classDisplayOrder: -1);
    classItems = [];
    subjectItems = [];
    selectedSubject = SubjectListEmployeeModel(subjectId: -1, subjectHead: "");
    selectedSkills =
        GetTopicAndSkillModel(skill: "", skillId: "", topic: "", topicId: "");
    selectedTopic =
        GetTopicAndSkillModel(skill: "", skillId: "", topic: "", topicId: "");
    getClassList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
        context,
        title: 'Subject Enrichment Entry',
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<GetTopicAndSkillCubit, GetTopicAndSkillState>(
            listener: (context, state) {
              if (state is GetTopicAndSkillLoadFail) {
                if (state.failReason == 'false') {
                  UserUtils.unauthorizedUser(context);
                } else {
                  setState(() {
                    selectedTopic = null;
                    topicDropdown = [];
                    selectedSkills = null;
                    skillsDropdown = [];
                  });
                }
              }
              if (state is GetTopicAndSkillLoadSuccess) {
                setState(() {
                  if (currentIndex == 0) {
                    topicDropdown = state.topicSkillList;
                    selectedTopic = topicDropdown![0];
                    currentIndex = 1;
                    getTopicAndSkill();
                  } else if (currentIndex == 1) {
                    skillsDropdown = state.topicSkillList;
                    selectedSkills = skillsDropdown![0];
                    currentIndex = -1;
                    // print(
                    //     "skillsDropdown => $skillsDropdown, selectedSkills : ${selectedSkills!.skill}");
                  }
                });
              }
            },
          ),
          BlocListener<LoadStudentForSubjectListCubit,
              LoadStudentForSubjectListState>(listener: (context, state) {
            if (state is LoadStudentForSubjectListLoadSuccess) {
              print(state.stuList.runtimeType);
              List<LoadStudentForSubjectListModel> stuListFinal = state.stuList;

              // stuListFinal.forEach((element) {
              //   print(element.stName);
              // });

              // Map<String, dynamic> data = {
              //   "stuList": "$stuListFinal",
              //   "subjectid": "${selectedSubject!.subjectId}",
              //   "topicid": "${selectedTopic!.topicId}",
              //   "skillid": "${selectedSkills!.skillId}",
              //   "termid": "${selectedTerm == "Ist Term" ? "0" : "1"}",
              // };

              // Navigator.pushNamed(context, SubjectListEntryEmployee.routeName,
              //     arguments: {stuListFinal});

              // Navigator.pushNamed(context, SubjectListEntryEmployee.routeName,
              //     arguments: data);

              var isCheck = false;
              stuListFinal.forEach((element) {
                print(element.term1Grade);
                // print(element.term2Grade);
                if (selectedTerm == "Ist Term") {
                  if (element.term1Grade != null) {
                    setState(() {
                      isCheck = true;
                    });
                  }
                } else {
                  if (element.term2Grade != null) {
                    setState(() {
                      isCheck = true;
                    });
                  }
                }
              });
              print(isCheck);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SubjectListEntryEmployee(
                      studentList: stuListFinal,
                      skillId: selectedSkills!.skillId,
                      subjectId: selectedSubject!.subjectId.toString(),
                      topicId: selectedTopic!.topicId,
                      termId: selectedTerm == "Ist Term" ? "0" : "1",
                      isCheck: isCheck,
                    );
                  },
                ),
              );
            }
            if (state is LoadStudentForSubjectListLoadFail) {
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
            Row(
              children: [
                BlocConsumer<ResultAnnounceClassCubit,
                    ResultAnnounceClassState>(
                  listener: (context, state) {
                    if (state is ResultAnnounceClassLoadSuccess) {
                      setState(() {
                        selectedClass = state.classList[0];
                        classItems = state.classList;
                      });
                      getEmployeeSubject(
                          classId: selectedClass!.id!.split('#')[0],
                          streamId: selectedClass!.id!.split('#')[1],
                          sectionId: selectedClass!.id!.split('#')[2],
                          yearID: selectedClass!.id!.split('#')[4]);
                    }
                    if (state is ResultAnnounceClassLoadFail) {
                      if (state.failReason == 'false') {
                        UserUtils.unauthorizedUser(context);
                      } else {
                        setState(() {
                          selectedClass = ResultAnnounceClassModel(
                              id: "", className: "", classDisplayOrder: -1);
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
                BlocConsumer<SubjectListEmployeeCubit,
                    SubjectListEmployeeState>(
                  listener: (context, state) {
                    if (state is SubjectListEmployeeLoadSuccess) {
                      setState(() {
                        selectedSubject = state.subjectList[0];
                        subjectItems = state.subjectList;
                        // subjectId = state.subjectList[0].subjectId.toString();
                        currentIndex = 0;
                      });
                      getTopicAndSkill();
                    }
                    if (state is SubjectListEmployeeLoadFail) {
                      if (state.failReason == 'false') {
                        UserUtils.unauthorizedUser(context);
                      } else {
                        setState(() {
                          selectedSubject = SubjectListEmployeeModel(
                              subjectHead: "", subjectId: -1);
                          subjectItems = [];
                        });
                      }
                    }
                  },
                  builder: (context, state) {
                    if (state is SubjectListEmployeeLoadInProgress) {
                      return buildSubjectDropDown(context);
                    } else if (state is SubjectListEmployeeLoadSuccess) {
                      return buildSubjectDropDown(context);
                    } else if (state is SubjectListEmployeeLoadFail) {
                      return buildSubjectDropDown(context);
                    } else {
                      return Container();
                    }
                  },
                ),
                // buildSubjectDropDown(context),
              ],
            ),
            //topic and skill dropdown
            Row(
              children: [
                // BlocConsumer<GetTopicAndSkillCubit, GetTopicAndSkillState>(
                //   listener: (context, state) {
                //     if (state is GetTopicAndSkillLoadSuccess) {
                //       setState(() {
                //         selectedTopic = state.topicSkillList[0];
                //         topicItems = state.topicSkillList;
                //       });
                //       // getTopicAndSkill(subjectid: subjectId, topicid: "1");
                //     }
                //     if (state is GetTopicAndSkillLoadFail) {
                //       if (state.failReason == 'false') {
                //         UserUtils.unauthorizedUser(context);
                //       } else {
                //         topicItems = [];
                //         selectedTopic = GetTopicAndSkillModel(
                //             skill: "", skillId: "", topic: "", topicId: "");
                //       }
                //     }
                //   },
                //   builder: (context, state) {
                //     if (state is GetTopicAndSkillLoadInProgress) {
                //       return buildTopicDropDown(context);
                //     } else if (state is GetTopicAndSkillLoadSuccess) {
                //       return buildTopicDropDown(context);
                //     } else if (state is GetTopicAndSkillLoadFail) {
                //       return buildTopicDropDown(context);
                //     } else {
                //       return Container();
                //     }
                //   },
                // ),
                buildTopicDropDown(context),
                buildSkillDropDown(context),
              ],
            ),
            Row(
              children: [
                buildTermDropDown(context),
                buildGetDetailButton(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector buildGetDetailButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (selectedClass != null &&
            selectedSubject != null &&
            selectedTopic != null &&
            selectedSkills != null &&
            selectedTerm.isNotEmpty) {
          // ScaffoldMessenger.of(context).showSnackBar(
          //   commonSnackBar(title: 'Values Entered Properly'),
          // );
          getStudentList(
              subjectid: selectedSubject!.subjectId.toString(),
              classid: selectedClass!.id,
              skillid: selectedSkills!.skillId,
              topicid: selectedTopic!.topicId,
              termid: selectedTerm == "Ist Term" ? "0" : "1");
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            commonSnackBar(title: 'Select Values Properly'),
          );
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        margin: EdgeInsets.only(left: 20, right: 10, top: 34, bottom: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          border: Border.all(width: 0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        height: 40,
        child: Center(
          child: Text(
            'Get Details',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Column buildTermDropDown(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 20, top: 10),
          child: Text(
            'Term',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(width: 0.1),
          ),
          padding: EdgeInsets.all(8),
          height: 40,
          margin: EdgeInsets.only(left: 20, right: 10, top: 5, bottom: 10),
          child: DropdownButton(
            isExpanded: true,
            underline: Container(),
            items: termItems,
            value: selectedTerm,
            onChanged: (String? val) {
              setState(() {
                selectedTerm = val!;
              });
            },
          ),
        ),
      ],
    );
  }

  Column buildTopicDropDown(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(
            left: 20,
            top: 10,
          ),
          child: Text(
            'Topic',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.4,
          height: 40,
          margin: EdgeInsets.only(left: 20, right: 10, top: 5, bottom: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(width: 0.1),
          ),
          padding: EdgeInsets.all(8),
          child: DropdownButton<GetTopicAndSkillModel>(
            isExpanded: true,
            underline: Container(),
            items: topicDropdown!
                .map((e) => DropdownMenuItem<GetTopicAndSkillModel>(
                      child: Text('${e.topic}'),
                      value: e,
                    ))
                .toList(),
            value: selectedTopic,
            onChanged: (val) {
              setState(() {
                selectedTopic = val!;
                currentIndex = 1;
              });
              getTopicAndSkill();
            },
          ),
        ),
      ],
    );
  }

  Column buildSkillDropDown(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(
            left: 20,
            top: 10,
          ),
          child: Text(
            'Skills',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.4,
          height: 40,
          margin: EdgeInsets.only(left: 20, right: 10, top: 5, bottom: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(width: 0.1),
          ),
          padding: EdgeInsets.all(8),
          child: DropdownButton<GetTopicAndSkillModel>(
            isExpanded: true,
            underline: Container(),
            items: skillsDropdown!
                .map((e) => DropdownMenuItem<GetTopicAndSkillModel>(
                      child: Text('${e.skill}'),
                      value: e,
                    ))
                .toList(),
            value: selectedSkills,
            onChanged: (val) {
              setState(() {
                selectedSkills = val!;
              });
            },
          ),
        ),
      ],
    );
  }

  Column buildSubjectDropDown(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 20, top: 10),
          child: Text(
            'Subject',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.4,
          height: 40,
          margin: EdgeInsets.only(left: 20, right: 10, top: 5, bottom: 10),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(width: 0.1),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: DropdownButton<SubjectListEmployeeModel>(
            isExpanded: true,
            underline: Container(),
            items: subjectItems!
                .map((e) => DropdownMenuItem(
                      child: Text('${e.subjectHead}'),
                      value: e,
                    ))
                .toList(),
            value: selectedSubject,
            onChanged: (val) {
              setState(() {
                selectedSubject = val!;
                // subjectId = val.subjectId.toString();
                currentIndex = 0;
              });
              getTopicAndSkill();
            },
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
          margin: EdgeInsets.only(left: 20, top: 10),
          child: Text(
            'Class',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.4,
          height: 40,
          margin: EdgeInsets.only(left: 20, right: 10, top: 5, bottom: 10),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(width: 0.1),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: DropdownButton<ResultAnnounceClassModel>(
            isExpanded: true,
            underline: Container(),
            items: classItems
                .map((e) => DropdownMenuItem(
                      child: Text('${e.className}'),
                      value: e,
                    ))
                .toList(),
            value: selectedClass,
            onChanged: (val) {
              setState(() {
                selectedClass = val!;
              });
              getEmployeeSubject(
                  classId: selectedClass!.id!.split('#')[0],
                  streamId: selectedClass!.id!.split('#')[1],
                  sectionId: selectedClass!.id!.split('#')[2],
                  yearID: selectedClass!.id!.split('#')[4]);
            },
          ),
        ),
      ],
    );
  }
}
