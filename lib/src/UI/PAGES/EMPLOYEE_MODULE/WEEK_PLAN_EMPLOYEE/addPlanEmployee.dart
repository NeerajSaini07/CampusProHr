import 'package:campus_pro/src/DATA/BLOC_CUBIT/ADD_PLAN_EMPLOYEE_CUBIT/add_plan_employee_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/CLASS_LIST_EMPLOYEE_CUBIT/class_list_employee_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/WEEK_PLAN_SUBJECT_LIST_CUBIT/week_plan_subject_list_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/classListEmployeeModel.dart';
import 'package:campus_pro/src/DATA/MODELS/weekPlanSubjectListModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonSnackbar.dart';
import 'package:campus_pro/src/UTILS/fieldValidators.dart';
import 'package:campus_pro/src/WIDGETS_STYLE/style_common.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddPlanEmployee extends StatefulWidget {
  static const routeName = '/Add-Plan-Employee';

  @override
  _AddPlanEmployeeState createState() => _AddPlanEmployeeState();
}

class _AddPlanEmployeeState extends State<AddPlanEmployee> {
  TextEditingController titleController = TextEditingController();
  TextEditingController detailController = TextEditingController();

  List<ClassListEmployeeModel> classItem = [];

  List<WeekPlanSubjectListModel> subjectItem = [];
  String? subjectId;
  String? classId;
  ClassListEmployeeModel? dropDownClassValue;

