import 'dart:convert';

import 'package:campus_pro/src/DATA/API_SERVICES/cceSubjectTeacherRemarksListApi.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/CCE_GENERAL_TEACHER_REMARKS_LIST_CUBIT/cce_general_teacher_remarks_list_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/CCE_SUBJECT_TEACHER_REMARKS_LIST_CUBIT/cce_subject_teacher_remarks_list_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/RESULT_ANNOUNCE_CLASS_CUBIT/result_announce_class_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/SAVE_CCE_GENERAL_TEACHER_REMARKS_CUBIT/save_cce_general_teacher_remarks_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/SAVE_CCE_SUBJECT_TEACHER_REMARKS_CUBIT/save_cce_subject_teacher_remarks_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/TEACHER_REMARKS_LIST_CUBIT/teacher_remarks_list_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/cceGeneralTeacherRemarksListModel.dart';
import 'package:campus_pro/src/DATA/MODELS/cceSubjectTeacherRemarksListModel.dart';
import 'package:campus_pro/src/DATA/MODELS/resultAnnounceClassModel.dart';
import 'package:campus_pro/src/DATA/MODELS/teacherRemarksListModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonSnackbar.dart';
import 'package:campus_pro/src/UI/WIDGETS/noRecordFound.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

List<CceGeneralTeacherRemarksListModel>? generalRemarkList = [];
List<CceSubjectTeacherRemarksListModel>? subjectRemarkList = [];

class CceTeacherRemarks extends StatefulWidget {
  static const routeName = "/cce-teacher-remarks";
  const CceTeacherRemarks({Key? key}) : super(key: key);

  @override
  _CceTeacherRemarksState createState() => _CceTeacherRemarksState();
}

class _CceTeacherRemarksState extends State<CceTeacherRemarks> {
  int? selectedType = 0;
  List<int> typeDropdown = [0, 1];

  ResultAnnounceClassModel? selectedClass;
  List<ResultAnnounceClassModel>? classDropdown = [];

  int? selectedTerm;
  List<int>? termDropdown = [];

  @override
  void initState() {
    getClassList();
    super.initState();
  }

