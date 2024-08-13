import 'dart:convert';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/ASSIGN_CLASS_TEACHER_ADMIN_CUBIT/assign_class_teacher_admin_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/ASSIGN_PERIOD_ADMIN_CUBIT/assign_period_admin_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/EMPLOYEE_INFO_FOR_SEARCH_CUBIT/employee_info_for_search_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/GET_CLASSWISE_SUBJECT_ADMIN_CUBIT/get_classwise_subject_admin_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/GET_CLASS_SECTION_ADMIN_CUBIT/get_class_section_admin_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/GET_SELECT_CLASS_TEACHER_CUBIT/get_select_class_teacher_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/LOAD_ALLOTTED_SUBJECT_CUBIT/load_allotted_subject_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/LOAD_CLASS_FOR_SMS_CUBIT/load_class_for_sms_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/LOAD_CLASS_FOR_SUBJECT_ADMIN_CUBIT/load_class_for_subject_admin_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/MARK_ATTENDANCE_PERIOD_EMPLOYEE_CUBIT/mark_attendance_employee_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/REMOVE_ALLOTTED_SUBJECT_CUBIT/remove_allotted_subject_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/SUBJECT_ALLOTE_TO_TEACHER_CUBIT/subject_allote_to_teacher_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/employeeInfoForSearchModel.dart';
import 'package:campus_pro/src/DATA/MODELS/getClassSectionAdminModel.dart';
import 'package:campus_pro/src/DATA/MODELS/getClasswiseSubjectAdminModel.dart';
import 'package:campus_pro/src/DATA/MODELS/loadAllottedSubjectsModel.dart';
import 'package:campus_pro/src/DATA/MODELS/loadClassForSmsModel.dart';
import 'package:campus_pro/src/DATA/MODELS/loadClassForSubjectAdminModel.dart';
import 'package:campus_pro/src/DATA/MODELS/markAttendacePeriodsEmployeeModel.dart';
import 'package:campus_pro/src/DATA/MODELS/searchEmployeeFromRecordsCommonModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonSnackbar.dart';
import 'package:campus_pro/src/UI/WIDGETS/searchEmployeeFromRecordsCommon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

class TeacherAssignAdmin extends StatefulWidget {
  static const routeName = '/Teacher-Assign-Admin';
  const TeacherAssignAdmin({Key? key}) : super(key: key);

  @override
  _TeacherAssignAdminState createState() => _TeacherAssignAdminState();
}

class _TeacherAssignAdminState extends State<TeacherAssignAdmin> {
  TextEditingController employeeNameController = TextEditingController();
  int _selectedIndex = 0;

  SearchEmployeeFromRecordsCommonModel? selectedEmployee;

  //Multi Class Select variables
  List<Map<String, dynamic>>? finalClassList;
  List<LoadClassForSmsModel>? classList;
  List<LoadClassForSmsModel>? _selectedClassList = [];
  final _classSelectKey = GlobalKey<FormFieldState>();
  List<LoadClassForSmsModel>? selectedDropDownClassList = [];
  //

  //section Multi Dropdown
  List<Map<String, dynamic>>? finalSectionList = [];
  List<GetClassSectionAdminModel>? sectionList;
  List _selectedSectionList = [];
  final _sectionSelectKey = GlobalKey<FormFieldState>();
  //

  //period dropdown
  List<Map<String, String>> finalPeriodList = [];
  List<MarkAttendacePeriodsEmployeeModel>? periodList;

  List _selectedPeriodList = [];
  List? collectionOfSelectedPeriodList = [];
  List? periodListForTeacherAssign = [];
  List? totalPeriodsSelection = [];
  //

  //class dropdown
  List? classidFinal;
  List<LoadClassForSubjectAdminModel>? classItems1;
  LoadClassForSubjectAdminModel? selectedClass;
  //

  //subject dropdown
  List finalSubjectList = [];
  List<GetClasswiseSubjectAdminModel>? subjectList;
  List _selectedSubjectList = [];
  final _subjectSelectKey = GlobalKey<FormFieldState>();
  //

  List<LoadAllottedSubjectsModel>? loadAllottedSubjectList;
  bool subjectListCheck = false;

  String? empNo = "";
  String? name = "";
  String? fatherName = "";
  String? designation = "";
  String? group = "";
  int? empId;

  // final List<Map<String, dynamic>> _allUsers = [
  //   {"id": 1, "name": "Andy", "age": 29},
  //   {"id": 2, "name": "Aragon", "age": 40},
  //   {"id": 3, "name": "Bob", "age": 5},
  //   {"id": 4, "name": "Barbara", "age": 35},
  //   {"id": 5, "name": "Candy", "age": 21},
  //   {"id": 6, "name": "Colin", "age": 55},
  //   {"id": 7, "name": "Audra", "age": 30},
  //   {"id": 8, "name": "Banana", "age": 14},
  //   {"id": 9, "name": "Caversky", "age": 100},
  //   {"id": 10, "name": "Becky", "age": 32},
  // ];
  //
  // bool isCheck = false;
  //
  // final List<DropdownMenuItem<String>> classItem = item
  //     .map(
  //         (String e) => DropdownMenuItem<String>(value: e, child: Text('${e}')))
  //     .toList();

  // final List<DropdownMenuItem<String>> subjectItem = item1
  //     .map((String e) => DropdownMenuItem<String>(value: e, child: Text('$e')))
  //     .toList();

  // void _runFilter(String enteredKeyword) {
  //   List<Map<String, dynamic>> results = [];
  //   if (enteredKeyword.isEmpty) {
  //     // if the search field is empty or only contains white-space, we'll display all users
  //     //results = _allUsers;
  //   } else {
  //     results = _allUsers
  //         .where((user) =>
  //             user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
  //         .toList();
  //     // we use the toLowerCase() method to make it case-insensitive
  //   }
  //
  //   // Refresh the UI
  //   setState(() {
  //     _foundUsers = results;
  //   });
  // }

  List customClassListBool = [];

  List<List<Map<String, bool>>> customPeriodListBool = [];

  getAdminSubject({String? classId}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final getSubData = {
      "OUserId": uid,
      "Token": token,
      "StuEmpId": userData!.stuEmpId,
      "OrgId": userData.organizationId,
      "Schoolid": userData.schoolId,
      "UserType": userData.ouserType,
      "ClassID": classId.toString(),
    };

    print('Get Admin Subject $getSubData');
    context
        .read<GetClasswiseSubjectAdminCubit>()
        .getClasswiseSubjectAdminCubitCall(getSubData);
  }

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

  getEmployeePeriod({String? classid}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final getEmpPeriodData = {
      "OUserId": uid!,
      "Token": token!,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "SessionId": userData.currentSessionid,
      "EmpID": userData.stuEmpId,
      //"ClassIds": classid.toString(),
      "ClassIds": classid.toString(),
      'UserType': userData.ouserType,
    };
    print('Get Employee PeriodList $getEmpPeriodData');
    context
        .read<MarkAttendancePeriodsEmployeeCubit>()
        .markAttendancePeriodsEmployeeCubitCall(getEmpPeriodData, 0);
  }

  saveClassTeacher({List<Map<String, dynamic>>? classid, int? empid}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userdata = await UserUtils.userTypeFromCache();

    final sendingSaveClass = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userdata!.organizationId,
      "Schoolid": userdata.schoolId,
      "SessionID": userdata.currentSessionid,
      "EmpID": empid.toString(),
      "JsonData": jsonEncode(classid),
      //[{"ClassID":"277#277#1799#1#1"},{"ClassID":"204#204#1424#1#1"},{"ClassID":"204#204#1445#1#1"},{"ClassID":"205#205#1428#1#1"},{"ClassID":"206#206#1769#1#1"}]
      "StuEmpId": userdata.stuEmpId,
      "UserType": userdata.ouserType,
    };