  WeekPlanSubjectListModel? dropdownSubjectValue;
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
    print('Class list lesson planner $getEmpClassData');
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
      "ClassID":  classId.toString(),
      "StreamID":  streamId.toString(),
      "SectionID":  sectionId.toString(),
      "YearID":  yearID.toString(),
      "Schoolid": userData.schoolId,
      "SessionId": userData.currentSessionid,
      "EmpID": userData.stuEmpId,
    };
    print('Subject List lesson planner $getEmpSubData');
    context
        .read<WeekPlanSubjectListCubit>()
        .weekPlanSubjectListCubitCall(getEmpSubData);
  }

  submitPlanner(
      {String? title,
      String? todate,
      String? fromdate,
      String? detail,
      String? classid}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    print(classId);
    print(todate);
    print(fromdate);
    final submitPlanner = {
      "UserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Remark": "",
      "PlanId": "0",
      "PlanStatus": "0",
      "Title": title.toString(),
      "ToDate": todate.toString(),
      "FromDate": fromdate.toString(),
      "Detail": detail.toString(),
      "classId":
          //"204#23204#231418#231#231#233",
          classid.toString(),
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
    dropdownSubjectValue =
        WeekPlanSubjectListModel(subjectHead: '', subjectId: '');
    subjectItem = [];
    dropDownClassValue = ClassListEmployeeModel(iD: '', className: '');
    classItem = [];
    getEmployeeClass();
    isLoader = false;
  }

  GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //For fixing the position of floating action button.
      resizeToAvoidBottomInset: false,
      appBar: commonAppBar(
        context,
        title: 'Lesson Planner',
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding:
                    EdgeInsets.only(top: 12, bottom: 5, left: 18, right: 18),
                child: Row(
                  children: [
                    BlocConsumer<ClassListEmployeeCubit,
                        ClassListEmployeeState>(
                      listener: (context, state) {
                        if (state is ClassListEmployeeLoadSuccess) {
                          setState(() {
                            classId = state.classList[0].iD;

                            //classId = state.classList[0].iD!.split('#')[0];
                            dropDownClassValue = state.classList[0];
                            classItem = state.classList;
                          });
                          //print(dropDownClassValue!.className);
                          getEmployeeSubject(
                            classId: dropDownClassValue!.iD!.split('#')[0],
                            streamId: dropDownClassValue!.iD!.split('#')[1],
                            sectionId: dropDownClassValue!.iD!.split('#')[2],
                            yearID: dropDownClassValue!.iD!.split('#')[3],
                          );
                        }
                        if (state is ClassListEmployeeLoadFail) {
                          if (state.failReason == "false") {
                            UserUtils.unauthorizedUser(context);
                          }
                          setState(() {
                            dropDownClassValue =
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
                            subjectId =
                                state.subjectList[0].subjectId.toString();
                            dropdownSubjectValue = WeekPlanSubjectListModel(
                                subjectHead: '', subjectId: '');
                            subjectItem = [];
                            print(state.subjectList);
                            subjectItem = state.subjectList;
                            dropdownSubjectValue = state.subjectList[0];
                          });
                        }
                        if (state is WeekPlanSubjectListLoadFail) {
                          if (state.failReason == "false") {
                            UserUtils.unauthorizedUser(context);
                          }
                          setState(() {
                            subjectItem = [];
                            dropdownSubjectValue = WeekPlanSubjectListModel(
                                subjectHead: "", subjectId: '');
                          });
                        }
                      },
                      builder: (context, state) {
                        if (state is WeekPlanSubjectListLoadInProgress) {
                          return buildSubjectDropDown();
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
                    //buildSubjectDropDown(),
                  ],
                ),
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
                            style: Theme.of(context).textTheme.titleLarge,
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
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          buildDateSelector(
                            index: 1,
                            selectedDate: DateFormat("dd MMM yyyy")
                                .format(selectedToDate),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 18, top: 5, bottom: 5),
                child: Text(
                  'Title',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              buildTextField(
                controller: titleController,
                validator: FieldValidators.globalValidator,
                maxLines: 1,
              ),
              Padding(
                padding: EdgeInsets.only(left: 18, top: 10, bottom: 5),
                child: Text(
                  'Detail',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              buildTextField(
                controller: detailController,
                validator: FieldValidators.globalValidator,
                maxLines: 5,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.07,
              ),

              BlocConsumer<AddPlanEmployeeCubit, AddPlanEmployeeState>(
                  listener: (context, state) {
                if (state is AddPlanEmployeeLoadInProgress) {
                  setState(() {
                    isLoader = true;
                  });
                }
                if (state is AddPlanEmployeeLoadSuccess) {
                  setState(() {
                    isLoader = false;
                    titleController.text = "";
                    detailController.text = "";
                  });
                  // showDialog(
                  //     context: context,
                  //     builder: (context) {
                  //       return AlertDialog(
                  //         title: Text('Plan Added/Updated '),
                  //         actions: [
                  //           TextButton(
                  //             onPressed: () {
                  //               Navigator.pop(context);
                  //             },
                  //             child: Text('Back'),
                  //           )
                  //         ],
                  //       );
                  //     });
                  ScaffoldMessenger.of(context).showSnackBar(
                    commonSnackBar(
                      title: 'Plan Added/Updated ',
                      duration: Duration(seconds: 1),
                    ),
                  );
                }
                if (state is AddPlanEmployeeLoadFail) {
                  if (state.failReason == "false") {
                    UserUtils.unauthorizedUser(context);
                  }
                  setState(() {
                    isLoader = false;
                  });
                }
              }, builder: (context, state) {
                if (state is AddPlanEmployeeLoadInProgress) {
                  return buildSaveButton(context);
                } else if (state is AddPlanEmployeeLoadSuccess) {
                  return buildSaveButton(context);
                } else if (state is AddPlanEmployeeLoadFail) {
                  return buildSaveButton(context);
                } else {
                  return buildSaveButton(context);
                }
              })
              //buildSaveButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Center buildSaveButton(BuildContext context) {
    return isLoader == false
        ? Center(
            child: Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 8),
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
                  if (_key.currentState!.validate()) {
                    print('Test');
                    submitPlanner(
                        title: titleController.text,
                        detail: detailController.text,
                        todate:
                            DateFormat("dd-MMM-yyyy").format(selectedToDate),
                        fromdate:
                            DateFormat("dd-MMM-yyyy").format(selectedFromDate),
                        classid: classId! + "#" + subjectId!);
                  }
                },
                child: Text(
                  'Save',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                //customBorder: CircleBorder(),
              ),
            ),
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }

  Expanded buildClassDropDown() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Class',
            style: Theme.of(context).textTheme.titleLarge,
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
              value: dropDownClassValue,
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
                  dropDownClassValue = val;
                  print("selectedMonth: $val");
                  classId = dropDownClassValue!.iD;
                });
                dropdownSubjectValue =
                    WeekPlanSubjectListModel(subjectHead: '', subjectId: '');
                subjectItem = [];
                getEmployeeSubject(
                  classId: dropDownClassValue!.iD!.split('#')[0],
                  streamId: dropDownClassValue!.iD!.split('#')[1],
                  sectionId: dropDownClassValue!.iD!.split('#')[2],
                  yearID: dropDownClassValue!.iD!.split('#')[3],
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
            style: Theme.of(context).textTheme.titleLarge,
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
              value: dropdownSubjectValue,
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
                setState(
                  () {
                    dropdownSubjectValue = val!;
                    print("selectedMonth: $val");
                    subjectId = val.subjectId.toString();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  InkWell buildDateSelector({String? selectedDate, int? index}) {
    return InkWell(
        onTap: () => _selectDate(context),
        child: internalTextForDateTime(context,
            selectedDate: selectedDate,
            width: MediaQuery.of(context).size.width * 0.435)
        // Container(
        //   width: MediaQuery.of(context).size.width * 0.435,
        //   height: MediaQuery.of(context).size.height * 0.06,
        //   padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        //   decoration: BoxDecoration(
        //     border: Border.all(
        //       color: Color(0xffECECEC),
        //     ),
        //   ),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       Container(
        //         width: MediaQuery.of(context).size.width * 0.25,
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

  Container buildTextField({
    int? maxLines = 1,
    String? Function(String?)? validator,
    @required TextEditingController? controller,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        controller: controller,
        validator: validator,
        maxLines: maxLines ?? null,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          //counterText: "",
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
          hintText: "type here",
          hintStyle: TextStyle(color: Color(0xffA5A5A5)),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
        ),
      ),
    );
  }
}