  getRemarkDropdownList() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final request = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "EmpId": userData.stuEmpId,
      "UserType": userData.ouserType,
    };
    context
        .read<TeacherRemarksListCubit>()
        .teacherRemarksListCubitCall(request);
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
      "classteacher": "1",
      "SessionId": userData.currentSessionid,
    };

    context
        .read<ResultAnnounceClassCubit>()
        .resultAnnounceClassCubitCall(sendingClassData);
  }

  getGeneralRemarks() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final generalData = {
      'OUserId': uid,
      'Token': token,
      'OrgId': userData!.organizationId,
      'Schoolid': userData.schoolId,
      'SessionId': userData.currentSessionid,
      'EmpId': userData.stuEmpId,
      'ClassID': selectedClass!.id,
      'UserType': userData.ouserType,
      'TermID': selectedTerm.toString(),
    };
    print("Sending CceGeneralTeacherRemarksList Data => $generalData");
    context
        .read<CceGeneralTeacherRemarksListCubit>()
        .cceGeneralTeacherRemarksListCubitCall(generalData);
  }

  getSubjectRemarks() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final generalData = {
      'OUserId': uid,
      'Token': token,
      'OrgId': userData!.organizationId,
      'SchoolID': userData.schoolId,
      'Sessionid': userData.currentSessionid,
      'EmpId': userData.stuEmpId,
      'ClassID': selectedClass!.id,
      'UserType': userData.ouserType,
    };
    print("Sending CceGeneralTeacherRemarksList Data => $generalData");
    context
        .read<CceSubjectTeacherRemarksListCubit>()
        .cceSubjectTeacherRemarksListCubitCall(generalData);
  }

  saveRemarks() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    List<Map<String, String>> generalListFinal = [];
    List<Map<String, String>> subjectListFinal = [];

    if (selectedType == 0) {
      generalRemarkList!.forEach((element) {
        generalListFinal.add({
          "ADMNO": element.studentId!,
          "RemarkID": element.remarkID != "0" ? element.remarkID! : ""
        });
      });
      print("generalListFinal : $generalListFinal");
    } else {
      subjectRemarkList!.forEach((element) {
        subjectListFinal.add({
          "ADMNO": element.admNo!,
          "NAME": element.name!,
          for (var i = 0; i < element.remarks!.length; i++)
            element.remarks![i].subject!:
                (element.remarks![i].remark.toString() != "0"
                    ? element.remarks![i].remark.toString()
                    : "")
        });
      });
      print("subjectListFinal : $subjectListFinal");
    }
    print("generalRemarkList.length : ${generalRemarkList!.length}");

    final finalRemarkData = {
      'OUserId': uid,
      'Token': token,
      'OrgID': userData!.organizationId,
      'SchoolID': userData.schoolId,
      'SessionID': userData.currentSessionid,
      'UserId': userData.stuEmpId,
      'ClassID': selectedClass!.id!.split("#")[0],
      'SectionID': selectedClass!.id!.split("#")[2],
      'UserType': userData.ouserType,
      'StreamId': selectedClass!.id!.split("#")[1],
      'YearID': selectedClass!.id!.split("#")[4],
      'TermId': selectedType == 0 ? selectedTerm.toString() : "1",
      'JsonData': selectedType == 0
          ? jsonEncode(generalListFinal)
          : jsonEncode(subjectListFinal),
    };
    if (selectedType == 0) {
      print("Sending SaveCceGeneralTeacherRemarks data => $finalRemarkData");
      context
          .read<SaveCceGeneralTeacherRemarksCubit>()
          .saveCceGeneralTeacherRemarksCubitCall(finalRemarkData);
    } else if (selectedType == 1) {
      print("Sending SaveCceSubjectTeacherRemarks data => $finalRemarkData");
      context
          .read<SaveCceSubjectTeacherRemarksCubit>()
          .saveCceSubjectTeacherRemarksCubitCall(finalRemarkData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context,
          title: "CCE Teacher Remarks",
          icon: InkWell(
            onTap: () => saveRemarks(),
            child: Center(
                child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text("Save"),
            )),
          )),
      body: MultiBlocListener(
        listeners: [
          BlocListener<TeacherRemarksListCubit, TeacherRemarksListState>(
            listener: (context, state) {
              if (state is TeacherRemarksListLoadSuccess) {
                setState(() {
                  remarkListDropdown = state.teacherRemarksList;
                  if (remarkListDropdown[0].remark != 'Select') {
                    remarkListDropdown.insert(
                        0, TeacherRemarksListModel(id: "0", remark: "Select"));
                  }
                  // selectedRemark = remarkListDropdown[0];
                });
              }
              if (state is TeacherRemarksListLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                } else {
                  setState(() {
                    remarkListDropdown = [];
                    // selectedRemark = TeacherRemarksListModel(remark: "", id: "");
                  });
                }
              }
            },
          ),
          BlocListener<ResultAnnounceClassCubit, ResultAnnounceClassState>(
            listener: (context, state) {
              if (state is ResultAnnounceClassLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                } else {}
              }
              if (state is ResultAnnounceClassLoadSuccess) {
                selectedTerm = 0;
                termDropdown = [0, 1, 2];
                setState(() {
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
              }
            },
          ),
          BlocListener<SaveCceGeneralTeacherRemarksCubit,
              SaveCceGeneralTeacherRemarksState>(listener: (context, state) {
            if (state is SaveCceGeneralTeacherRemarksLoadSuccess) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(commonSnackBar(title: "General Remark Saved"));
            }
          }),
          BlocListener<SaveCceSubjectTeacherRemarksCubit,
              SaveCceSubjectTeacherRemarksState>(listener: (context, state) {
            if (state is SaveCceSubjectTeacherRemarksLoadSuccess) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(commonSnackBar(title: "Subject Remark Saved"));
            }
          }),
        ],
        child: Column(
          children: [
            Divider(color: Color(0xffECECEC), thickness: 2, height: 0),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  buildRemarkTypeDropdown(),
                  buildClassDropdown(),
                  if (selectedType == 0) buildTermDropdown(),
                ],
              ),
            ),
            Divider(color: Color(0xffECECEC), thickness: 2, height: 0),
            if (selectedType == 0)
              BlocConsumer<CceGeneralTeacherRemarksListCubit,
                  CceGeneralTeacherRemarksListState>(
                listener: (context, state) {
                  if (state is CceGeneralTeacherRemarksListLoadFail) {
                    if (state.failReason == "false") {
                      UserUtils.unauthorizedUser(context);
                    }
                  }
                  if (state is CceGeneralTeacherRemarksListLoadSuccess) {
                    setState(() {
                      generalRemarkList = state.remarksList;
                    });
                  }
                },
                builder: (context, state) {
                  if (state is CceGeneralTeacherRemarksListLoadInProgress) {
                    return CircularProgressIndicator();
                  } else if (state is CceGeneralTeacherRemarksListLoadSuccess) {
                    return buildGeneralRemarkBody(context);
                  } else if (state is CceGeneralTeacherRemarksListLoadFail) {
                    return noRecordFound();
                  } else {
                    return Container();
                  }
                },
              ),
            if (selectedType == 1)
              BlocConsumer<CceSubjectTeacherRemarksListCubit,
                  CceSubjectTeacherRemarksListState>(
                listener: (context, state) {
                  if (state is CceSubjectTeacherRemarksListLoadFail) {
                    if (state.failReason == "false") {
                      UserUtils.unauthorizedUser(context);
                    }
                  }
                  if (state is CceSubjectTeacherRemarksListLoadSuccess) {
                    setState(() {
                      List<CceSubjectTeacherRemarksListModel> finalRemarkList =
                          [];
                      List remarkList = state.remarksList;
                      for (var i = 0; i < remarkList.length; i++) {
                        List<Remarks> itemList = [];
                        List<ItemModel> item = [];

                        remarkList[i].forEach((subject, remark) =>
                            item.add(ItemModel.fromJson(subject, remark)));

                        item.forEach((element) => itemList.add(Remarks(
                            subject: element.subject, remark: element.remark)));

                        itemList.removeAt(0);
                        itemList.removeAt(0);

                        subjectRemarkList!
                            .add(CceSubjectTeacherRemarksListModel(
                          iD: i,
                          admNo: remarkList[i]["ADMNO"],
                          name: remarkList[i]["NAME"],
                          expanded: false,
                          remarks: itemList,
                        ));
                      }
                      print(
                          "CceSubjectTeacherRemarksList after Modify on UI : $subjectRemarkList");
                      // Future.delayed(Duration(seconds: 1))
                      //     .then((value) => subjectRemarkList = finalRemarkList);
                    });
                  }
                },
                builder: (context, state) {
                  if (state is CceSubjectTeacherRemarksListLoadInProgress) {
                    return LinearProgressIndicator();
                  } else if (state is CceSubjectTeacherRemarksListLoadSuccess) {
                    return buildSubjectRemarkBody(context);
                  } else if (state is CceSubjectTeacherRemarksListLoadFail) {
                    return noRecordFound();
                  } else {
                    return Container();
                  }
                },
              ),
          ],
        ),
      ),
    );
  }

  Expanded buildSubjectRemarkBody(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(10),
        child: ListView.separated(
          separatorBuilder: (context, mainIndex) => SizedBox(height: 10.0),
          itemCount: subjectRemarkList!.length,
          itemBuilder: (context, mainIndex) {
            var item = subjectRemarkList![mainIndex];
            return Container(
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xffECECEC)),
              ),
              child: ExpansionPanelList(
                animationDuration: Duration(milliseconds: 1000),
                // dividerColor: Colors.red,
                elevation: 0,
                children: [
                  ExpansionPanel(
                    canTapOnHeader: true,
                    backgroundColor: item.expanded!
                        ? Colors.blue.withOpacity(0.1)
                        : Colors.transparent,
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        // color: Colors.green,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name!,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${item.admNo!}",
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    body: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Divider(),
                          ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            separatorBuilder: (context, remarkIndex) =>
                                Divider(),
                            shrinkWrap: true,
                            itemCount: item.remarks!.length,
                            itemBuilder: (context, remarkIndex) {
                              var sub = item.remarks![remarkIndex];
                              return Row(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    child: Text(
                                      sub.subject!,
                                      textScaleFactor: 1.5,
                                      style: GoogleFonts.quicksand(
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  RemarksDropdown(
                                    index: 1,
                                    mainIndex: mainIndex,
                                    // selectedValue: 1,
                                    selectedValue:
                                        getSelectedSubjectIndex(sub.remark),
                                    remarkIndex: remarkIndex,
                                  ),
                                ],
                              );
                              // return buildRemarkDropDown(
                              //   title: sub.subject,
                              //     mainIndex: mainIndex,
                              //     remarkIndex: remarkIndex,
                              //     // selectedValue: selectedRemark,
                              //     selectedValue:
                              //         sub.remark != "" && sub.remark != null
                              //             ? TeacherRemarksListModel(
                              //                 id: sub.remark,
                              //                 remark: getRemarkName(sub.remark),
                              //               )
                              //             : selectedRemark,
                              //     dropdown: remarkListDropdown);
                            },
                          ),
                          SizedBox(height: 8.0),
                        ],
                      ),
                    ),
                    isExpanded: item.expanded!,
                  )
                ],
                expansionCallback: (int items, bool status) {
                  setState(() {
                    subjectRemarkList!.forEach((element) {
                      if (element.iD == item.iD) {
                        subjectRemarkList![mainIndex].expanded =
                            !subjectRemarkList![mainIndex].expanded!;
                      } else {
                        element.expanded = false;
                      }
                    });
                  });
                },
              ),
            );
          },
        ),
      ),
    );
  }

  int? getSelectedGeneralIndex(String? remark) {
    print("item.remarkID : ${remark}");
    final indexFinal =
        remarkListDropdown.indexWhere((element) => element.id == remark);
    return indexFinal;
  }

  int? getSelectedSubjectIndex(String? remark) {
    final indexFinal =
        remarkListDropdown.indexWhere((element) => element.id == remark);
    return indexFinal;
  }

  Expanded buildGeneralRemarkBody(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(10),
        // color: Colors.yellow,
        child: ListView.separated(
          separatorBuilder: (context, mainIndex) => SizedBox(height: 10.0),
          // itemCount: 1,
          itemCount: generalRemarkList!.length,
          itemBuilder: (context, mainIndex) {
            var item = generalRemarkList![mainIndex];
            print("item.remarkID : ${item.remarkID}");
            return Container(
              padding:
                  const EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xffECECEC)),
              ),
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 3,
                    child: Text(
                      item.stname!,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  RemarksDropdown(
                    index: 0,
                    mainIndex: mainIndex,
                    // selectedValue: 1,
                    selectedValue: getSelectedGeneralIndex(item.remarkID),
                    remarkIndex: -1,
                  ),
                  // RemarksDropdown(
                  //   index: 0,
                  //   mainIndex: mainIndex,
                  //   remarkIndex: 1,
                  //   // remarkIndex: remarkIndex,
                  //   // selectedValue: TeacherRemarksListModel(
                  //   //   id: sub.remark,
                  //   //   remark: getRemarkName(sub.remark),
                  //   // ),
                  // ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Flexible buildRemarkTypeDropdown() {
    return Flexible(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            buildLabels("Remark"),
            Container(
              child: DropdownButton<int>(
                isDense: true,
                value: selectedType,
                key: UniqueKey(),
                isExpanded: true,
                underline: Container(),
                items: typeDropdown
                    .map((item) => DropdownMenuItem<int>(
                        child: Text(
                            item == 0
                                ? "General Remark"
                                : "Subject Wise Remark",
                            style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold)),
                        value: item))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    selectedType = val;
                    selectedClass = classDropdown![0];
                    selectedTerm = 0;
                    generalRemarkList = [];
                    subjectRemarkList = [];
                  });
                  print("selectedType : $selectedType");
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
          ),
        ),
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
                    selectedTerm = 0;
                    selectedClass = val;
                    generalRemarkList = [];
                    remarkListDropdown = [];
                  });
                  print("selectedType 1 : $selectedType");
                  getRemarkDropdownList();
                  if (selectedType == 1 && selectedTerm == 0)
                    getSubjectRemarks();
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
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(width: 2, color: Color(0xffECECEC)),
          ),
        ),
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
                    generalRemarkList = [];
                  });
                  if (selectedType == 0 && selectedTerm != 0)
                    getGeneralRemarks();
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

  // buildRemarkDropDown(
  //     {int? mainIndex,
  //     int? remarkIndex,
  //     TeacherRemarksListModel? selectedValue,
  //     List<TeacherRemarksListModel>? dropdown,
  //     String? title}) {
  //   // selectedRemark = selectedValue;

  //   print("selectedRemark Faizan : $selectedRemark");
  //   print("selectedValue Faizan : $selectedValue");
  //   print("dropdown Faizan : $dropdown");
  //   // TeacherRemarksListModel? selectedItem =
  //   //     TeacherRemarksListModel(id: "", remark: "");
  //   // if (selectedValue!.id != "") {
  //   //   selectedItem = selectedValue;
  //   // }
  //   return Row(
  //     // crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Container(
  //         width: MediaQuery.of(context).size.width / 3,
  //         child: Text(
  //           title!,
  //           textScaleFactor: 1.5,
  //           style: GoogleFonts.quicksand(fontWeight: FontWeight.w500),
  //         ),
  //       ),
  //       RemarksDropdown(
  //           index: 1, mainIndex: mainIndex, remarkIndex: remarkIndex),
  //       // Flexible(
  //       //   child: Container(
  //       //     padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
  //       //     decoration: BoxDecoration(
  //       //         // border: Border.all(color: Color(0xffECECEC)),
  //       //         ),
  //       //     child: DropdownButton<TeacherRemarksListModel>(
  //       //       isDense: true,
  //       //       value: selectedValue,
  //       //       // value: getRemarkId(widget.remark),
  //       //       key: UniqueKey(),
  //       //       isExpanded: true,
  //       //       underline: Container(),
  //       //       items: dropdown!
  //       //           .map((remark) => DropdownMenuItem<TeacherRemarksListModel>(
  //       //               child:
  //       //                   Text(remark.remark!, style: TextStyle(fontSize: 12)),
  //       //               value: remark))
  //       //           .toList(),
  //       //       onChanged: (val) {
  //       //         // setState(() {
  //       //         //   selectedRemark = val;
  //       //         //   print("selectedValue: $val");
  //       //         // });
  //       //       },
  //       //     ),
  //       //   ),
  //       // )
  //     ],
  //   );
  // }
}

