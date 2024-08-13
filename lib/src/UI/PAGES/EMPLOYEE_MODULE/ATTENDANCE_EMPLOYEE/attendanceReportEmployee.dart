import 'package:campus_pro/src/DATA/BLOC_CUBIT/ATTENDANCE_REPORT_EMPLOYEE_CUBIT/attendance_report_employee_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/CLASS_LIST_ATTENDANCE_EMPLOYEE_CUBIT/class_list_att_report_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/CLASS_LIST_ATTENDANCE_REPORT_ADMIN_CUBIT/class_list_attendance_report_admin_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/CLASS_LIST_ATTENDANCE_REPORT_CUBIT/class_list_attendance_report_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/SECTION_LIST_ATTENDANCE_ADMIN_CUBIT/section_list_attendance_admin_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/SECTION_LIST_ATTENDANCE_EMPLOYEE/section_list_attendance_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/classListAttendanceReportAdminModel.dart';
import 'package:campus_pro/src/DATA/MODELS/classListAttendanceReportModel.dart';
import 'package:campus_pro/src/DATA/MODELS/sectionListAttendanceAdminModel.dart';
import 'package:campus_pro/src/DATA/MODELS/sectionListAttendanceModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/PAGES/EMPLOYEE_MODULE/ATTENDANCE_EMPLOYEE/excelReport.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UTILS/fieldValidators.dart';
import 'package:campus_pro/src/WIDGETS_STYLE/style_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AttendanceReport extends StatefulWidget {
  static const routeName = "/attendance-report-employee";
  @override
  _AttendanceReportState createState() => _AttendanceReportState();
}

class _AttendanceReportState extends State<AttendanceReport> {
  TextEditingController _controllerDays = TextEditingController();
  DateTime selectedDate = DateTime.now();

  List<ClassListAttendanceReportModel>? classItem = [];
  List<ClassListAttendanceReportAdminModel>? classItemAdmin = [];

  List<SectionListAttendanceModel> sectionItem = [];
  List<SectionListAttendanceAdminModel> sectionItemAdmin = [];

  ClassListAttendanceReportModel? selectedClass;
  ClassListAttendanceReportAdminModel? selectedClassAdmin;

  SectionListAttendanceModel? selectedSection;
  SectionListAttendanceAdminModel? selectedSectionAdmin;

  String? classID;
  String? sectionID;
  String? className;
  String? sectionName;
  String? userType = 'e';

