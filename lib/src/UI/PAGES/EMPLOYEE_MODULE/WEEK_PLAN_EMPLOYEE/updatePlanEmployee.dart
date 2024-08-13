import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/ADD_PLAN_EMPLOYEE_CUBIT/add_plan_employee_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/CLASS_LIST_EMPLOYEE_CUBIT/class_list_employee_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/UPDATE_PLAN_EMPLOYEE_CUBIT/update_plan_employee_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/WEEK_PLAN_SUBJECT_LIST_CUBIT/week_plan_subject_list_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/classListEmployeeModel.dart';
import 'package:campus_pro/src/DATA/MODELS/updatePlanEmployeeModel.dart';
import 'package:campus_pro/src/DATA/MODELS/weekPlanSubjectListModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/PAGES/EMPLOYEE_MODULE/WEEK_PLAN_EMPLOYEE/addPlanEmployee.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/WIDGETS_STYLE/style_common.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../DATA/API_SERVICES/addPlanEmployeeApi.dart';
import '../../../../DATA/API_SERVICES/classListEmployeeApi.dart';
import '../../../../DATA/API_SERVICES/weekPlanSubjectListApi.dart';
import '../../../../DATA/REPOSITORIES/addPlanEmployeeRepository.dart';
import '../../../../DATA/REPOSITORIES/classListEmployeeRepository.dart';
import '../../../../DATA/REPOSITORIES/weekPlanSubjectListRepository.dart';

class WeekPlanEmployee extends StatefulWidget {
  static const routeName = '/week-plan-employee';
  @override
  _WeekPlanEmployeeState createState() => _WeekPlanEmployeeState();
}

class _WeekPlanEmployeeState extends State<WeekPlanEmployee> {
  List<TextEditingController> _controllers = [];

  DateTime selectedDate = DateTime.now();

  List<ClassListEmployeeModel> classItem = [];

  List<WeekPlanSubjectListModel> subjectItem = [];
  String? subjectId;
  String? classId;
  ClassListEmployeeModel? selectedClass;

  WeekPlanSubjectListModel? selectedSubject;
  bool? isLoader;