class RemarksDropdown extends StatefulWidget {
  final int? index;
  final int? mainIndex;
  final int? remarkIndex;
  final int? selectedValue;
  final int? value;
  // final TeacherRemarksListModel? selectedValue;
  // final List<TeacherRemarksListModel>? dropdown;
  const RemarksDropdown(
      {Key? key,
      this.index,
      this.mainIndex,
      this.remarkIndex,
      this.selectedValue,
      this.value})
      : super(key: key);

  @override
  _RemarksDropdownState createState() => _RemarksDropdownState();
}

class _RemarksDropdownState extends State<RemarksDropdown> {
  TeacherRemarksListModel? selectedRemark;
  @override
  void initState() {
    selectedRemark = remarkListDropdown[widget.selectedValue!];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildRemark(context);
    // return BlocConsumer<TeacherRemarksListCubit, TeacherRemarksListState>(
    //   listener: (context, state) {},
    //   builder: (context, state) {
    //     if (state is TeacherRemarksListLoadInProgress) {
    //       return CircularProgressIndicator();
    //     } else if (state is TeacherRemarksListLoadSuccess) {
    //       return buildRemark(context);
    //     } else if ()
    //   },
    // );
  }

  Flexible buildRemark(BuildContext context) {
    return Flexible(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(),
        child: DropdownButton<TeacherRemarksListModel>(
          isDense: true,
          // value: remarkListDropdown[widget.selectedValue!],
          value: selectedRemark,
          key: UniqueKey(),
          isExpanded: true,
          underline: Container(),
          items: remarkListDropdown
              .map((remark) => DropdownMenuItem<TeacherRemarksListModel>(
                  child: Text(remark.remark!, style: TextStyle(fontSize: 12)),
                  value: remark))
              .toList(),
          onChanged: (val) {
            setState(() {
              selectedRemark = val;
              if (widget.index == 0) {
                print(
                    'General Before : ${generalRemarkList![widget.mainIndex!].remarkID} & ${generalRemarkList![widget.mainIndex!].stname}}');
                setState(() {
                  generalRemarkList![widget.mainIndex!].remarkID =
                      selectedRemark!.id;
                });
                print(
                    'General After : ${generalRemarkList![widget.mainIndex!].remarkID} & ${generalRemarkList![widget.mainIndex!].stname}}');
              } else if (widget.index == 1) {
                print(
                    'Subject Before : ${subjectRemarkList![widget.mainIndex!].remarks} & ${subjectRemarkList![widget.mainIndex!].name}}');
                setState(() {
                  subjectRemarkList![widget.mainIndex!]
                      .remarks![widget.remarkIndex!]
                      .remark = selectedRemark!.id;
                });
                print(
                    'Subject After : ${subjectRemarkList![widget.mainIndex!].remarks} & ${subjectRemarkList![widget.mainIndex!].name}}');
              }
            });
          },
        ),
      ),
    );
  }
}

List<TeacherRemarksListModel> remarkListDropdown = [];
