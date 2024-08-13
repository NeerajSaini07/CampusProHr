import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/DATE_SHEET_STUDENT_CUBIT/date_sheet_student_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/dateSheetStudentModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/drawerWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DateSheetStudent extends StatefulWidget {
  static const routeName = "/datesheet-student";
  @override
  _DateSheetStudentState createState() => _DateSheetStudentState();
}

class _DateSheetStudentState extends State<DateSheetStudent> {
  List<DateSheetStudentModel> examDropdown = [];
  DateSheetStudentModel? selectedExam;

  List<DateSheetStudentModel> dateSheetFilterList = [];
  // List<String> dropdownValueList = <String>[
  //   'MONDAY TEST 1',
  //   'April Monday Test',
  //   'UNI TEST'
  // ];
  // String? dropdownValue;

  @override
  void initState() {
    dateSheet();
    super.initState();
  }

  void dateSheet() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final dateSheetRequest = {
      "UserId": uid!,
      "Token": token!,
      "OrgId": userData!.organizationId,
      "SchoolId": userData.schoolId!,
      "SessionId": "6", //userData.currentSessionid!, //"6"
      "StudentId": userData.stuEmpId
    };
    context
        .read<DateSheetStudentCubit>()
        .dateSheetStudentCubitCall(dateSheetRequest);
  }

  _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000)).then((value) {
      dateSheet();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: commonAppBar(context, title: "DateSheet"),
      body: RefreshIndicator(
        onRefresh: () => _onRefresh(),
        child: MultiBlocListener(
          listeners: [
            BlocListener<DateSheetStudentCubit, DateSheetStudentState>(
              listener: (context, state) {
                if (state is DateSheetStudentLoadFail) {
                  if (state.failReason == "false") {
                    UserUtils.unauthorizedUser(context);
                  }
                }
                if (state is DateSheetStudentLoadSuccess) {
                  setState(() {
                    examDropdown = state.dateSheet;
                    selectedExam = state.dateSheet[0];
                    dateSheetFilterList = examDropdown
                        .where((val) => val.examId == selectedExam!.examId)
                        .toList();
                  });
                }
              },
            ),
          ],
          child: Column(
            children: [
              BlocConsumer<DateSheetStudentCubit, DateSheetStudentState>(
                listener: (context, state) {
                  if (state is DateSheetStudentLoadFail) {
                    if (state.failReason == "false") {
                      UserUtils.unauthorizedUser(context);
                    }
                  }
                },
                builder: (context, state) {
                  if (state is DateSheetStudentLoadInProgress) {
                    return Container();
                  } else if (state is DateSheetStudentLoadSuccess) {
                    return buildDropDownButton(context);
                  } else if (state is DateSheetStudentLoadFail) {
                    return Expanded(
                      child: Container(
                        child: Center(
                          child: Text(state.failReason,
                              style: commonStyleForText.copyWith(
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              if (dateSheetFilterList != [])
                buildExamDateSheet(context, dateSheet: dateSheetFilterList)
              else
                Expanded(
                    child:
                        Container(child: Center(child: Text(NO_RECORD_FOUND)))),
              // BlocConsumer<DateSheetStudentCubit, DateSheetStudentState>(
              //   listener: (context, state) {
              //     if (state is DateSheetStudentLoadFail) {
              //     }
              //   },
              //   builder: (context, state) {
              //     if (state is DateSheetStudentLoadInProgress) {
              //       return Center(child: CircularProgressIndicator());
              //     } else if (state is DateSheetStudentLoadSuccess) {
              //       return buildExamDateSheet(context, dateSheet: state.dateSheet);
              //     } else if (state is DateSheetStudentLoadFail) {
              //       return Center(child: Text(state.failReason));
              //     } else {
              //       return Center(child: CircularProgressIndicator());
              //     }
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildExamDateSheet(BuildContext context,
      {List<DateSheetStudentModel>? dateSheet}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: ListView.separated(
          physics: AlwaysScrollableScrollPhysics(),
          separatorBuilder: (context, index) => SizedBox(height: 10.0),
          shrinkWrap: true,
          itemCount: dateSheet!.length,
          itemBuilder: (BuildContext context, int i) {
            var item = dateSheet[i];
            return Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xffE1E3E8)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    // width: MediaQuery.of(context).size.width / 2.9,
                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffE1E3E8)),
                    ),
                    child: Column(
                      children: [
                        Container(
                          color: Theme.of(context).primaryColor,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(item.examDate!.split(" ")[1],
                              // textScaleFactor: 1.2,
                              style: TextStyle(color: Colors.white)),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Text(item.examDate!.split(" ")[0],
                              // textScaleFactor: 1.5,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    // child: Row(
                    //   children: [
                    //     buildTiming(
                    //         color: Theme.of(context).primaryColor,
                    //         title: item.timing!.split("-")[0]),
                    //     buildTiming(
                    //         color: Colors.blue[800],
                    //         title: item.timing!.split("-")[0]),
                    //   ],
                    // ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      // width: MediaQuery.of(context).size.width / 1.8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(item.subjectHead!,
                              style: TextStyle(
                                fontSize: 17,
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Text(
                                    item.syllabus!.isNotEmpty
                                        ? "Syllabus : ${item.syllabus!} ${item.syllabus!}${item.syllabus!}"
                                        : "Syllabus : N/A",
                                    // style: Theme.of(context)
                                    //     .textTheme
                                    //     .subtitle1!
                                    //     .copyWith(color: Colors.grey)
                                ),
                              ),
                              Column(
                                children: [
                                  Text(item.shift!,
                                      // textScaleFactor: 1.2,
                                      // style: Theme.of(context)
                                      //     .textTheme
                                      //     .headline6!
                                      //     .copyWith(
                                      //         color: Colors.green,
                                      //         fontSize: 14)
                                  ),
                                  Text(item.timing!,
                                      // // textScaleFactor: 1.2,
                                      // style: Theme.of(context)
                                      //     .textTheme
                                      //     .headline6!
                                      //     .copyWith(fontSize: 14)
                                  ),
                                ],
                              ),
                            ],
                          ),
                          // if (item.syllabus!.isNotEmpty)
                          //   Text("Syllabus : ${item.syllabus!}",
                          //       // textScaleFactor: 1.2,
                          //       style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Padding buildDropDownButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              "Select Exam :",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xffECECEC)),
              // borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButton<DateSheetStudentModel>(
              isDense: true,
              value: selectedExam,
              key: UniqueKey(),
              isExpanded: true,
              underline: Container(),
              onChanged: (newValue) {
                setState(() {
                  selectedExam = newValue;
                  print("selectedExam ${selectedExam!.exam}");
                  dateSheetFilterList = examDropdown
                      .where((val) => val.examId == selectedExam!.examId)
                      .toList();
                });

                print('examDropdown length = > ${examDropdown.length}');
                print(
                    'dateSheetFilterList length = > ${dateSheetFilterList.length}');
              },
              items: examDropdown.map<DropdownMenuItem<DateSheetStudentModel>>(
                  (DateSheetStudentModel value) {
                return DropdownMenuItem<DateSheetStudentModel>(
                  value: value,
                  child: Text(
                    value.exam!,
                    style: TextStyle(fontSize: 16),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Expanded buildTiming({Color? color, String? title}) {
    return Expanded(
      child: Container(
        color: color,
        padding: const EdgeInsets.all(8.0),
        width: (MediaQuery.of(context).size.width / 2.9) / 2,
        child: Center(
          child: Text(
            title!,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class ExamDropDown {
  String? examId = "";
  String? examName = "";

  ExamDropDown({this.examId, this.examName});
}