    print('sending save class teacher $sendingSaveClass');

    context
        .read<AssignClassTeacherAdminCubit>()
        .assignClassTeacherAdminCubitCall(sendingSaveClass);
  }

  getClassForSubject() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final sendingClassForSubject = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "StuEmpId": userData.stuEmpId,
      "Usertype": userData.ouserType,
    };

    print('Sending class for subject $sendingClassForSubject');

    context
        .read<LoadClassForSubjectAdminCubit>()
        .loadClassForSubjectAdminCubitCall(sendingClassForSubject);
  }

  getClassSection({String? classid}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final sendingSectionData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "ClassId": classid.toString(),
      "StuEmpId": userData.stuEmpId,
      "Usertype": userData.ouserType,
    };
    print('sending data for section data $sendingSectionData');

    context
        .read<GetClassSectionAdminCubit>()
        .getClassSectionAdminCubitCall(sendingSectionData);
  }

  alloteSuject(
      {String? classid,
      String? subjectid,
      String? empid,
      List<Map<String, dynamic>>? sectionid}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final sendingData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "SessionID": userData.currentSessionid,
      "ClassID": classid.toString(),
      "SubjectID": subjectid.toString(),
      "JsonSection": jsonEncode(sectionid),
      //[{"SectionID":"1799"}],
      "EmpId": empid.toString(),
      //userData.stuEmpId,
      "StuempId": userData.stuEmpId,
      "Usertype": userData.ouserType,
    };

    print('sending data for allote subject $sendingData');

    context
        .read<SubjectAlloteToTeacherCubit>()
        .subjectAlloteToTeacherCubitCall(sendingData);
  }

  getAllottedSubjectList({String? empid}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final sendingData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "SessionID": userData.currentSessionid,
      "EmpId": empid.toString(),
      "StuEmpId": userData.stuEmpId,
      "UserType": userData.ouserType,
    };
    print('sending data for allotted subject $sendingData');

    context
        .read<LoadAllottedSubjectCubit>()
        .loadAllottedSubjectCubitCall(sendingData);
  }

  deletedAllottedSubject({String? data, String? empid, String? nulll}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final sendingData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "SessionID": userData.currentSessionid,
      "EmpId": empid.toString(),
      "Data": data.toString(),
      //277.1799.277.1.1,
      "PeriodID": 'nulll',
      "removetype": 's',
      "StuEmpId": userData.stuEmpId,
      "UserType": userData.ouserType,
    };
    print('sending data for remove allotted period $sendingData');
    context
        .read<RemoveAllottedSubjectCubit>()
        .removeAllottedSubjectCubitCall(sendingData);
  }

  assignPeriod({List<Map<String, String>>? data, String? empid}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final sendingDataPeriod = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "SessionId": userData.currentSessionid,
      "EmpID": empid.toString(),
      "JsonData": jsonEncode(data),
      //[{"PireodID":"2","ClassID":"205","SectionID":"1428","StreamID":"205","YearID":"1","SubjectID":"1"},{"PireodID":"3","ClassID":"205","SectionID":"1428","StreamID":"205","YearID":"1","SubjectID":"1"},{"PireodID":"-1","ClassID":"277","SectionID":"1799","StreamID":"277","YearID":"1","SubjectID":"1"},{"PireodID":"-1","ClassID":"204","SectionID":"1418","StreamID":"204","YearID":"1","SubjectID":"3"},{"PireodID":"-1","ClassID":"204","SectionID":"1424","StreamID":"204","YearID":"1","SubjectID":"3"},{"PireodID":"-1","ClassID":"204","SectionID":"1445","StreamID":"204","YearID":"1","SubjectID":"3"},{"PireodID":"4","ClassID":"207","SectionID":"1421","StreamID":"207","YearID":"1","SubjectID":"7"}]↵
      "UpdatedByID": userData.stuEmpId,
      "StuEmpId": userData.stuEmpId,
      "UserType": userData.ouserType,
    };

    print('sending data for assign period $sendingDataPeriod');
    context
        .read<AssignPeriodAdminCubit>()
        .assignPeriodAdminCubitCall(sendingDataPeriod);
  }

  getSelectedClass({String? empid}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final sendingSelectedClassData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "SessionID": userData.currentSessionid,
      "EmpID": empid.toString(),
      "StuEmpId": userData.stuEmpId,
      "UserType": userData.ouserType,
    };

    print(
        'sending data for get select class teacher $sendingSelectedClassData');

    context
        .read<GetSelectClassTeacherCubit>()
        .getSelectClassTeacherCubitCall(sendingSelectedClassData);
  }

  @override
  void initState() {
    super.initState();
    empNo = "";
    name = "";
    fatherName = "";
    designation = "";
    group = "";
    empId = -1;
    classItems1 = [];
    selectedClass = LoadClassForSubjectAdminModel(
        classDisplayOrder: "", classId: "", className: "");
    classList = [];
    finalClassList = [];
    subjectList = [];
    finalSubjectList = [];
    sectionList = [];
    classidFinal = [];
    loadAllottedSubjectList = [];
    getClass();
    getClassForSubject();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 20,
        selectedLabelStyle: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).primaryColor,
        ),
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
        selectedIconTheme: IconThemeData(size: 25),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: 'Class Teacher \n Assign',
            icon: Icon(
              Icons.person,
            ),
          ),
          BottomNavigationBarItem(
              label: 'Assigned \n Subjects', icon: Icon(Icons.person)),
          BottomNavigationBarItem(
            label: 'Detail \n',
            icon: Icon(Icons.person),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (ind) {
          setState(() {
            _selectedIndex = ind;
          });
        },
      ),
      appBar: commonAppBar(context, title: 'Teacher Assign'),
      body: MultiBlocListener(
        listeners: [
          BlocListener<EmployeeInfoForSearchCubit, EmployeeInfoForSearchState>(
            listener: (context, state) {
              if (state is EmployeeInfoForSearchLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                }
              }
              if (state is EmployeeInfoForSearchLoadSuccess) {
                setState(() {
                  // selectedEmployee = state.employeeInfoData;
                  empNo = selectedEmployee!.empno;
                  name = selectedEmployee!.name;
                  fatherName = selectedEmployee!.fatherName;
                  designation = selectedEmployee!.deptName;
                  group = selectedEmployee!.groupName;
                  empId = int.parse(selectedEmployee!.empId!);
                });
                setState(() {
                  periodListForTeacherAssign = [];
                  totalPeriodsSelection = [];
                  collectionOfSelectedPeriodList = [];
                });
                getSelectedClass(empid: empId.toString());
                getAllottedSubjectList(empid: empId.toString());
              }
            },
          ),
          BlocListener<AssignClassTeacherAdminCubit,
              AssignClassTeacherAdminState>(listener: (context, state) {
            if (state is AssignClassTeacherAdminLoadFail) {
              if (state.failReason == 'false') {
                UserUtils.unauthorizedUser(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(commonSnackBar(
                    title: '${state.failReason}',
                    duration: Duration(seconds: 1)));
              }
            }
            if (state is AssignClassTeacherAdminLoadSuccess) {
              setState(() {
                // finalClassList = [];
                // _selectedClassList = [];
                // selectedEmployee = null;
              });
              ScaffoldMessenger.of(context).showSnackBar(commonSnackBar(
                  title: 'Teacher Assigned', duration: Duration(seconds: 1)));
              // getClass();
            }
          }),
          BlocListener<LoadClassForSubjectAdminCubit,
              LoadClassForSubjectAdminState>(
            listener: (context, state) {
              if (state is LoadClassForSubjectAdminLoadFail) {
                if (state.failReason == 'false') {
                  UserUtils.unauthorizedUser(context);
                } else {
                  setState(() {
                    classItems1 = [];
                    selectedClass = LoadClassForSubjectAdminModel(
                        classDisplayOrder: "", classId: "", className: "");
                  });
                }
              }
              if (state is LoadClassForSubjectAdminLoadSuccess) {
                setState(() {
                  classItems1 = state.classList;
                  selectedClass = state.classList[0];
                  classidFinal!.add(state.classList[0].classId);
                });
                getAdminSubject(classId: selectedClass!.classId);
                getClassSection(classid: selectedClass!.classId!.split("#")[0]);
              }
            },
          ),
          BlocListener<GetClasswiseSubjectAdminCubit,
              GetClasswiseSubjectAdminState>(listener: (context, state) {
            if (state is GetClasswiseSubjectAdminLoadFail) {
              if (state.failReason == 'false') {
                UserUtils.unauthorizedUser(context);
              } else {
                subjectList = [];
              }
            }
            if (state is GetClasswiseSubjectAdminLoadSuccess) {
              setState(() {
                subjectList = state.subjectList;
              });
            }
          }),
          BlocListener<GetClassSectionAdminCubit, GetClassSectionAdminState>(
              listener: (context, state) {
            if (state is GetClassSectionAdminLoadFail) {
              if (state.failReason == 'false') {
                UserUtils.unauthorizedUser(context);
              } else {
                sectionList = [];
              }
            }
            if (state is GetClassSectionAdminLoadSuccess) {
              setState(() {
                sectionList = state.sectionList;
              });
            }
          }),
          BlocListener<SubjectAlloteToTeacherCubit,
              SubjectAlloteToTeacherState>(listener: (context, state) {
            if (state is SubjectAlloteToTeacherLoadFail) {
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
            if (state is SubjectAlloteToTeacherLoadSucces) {
              if (state.success == "Success") {
                setState(() {
                  subjectList = [];
                  sectionList = [];
                  _selectedSubjectList = [];
                  _selectedSectionList = [];
                  finalSectionList = [];
                  finalSubjectList = [];
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  commonSnackBar(
                    title: 'Subject Allotted',
                    duration: Duration(seconds: 1),
                  ),
                );
                getAdminSubject(classId: selectedClass!.classId);
                getClassSection(classid: selectedClass!.classId!.split("#")[0]);
                getAllottedSubjectList(empid: empId.toString());
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  commonSnackBar(
                    title: '${state.success}',
                    duration: Duration(seconds: 1),
                  ),
                );
              }
            }
          }),
          BlocListener<LoadAllottedSubjectCubit, LoadAllottedSubjectState>(
              listener: (context, state) {
            if (state is LoadAllottedSubjectLoadFail) {
              if (state.failReason == 'false') {
                UserUtils.unauthorizedUser(context);
              } else {
                setState(() {
                  subjectListCheck = true;
                });
              }
            }
            if (state is LoadAllottedSubjectLoadSuccess) {
              getEmployeePeriod(classid: classList![0].classId);
              setState(() {
                subjectListCheck = true;
                loadAllottedSubjectList = state.subjectListt;
              });
            }
          }),
          BlocListener<RemoveAllottedSubjectCubit, RemoveAllottedSubjectState>(
              listener: (context, state) {
            if (state is RemoveAllottedSubjectLoadFail) {
              if (state.failReason == 'false') {
                UserUtils.unauthorizedUser(context);
              }
            }
            if (state is RemoveAllottedSubjectLoadSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                commonSnackBar(
                  title: 'Deleted',
                  duration: Duration(seconds: 1),
                ),
              );
              setState(() {
                periodListForTeacherAssign = [];
                totalPeriodsSelection = [];
                collectionOfSelectedPeriodList = [];
              });
              getAllottedSubjectList(empid: empId.toString());
            }
          }),
          BlocListener<MarkAttendancePeriodsEmployeeCubit,
              MarkAttendanceEmployeeState>(listener: (context, state) {
            if (state is MarkAttendanceEmployeeLoadFail) {
              if (state.failReason == 'false') {
                UserUtils.unauthorizedUser(context);
              }
            }
            if (state is MarkAttendanceEmployeeLoadSuccess) {
              setState(() {
                //periodList = state.periodList[0].periodname;
                periodList = state.periodList;
              });

              ///
              customPeriodListBool = [];
              // for (int i = 0; i < loadAllottedSubjectList!.length - 1; i++) {
              //   String selPeriodString = loadAllottedSubjectList![i].periodID!;
              //   List selPeriod = selPeriodString.split(",");
              //   periodList!.forEach((ele) {
              //     if (selPeriod.contains(ele.periodid)) {
              //       customPeriodListBool[i].addAll({ele.periodid!: true});
              //     } else {
              //       customPeriodListBool[i].addAll({ele.periodid!: false});
              //     }
              //   });
              // }

              for (int i = 0; i < loadAllottedSubjectList!.length; i++) {
                customPeriodListBool.add([]);
                for (int j = 0; j < periodList!.length; j++) {
                  customPeriodListBool[i].add({});
                }
              }

              print(customPeriodListBool);
              for (int i = 0; i < loadAllottedSubjectList!.length; i++) {
                String selPeriodString = loadAllottedSubjectList![i].periodID!;
                List selPeriod = selPeriodString.split(",");
                for (int j = 0; j < periodList!.length; j++) {
                  if (selPeriod.contains(periodList![j].periodid)) {
                    customPeriodListBool[i][j]
                        .addAll({periodList![j].periodid!: true});
                  } else {
                    customPeriodListBool[i][j]
                        .addAll({periodList![j].periodid!: false});
                  }
                }
              }

              print("customPeriodListBool$customPeriodListBool");

              ///
            }
          }),
          BlocListener<AssignPeriodAdminCubit, AssignPeriodAdminState>(
              listener: (context, state) {
            if (state is AssignPeriodAdminLoadFail) {
              if (state.failReason == 'false') {
                UserUtils.unauthorizedUser(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(commonSnackBar(
                    title: '${state.failReason}',
                    duration: Duration(seconds: 1)));
              }
            }
            if (state is AssignPeriodAdminLoadSuccess) {
              //Todo:Fix
              setState(() {
                periodListForTeacherAssign = [];
                totalPeriodsSelection = [];
                collectionOfSelectedPeriodList = [];
              });
              getAllottedSubjectList(empid: empId.toString());
              //
              setState(() {
                finalPeriodList = [];
              });
              ScaffoldMessenger.of(context).showSnackBar(commonSnackBar(
                  title: 'Period Assigned', duration: Duration(seconds: 1)));
            }
          }),
          BlocListener<GetSelectClassTeacherCubit, GetSelectClassTeacherState>(
              listener: (context, state) {
            if (state is GetSelectClassTeacherLoadFail) {
              if (state.failReason == 'false') {
                UserUtils.unauthorizedUser(context);
              }
            }
            if (state is GetSelectClassTeacherLoadSuccess) {
              ///new
              setState(() {
                finalClassList = [];
              });

              //print(selectedClassListCoordinator);
              for (int v = 0; v < classList!.length; v++) {
                setState(() {
                  customClassListBool[v] = false;
                });
              }

              // main tick for class acq to coordinator
              for (int i = 0; i < classList!.length; i++) {
                for (int j = 0; j < state.selectedClass.length; j++) {
                  if (classList![i].classId ==
                      state.selectedClass[j]['ClassId']) {
                    setState(() {
                      customClassListBool[i] = true;
                    });
                  }
                }
              }
              //

              //
              for (int i = 0; i < classList!.length; i++) {
                if (customClassListBool[i] == true) {
                  setState(() {
                    finalClassList!
                        .add({"ClassID": "${classList![i].classId}"});
                  });
                }
              }

              /// Old
              // setState(() {
              //   _selectedClassList = [];
              // });
              //
              // state.selectedClass.forEach((element) {
              //   for (var i = 0; i < classList!.length; i++) {
              //     if (classList![i].classId == element['ClassId']) {
              //       setState(() {
              //         _selectedClassList!.add(classList![i]);
              //       });
              //     }
              //   }
              //
              // classList!.forEach((ele) {
              //   if (ele.classId == element['ClassId']) {
              //
              //     setState(() {
              //       // _selectedClassList!.add(LoadClassForSmsModel(
              //       //     classId: ele.classId,
              //       //     classname: ele.classname,
              //       //     classDisplayOrder: ele.classDisplayOrder));
              //       selectedDropDownClassList!.add(value);
              //       _selectedClassList!.add(ele);
              //     });
              //   }
              //   //print(element['ClassId']);
              // });
              //  });

              // _selectedClassList!.forEach((element) {
              //   print(element.classname);
              // });
              //
              // //print(_selectedClassList![0].classname);
              // getClass();
            }
          }),
        ],
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _selectedIndex == 0
                  ? Container(
                      margin: EdgeInsets.only(left: 20, right: 20, top: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            //margin: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(
                              'Select Employee',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 18),
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

                              if (data.empId != null) {
                                setState(() {
                                  selectedEmployee = data;
                                });
                                setState(() {
                                  // selectedEmployee = state.employeeInfoData;
                                  empNo = selectedEmployee!.empno;
                                  name = selectedEmployee!.name;
                                  fatherName = selectedEmployee!.fatherName;
                                  designation = selectedEmployee!.deptName;
                                  group = selectedEmployee!.groupName;
                                  empId = int.parse(selectedEmployee!.empId!);
                                });
                                setState(() {
                                  periodListForTeacherAssign = [];
                                  totalPeriodsSelection = [];
                                  collectionOfSelectedPeriodList = [];
                                });
                                print('${empId.toString()}');
                                getSelectedClass(empid: empId.toString());
                                getAllottedSubjectList(empid: empId.toString());
                              }
                            },
                            child: Container(
                              // height: 40,
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black12),
                              ),
                              child: Text("search employee here..."),
                            ),
                          ),
                          if (selectedEmployee != null)
                            Text(
                                "● ${selectedEmployee!.name!} - ${selectedEmployee!.mobileNo!}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context).primaryColor)),
                          // TextFormField(
                          //   controller: employeeNameController,
                          //   validator: FieldValidators.globalValidator,
                          //   style: TextStyle(color: Colors.black),
                          //   decoration: InputDecoration(
                          //     //counterText: "",
                          //     border: new OutlineInputBorder(
                          //       borderRadius: const BorderRadius.all(
                          //         const Radius.circular(18.0),
                          //       ),
                          //     ),
                          //     enabledBorder: OutlineInputBorder(
                          //       borderSide: BorderSide(
                          //         color: Color(0xffECECEC),
                          //       ),
                          //       gapPadding: 0.0,
                          //     ),
                          //     disabledBorder: OutlineInputBorder(
                          //       borderSide: BorderSide(
                          //         color: Theme.of(context).primaryColor,
                          //       ),
                          //     ),
                          //     errorBorder: OutlineInputBorder(
                          //       borderSide: BorderSide(
                          //         color: Color(0xffECECEC),
                          //       ),
                          //     ),
                          //     focusedErrorBorder: OutlineInputBorder(
                          //       borderSide: BorderSide(
                          //         color: Theme.of(context).primaryColor,
                          //       ),
                          //     ),
                          //     focusedBorder: OutlineInputBorder(
                          //       borderSide: BorderSide(
                          //         color: Theme.of(context).primaryColor,
                          //       ),
                          //     ),
                          //     hintText: "type employee name",
                          //     hintStyle: TextStyle(color: Color(0xffA5A5A5)),
                          //     contentPadding: const EdgeInsets.symmetric(
                          //         vertical: 0.0, horizontal: 16.0),
                          //     prefixIcon: Icon(Icons.search),
                          //   ),
                          //   onTap: () {
                          //     // setState(() {
                          //     //   searchResult = [];
                          //     // });
                          //     // Container(
                          //     //   height: 50,
                          //     //   width: 100,
                          //     //   child: ListView.builder(
                          //     //       shrinkWrap: true,
                          //     //       itemCount: searchResult!.length != 0
                          //     //           ? searchResult!.length
                          //     //           : 1,
                          //     //       itemBuilder: (context, index) {
                          //     //         if (searchResult!.length > 0) {
                          //     //           var itm = searchResult![index];
                          //     //           return Container(
                          //     //             // margin: EdgeInsets.all(8),
                          //     //             // padding: EdgeInsets.all(8),
                          //     //             child: Text('${itm}'),
                          //     //           );
                          //     //         } else {
                          //     //           return Container(
                          //     //             height:
                          //     //                 MediaQuery.of(context).size.height *
                          //     //                     0.1,
                          //     //             width:
                          //     //                 MediaQuery.of(context).size.width *
                          //     //                     0.2,
                          //     //             child: Text('No data'),
                          //     //           );
                          //     //         }
                          //     //       }),
                          //     // );
                          //   },
                          //   onChanged: (val) {
                          //     _runFilter(val);
                          //     // setState(() {
                          //     //   employeeNameController.text=val;
                          //     // });
                          //
                          //     // searchList!.forEach((element) {
                          //     //   if (element
                          //     //       .toLowerCase()
                          //     //       .contains(val.toLowerCase())) {
                          //     //     setState(() {
                          //     //       searchResult!.add(element);
                          //     //     });
                          //     //   }
                          //     // });
                          //   },
                          //   // onEditingComplete: () {
                          //   //   Container(
                          //   //     height: 50,
                          //   //     width: 100,
                          //   //     child: ListView.builder(
                          //   //         shrinkWrap: true,
                          //   //         itemCount: searchResult!.length != 0
                          //   //             ? searchResult!.length
                          //   //             : 1,
                          //   //         itemBuilder: (context, index) {
                          //   //           if (searchResult!.length > 0) {
                          //   //             var itm = searchResult![index];
                          //   //             return Container(
                          //   //               // margin: EdgeInsets.all(8),
                          //   //               // padding: EdgeInsets.all(8),
                          //   //               child: Text('${itm}'),
                          //   //             );
                          //   //           } else {
                          //   //             return Container(
                          //   //               height:
                          //   //                   MediaQuery.of(context).size.height *
                          //   //                       0.1,
                          //   //               width:
                          //   //                   MediaQuery.of(context).size.width *
                          //   //                       0.2,
                          //   //               child: Text('No data'),
                          //   //             );
                          //   //           }
                          //   //         }),
                          //   //   );
                          //   // },
                          // ),
                          // _foundUsers.length > 0
                          //     ? isCheck == false
                          //         ? Container(
                          //             height:
                          //                 //_foundUsers.length * 70,
                          //                 MediaQuery.of(context).size.height *
                          //                     0.6,
                          //             width:
                          //                 MediaQuery.of(context).size.width * 0.9,
                          //             child: ListView.builder(
                          //               itemCount: _foundUsers.length,
                          //               itemBuilder: (context, index) => Card(
                          //                 key: ValueKey(_foundUsers[index]["id"]),
                          //                 color: Colors.blueGrey[100],
                          //                 elevation: 4,
                          //                 margin: EdgeInsets.symmetric(
                          //                     vertical: 2, horizontal: 2),
                          //                 child: GestureDetector(
                          //                   onTap: () {
                          //                     setState(() {
                          //                       employeeNameController.text =
                          //                           _foundUsers[index]['name'];
                          //                       _foundUsers = [];
                          //                       _foundUsers.length = 0;
                          //                       isCheck = true;
                          //                     });
                          //                   },
                          //                   child: ListTile(
                          //                     leading: Text(
                          //                       _foundUsers[index]["id"]
                          //                           .toString(),
                          //                       style: TextStyle(fontSize: 24),
                          //                     ),
                          //                     title: Text(
                          //                         _foundUsers[index]['name']),
                          //                     subtitle: Text(
                          //                         '${_foundUsers[index]["age"].toString()} years old'),
                          //                   ),
                          //                 ),
                          //               ),
                          //             ),
                          //           )
                          //         : Container()
                          //     : employeeNameController.text.length > 0
                          //         ? Container(
                          //             child: Text(
                          //               'No results found',
                          //               style: TextStyle(fontSize: 24),
                          //             ),
                          //           )
                          //         : Container(),
                          // Text(
                          //         'No results found',
                          //         style: TextStyle(fontSize: 24),
                          //       ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          Divider(
                            thickness: 5,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          Container(
                            // margin: EdgeInsets.only(left: 22, right: 20, top: 5),
                            padding: EdgeInsets.all(8),
                            width: MediaQuery.of(context).size.width * 1,
                            decoration:
                                BoxDecoration(border: Border.all(width: 0.5)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Employee No. : $empNo',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                Text(
                                  'Name : $name',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                Text(
                                  'Father Name : $fatherName',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                Text(
                                  'Designation : $designation',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                Text(
                                  'Group : $group',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                Text(
                                  'Classes :',
                                  //' Selected : ${finalClassList!.length > 0 ? finalClassList!.length : "0"}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.008,
                                ),
                                BlocConsumer<LoadClassForSmsCubit,
                                    LoadClassForSmsState>(
                                  listener: (context, state) {
                                    if (state is LoadClassForSmsLoadSuccess) {
                                      setState(() {
                                        classList = state.classList;
                                      });
                                      classList!.forEach((element) {
                                        setState(() {
                                          customClassListBool.add(false);
                                        });
                                      });
                                    }
                                    if (state is LoadClassForSmsLoadFail) {
                                      if (state.failReason == 'false') {
                                        UserUtils.unauthorizedUser(context);
                                      } else {
                                        classList = [];
                                      }
                                    }
                                  },
                                  builder: (context, state) {
                                    if (state
                                        is LoadClassForSmsLoadInProgress) {
                                      //return buildClassMultiSelect();
                                      return testContainer();
                                    }
                                    if (state is LoadClassForSmsLoadSuccess) {
                                      //  return buildClassMultiSelect();
                                      return buttonModalBottomSheet(
                                          classList: classList);
                                    }
                                    if (state is LoadClassForSmsLoadFail) {
                                      // return buildClassMultiSelect();
                                      return buttonModalBottomSheet();
                                    } else {
                                      return Container();
                                    }
                                  },
                                ),
                                //buildClassMultiSelect(),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.07,
                                ),
                                Center(
                                  child: InkWell(
                                    onTap: () {
                                      //print('Hello');
                                      // if (empId == -1) {
                                      //   ScaffoldMessenger.of(context)
                                      //       .showSnackBar(
                                      //     commonSnackBar(
                                      //       title: 'Enter Employee Name',
                                      //       duration: Duration(seconds: 1),
                                      //     ),
                                      //   );
                                      // } else {
                                      //   if (finalClassList!.length == 0) {
                                      //     ScaffoldMessenger.of(context)
                                      //         .showSnackBar(
                                      //       commonSnackBar(
                                      //         title: 'Select Class',
                                      //         duration: Duration(seconds: 1),
                                      //       ),
                                      //     );
                                      //   } else {
                                      //     saveClassTeacher(
                                      //         classid: finalClassList,
                                      //         empid: empId);
                                      //   }
                                      // }
                                      if (selectedEmployee != null) {
                                        saveClassTeacher(
                                            classid: finalClassList,
                                            empid: empId);
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          commonSnackBar(
                                            title: 'Enter Employee Name',
                                            duration: Duration(seconds: 1),
                                          ),
                                        );
                                      }
                                    },
                                    child: Container(
                                      margin:
                                          EdgeInsets.only(left: 10, right: 10),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      decoration: BoxDecoration(
                                          border: Border.all(width: 0.1),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color:
                                              Theme.of(context).primaryColor),
                                      child: Text(
                                        'Save Class Teacher',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.02,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : _selectedIndex == 1
                      ? Container(
                          margin: EdgeInsets.only(left: 18, right: 18, top: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  BlocConsumer<LoadClassForSubjectAdminCubit,
                                      LoadClassForSubjectAdminState>(
                                    listener: (context, state) {
                                      // if (state
                                      //     is LoadClassForSubjectAdminLoadFail) {
                                      //   if (state.failReason == 'false') {
                                      //     UserUtils.unauthorizedUser(context);
                                      //   } else {
                                      //     setState(() {
                                      //       classItems1 = [];
                                      //       selectedClass =
                                      //           LoadClassForSubjectAdminModel(
                                      //               classDisplayOrder: "",
                                      //               classId: "",
                                      //               className: "");
                                      //     });
                                      //   }
                                      // }
                                      // if (state
                                      //     is LoadClassForSubjectAdminLoadSuccess) {
                                      //   setState(() {
                                      //     classItems1 = state.classList;
                                      //     selectedClass = state.classList[0];
                                      //   });
                                      // }
                                    },
                                    builder: (context, state) {
                                      if (state
                                          is LoadClassForSubjectAdminLoadInProgress) {
                                        return buildClassDropDown();
                                      } else if (state
                                          is LoadClassForSubjectAdminLoadSuccess) {
                                        return buildClassDropDown();
                                      } else if (state
                                          is LoadClassForSubjectAdminLoadFail) {
                                        return buildClassDropDown();
                                      } else {
                                        return Container();
                                      }
                                    },
                                  ),
                                  // buildClassDropDown(),
                                  //buildSubjectDropDown()
                                ],
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Text(
                                  'Select Subject',
                                  // style: Theme.of(context).textTheme.headline6,
                                ),
                              ),
                              //buildSubjectMultiSelect(),
                              BlocConsumer<GetClasswiseSubjectAdminCubit,
                                      GetClasswiseSubjectAdminState>(
                                  listener: (context, state) {},
                                  builder: (context, state) {
                                    if (state
                                        is GetClasswiseSubjectAdminLoadInProgress) {
                                      //return buildSubjectMultiSelect();
                                      return testSubjectSection(
                                          title: "Select Subject");
                                    } else if (state
                                        is GetClasswiseSubjectAdminLoadSuccess) {
                                      return buildSubjectMultiSelect();
                                    } else if (state
                                        is GetClasswiseSubjectAdminLoadFail) {
                                      return buildSubjectMultiSelect();
                                    } else {
                                      return Container();
                                    }
                                  }),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.035,
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Text(
                                  'Select Section',
                                  // style: Theme.of(context).textTheme.headline6,
                                ),
                              ),
                              BlocConsumer<GetClassSectionAdminCubit,
                                      GetClassSectionAdminState>(
                                  listener: (context, state) {},
                                  builder: (context, state) {
                                    if (state
                                        is GetClassSectionAdminLoadInProgress) {
                                      //return buildSectionMultiSelect();
                                      return testSubjectSection(
                                          title: 'Select Section');
                                    } else if (state
                                        is GetClassSectionAdminLoadSuccess) {
                                      return buildSectionMultiSelect();
                                    } else if (state
                                        is GetClassSectionAdminLoadFail) {
                                      return buildSectionMultiSelect();
                                    } else {
                                      return Container();
                                    }
                                  }),
                              // buildSectionMultiSelect(),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                              ),
                              Center(
                                child: InkWell(
                                  onTap: () {
                                    print('Hello');
                                    print(classidFinal);
                                    print(finalSubjectList);
                                    print(finalSectionList);
                                    if (selectedEmployee != null) {
                                      alloteSuject(
                                          classid: classidFinal!.join(","),
                                          subjectid: finalSubjectList.join(","),
                                          //empid: empId.toString(),
                                          empid: selectedEmployee!.empId,
                                          sectionid: finalSectionList);
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        commonSnackBar(
                                            title: 'Please Select Employee',
                                            duration: Duration(seconds: 1)),
                                      );
                                    }
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 8),
                                    decoration: BoxDecoration(
                                        border: Border.all(width: 0.1),
                                        borderRadius: BorderRadius.circular(20),
                                        color: Theme.of(context).primaryColor),
                                    padding: EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                        top: 10,
                                        bottom: 10),
                                    child: Text(
                                      'Allocate Subject',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.03),
                            ],
                          ),
                        )
                      : Column(
                          children: [
                            subjectListCheck == true
                                ? BlocConsumer<LoadAllottedSubjectCubit,
                                    LoadAllottedSubjectState>(
                                    listener: (context, state) {},
                                    builder: (context, state) {
                                      if (state
                                          is LoadAllottedSubjectLoadInProgress) {
                                        return Center(
                                          child: Container(
                                            margin: EdgeInsets.all(10),
                                            height: 10,
                                            width: 10,
                                            child: CircularProgressIndicator(),
                                          ),
                                        );
                                      } else if (state
                                          is LoadAllottedSubjectLoadSuccess) {
                                        return checkList(
                                            subjectListt:
                                                loadAllottedSubjectList
                                            //    subjectList: state.subjectListt
                                            );
                                      } else if (state
                                          is LoadAllottedSubjectLoadFail) {
                                        return checkList(
                                            error: state.failReason);
                                      } else {
                                        return Container();
                                      }
                                    },
                                  )
                                : Container(
                                    child: Center(
                                      child: Text(
                                        'Enter Employee Name First',
                                        style: TextStyle(
                                          color: Colors.red[300],
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                            //Container(child: buildAllottedSubjectList()),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            loadAllottedSubjectList!.length != 0
                                ? InkWell(
                                    splashColor: Colors.transparent,
                                    onTap: () {
                                      print('Hello');
                                      if (finalPeriodList.length > 0) {
                                        assignPeriod(
                                            data: finalPeriodList,
                                            empid: empId.toString());
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          commonSnackBar(
                                            title: 'Choose Atleast one Period',
                                            duration: Duration(seconds: 1),
                                          ),
                                        );
                                      }
                                    },
                                    child: Container(
                                      margin:
                                          EdgeInsets.only(left: 10, right: 10),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      decoration: BoxDecoration(
                                          border: Border.all(width: 0.1),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color:
                                              Theme.of(context).primaryColor),
                                      child: Text(
                                        'Assign Period',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.03,
                            ),
                          ],
                        )
            ],
          ),
        ),
      ),
    );
  }

  Container checkList(
      {List<LoadAllottedSubjectsModel>? subjectListt, String? error}) {
    if (subjectListt == null || subjectListt.isEmpty) {
      if (error == null) {
        return Container(
          child: Center(
            child: Text('No Record'),
          ),
        );
      } else {
        return Container(
          child: Center(
              child: Text(
            '$error',
            style: TextStyle(
              color: Colors.red,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          )),
        );
      }
    } else {
      subjectListt.forEach((element) {
        customPeriodListBool.add([]);
      });
      return buildAllottedSubjectList(subjectListt: subjectListt);
    }
  }

  Container buildAllottedSubjectList(
      {List<LoadAllottedSubjectsModel>? subjectListt}) {
    return Container(
      child: ListView.separated(
        primary: false,
        shrinkWrap: true,
        separatorBuilder: (context, index) => SizedBox(
          height: 10,
        ),
        itemCount: subjectListt!.length,
        itemBuilder: (context, index) {
          //Key
          // periodListForTeacherAssign!.add(GlobalKey<FormFieldState>());
          //
          // totalPeriodsSelection!.add(periodList);
          //
          // print(periodList!.length);

          // periodList!.forEach((element) {
          //   customPeriodListBool[index].add(false);
          // });

          // print(customPeriodListBool);
          // subjectList!.forEach((element) {
          //   customPeriodListBool[index].add(false);
          // });

          // collectionOfSelectedPeriodList!.add(_selectedPeriodList);
          var item = subjectListt[index];
          return Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 4),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(border: Border.all(width: 0.2)),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${item.className.toString()}-${item.section.toString()}",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.red),
                    ),
                    Text(
                      '${item.subject} ',
                      //'(${item.subjectCode})',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                          color: Colors.blueAccent),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.008,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //Todo:Add Custom multi dropdown

                    // buildPeriodMultiSelect(
                    //   key: periodListForTeacherAssign![index],
                    //   periodListSelected: totalPeriodsSelection![index],
                    //   selectedPeriodList:
                    //       collectionOfSelectedPeriodList![index],
                    //   ind: index,
                    //   periodID: item.periodID,
                    //   classID: item.classId.toString(),
                    //   sectionID: item.sectionId.toString(),
                    //   streamID: item.streamID.toString(),
                    //   yearID: item.yearId.toString(),
                    //   subjectID: item.subjectId.toString(),
                    // ),

                    buttonModalBottomSheetForPeriod(
                      periodListSelected: periodList,
                      selectedPeriodList: customPeriodListBool[index],
                      ind: index,
                      periodID: item.periodID,
                      classID: item.classId.toString(),
                      sectionID: item.sectionId.toString(),
                      streamID: item.streamID.toString(),
                      yearID: item.yearId.toString(),
                      subjectID: item.subjectId.toString(),
                    ),

                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        deletedAllottedSubject(
                            empid: empId.toString(),
                            data:
                                '${item.classId}.${item.sectionId}.${item.streamID}.${item.yearId}.${item.subjectId}');
                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        child: Icon(
                          Icons.delete,
                          size: 25,
                          color: Colors.red[400],
                          //Theme.of(context).primaryColor,
                        ),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xFFe0f2f1)),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.005,
                ),
                // Text(
                //   'Subject',
                //   style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                // ),
                Text(
                  item.toDate != null
                      ? '${item.fromDate} =>${item.toDate}'
                      : '${item.fromDate}',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  //Todo:Use this custom multi select class dropdown
  Center buttonModalBottomSheet({List<LoadClassForSmsModel>? classList}) {
    return Center(
      child: GestureDetector(
        onTap: () async {
          if (classList != null) {
            await customMultiSelect(classList: classList);
            setState(() {
              finalClassList!.length = finalClassList!.length;
            });
          }
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(border: Border.all(width: 0.05)),
          padding: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width * 0.75,
          height: MediaQuery.of(context).size.height * 0.055,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Select Classes : ${finalClassList!.length > 0 ? finalClassList!.length : finalClassList!.length}",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Icon(Icons.arrow_downward)
            ],
          ),
        ),
      ),
    );
  }

  Future<Widget?> customMultiSelect({List<LoadClassForSmsModel>? classList}) {
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
                              Text(
                                '${item.classname}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Checkbox(
                                value: customClassListBool[index],
                                onChanged: (val) {
                                  setState(
                                    () {
                                      customClassListBool[index] =
                                          !customClassListBool[index];
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
                      )),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              // height: MediaQuery.of(context).size.height * 0.06,
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
                        Container(
                            height: 30,
                            child: VerticalDivider(color: Colors.black)),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              finalClassList = [];
                            });

                            for (int i = 0; i < classList.length; i++) {
                              if (customClassListBool[i] == true) {
                                setState(() {
                                  finalClassList!
                                      .add({"ClassID": classList[i].classId});
                                });
                              }
                            }

                            setState(() {
                              finalClassList!.length = finalClassList!.length;
                            });
                            print(finalClassList!.length);
                            // setState(() {
                            //   finalClassList = [];
                            //   _selectedClassList = values;
                            // });

                            // print(_selectedClassList!.length);
                            // for (var i in _selectedClassList!) {
                            //   finalClassList!.add({"ClassID": i.classId});
                            // }

                            Navigator.pop(context);
                          },
                          child: Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              // height: MediaQuery.of(context).size.height * 0.04,
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

  // Container buildClassMultiSelect({List<LoadClassForSmsModel>? initialList}) {
  //   return Container(
  //     alignment: Alignment.center,
  //     // padding: EdgeInsets.symmetric(horizontal: 10),
  //     margin: EdgeInsets.symmetric(horizontal: 20),
  //     child: MultiSelectBottomSheetField<LoadClassForSmsModel>(
  //         initialValue:
  //             _selectedClassList!.length != 0 ? _selectedClassList : [],
  //         autovalidateMode: AutovalidateMode.disabled,
  //         decoration: BoxDecoration(
  //           border: Border.all(color: Color(0xffECECEC)),
  //         ),
  //         key: _classSelectKey,
  //         initialChildSize: 0.7,
  //         maxChildSize: 0.95,
  //         searchIcon: Icon(Icons.ac_unit),
  //         title: Text("All Classes",
  //             style: TextStyle(
  //                 fontWeight: FontWeight.bold,
  //                 color: Colors.black,
  //                 fontSize: 18)),
  //         buttonText: Text(
  //           _selectedClassList!.length == 0
  //               ? "Select Classes"
  //               : "${_selectedClassList!.length} Selected",
  //           style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
  //         ),
  //         // items: _items,
  //         items:
  //             // _selectedClassList!
  //             //     .map((val) => MultiSelectItem(val, val.classname!))
  //             //     .toList(),
  //             classList!
  //                 .map((val) => MultiSelectItem(val, val.classname!))
  //                 .toList(),
  //         searchable: false,
  //         validator: (values) {
  //           if (values == null ||
  //               values.isEmpty ||
  //               _selectedClassList!.isEmpty) {
  //             return "Required Field";
  //           }
  //           // List<String> names = values.map((e) => e.name!).toList();
  //           // if (names.contains("Frog")) {
  //           //   return "Frogs are weird!";
  //           // }
  //           return null;
  //         },
  //         onConfirm: (values) {
  //           classList!.forEach((element) {
  //             print(element.classname);
  //           });
  //           // final checkClassList = _selectedClassList;
  //           // print(_selectedClassList!.length);
  //           // if (_selectedClassList!.length > 0) {
  //           //   values.forEach((element) {
  //           //     print('innnnnnnnn');
  //           //     for (var i = 0; i < checkClassList!.length; i++) {
  //           //       if (checkClassList[i].classId == element.classId) {
  //           //         setState(() {
  //           //           _selectedClassList!.removeAt(i);
  //           //         });
  //           //       } else {
  //           //         setState(() {
  //           //           // _selectedClassList!.add(LoadClassForSmsModel(
  //           //           //     classId: element.classId,
  //           //           //     classname: element.classname,
  //           //           //     classDisplayOrder: element.classDisplayOrder));
  //           //         });
  //           //       }
  //           //     }
  //           //   });
  //           // } else {
  //           //   setState(() {
  //           //     finalClassList = [];
  //           //     _selectedClassList = values;
  //           //   });
  //           // }
  //
  //           setState(() {
  //             finalClassList = [];
  //             _selectedClassList = values;
  //           });
  //
  //           print(_selectedClassList!.length);
  //           for (var i in _selectedClassList!) {
  //             finalClassList!.add({"ClassID": i.classId});
  //           }
  //           //print(finalClassList);
  //         },
  //         // chipDisplay: MultiSelectChipDisplay(
  //         //   shape: RoundedRectangleBorder(),
  //         //   textStyle: TextStyle(
  //         //       fontWeight: FontWeight.w900,
  //         //       color: Theme.of(context).primaryColor),
  //         // ),
  //         chipDisplay: MultiSelectChipDisplay.none()),
  //   );
  // }

  Container buildClassDropDown() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 10),
      width: MediaQuery.of(context).size.width * 0.4,
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
              borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButton<LoadClassForSubjectAdminModel>(
              isDense: true,
              value: selectedClass,
              key: UniqueKey(),
              isExpanded: true,
              underline: Container(),
              items: classItems1!
                  .map((e) => DropdownMenuItem(
                        child: Text('${e.className}'),
                        value: e,
                      ))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  classidFinal = [];
                  selectedClass = val;
                });
                setState(() {
                  classidFinal!.add(selectedClass!.classId);
                });
                getAdminSubject(classId: selectedClass!.classId);
                getClassSection(classid: selectedClass!.classId!.split("#")[0]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSubjectMultiSelect() {
    return Container(
      alignment: Alignment.center,
      // padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: MultiSelectBottomSheetField<GetClasswiseSubjectAdminModel>(
        autovalidateMode: AutovalidateMode.disabled,
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xffECECEC)),
        ),
        key: _subjectSelectKey,
        initialChildSize: 0.7,
        maxChildSize: 0.95,
        searchIcon: Icon(Icons.ac_unit),
        title: Text("All Subjects",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 18)),
        buttonText: Text("Select Subjects"),
        // items: _items,
        items: subjectList!
            .map((val) => MultiSelectItem(val, val.subjectHead!))
            .toList(),
        searchable: false,
        validator: (values) {
          if (values == null ||
              values.isEmpty ||
              _selectedSubjectList.isEmpty) {
            return "Required Field";
          }
          return null;
        },
        onConfirm: (values) {
          setState(() {
            finalSubjectList = [];
            _selectedSubjectList = values;
            //values[0].iD
          });
          // _classSelectKey.currentState!.validate();
          for (var i in _selectedSubjectList) {
            finalSubjectList.add(i.iD);
          }
          print(finalSubjectList);
        },
        chipDisplay: MultiSelectChipDisplay(
          shape: RoundedRectangleBorder(),
          textStyle: TextStyle(
              fontWeight: FontWeight.w900,
              color: Theme.of(context).primaryColor),
        ),
      ),
    );
  }

  Widget buildSectionMultiSelect() {
    return Container(
      alignment: Alignment.center,
      // padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: MultiSelectBottomSheetField<GetClassSectionAdminModel>(
        autovalidateMode: AutovalidateMode.disabled,
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xffECECEC)),
        ),
        key: _sectionSelectKey,
        initialChildSize: 0.7,
        maxChildSize: 0.95,
        searchIcon: Icon(Icons.ac_unit),
        title: Text("All Sections",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 18)),
        buttonText: Text("Select Section"),
        // items: _items,
        items: sectionList!
            .map((val) => MultiSelectItem(
                  val,
                  val.classSection!,
                ))
            .toList(),
        searchable: false,
        validator: (values) {
          if (values == null || values.isEmpty || finalSectionList!.isEmpty) {
            return "Required Field";
          }
          return null;
        },
        onConfirm: (values) {
          setState(() {
            finalSectionList = [];
            _selectedSectionList = values;
            //values[0].iD
          });

          for (var i in _selectedSectionList) {
            finalSectionList!.add({'SectionID': i.id});
          }
        },
        chipDisplay: MultiSelectChipDisplay(
          shape: RoundedRectangleBorder(),
          textStyle: TextStyle(
              fontWeight: FontWeight.w900,
              color: Theme.of(context).primaryColor),
        ),
      ),
    );
  }

  //Todo:
  Widget buildPeriodMultiSelect({
    GlobalKey<FormFieldState>? key,
    List? periodListSelected,
    List? selectedPeriodList,
    int? ind,
    String? periodID,
    String? classID,
    String? sectionID,
    String? streamID,
    String? yearID,
    String? subjectID,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: MultiSelectBottomSheetField(
        buttonIcon: Icon(
          Icons.arrow_downward_sharp,
          size: 18,
        ),
        autovalidateMode: AutovalidateMode.disabled,
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xffECECEC)),
        ),
        key: key,
        initialChildSize: 0.5,
        maxChildSize: 0.95,
        searchIcon: Icon(Icons.ac_unit),
        title: Text("All Periods",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 18)),
        buttonText: Text(
          collectionOfSelectedPeriodList![ind!].length == 0
              ? "Periods"
              : "${selectedPeriodList!.length} Selected",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
        // items: _items,
        items: periodListSelected!
            .map((val) => MultiSelectItem(
                  val,
                  val.periodname,
                ))
            .toList(),
        searchable: false,
        validator: (values) {
          if (values == null || values.isEmpty || selectedPeriodList!.isEmpty) {
            return "Required Field";
          }
          return null;
        },
        onConfirm: (values) async {
          setState(() {
            //finalPeriodList = [];
            collectionOfSelectedPeriodList![ind] = values;
            selectedPeriodList = values;
            print('${selectedPeriodList!.length}');
          });
          setState(() {
            if (selectedPeriodList!.length > 0) {
              selectedPeriodList!.forEach((element) {
                finalPeriodList.add({
                  "PireodID": "${element.periodid.toString()}",
                  "ClassID": "${classID.toString()}",
                  "SectionID": "${sectionID.toString()}",
                  "StreamID": "${streamID.toString()}",
                  "YearID": "${yearID.toString()}",
                  "SubjectID": "${subjectID.toString()}"
                });
              });
            }
          });
          print(finalPeriodList);
        },
        chipDisplay: MultiSelectChipDisplay.none(),
        // chipDisplay: MultiSelectChipDisplay(
        //   height: 2,
        //   chipWidth: 2,
        //   shape: RoundedRectangleBorder(),
        //   textStyle: TextStyle(
        //       fontWeight: FontWeight.w900,
        //       color: Theme.of(context).primaryColor,
        //       fontSize: 12),
        // ),
      ),
    );
  }

  //Todo:Use this custom multi select Assign Period dropdown
  Center buttonModalBottomSheetForPeriod({
    List? periodListSelected,
    List<Map<String, bool>>? selectedPeriodList,
    int? ind,
    String? periodID,
    String? classID,
    String? sectionID,
    String? streamID,
    String? yearID,
    String? subjectID,
  }) {
    var selectedIndexPeriodLength = 0;
    selectedPeriodList!.forEach((element) {
      if (element.values.first == true) {
        selectedIndexPeriodLength = selectedIndexPeriodLength + 1;
      }
    });

    return Center(
      child: GestureDetector(
        onTap: () async {
          if (periodList != null) {
            await customMultiSelectForPeriod(
              periodList: periodListSelected,
              selectedPeriodList: selectedPeriodList,
              periodID: periodID,
              classID: classID.toString(),
              sectionID: sectionID.toString(),
              streamID: streamID.toString(),
              yearID: yearID.toString(),
              subjectID: subjectID.toString(),
            );

            ///
            selectedIndexPeriodLength = 0;
            selectedPeriodList.forEach((element) {
              if (element.values.first == true) {
                selectedIndexPeriodLength = selectedIndexPeriodLength + 1;
              }
            });

            ///
            setState(() {
              finalPeriodList.length = finalPeriodList.length;
              selectedIndexPeriodLength = selectedIndexPeriodLength;
            });
          }
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          decoration: BoxDecoration(border: Border.all(width: 0.05)),
          padding: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width * 0.35,
          height: MediaQuery.of(context).size.height * 0.055,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              selectedIndexPeriodLength > 0
                  ? Text(
                      // "Selected ${finalPeriodList.length}",
                      "Selected $selectedIndexPeriodLength",
                      textScaleFactor: 1.0,
                    )
                  : Text(
                      "Select Period ",
                      textScaleFactor: 1.0,
                    ),
              Icon(
                Icons.arrow_downward,
                size: 20,
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<Widget?> customMultiSelectForPeriod({
    List? periodList,
    List<Map<String, bool>>? selectedPeriodList,
    int? ind,
    String? periodID,
    String? classID,
    String? sectionID,
    String? streamID,
    String? yearID,
    String? subjectID,
  }) {
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
                      'Period List',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(
                        height: 2,
                      ),
                      itemCount: periodList!.length,
                      itemBuilder: (context, index) {
                        var item = periodList[index];
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${item.periodname}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Checkbox(
                                value: selectedPeriodList![index].values.first,
                                onChanged: (val) {
                                  String key =
                                      selectedPeriodList[index].keys.first;
                                  setState(
                                    () {
                                      selectedPeriodList[index]
                                          .update(key, (v) => val!);
                                      // !selectedPeriodList[index].values.first;
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
                    ))
                        // border: Border.symmetric(
                        //   vertical: BorderSide.none,
                        //   horizontal: BorderSide(width: 0.1),
                        // ),
                        ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: MediaQuery.of(context).size.height * 0.06,
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
                        Container(
                            height: 30,
                            child: VerticalDivider(color: Colors.black)),
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            print(selectedPeriodList);
                            print(periodList);
                            setState(() {
                              finalPeriodList = [];
                              //
                              // if (finalPeriodList.length > 0) {
                              //   var tempList = finalPeriodList;
                              //   for (int i = 0; i < tempList.length; i++) {
                              //     if (tempList[i]["ClassID"] == classID &&
                              //         tempList[i]["PireodID"] == periodID &&
                              //         tempList[i]["SectionID"] == sectionID) {
                              //       finalPeriodList.removeAt(i);
                              //     }
                              //   }
                              // }
                              //
                              print('${selectedPeriodList!.length}');
                            });

                            for (int i = 0;
                                i < selectedPeriodList!.length;
                                i++) {
                              if (selectedPeriodList[i].values.first == true) {
                                finalPeriodList.add({
                                  "PireodID":
                                      "${periodList[i].periodid.toString()}",
                                  "ClassID": "${classID.toString()}",
                                  "SectionID": "${sectionID.toString()}",
                                  "StreamID": "${streamID.toString()}",
                                  "YearID": "${yearID.toString()}",
                                  "SubjectID": "${subjectID.toString()}"
                                });
                              }
                            }

                            print(finalPeriodList);

                            Navigator.pop(context);
                          },
                          child: Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: MediaQuery.of(context).size.height * 0.04,
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

  Row testContainer() {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.055,
        ),
        Container(
          child: Text("Select Classes"),
          decoration: BoxDecoration(border: Border.all(width: 0.05)),
          padding: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width * 0.75,
          height: MediaQuery.of(context).size.height * 0.06,
        ),
      ],
    );
  }

  Container testSubjectSection({String? title}) {
    return Container(
      child: Text("$title"),
      decoration: BoxDecoration(border: Border.all(width: 0.05)),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: MediaQuery.of(context).size.width * 0.87,
      height: MediaQuery.of(context).size.height * 0.06,
    );
  }
}