  GlobalKey<FormState> _key = GlobalKey<FormState>();
  String? schoolName;

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
      "UserType": userData.ouserType,
    };
    print('Get Attendance class list $getEmpClassData');
    context
        .read<ClassListAttendanceReportCubit>()
        .classListAttendanceReportCubitCall(getEmpClassData);
  }

  getEmployeeClassAdmin() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final getEmpClassData = {
      "OUserId": uid!,
      "Token": token!,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "EmpStuId": userData.stuEmpId,
      "UserType": userData.ouserType,
    };
    print('Get Attendance class list $getEmpClassData');

    context
        .read<ClassListAttendanceReportAdminCubit>()
        .classListAttendanceReportAdminCubitCall(getEmpClassData);
  }

  getEmployeeSection({String? classid}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final getEmpSectionData = {
      "OUserId": uid!,
      "Token": token!,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "classid": classid.toString(),
      "SessionId": userData.currentSessionid,
      "EmpID": userData.stuEmpId,
    };
    print('Section list data $getEmpSectionData');
    context
        .read<SectionListAttendanceCubit>()
        .sectionListAttendanceCubitCall(getEmpSectionData);
  }

  getEmployeeSectionAdmin({String? classid}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final getEmpSectionData = {
      "OUserId": uid!,
      "Token": token!,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "ClassId": classid.toString(),
      "UserType": userData.ouserType,
      "EmpStuId": userData.stuEmpId,
    };

    print('Section list data $getEmpSectionData');
    context
        .read<SectionListAttendanceAdminCubit>()
        .sectionListAttendanceAdminCubitCall(getEmpSectionData);
  }

  getAttendanceReport(
      {String? classid,
      String? sectionid,
      String? number,
      String? date}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final getEmpAttendanceReport = {
      "OUserId": uid!,
      "Token": token!,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "ClassID": classid.toString(),
      "SessionId": userData.currentSessionid,
      "SectionID": sectionid.toString(),
      "Number": number.toString(),
      "Date": date.toString(),
    };
    print('attendance report data $getEmpAttendanceReport');
    context
        .read<AttendanceReportEmployeeCubit>()
        .attendanceReportEmployeeCubitCall(getEmpAttendanceReport);
  }

  getSchoolName() async {
    final userData = await UserUtils.userTypeFromCache();
    setState(() {
      schoolName = userData!.schoolName;
    });
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
    selectedClassAdmin = ClassListAttendanceReportAdminModel(
      id: "",
      className: "",
    );
    classItemAdmin = [];
    selectedClass = ClassListAttendanceReportModel(
        iD: "", classname: "", classId: "", classDisplayOrder: "");
    classItem = [];
    selectedSection = SectionListAttendanceModel(id: "", classSection: "");
    sectionItem = [];
    selectedSectionAdmin =
        SectionListAttendanceAdminModel(id: "", classSection: "");
    sectionItemAdmin = [];
    getEmployeeClass();
    getEmployeeClassAdmin();
    getSchoolName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, title: 'Attendance Report'),
      body: SingleChildScrollView(
        child: MultiBlocListener(
          listeners: [
            BlocListener<AttendanceReportEmployeeCubit,
                    AttendanceReportEmployeeState>(
                listener: (context, state) async {
              if (state is AttendanceReportEmployeeLoadSuccess) {
                //Navigator.pushNamed(context, ExcelReport.routeName);
                // print('school Name ${schoolName}');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ExcelReport(
                        data: state.attendanceReport,
                        schoolName: schoolName,
                        className: className,
                        sectionName: sectionName,
                      );
                    },
                  ),
                );
              }
              if (state is AttendanceReportEmployeeLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                }
              }
            }),
          ],
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(top: 12, bottom: 5, left: 12, right: 16),
                  child: Row(
                    children: [
                      userType!.toLowerCase() == 'e'
                          ? BlocConsumer<ClassListAttendanceReportCubit,
                              ClassListAttendanceReportState>(
                              listener: (context, state) {
                                if (state
                                    is ClassListAttendanceReportLoadSuccess) {
                                  print(state.classList[0].classname);
                                  setState(() {
                                    classItem = state.classList;
                                    selectedClass = state.classList[0];
                                    classID = state.classList[0].iD;
                                    className = state.classList[0].classname;
                                    getEmployeeSection(classid: classID);
                                  });
                                  //print(dropDownClassValue!.className);
                                }
                                if (state
                                    is ClassListAttendanceReportLoadFail) {
                                  if (state.failReason == "false") {
                                    UserUtils.unauthorizedUser(context);
                                  }
                                  setState(() {
                                    selectedClass =
                                        ClassListAttendanceReportModel(
                                            iD: "",
                                            classname: "",
                                            classId: "",
                                            classDisplayOrder: "");
                                    classItem = [];
                                  });
                                }
                              },
                              builder: (context, state) {
                                if (state
                                    is ClassListAttendanceReportLoadInProgress) {
                                  //return CircularProgressIndicator();
                                  return buildClassDropDown();
                                } else if (state
                                    is ClassListAttendanceReportLoadSuccess) {
                                  return buildClassDropDown();
                                } else if (state
                                    is ClassListAttReportLoadFail) {
                                  return buildClassDropDown();
                                } else {
                                  return Container();
                                }
                              },
                            )
                          : BlocConsumer<ClassListAttendanceReportAdminCubit,
                              ClassListAttendanceReportAdminState>(
                              listener: (context, state) {
                                if (state
                                    is ClassListAttendanceReportAdminLoadSuccess) {
                                  print(state.classList[0].className);
                                  setState(() {
                                    classItemAdmin = state.classList;
                                    selectedClassAdmin = state.classList[0];
                                    classID = state.classList[0].id;
                                    className = state.classList[0].className;
                                    getEmployeeSectionAdmin(classid: classID);
                                  });
                                  //print(dropDownClassValue!.className);
                                }
                                if (state
                                    is ClassListAttendanceReportAdminLoadFail) {
                                  if (state.failReason == "false") {
                                    UserUtils.unauthorizedUser(context);
                                  }
                                  setState(() {
                                    selectedClassAdmin =
                                        ClassListAttendanceReportAdminModel(
                                      id: "",
                                      className: "",
                                    );
                                    classItemAdmin = [];
                                  });
                                }
                              },
                              builder: (context, state) {
                                if (state
                                    is ClassListAttendanceReportAdminLoadInProgress) {
                                  //return CircularProgressIndicator();
                                  return buildClassDropDownAdmin();
                                } else if (state
                                    is ClassListAttendanceReportAdminLoadSuccess) {
                                  return buildClassDropDownAdmin();
                                } else if (state
                                    is ClassListAttReportLoadFail) {
                                  return buildClassDropDownAdmin();
                                } else {
                                  return Container();
                                }
                              },
                            ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.05,
                      ),
                      userType!.toLowerCase() == 'e'
                          ? BlocConsumer<SectionListAttendanceCubit,
                              SectionListAttendanceState>(
                              listener: (context, state) {
                                if (state is SectionListAttendanceLoadSuccess) {
                                  print(state.sectionList[0].classSection);
                                  setState(() {
                                    sectionItem = state.sectionList;
                                    selectedSection = state.sectionList[0];
                                    sectionID = state.sectionList[0].id;
                                    sectionName =
                                        state.sectionList[0].classSection;
                                  });
                                  //print(dropDownClassValue!.className);
                                }
                                if (state is SectionListAttendanceLoadFail) {
                                  if (state.failReason == "false") {
                                    UserUtils.unauthorizedUser(context);
                                  } else {
                                    setState(() {
                                      selectedSection =
                                          SectionListAttendanceModel(
                                              id: "", classSection: "");
                                      sectionItem = [];
                                    });
                                  }
                                }
                              },
                              builder: (context, state) {
                                if (state
                                    is SectionListAttendanceLoadInProgress) {
                                  //return CircularProgressIndicator();
                                  return buildPeriodDropDown();
                                } else if (state
                                    is SectionListAttendanceLoadSuccess) {
                                  return buildPeriodDropDown();
                                }
                                // else if (state is SectionListAttendanceLoadFail) {
                                //   return buildPeriodDropDown();
                                // }
                                else {
                                  return Container();
                                }
                              },
                            )
                          : BlocConsumer<SectionListAttendanceAdminCubit,
                              SectionListAttendanceAdminState>(
                              listener: (context, state) {
                                if (state
                                    is SectionListAttendanceAdminLoadSuccess) {
                                  print(state.sectionList[0].classSection);
                                  setState(() {
                                    sectionItemAdmin = state.sectionList;
                                    selectedSectionAdmin = state.sectionList[0];
                                    sectionID = state.sectionList[0].id;
                                    sectionName =
                                        state.sectionList[0].classSection;
                                  });
                                  //print(dropDownClassValue!.className);
                                }
                                if (state
                                    is SectionListAttendanceAdminLoadFail) {
                                  if (state.failReason == "false") {
                                    UserUtils.unauthorizedUser(context);
                                  } else {
                                    setState(() {
                                      selectedSectionAdmin =
                                          SectionListAttendanceAdminModel(
                                              id: "", classSection: "");
                                      sectionItemAdmin = [];
                                    });
                                  }
                                }
                              },
                              builder: (context, state) {
                                if (state
                                    is SectionListAttendanceAdminLoadInProgress) {
                                  //return CircularProgressIndicator();
                                  return buildPeriodDropDownAdmin();
                                } else if (state
                                    is SectionListAttendanceAdminLoadSuccess) {
                                  return buildPeriodDropDownAdmin();
                                }
                                // else if (state is SectionListAttendanceLoadFail) {
                                //   return buildPeriodDropDown();
                                // }
                                else {
                                  return Container();
                                }
                              },
                            ),
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 11),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Number of day',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.435,
                            height: MediaQuery.of(context).size.height * 0.08,
                            child: TextFormField(
                              controller: _controllerDays,
                              autofocus: false,
                              keyboardType: TextInputType.number,
                              maxLength: 1,
                              textAlign: TextAlign.center,
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                // FocusScopeNode currentFocus = FocusScope.of(context);
                                // if (!currentFocus.hasPrimaryFocus &&
                                //     currentFocus.focusedChild != null) {
                                //   FocusManager.instance.primaryFocus!.unfocus();
                                // }
                                // //FocusScope.of(context).requestFocus(new FocusNode());
                                // //FocusScope.of(context).unfocus();
                              },
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-7]'),
                                ),
                              ],
                              validator: FieldValidators.globalValidator,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(8),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 0.1),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 0.1),
                                ),
                                //labelText: "whatever you want",
                                hintText: "1 to 7 ",
                                //counter: Offstage(),
                                // counterText: ""
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Date",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          buildDateSelector(
                            selectedDate:
                                DateFormat("dd MMM yyyy").format(selectedDate),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.07,
                ),
                Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: InkWell(
                      hoverColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        if (_key.currentState!.validate()) {
                          print('He');
                          print(selectedDate);
                          getAttendanceReport(
                              classid: classID,
                              sectionid: sectionID,
                              number: _controllerDays.text,
                              date: DateFormat('dd-MMM-yyyy')
                                  .format(selectedDate));
                        }
                      },
                      child: Text(
                        'Get Details',
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
                  height: MediaQuery.of(context).size.height * 0.45,
                ),
                Center(
                  child: Text(
                    'NOTE : Your phone should have excel app.',
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Expanded buildClassDropDown() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Class',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
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
            child: DropdownButton<ClassListAttendanceReportModel>(
              isDense: true,
              value: selectedClass!,
              iconSize: 20,
              elevation: 16,
              isExpanded: true,
              dropdownColor: Color(0xffFFFFFF),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 13.0,
              ),
              underline: Container(
                color: Color(0xffFFFFFF),
              ),
              items: classItem!
                  .map((item) =>
                      DropdownMenuItem<ClassListAttendanceReportModel>(
                        value: item,
                        child: Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            item.classname!,
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.w300),
                          ),
                        ),
                      ))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  selectedClass = val!;
                  print("selectedMonth: ${val.classname}");
                  classID = val.iD;
                  className = val.classname;
                });
                getEmployeeSection(classid: classID);
                // btnClassSelectedVal =
                //     ClassListEmployeeModel(iD: '', className: '');
                // classItem = [];
              },
            ),
          ),
        ],
      ),
    );
  }

  Expanded buildClassDropDownAdmin() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Class',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xffECECEC)),
              // borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButton<ClassListAttendanceReportAdminModel>(
              isDense: true,
              value: selectedClassAdmin!,
              iconSize: 20,
              elevation: 16,
              isExpanded: true,
              dropdownColor: Color(0xffFFFFFF),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 13.0,
              ),
              underline: Container(
                color: Color(0xffFFFFFF),
              ),
              items: classItemAdmin!
                  .map((item) =>
                      DropdownMenuItem<ClassListAttendanceReportAdminModel>(
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
                  selectedClassAdmin = val!;
                  print("selectedMonth: ${val.className}");
                  classID = val.id;
                  className = val.className;
                });
                getEmployeeSectionAdmin(classid: classID);
                // btnClassSelectedVal =
                //     ClassListEmployeeModel(iD: '', className: '');
                // classItem = [];
              },
            ),
          ),
        ],
      ),
    );
  }

  Expanded buildPeriodDropDown() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Section',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
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
            child: DropdownButton<SectionListAttendanceModel>(
              isDense: true,
              value: selectedSection!,
              iconSize: 20,
              elevation: 16,
              isExpanded: true,
              dropdownColor: Color(0xffFFFFFF),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 13.0,
              ),
              underline: Container(
                color: Color(0xffFFFFFF),
              ),
              items: sectionItem
                  .map((item) => DropdownMenuItem<SectionListAttendanceModel>(
                        value: item,
                        child: Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            item.classSection!,
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.w300),
                          ),
                        ),
                      ))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  selectedSection = val!;
                  sectionID = val.id;
                  sectionName = val.classSection;
                });
                print("selectedSection: ${val!.classSection}");
              },
            ),
          ),
        ],
      ),
    );
  }

  Expanded buildPeriodDropDownAdmin() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Section',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xffECECEC)),
              // borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButton<SectionListAttendanceAdminModel>(
              isDense: true,
              value: selectedSectionAdmin!,
              iconSize: 20,
              elevation: 16,
              isExpanded: true,
              dropdownColor: Color(0xffFFFFFF),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 13.0,
              ),
              underline: Container(
                color: Color(0xffFFFFFF),
              ),
              items: sectionItemAdmin
                  .map((item) =>
                      DropdownMenuItem<SectionListAttendanceAdminModel>(
                        value: item,
                        child: Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            item.classSection!,
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.w300),
                          ),
                        ),
                      ))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  selectedSectionAdmin = val!;
                  sectionID = val.id;
                  sectionName = val.classSection;
                });
                print("selectedSection: ${val!.classSection}");
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1947),
      lastDate: DateTime(2101),
    );
    if (picked != null)
      setState(
        () {
          selectedDate = picked;
        },
      );
  }

  InkWell buildDateSelector({String? selectedDate, int? index}) {
    return InkWell(
      onTap: () => _selectDate(context),
      child: internalTextForDateTime(context,
          width: MediaQuery.of(context).size.width * 0.4,
          selectedDate: selectedDate),
      // Container(
      //   width: MediaQuery.of(context).size.width * 0.42,
      //   height: MediaQuery.of(context).size.height * 0.06,
      //   padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
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
}