  DateTime selectedFromDate = DateTime.now();
  DateTime selectedToDate = DateTime.now();
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
    print('Class data $getEmpClassData');
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
    final updatePlan = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "ClassID": classId.toString(),
      "StreamID": streamId.toString(),
      "SectionID": sectionId.toString(),
      "YearID": yearID.toString(),
      "Schoolid": userData.schoolId,
      "SessionId": userData.currentSessionid,
      "EmpID": userData.stuEmpId,
    };
    print('update plan $updatePlan');
    context
        .read<WeekPlanSubjectListCubit>()
        .weekPlanSubjectListCubitCall(updatePlan);
  }

  getEmployeePlanList({String? classid, fromdate, todate}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final getEmpPlanList = {
      "UserId": uid!,
      "Token": token!,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "SessionId": userData.currentSessionid,
      "EmpId": userData.stuEmpId,
      "classId": classid.toString(),
      "FromDate": fromdate.toString(),
      "ToDate": todate.toString(),
    };
    print('Update List employee $getEmpPlanList');
    context
        .read<UpdatePlanEmployeeCubit>()
        .updatePlanEmployeeCubitCall(getEmpPlanList);
  }

  submitPlanner(
      {String? title,
      todate,
      fromdate,
      String? detail,
      String? classid,
      String? remark,
      String? planid}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    print(classId);
    final submitPlanner = {
      "UserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Remark": remark.toString(),
      "PlanId": planid.toString(),
      "PlanStatus": "1",
      "Title": title.toString(),
      "ToDate": todate.toString(),
      "FromDate": fromdate.toString(),
      "Detail": detail.toString(),
      "classId": classid.toString(),
      "Schoolid": userData.schoolId,
      "SessionId": userData.currentSessionid,
      "EmpId": userData.stuEmpId,
    };

    print('Submit planner $submitPlanner');
    context
        .read<AddPlanEmployeeCubit>()
        .addPlanEmployeeCubitCall(submitPlanner);
  }

  Future<void> _selectDate(BuildContext context, {int? index}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedFromDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      helpText: index == 0 ? "SELECT FROM DATE" : "SELECT TO DATE",
    );
    if (picked != null)
      setState(() {
        if (index == 0) {
          selectedFromDate = picked;
        } else {
          selectedToDate = picked;
        }
      });
  }

  @override
  void initState() {
    super.initState();
    selectedSubject = WeekPlanSubjectListModel(subjectHead: '', subjectId: '');
    subjectItem = [];
    selectedClass = ClassListEmployeeModel(iD: '', className: '');
    classItem = [];
    getEmployeeClass();
    isLoader = false;
    selectedFromDate = DateTime.now();
    selectedToDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, title: 'Week Planner'),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return BlocProvider<AddPlanEmployeeCubit>(
              create: (_) => AddPlanEmployeeCubit(
                  AddPlanEmployeeRepository(AddPlanEmployeeApi())),
              child: BlocProvider<WeekPlanSubjectListCubit>(
                create: (_) => WeekPlanSubjectListCubit(
                    WeekPlanSubjectListRepository(WeekPlanSubjectListApi())),
                child: BlocProvider<ClassListEmployeeCubit>(
                  create: (_) => ClassListEmployeeCubit(
                      ClassListEmployeeRepository(ClassListEmployeeApi())),
                  child: AddPlanEmployee(),
                ),
              ),
            );
          }));
          // Navigator.pushNamed(context, AddPlanEmployee.routeName);
        },
        child: Icon(Icons.add),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<AddPlanEmployeeCubit, AddPlanEmployeeState>(
              listener: (context, state) {
            if (state is AddPlanEmployeeLoadSuccess) {
              getEmployeePlanList(
                classid: classId! + "#" + subjectId!,
                todate: DateFormat('dd-MMM-yyyy').format(selectedToDate),
                fromdate: DateFormat('dd-MMM-yyyy').format(selectedFromDate),
              );
            }
            if (state is AddPlanEmployeeLoadFail) {
              if (state.failReason == "false") {
                UserUtils.unauthorizedUser(context);
              }
            }
          })
        ],
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 12, bottom: 5, left: 18, right: 18),
              child: Row(
                children: [
                  BlocConsumer<ClassListEmployeeCubit, ClassListEmployeeState>(
                    listener: (context, state) {
                      if (state is ClassListEmployeeLoadSuccess) {
                        setState(() {
                          classId = state.classList[0].iD;
                          selectedClass = state.classList[0];
                          classItem = state.classList;
                        });
                        //print(dropDownClassValue!.className);
                        getEmployeeSubject(
                          classId: selectedClass!.iD!.split('#')[0],
                          streamId: selectedClass!.iD!.split('#')[1],
                          sectionId: selectedClass!.iD!.split('#')[2],
                          yearID: selectedClass!.iD!.split('#')[3],
                        );
                      }
                      if (state is ClassListEmployeeLoadFail) {
                        if (state.failReason == "false") {
                          UserUtils.unauthorizedUser(context);
                        }
                        setState(() {
                          selectedClass =
                              ClassListEmployeeModel(iD: "", className: "");
                          classItem = [];
                        });
                      }
                    },
                    builder: (context, state) {
                      if (state is ClassListEmployeeLoadInProgress) {
                        return buildClassDropDown();
                        //return CircularProgressIndicator();
                      } else if (state is ClassListEmployeeLoadSuccess) {
                        return buildClassDropDown();
                      } else if (state is ClassListEmployeeLoadFail) {
                        return buildClassDropDown();
                      } else {
                        return Container();
                      }
                    },
                  ),
                  // buildClassDropDown(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),
                  BlocConsumer<WeekPlanSubjectListCubit,
                      WeekPlanSubjectListState>(
                    listener: (context, state) {
                      if (state is WeekPlanSubjectListLoadSuccess) {
                        setState(() {
                          subjectId = state.subjectList[0].subjectId.toString();
                          selectedSubject = WeekPlanSubjectListModel(
                              subjectHead: '', subjectId: '');
                          subjectItem = [];
                          print(state.subjectList);
                          subjectItem = state.subjectList;
                          selectedSubject = state.subjectList[0];
                        });
                        getEmployeePlanList(
                          classid: classId! + "#" + subjectId!,
                          todate:
                              DateFormat('dd-MMM-yyyy').format(selectedToDate),
                          fromdate: DateFormat('dd-MMM-yyyy')
                              .format(selectedFromDate),
                        );
                      }
                      if (state is WeekPlanSubjectListLoadFail) {
                        if (state.failReason == "false") {
                          UserUtils.unauthorizedUser(context);
                        }
                        setState(() {
                          subjectItem = [];
                          selectedSubject = WeekPlanSubjectListModel(
                              subjectHead: "", subjectId: "");
                        });
                      }
                    },
                    builder: (context, state) {
                      if (state is WeekPlanSubjectListLoadInProgress) {
                        return buildSubjectDropDown();
                        // return buildSubjectDropDown();
                      } else if (state is WeekPlanSubjectListLoadSuccess) {
                        return buildSubjectDropDown();
                      } else if (state is WeekPlanSubjectListLoadFail) {
                        return buildSubjectDropDown();
                        //return Container();
                      } else {
                        return Container();
                      }
                    },
                  )
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Padding(
              padding: EdgeInsets.only(left: 18, right: 18),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'From Date',
                          // style: Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        buildDateSelector(
                          index: 0,
                          selectedDate: DateFormat("dd MMM yyyy")
                              .format(selectedFromDate),
                        ),
                      ],
                    ),
                  ),
                  //Icon(Icons.arrow_right_alt_outlined),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'To Date',
                          // style: Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        buildDateSelector(
                          index: 1,
                          selectedDate:
                              DateFormat("dd MMM yyyy").format(selectedToDate),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            Center(
              child: Container(
                // width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                height: MediaQuery.of(context).size.height * 0.05,
                decoration: BoxDecoration(
                  border: Border.all(width: 0.2),
                  borderRadius: BorderRadius.circular(30),
                  color: Theme.of(context).primaryColor,
                ),
                child: InkWell(
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    getEmployeePlanList(
                      classid: classId! + "#" + subjectId!,
                      todate: DateFormat('dd-MMM-yyyy').format(selectedToDate),
                      fromdate:
                          DateFormat('dd-MMM-yyyy').format(selectedFromDate),
                    );
                  },
                  child: Text(
                    'Show Plan',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Divider(
              thickness: 5,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),

            BlocConsumer<UpdatePlanEmployeeCubit, UpdateEmployeeState>(
              listener: (context, state) {
                if (state is UpdateEmployeeLoadFail) {
                  if (state.failReason == "false") {
                    UserUtils.unauthorizedUser(context);
                  }
                }
              },
              builder: (context, state) {
                if (state is UpdateEmployeeLoadInProgress) {
                  // return CircularProgressIndicator();
                  return LinearProgressIndicator();
                } else if (state is UpdateEmployeeLoadSuccess) {
                  return checkPlanList(planList: state.PlanList);
                } else if (state is UpdateEmployeeLoadFail) {
                  return checkPlanList(error: state.failReason);
                  //return buildAttendanceList();
                } else {
                  return Container();
                }
              },
            ),

            // buildPlanList()
          ],
        ),
      ),
    );
  }

  Expanded checkPlanList(
      {List<UpdatePlanEmployeeModel>? planList, String? error}) {
    if (planList == null || planList.isEmpty) {
      if (error != null) {
        return Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(error),
            ],
          ),
        );
      } else {
        return Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                NO_RECORD_FOUND,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
            ],
          ),
        );
      }
    } else {
      return buildPlanList(planList: planList);
    }
  }

  Expanded buildPlanList({List<UpdatePlanEmployeeModel>? planList}) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(
          height: 3,
        ),
        itemCount: planList!.length,
        itemBuilder: (context, index) {
          _controllers.add(
            new TextEditingController(),
          );
          var itm = planList[index];
          return Container(
            margin: EdgeInsets.only(left: 18, right: 18, top: 6, bottom: 4),
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
                border: Border.all(width: 0.2),
                borderRadius: BorderRadius.circular(3),
                color: Colors.white),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: Row(
                        children: [
                          Text(
                            'Title : ',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.22,
                            child: Text(
                              '${itm.title.toString().toUpperCase()}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.today,
                          size: 15,
                          color: Theme.of(context).primaryColor,
                        ),
                        Text(
                          ' ${itm.FromDate} => '
                          '${itm.ToDate}',
                          style: TextStyle(
                              fontSize: 11.0, fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Detail : ${itm.detail} ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      //'${item[index][1]}',
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          'Status : ',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          itm.planStatus == '0' ? 'Active' : 'InActive',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: itm.planStatus == '0'
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: RichText(
                        text: TextSpan(
                          text: 'Remark : ',
                          style: TextStyle(
                            fontSize: 15,
                            //fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                              text: itm.remark == null
                                  ? " "
                                  : itm.remark.toString(),
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    // Row(
                    //   children: [
                    //     Text(
                    //       'Remark : ',
                    //       style: TextStyle(
                    //         fontSize: 15,
                    //         fontWeight: FontWeight.w600,
                    //       ),
                    //     ),
                    //     itm.remark == null
                    //         ? Text("")
                    //         : Text(
                    //             itm.remark.toString(),
                    //             style: TextStyle(
                    //               fontSize: 15,
                    //               fontWeight: FontWeight.w700,
                    //             ),
                    //           ),
                    //     // Text(
                    //     //   itm.remark == null ? " " : itm.remark.toString(),
                    //     //   style: TextStyle(
                    //     //     fontSize: 15,
                    //     //     fontWeight: FontWeight.w700,
                    //     //   ),
                    //     // ),
                    //   ],
                    // ),
                    itm.remark == ""
                        ? Row(
                            children: [
                              Text(
                                'Click Here To Add Remark  : ',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Container(
                                width:
                                    MediaQuery.of(context).size.width * 0.055,
                                height:
                                    MediaQuery.of(context).size.height * 0.028,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.black,
                                  ),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text(
                                              'Add Remark',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w900,
                                                fontSize: 18,
                                                color: Colors.black,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            contentPadding:
                                                const EdgeInsets.all(16.0),
                                            content: new Row(
                                              children: <Widget>[
                                                new Expanded(
                                                  child: new TextFormField(
                                                    controller:
                                                        _controllers[index],
                                                    autofocus: true,
                                                    decoration:
                                                        new InputDecoration(
                                                            labelText: 'Remark',
                                                            hintText:
                                                                'Enter Here'),
                                                  ),
                                                )
                                              ],
                                            ),
                                            actions: <Widget>[
                                              new TextButton(
                                                child: const Text('CANCEL'),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              new TextButton(
                                                  style: ButtonStyle(
                                                    overlayColor: _controllers[
                                                                    index]
                                                                .text
                                                                .length ==
                                                            0
                                                        ? MaterialStateProperty
                                                            .all(Colors
                                                                .transparent)
                                                        : MaterialStateProperty
                                                            .all(Colors
                                                                .cyanAccent),
                                                  ),
                                                  child: const Text('ADD'),
                                                  onPressed: () {
                                                    _controllers[index]
                                                                .text
                                                                .length ==
                                                            0
                                                        ? null
                                                        : setState(() {
                                                            //Todo
                                                            // print(
                                                            //     _controllers[index]
                                                            //         .text);
                                                            submitPlanner(
                                                                title:
                                                                    itm.title,
                                                                detail:
                                                                    itm.detail,
                                                                todate:
                                                                    itm.ToDate,
                                                                fromdate: itm
                                                                    .FromDate,
                                                                classid: classId! +
                                                                    "#" +
                                                                    subjectId!,
                                                                //itm.id,
                                                                planid: itm.id,
                                                                remark:
                                                                    _controllers[
                                                                            index]
                                                                        .text);

                                                            // getEmployeePlanList(
                                                            //   classid: classId! +
                                                            //       "#" +
                                                            //       subjectId!,
                                                            //   todate: DateFormat(
                                                            //           'dd-MMM-yyyy')
                                                            //       .format(
                                                            //           selectedToDate),
                                                            //   fromdate: DateFormat(
                                                            //           'dd-MMM-yyyy')
                                                            //       .format(
                                                            //           selectedFromDate),
                                                            // );
                                                            Navigator.pop(
                                                                context);
                                                          });
                                                  })
                                            ],
                                          );
                                        });
                                  },
                                  child: Text(' '),
                                ),
                              ),
                            ],
                          )
                        : Container()
                  ],
                )
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Row(
                //       children: [
                //         Text(
                //           '${item[index][3]} : ',
                //           style: TextStyle(
                //             fontWeight: FontWeight.bold,
                //           ),
                //         ),
                //         item[index][5] == '0'
                //             ? Container()
                //             : Text(
                //                 '${item[index][6]}',
                //                 style: TextStyle(
                //                   fontWeight: FontWeight.bold,
                //                 ),
                //               ),
                //       ],
                //     ),
                //     item[index][5] == '0'
                //         ? Container(
                //             width: MediaQuery.of(context).size.width * 0.055,
                //             height: MediaQuery.of(context).size.height * 0.028,
                //             decoration: BoxDecoration(
                //               borderRadius: BorderRadius.circular(3),
                //               border: Border.all(width: 1),
                //             ),
                //             child: InkWell(
                //               onTap: () {
                //                 showDialog(
                //                     context: context,
                //                     builder: (context) {
                //                       return AlertDialog(
                //                         title: Text('Add Remark'),
                //                         contentPadding:
                //                             const EdgeInsets.all(16.0),
                //                         content: new Row(
                //                           children: <Widget>[
                //                             new Expanded(
                //                               child: new TextFormField(
                //                                 controller: _controllers[index],
                //                                 autofocus: true,
                //                                 decoration: new InputDecoration(
                //                                     labelText: 'Remark',
                //                                     hintText: 'Enter Here'),
                //                               ),
                //                             )
                //                           ],
                //                         ),
                //                         actions: <Widget>[
                //                           new TextButton(
                //                             child: const Text('CANCEL'),
                //                             onPressed: () {
                //                               // setState(() {
                //                               //   // item[index][5] = '1';
                //                               //   // item[index].add('');
                //                               // });
                //                               Navigator.pop(context);
                //                             },
                //                           ),
                //                           new TextButton(
                //                               child: const Text('ADD'),
                //                               onPressed: () {
                //                                 _controllers[index]
                //                                             .text
                //                                             .length ==
                //                                         0
                //                                     ? null
                //                                     : setState(() {
                //                                         item[index].add(
                //                                             _controllers[index]
                //                                                 .text);
                //                                         // item[index][6] =
                //                                         //     _controllers[index]
                //                                         //         .text;
                //                                         item[index][5] = '1';
                //                                         Navigator.pop(context);
                //                                       });
                //                               })
                //                         ],
                //                       );
                //                     });
                //               },
                //               child: Text(' '),
                //             ),
                //           )
                //         : Container()
                //   ],
                // ),
              ],
            ),
          );
        },
      ),
    );
  }

  InkWell buildDateSelector({String? selectedDate, int? index}) {
    return InkWell(
      onTap: () => _selectDate(context, index: index),
      child: internalTextForDateTime(context, selectedDate: selectedDate),
      // Container(
      //   width: MediaQuery.of(context).size.width,
      //   padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      //   decoration: BoxDecoration(
      //     border: Border.all(color: Color(0xffECECEC)),
      //   ),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       Container(
      //         width: MediaQuery.of(context).size.width / 4,
      //         child: Text(
      //           selectedDate!,
      //           overflow: TextOverflow.visible,
      //           maxLines: 1,
      //         ),
      //       ),
      //       Icon(Icons.today, color: Theme.of(context).primaryColor)
      //     ],
      //   ),
      // ),
    );
  }

  Expanded buildClassDropDown() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Class',
            // style: Theme.of(context).textTheme.headline6,
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
            child: DropdownButton<ClassListEmployeeModel>(
              isDense: true,
              value: selectedClass,
              key: UniqueKey(),
              isExpanded: true,
              underline: Container(),
              items: classItem
                  .map((item) => DropdownMenuItem<ClassListEmployeeModel>(
                        value: item,
                        child: Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            item.className!,
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.w300),
                          ),
                        ),
                      ))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  selectedClass = val;
                  print("selectedMonth: $val");
                  classId = selectedClass!.iD;
                });
                selectedSubject =
                    WeekPlanSubjectListModel(subjectHead: '', subjectId: '');
                subjectItem = [];
                getEmployeeSubject(
                  classId: selectedClass!.iD!.split('#')[0],
                  streamId: selectedClass!.iD!.split('#')[1],
                  sectionId: selectedClass!.iD!.split('#')[2],
                  yearID: selectedClass!.iD!.split('#')[3],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Expanded buildSubjectDropDown() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Subject',
            // style: Theme.of(context).textTheme.headline6,
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
            child: DropdownButton<WeekPlanSubjectListModel>(
              isDense: true,
              value: selectedSubject,
              key: UniqueKey(),
              isExpanded: true,
              underline: Container(),
              items: subjectItem
                  .map((item) => DropdownMenuItem<WeekPlanSubjectListModel>(
                        value: item,
                        child: Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            item.subjectHead!,
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.w300),
                          ),
                        ),
                      ))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  selectedSubject = val!;
                  print("selectedMonth: $val");
                  subjectId = val.subjectId.toString();
                });
                getEmployeePlanList(
                    classid: classId! + "#" + subjectId!,
                    todate: selectedToDate,
                    fromdate: selectedFromDate);
              },
            ),
          ),
        ],
      ),
    );
  }
}
