import 'package:campus_pro/src/DATA/BLOC_CUBIT/CLASS_LIST_EMPLOYEE_CUBIT/class_list_employee_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/DELETE_HOMEWORK_CUBIT/delete_homework_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/EMPLOYEE_INFO_FOR_SEARCH_CUBIT/employee_info_for_search_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/HOMEWORK_EMPLOYEE_CUBIT/homework_employee_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/STUDENT_LIST_MEETING_CUBIT/student_list_meeting_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/SUBJECT_LIST_EMPLOYEE_CUBIT/subject_list_employee_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/SubjectListEmployeeModel.dart';
import 'package:campus_pro/src/DATA/MODELS/classListEmployeeModel.dart';
import 'package:campus_pro/src/DATA/MODELS/employeeInfoForSearchModel.dart';
import 'package:campus_pro/src/DATA/MODELS/homeworkEmployeeModel.dart';
import 'package:campus_pro/src/DATA/MODELS/searchEmployeeFromRecordsCommonModel.dart';
import 'package:campus_pro/src/DATA/MODELS/studentListMeetingModel.dart';
import 'package:campus_pro/src/DATA/MODELS/userTypeModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/PAGES/EMPLOYEE_MODULE/COMMUNICATION_EMPLOYEE/SEND_HOMEWORK_EMPLOYEE/createHomeWorkEmployee.dart';
import 'package:campus_pro/src/UI/PAGES/STAND_ALONE_PAGES/chatRoomCommon.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/fileDownloader.dart';
import 'package:campus_pro/src/UI/WIDGETS/noRecordFound.dart';
import 'package:campus_pro/src/UI/WIDGETS/searchEmployeeFromRecordsCommon.dart';
import 'package:campus_pro/src/UTILS/appImages.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/src/bloc.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

import '../../../../../DATA/API_SERVICES/classListEmployeeApi.dart';
import '../../../../../DATA/API_SERVICES/fillClassOnlyWithSectionAdminApi.dart';
import '../../../../../DATA/API_SERVICES/getClasswiseSubjectAdminApi.dart';
import '../../../../../DATA/API_SERVICES/sendHomeWorkEmployeeApi.dart';
import '../../../../../DATA/API_SERVICES/subjectListEmployeeApi.dart';
import '../../../../../DATA/API_SERVICES/teacherListSubjectWiseApi.dart';
import '../../../../../DATA/BLOC_CUBIT/FILL_CLASS_ONLY_WITH_SECTION_ADMIN_CUBIT/fill_class_only_with_section_cubit.dart';
import '../../../../../DATA/BLOC_CUBIT/GET_CLASSWISE_SUBJECT_ADMIN_CUBIT/get_classwise_subject_admin_cubit.dart';
import '../../../../../DATA/BLOC_CUBIT/Send_HomeWork_Employee_Cubit/send_homework_cubit.dart';
import '../../../../../DATA/BLOC_CUBIT/TEACHER_LIST_SUBJECT_WISE_CUBIT/teacher_list_subject_wise_cubit.dart';
import '../../../../../DATA/REPOSITORIES/classListEmployeeRepository.dart';
import '../../../../../DATA/REPOSITORIES/fillClassOnlyWithSectionAdminRepository.dart';
import '../../../../../DATA/REPOSITORIES/getClasswiseSubjectAdminReposiory.dart';
import '../../../../../DATA/REPOSITORIES/sendHomeWorkEmployeeRepository.dart';
import '../../../../../DATA/REPOSITORIES/subjectListEmployeeRepository.dart';
import '../../../../../DATA/REPOSITORIES/teacherListSubjectWiseRepository.dart';

class HomeworkEmployee extends StatefulWidget {
  static const routeName = "/homework-employee";
  @override
  _HomeworkEmployeeState createState() => _HomeworkEmployeeState();
}

class _HomeworkEmployeeState extends State<HomeworkEmployee> {
  // DateTime selectedFromDate = DateTime.now().subtract(Duration(days: 7));
  DateTime selectedDate = DateTime.now();

  String? uid = '';
  String? token = '';
  UserTypeModel? userData;

  bool showFilters = false;
  bool showLoader = false;

  EmployeeInfoForSearchModel? selectedEmployee =
      EmployeeInfoForSearchModel(empId: -1);

  @override
  void initState() {
    homeworkEmpData = [];
    userData = UserTypeModel(
      buttonConfigString: "",
      schoolName: "",
      attStartTime: "",
      attCloseTime: "",
      showFeeReceipt: "",
      editAmount: "",
      incrementMonthId: "",
      currentSessionid: "",
      organizationId: "",
      schoolId: "",
      stuEmpId: "",
      stuEmpName: "",
      ouserType: "",
      headerImgPath: "",
      logoImgPath: "",
      websiteUrl: "",
      bloggerUrl: "",
      busId: "",
      sendOtpToVisitor: "",
      letPayOldFeeMonths: "",
      fillFeeAmount: "",
      testUrl: "",
      isShowMobileNo: "",
      empJoinOnPlatformApp: "",
      stuJoinOnPlatformApp: "",
      baseDomainURL: "",
      appUrl: "",
    );
    selectSubject =
        SubjectListEmployeeModel(subjectHead: "Select", subjectId: -1);
    getDataFromCache();
    super.initState();
  }

  getDataFromCache() async {
    uid = await UserUtils.idFromCache();
    token = await UserUtils.userTokenFromCache();
    userData = await UserUtils.userTypeFromCache();
    print("userData!.ouserType ${userData!.ouserType}");
    if (userData!.ouserType!.toLowerCase() == "a" ||
        userData!.ouserType!.toLowerCase() == "e" ||
        userData!.ouserType!.toLowerCase() == "s" ||
        userData!.ouserType!.toLowerCase() == "m" ||
        userData!.ouserType!.toLowerCase() == "p") {
      getHomework(0);
      getEmployeeClass(userData!.stuEmpId);
      if (userData!.ouserType!.toLowerCase() == "a") {
        setState(() {
          print("showFilters = true is working}");
          showFilters = true;
        });
      }
    }
  }

  getEmployeeClass(String? empId) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final getEmpClassData = {
      "OUserId": uid!,
      "Token": token!,
      "OrgId": userData!.organizationId!,
      "Schoolid": userData.schoolId!,
      "SessionId": userData.currentSessionid!,
      "EmpID": empId,
    };
    print('Employee Class List $getEmpClassData');
    context
        .read<ClassListEmployeeCubit>()
        .classListEmployeeCubitCall(getEmpClassData);
  }

  getHomework(int? index) async {
    List<String> classIdFinal = [];
    List<String> streamIdFinal = [];
    List<String> sectionIdFinal = [];
    List<String> yearIdFinal = [];
    if (_selectedClassList.isNotEmpty) {
      for (int i = 0; i < _selectedClassList.length; i++) {
        setState(
            () => classIdFinal.add(_selectedClassList[i].iD!.split("#")[0]));
      }

      for (int i = 0; i < _selectedClassList.length; i++) {
        setState(
            () => streamIdFinal.add(_selectedClassList[i].iD!.split("#")[1]));
      }

      for (int i = 0; i < _selectedClassList.length; i++) {
        setState(
            () => sectionIdFinal.add(_selectedClassList[i].iD!.split("#")[2]));
      }

      for (int i = 0; i < _selectedClassList.length; i++) {
        setState(
            () => yearIdFinal.add(_selectedClassList[i].iD!.split("#")[4]));
      }
    }
    final homeworkData = {
      'OUserId': uid,
      'Token': token,
      'OrgId': userData!.organizationId,
      'Schoolid': userData!.schoolId,
      'subjectid': selectSubject!.subjectHead == "Select"
          ? "0"
          : selectSubject!.subjectId.toString(),
      'ClassId': _selectedClassList.isNotEmpty ? classIdFinal.join(",") : "",
      'streamid': _selectedClassList.isNotEmpty ? streamIdFinal.join(",") : "",
      'sectionid':
          _selectedClassList.isNotEmpty ? sectionIdFinal.join(",") : "",
      'yearid': _selectedClassList.isNotEmpty ? yearIdFinal.join(",") : "",
      'TeacherId': userData!.ouserType!.toLowerCase() == "e"
          ? userData!.stuEmpId
          : selectedEmployee!.empId.toString(),
      'StuEmpId': userData!.stuEmpId,
      'FromDate': DateFormat("dd-MMM-yyyy").format(selectedDate),
      'ToDate': DateFormat("dd-MMM-yyyy").format(selectedDate),
      'TUsertype': "e",
      'OUserType': userData!.ouserType,
    };
    print("Sending HomeworkEmployee Data = > $homeworkData");
    context
        .read<HomeworkEmployeeCubit>()
        .homeworkEmployeeCubitCall(homeworkData);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      helpText: "SELECT DATE",
    );
    if (picked != null)
      setState(() {
        selectedDate = picked;
      });
  }

  _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000)).then((value) {
      if (userData!.ouserType == "s" && userData!.ouserType == "e")
        getHomework(0);
      else
        getHomework(1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, title: "Homework"),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return BlocProvider<SendHomeworkEmployeeCubit>(
              create: (_) => SendHomeworkEmployeeCubit(
                  SendHomeWorkEmployeeRepository(SendHomeWorkEmployeeApi())),
              child: BlocProvider<GetClasswiseSubjectAdminCubit>(
                create: (_) => GetClasswiseSubjectAdminCubit(
                    GetClasswiseSubjectAdminRepository(
                        GetClasswiseSubjectAdminApi())),
                child: BlocProvider<SubjectListEmployeeCubit>(
                  create: (_) => SubjectListEmployeeCubit(
                      SubjectListEmployeeRepository(SubjectListEmployeeApi())),
                  child: BlocProvider<FillClassOnlyWithSectionCubit>(
                    create: (_) => FillClassOnlyWithSectionCubit(
                        FillClassOnlyWithSectionAdminRepository(
                            FillClassOnlyWithSectionAdminApi())),
                    child: BlocProvider<ClassListEmployeeCubit>(
                      create: (_) => ClassListEmployeeCubit(
                          ClassListEmployeeRepository(ClassListEmployeeApi())),
                      child: BlocProvider<TeacherListSubjectWiseCubit>(
                        create: (_) => TeacherListSubjectWiseCubit(
                            TeacherListSubjectWiseRepository(
                                TeacherListSubjectWiseApi())),
                        child: CreateSendHomeWorkEmployee(),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }));
          // Navigator.pushNamed(context, CreateSendHomeWorkEmployee.routeName);
        },
        child: const Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<SubjectListEmployeeCubit, SubjectListEmployeeState>(
            listener: (context, state) {
              if (state is SubjectListEmployeeLoadSuccess) {
                setState(() {
                  subjectList = state.subjectList;
                  // if (subjectList![0].subjectHead != 'Select') {
                  //   subjectList!.insert(
                  //       0,
                  //       SubjectListEmployeeModel(
                  //           subjectId: -1, subjectHead: "Select"));
                  // }
                  selectSubject = subjectList!.first;
                });
                print('length of subject List ${subjectList!.length}');
              }
              if (state is SubjectListEmployeeLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                }
                setState(() {
                  subjectList = [];
                  selectSubject = SubjectListEmployeeModel(
                      subjectHead: "Select", subjectId: -1);
                });
              }
            },
          ),
          BlocListener<ClassListEmployeeCubit, ClassListEmployeeState>(
            listener: (context, state) {
              if (state is ClassListEmployeeLoadSuccess) {
                setState(() {
                  classListMulti = state.classList;
                });
              }
              if (state is ClassListEmployeeLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                }
                setState(() {
                  classListMulti = [];
                });
              }
            },
          ),
          BlocListener<DeleteHomeworkCubit, DeleteHomeworkState>(
            listener: (context, state) {
              if (state is DeleteHomeworkLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                }
              }
              if (state is DeleteHomeworkLoadSuccess) {
                getHomework(1);
              }
            },
          ),
          BlocListener<EmployeeInfoForSearchCubit, EmployeeInfoForSearchState>(
            listener: (context, state) {
              if (state is EmployeeInfoForSearchLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                }
              }
              if (state is EmployeeInfoForSearchLoadSuccess) {
                setState(() {
                  selectedEmployee = state.employeeInfoData;
                });
                getEmployeeClass(selectedEmployee!.empId.toString());
                getHomework(1);
              }
            },
          ),
        ],
        child: Column(
          children: [
            buildEnquiry(context),
            if (showLoader) LinearProgressIndicator(),
            if (showFilters) buildTopFilter(context),
            // if (userData!.ouserType!.toLowerCase() == "a")
            //   Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 10.0),
            //     child: Column(
            //       children: [
            //         buildLabels(label: "Search Employee"),
            //         GestureDetector(
            //           onTap: () async {
            //             final employeeData = await Navigator.pushNamed(context,
            //                     SearchEmployeeFromRecordsCommon.routeName)
            //                 as SearchEmployeeFromRecordsCommonModel;
            //             if (employeeData.empId != "") {
            //               final data = {
            //                 "OUserId": uid!,
            //                 "Token": token!,
            //                 "OrgId": userData!.organizationId!,
            //                 "Schoolid": userData!.schoolId!,
            //                 "EmployeeId": employeeData.empId!,
            //                 "SessionId": userData!.currentSessionid!,
            //                 "StuEmpId": userData!.stuEmpId!,
            //                 "UserType": userData!.ouserType!,
            //               };
            //               print("Sending EmployeeInfoForSearch Data => $data");
            //               context
            //                   .read<EmployeeInfoForSearchCubit>()
            //                   .employeeInfoForSearchCubitCall(data);
            //               // setState(() => userId = studentData.studentid);
            //             }
            //           },
            //           child: Container(
            //             // height: 40,
            //             width: MediaQuery.of(context).size.width,
            //             padding: const EdgeInsets.all(8.0),
            //             decoration: BoxDecoration(
            //               border: Border.all(color: Colors.black12),
            //             ),
            //             child: Text("search employee here..."),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),

            buildTopDateFilter(context),
            Divider(
              thickness: 2,
              // color: Theme.of(context).backgroundColor,
            ),
            BlocConsumer<HomeworkEmployeeCubit, HomeworkEmployeeState>(
              listener: (context, state) {
                if (state is HomeworkEmployeeLoadFail) {
                  if (state.failReason == "false") {
                    UserUtils.unauthorizedUser(context);
                  } else {
                    setState(() {
                      showLoader = false;
                    });
                  }
                }
                if (state is HomeworkEmployeeLoadSuccess) {
                  setState(() {
                    homeworkEmpData = state.homeworkEmpData;
                  });
                }
              },
              builder: (context, state) {
                if (state is HomeworkEmployeeLoadInProgress) {
                  // return Center(child: CircularProgressIndicator());
                  return Center(child: LinearProgressIndicator());
                } else if (state is HomeworkEmployeeLoadSuccess) {
                  return buildHomeWorkBody(context);
                } else if (state is HomeworkEmployeeLoadFail) {
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

  Row buildEnquiry(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            setState(() => showFilters = !showFilters);
          },
          child: Container(
            padding: const EdgeInsets.all(8.0),
            // color: Theme.of(context).primaryColor,
            child: Row(
              children: [
                Icon(Icons.sort),
                Text("Filters",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Container buildTopFilter(BuildContext context) {
    return Container(
      color: Color(0xffECECEC),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (userData!.ouserType!.toLowerCase() == "a" ||
              userData!.ouserType!.toLowerCase() == "m" ||
              userData!.ouserType!.toLowerCase() == "p")
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  buildLabels(label: "Search Employee"),
                  GestureDetector(
                    onTap: () async {
                      final employeeData = await Navigator.pushNamed(context,
                              SearchEmployeeFromRecordsCommon.routeName)
                          as SearchEmployeeFromRecordsCommonModel;
                      if (employeeData.empId != "") {
                        final data = {
                          "OUserId": uid!,
                          "Token": token!,
                          "OrgId": userData!.organizationId!,
                          "Schoolid": userData!.schoolId!,
                          "EmployeeId": employeeData.empId!,
                          "SessionId": userData!.currentSessionid!,
                          "StuEmpId": userData!.stuEmpId!,
                          "UserType": userData!.ouserType!,
                        };
                        print("Sending EmployeeInfoForSearch Data => $data");
                        context
                            .read<EmployeeInfoForSearchCubit>()
                            .employeeInfoForSearchCubitCall(data);
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
                  if (selectedEmployee!.empId != 0 &&
                      selectedEmployee!.empId != -1)
                    Text(
                        "● ${selectedEmployee!.name!} - ${selectedEmployee!.mobileNo!}",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).primaryColor)),
                ],
              ),
            ),
          SizedBox(height: 10.0),
          buildClassMultiSelect(context),
          SizedBox(height: 10.0),
          buildSubjectDropDown(context),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
          //   child: Row(
          //     children: [
          //       // buildDateContainer(context),
          //       SizedBox(width: 20),
          //       // buildHoursDropdown(context),
          //     ],
          //   ),
          // ),
          buildSearchBtn(),
        ],
      ),
    );
  }

  Container buildSearchBtn() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Theme.of(context).primaryColor,
      ),
      child: InkWell(
        onTap: () async {
          getHomework(0);
          setState(() {
            showFilters = false;
            showLoader = true;
            homeworkEmpData = [];
          });
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.search, color: Colors.white),
            SizedBox(width: 4),
            Text(
              "Search",
              style: TextStyle(
                  fontFamily: "BebasNeue-Regular", color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  //MultiSelect Class
  List<ClassListEmployeeModel> _selectedClassList =
      []; // Fee Head after Seletion
  List<ClassListEmployeeModel>? classListMulti = []; // Fee Head After API
  final _classListSelectKey = GlobalKey<FormFieldState>();

  Widget buildClassMultiSelect(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Class',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          child: MultiSelectBottomSheetField<ClassListEmployeeModel>(
            autovalidateMode: AutovalidateMode.disabled,
            decoration: BoxDecoration(
              border: Border.all(width: 0.1),
            ),
            key: _classListSelectKey,
            initialChildSize: 0.7,
            maxChildSize: 0.95,
            searchIcon: Icon(Icons.ac_unit),
            title: Text("All Classes",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 18)),
            buttonText: Text(
              "Selected Classes",
              // style: TextStyle(fontSize: 16,),
            ),
            // buttonText: Text(
            //   _selectedClassList.length > 0
            //       ? "${_selectedClassList.length} Class selected"
            //       : "None selected",
            // ),
            items: classListMulti!
                .map((e) => MultiSelectItem(e, e.className!))
                .toList(),
            searchable: false,
            validator: (values) {
              if (values == null || values.isEmpty) {
                return "Required";
              }
              return null;
            },
            onConfirm: (values) {
              setState(() {
                _selectedClassList = values;
              });

              getEmployeeSubject();
              getHomework(0);
              setState(() {
                // showFilters = !showFilters;
                showLoader = true;
                homeworkEmpData = [];
              });
            },
            // chipDisplay: MultiSelectChipDisplay.none(),
            chipDisplay: MultiSelectChipDisplay(
              onTap: (item) {
                setState(() {
                  _selectedClassList.remove(item);
                  print('removed below: ${_selectedClassList.toString()}');
                });
                // _classListSelectKey.currentState!.validate();
              },
              shape: RoundedRectangleBorder(),
              textStyle: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).primaryColor),
            ),
          ),
        ),
      ],
    );
  }

  //Subject Dropdown
  List<SubjectListEmployeeModel>? subjectList = [];
  SubjectListEmployeeModel? selectSubject;
  String? subjectId;

  int noOfMaleTeacher = 0;
  int noOfFemaleTeacher = 0;

  GlobalKey<FormFieldState> _classSelectKey = GlobalKey<FormFieldState>();
  GlobalKey<FormFieldState> _teacherSelectKey = GlobalKey<FormFieldState>();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //MultiSelect Class
  List<ClassListEmployeeModel>? classList = [];
  List finalClassList = [];
  List allClassList = [];
  //

  //MultiSelect Students
  List<StudentListMeetingModel>? teacherList = [];
  List finalTeacherList = [];
  //

  List<Map<String, String>> studentList = [];

  //
  List<String> classIds = [];
  List streamIds = [];
  List sectionIds = [];
  List yearIds = [];
  //

  String? userType = '';
  bool? classCheck = false;
  bool buttonLoader = false;
  String? empIdForAdminSearch;

  Column buildSubjectDropDown(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Subject',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
        Container(
          height: 40,
          margin: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            border: Border.all(width: 0.1),
          ),
          child: DropdownButton<SubjectListEmployeeModel>(
            value: selectSubject,
            isExpanded: true,
            underline: Container(),
            items: subjectList!
                .map((e) => DropdownMenuItem<SubjectListEmployeeModel>(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text('${e.subjectHead}'),
                      ),
                      value: e,
                    ))
                .toList(),
            onChanged: (val) {
              setState(() {
                selectSubject = val!;
                // subjectId = selectSubject.toString();
              });
              // getStudentsList(
              //   classId: classIds.join(','),
              //   streamId: streamIds.join(','),
              //   sectionId: sectionIds.join(','),
              //   yearId: yearIds.join(','),
              //   subjectId: int.parse(subjectId!),
              // );
            },
          ),
        ),
      ],
    );
  }

  // getStudentsList({
  //   @required String? classId,
  //   @required String? streamId,
  //   @required String? sectionId,
  //   @required String? yearId,
  //   @required int? subjectId,
  // }) async {
  //   final uid = await UserUtils.idFromCache();
  //   final token = await UserUtils.userTokenFromCache();
  //   final userData = await UserUtils.userTypeFromCache();

  //   final getStudentData = {
  //     "OUserId": uid!,
  //     "Token": token!,
  //     "OrgId": userData!.organizationId,
  //     "Schoolid": userData.schoolId,
  //     "SessionId": userData.currentSessionid,
  //     "ClassId": classId,
  //     "StreamId": streamId,
  //     "SectionId": sectionId,
  //     "YearId": yearId,
  //     "StuEmpId": userData.stuEmpId,
  //     "UserType": userData.ouserType,
  //     "SubjectId": subjectId.toString(),
  //   };

  //   print('Sending SubjectListMeeting datas $getStudentData');
  //   context
  //       .read<StudentListMeetingCubit>()
  //       .studentListMeetingCubitCall(getStudentData);
  // }

  getEmployeeSubject() async {
    List<String> classIdFinal = [];
    for (int i = 0; i < _selectedClassList.length; i++) {
      setState(() => classIdFinal.add(_selectedClassList[i].iD!.split("#")[0]));
    }

    List<String> streamIdFinal = [];
    for (int i = 0; i < _selectedClassList.length; i++) {
      setState(
          () => streamIdFinal.add(_selectedClassList[i].iD!.split("#")[1]));
    }

    List<String> sectionIdFinal = [];
    for (int i = 0; i < _selectedClassList.length; i++) {
      setState(
          () => sectionIdFinal.add(_selectedClassList[i].iD!.split("#")[2]));
    }

    List<String> yearIdFinal = [];
    for (int i = 0; i < _selectedClassList.length; i++) {
      setState(() => yearIdFinal.add(_selectedClassList[i].iD!.split("#")[4]));
    }

    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final getEmpSubData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "ClassID": classIdFinal.join(","),
      "StreamID": streamIdFinal.join(","),
      "SectionID": sectionIdFinal.join(","),
      "YearID": yearIdFinal.join(","),
      "Schoolid": userData.schoolId,
      "SessionId": userData.currentSessionid,
      "EmpId": userData.stuEmpId,
      "UserType": userData.ouserType,
      "TeacherId": userData.stuEmpId,
    };
    print('Sending SubjectListEmployee Data => $getEmpSubData');
    context
        .read<SubjectListEmployeeCubit>()
        .subjectListEmployeeCubitCall(getEmpSubData);
  }

  List<HomeworkEmployeeModel>? homeworkEmpData = [];

  Widget buildHomeWorkBody(BuildContext context) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () => _onRefresh(),
        child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) =>
              const SizedBox(height: 10.0),
          physics: AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: homeworkEmpData!.length,
          itemBuilder: (context, i) {
            var item = homeworkEmpData![i];
            return Stack(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffDBDBDB)),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        title: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (item.classname != "" &&
                                      item.classname != null)
                                    Text(
                                      item.classname!,
                                      // textScaleFactor: 1.0,
                                      // style: Theme.of(context)
                                      //     .textTheme
                                      //     .headline5!
                                      //     .copyWith(fontSize: 18),
                                    ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        // '${item.subject} ● ${item.attdate}',
                                        '${item.subject}',
                                        // style: Theme.of(context)
                                        //     .textTheme
                                        //     .subtitle1!
                                        //     .copyWith(
                                        //       color: Color(0xff3A3A3A)
                                        //           .withOpacity(0.7),
                                        //     ),
                                      ),
                                      Text(
                                        // '${item.subject} ● ${item.attdate}',
                                        '${item.attdate}',
                                        // style: Theme.of(context)
                                        //     .textTheme
                                        //     .subtitle1!
                                        //     .copyWith(
                                        //         color: Color(0xff3A3A3A)
                                        //             .withOpacity(0.7),
                                        //         fontSize: 11.0),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Divider(color: Color(0xffDBDBDB), height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  buildText(title: item.homework),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(color: Color(0xffDBDBDB), height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          if (item.imageurl != "")
                            item.imageurl!.contains(",")
                                ? Row(
                                    children: [
                                      for (int i = 0;
                                          i <
                                              item.imageurl!.split(",").length -
                                                  1;
                                          i++)
                                        FileDownload(
                                          fileName: item.imageurl!
                                              .split(",")[i]
                                              .split("/")
                                              .last,
                                          fileUrl: item.imageurl!.split(",")[i],
                                          downloadWidget: Image.asset(
                                            getDownloadImage(
                                                item.imageurl!.split(".").last),
                                            width: 28,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                    ],
                                  )
                                : FileDownload(
                                    fileName: item.imageurl!
                                        .split(",")
                                        .first
                                        .split("/")
                                        .last,
                                    fileUrl: item.imageurl!.split(",").first,
                                    downloadWidget: Row(
                                      children: [
                                        Image.asset(
                                          getDownloadImage(
                                              item.imageurl!.split(".").last),
                                          width: 28,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          "Download",
                                          style: TextStyle(
                                              color: Colors.black45,
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                          InkWell(
                            onTap: () {
                              final chatData = ChatRoomCommonModel(
                                appbarTitle:
                                    "${item.classname} / ${item.subject}",
                                iD: item.homeworkid,
                                stuEmpId: userData!.stuEmpId,
                                classId: "",
                                screenType: "homework",
                              );
                              Navigator.pushNamed(
                                  context, ChatRoomCommon.routeName,
                                  arguments: chatData);
                            },
                            child: Row(
                              children: [
                                Icon(Icons.chat_bubble_outline,
                                    color: Theme.of(context).primaryColor),
                                SizedBox(width: 10),
                                Text(
                                  "Comments",
                                  // textScaleFactor: 1.0,
                                  style: TextStyle(
                                      color: Colors.black45,
                                      // fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (userData!.stuEmpId == item.empid)
                  Positioned(
                    right: 10.0,
                    child: IconButton(
                      onPressed: () async {
                        final uid = await UserUtils.idFromCache();
                        final token = await UserUtils.userTokenFromCache();
                        final userData = await UserUtils.userTypeFromCache();
                        final deleteHomework = {
                          'OUserId': uid,
                          'Token': token,
                          'OrgId': userData!.organizationId,
                          'Schoolid': userData.schoolId,
                          'hwid': item.iD,
                          'hwtype': item.homeworktype,
                          'UserType': userData.ouserType,
                          'StuEmpId': userData.stuEmpId,
                        };
                        print("Sending DeleteHomework data => $deleteHomework");
                        context
                            .read<DeleteHomeworkCubit>()
                            .deleteHomeworkCubitCall(deleteHomework);
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Flexible buildText({String? title}) {
    return Flexible(
      child: Text(
        title!,
        // textScaleFactor: 1.2,
        // style:
        //     Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.grey),
      ),
    );
  }

  InkWell buildDateSelector({String? selectedDate}) {
    return InkWell(
      onTap: () => _selectDate(context),
      child: Container(
        //width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xffECECEC)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Text(
                selectedDate!,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Icon(Icons.today, color: Theme.of(context).primaryColor)
          ],
        ),
      ),
    );
  }

  Container buildTopDateFilter(BuildContext context) {
    return Container(
      // color: Colors.white,
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          buildDateSelector(
            selectedDate: DateFormat("dd MMM yyyy").format(selectedDate),
          ),
          SizedBox(width: 30.0),
          InkWell(
            onTap: () => getHomework(1),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 50),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Theme.of(context).primaryColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 17.0,
                    spreadRadius: 3.0,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Text(
                "Show",
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
    );
  }

  Padding buildLabels({String? label, Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        label!,
        style: GoogleFonts.quicksand(
          color: color ?? Color(0xff3A3A3A),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  String getDownloadImage(String? extention) {
    switch (extention) {
      case "jpg":
        return AppImages.jpgImage;
      case "jpeg":
        return AppImages.jpegImage;
      case "pdf":
        return AppImages.pdfImage;
      default:
        return AppImages.downloadImage;
    }
  }
}
