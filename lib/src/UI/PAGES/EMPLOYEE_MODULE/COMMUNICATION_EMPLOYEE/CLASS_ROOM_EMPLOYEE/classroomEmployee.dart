import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/CLASSROOMS_STUDENT_CUBIT/classrooms_student_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/CLASSROOM_EMPOYEE_CUBIT/classroom_employee_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/CLASS_END_DRAWER_LOCAL_CUBIT/class_end_drawer_local_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/CLASS_LIST_EMPLOYEE_CUBIT/class_list_employee_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/DELETE_CLASSROOM_CUBIT/delete_classroom_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/EMPLOYEE_INFO_FOR_SEARCH_CUBIT/employee_info_for_search_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/SEND_CUSTOM_CLASSROOM_COMMENT_CUBIT/send_custom_class_room_comment_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/STUDENT_LIST_MEETING_CUBIT/student_list_meeting_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/SUBJECT_LIST_EMPLOYEE_CUBIT/subject_list_employee_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/TEACHERS_LIST_CUBIT/teachers_list_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/SubjectListEmployeeModel.dart';
import 'package:campus_pro/src/DATA/MODELS/classListEmployeeModel.dart';
import 'package:campus_pro/src/DATA/MODELS/classroomEmployeeModel.dart';
import 'package:campus_pro/src/DATA/MODELS/employeeInfoForSearchModel.dart';
import 'package:campus_pro/src/DATA/MODELS/searchEmployeeFromRecordsCommonModel.dart';
import 'package:campus_pro/src/DATA/MODELS/studentInfoModel.dart';
import 'package:campus_pro/src/DATA/MODELS/studentListMeetingModel.dart';
import 'package:campus_pro/src/DATA/MODELS/teachersListModel.dart';
import 'package:campus_pro/src/DATA/MODELS/userTypeModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/PAGES/EMPLOYEE_MODULE/COMMUNICATION_EMPLOYEE/CLASS_ROOM_EMPLOYEE/addClassRoomEmployee.dart';
import 'package:campus_pro/src/UI/PAGES/STAND_ALONE_PAGES/chatRoomCommon.dart';
import 'package:campus_pro/src/UI/PAGES/STAND_ALONE_PAGES/contactList.dart';
import 'package:campus_pro/src/UI/WIDGETS/classEndDrawer.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonSnackbar.dart';
import 'package:campus_pro/src/UI/WIDGETS/fileDownloader.dart';
import 'package:campus_pro/src/UI/WIDGETS/noRecordFound.dart';
import 'package:campus_pro/src/UI/WIDGETS/searchEmployeeFromRecordsCommon.dart';
import 'package:campus_pro/src/UI/WIDGETS/toast.dart';
import 'package:campus_pro/src/UTILS/appImages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

import '../../../../../DATA/API_SERVICES/classListEmployeeApi.dart';
import '../../../../../DATA/API_SERVICES/saveClassroomApi.dart';
import '../../../../../DATA/API_SERVICES/studentListMeetingApi.dart';
import '../../../../../DATA/API_SERVICES/subjectListEmployeeApi.dart';
import '../../../../../DATA/BLOC_CUBIT/SAVE_CLASS_ROOM_CUBIT/save_class_room_cubit.dart';
import '../../../../../DATA/REPOSITORIES/classListEmployeeRepository.dart';
import '../../../../../DATA/REPOSITORIES/saveClassRoomRepository.dart';
import '../../../../../DATA/REPOSITORIES/studentListMeetingRepository.dart';
import '../../../../../DATA/REPOSITORIES/subjectListEmployeeRepository.dart';

class ClassroomEmployee extends StatefulWidget {
  static const routeName = "/classrooms-employee";

  const ClassroomEmployee({Key? key}) : super(key: key);

  @override
  _ClassroomEmployeeState createState() => _ClassroomEmployeeState();
}

class _ClassroomEmployeeState extends State<ClassroomEmployee> {
  ScrollController _scrollController = new ScrollController();

  final _drawerKey = GlobalKey<ScaffoldState>();

  bool showFilters = false;
  bool showLoader = false;

  String? uid;
  String? token;
  UserTypeModel? userData;

  String selectedTeacher = "All";

  List<StudentInfoModel>? stuData = [];

  bool isLoading = false;
  List<ClassroomEmployeeModel> classrommCustomList = [];

  EmployeeInfoForSearchModel? selectedEmployee = EmployeeInfoForSearchModel(empId: -1);

  @override
  void initState() {
    classrommCustomList = [];
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
    selectSubject = SubjectListEmployeeModel(subjectHead: "Select", subjectId: -1);
    getDataFromCache();

    super.initState();
  }

  getDataFromCache() async {
    uid = await UserUtils.idFromCache();
    token = await UserUtils.userTokenFromCache();
    userData = await UserUtils.userTypeFromCache();
    if (userData!.ouserType!.toLowerCase() == "a" ||
        userData!.ouserType!.toLowerCase() == "e" ||
        userData!.ouserType!.toLowerCase() == "s" ||
        userData!.ouserType!.toLowerCase() == "c" ||
        userData!.ouserType!.toLowerCase() == "m" ||
        userData!.ouserType!.toLowerCase() == "p") {
      getClassroomList(noRows: "20", counts: "0", index: 0);
      getEmployeeClass(userData!.stuEmpId);
      if (userData!.ouserType!.toLowerCase() == "a" ||
          userData!.ouserType!.toLowerCase() == "m" ||
          userData!.ouserType!.toLowerCase() == "c") {
        setState(() {
          showFilters = true;
        });
      }
    }
  }

  getClassroomList({String? noRows, String? counts, int? index}) async {
    List<String> classIdFinal = [];
    List<String> streamIdFinal = [];
    List<String> sectionIdFinal = [];
    List<String> yearIdFinal = [];
    if (_selectedClassList.isNotEmpty) {
      for (int i = 0; i < _selectedClassList.length; i++) {
        setState(() => classIdFinal.add(_selectedClassList[i].iD!.split("#")[0]));
      }

      for (int i = 0; i < _selectedClassList.length; i++) {
        setState(() => streamIdFinal.add(_selectedClassList[i].iD!.split("#")[1]));
      }

      for (int i = 0; i < _selectedClassList.length; i++) {
        setState(() => sectionIdFinal.add(_selectedClassList[i].iD!.split("#")[2]));
      }

      for (int i = 0; i < _selectedClassList.length; i++) {
        setState(() => yearIdFinal.add(_selectedClassList[i].iD!.split("#")[4]));
      }
    }

    final classData = {
      'OUserId': uid,
      'Token': token,
      'OrgId': userData!.organizationId,
      'Schoolid': userData!.schoolId,
      'NoRows': noRows,
      'Counts': counts,
      'EmpId': userData!.stuEmpId,
      'SubjectId': selectSubject!.subjectHead == "Select" ? "" : selectSubject!.subjectId.toString(),
      // 'SubjectId': selectSubject!.subjectId.toString(),
      'ClassId': _selectedClassList.isNotEmpty ? classIdFinal.join(",") : "",
      'StreamId': _selectedClassList.isNotEmpty ? streamIdFinal.join(",") : "",
      'SectionId': _selectedClassList.isNotEmpty ? sectionIdFinal.join(",") : "",
      'YearId': _selectedClassList.isNotEmpty ? yearIdFinal.join(",") : "",
      'LastId': "",
      'SessionId': userData!.currentSessionid,
      'UserType': userData!.ouserType,
      'TeacherId':
          userData!.ouserType!.toLowerCase() == "e" ? userData!.stuEmpId : selectedEmployee!.empId.toString(),
    };
    context.read<ClassroomEmployeeCubit>().classroomEmployeeCubitCall(classData);
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
    context.read<ClassListEmployeeCubit>().classListEmployeeCubitCall(getEmpClassData);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future loadMore() async {
    setState(() {
      isLoading = true;
    });
    // Add in an artificial delay
    await new Future.delayed(const Duration(seconds: 2));
    getClassroomList(noRows: "10", counts: classrommCustomList.length.toString(), index: 1);
  }

  _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000)).then((value) {
      setState(() {
        classrommCustomList = [];
      });
      getClassroomList(noRows: "20", counts: "0", index: 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return BlocProvider<StudentListMeetingCubit>(
              create: (_) => StudentListMeetingCubit((StudentListMeetingRepository(StudentListMeetingApi()))),
              child: BlocProvider<SubjectListEmployeeCubit>(
                create: (_) =>
                    SubjectListEmployeeCubit(SubjectListEmployeeRepository(SubjectListEmployeeApi())),
                child: BlocProvider<ClassListEmployeeCubit>(
                  create: (_) => ClassListEmployeeCubit(ClassListEmployeeRepository(ClassListEmployeeApi())),
                  child: BlocProvider<SaveClassRoomCubit>(
                    create: (_) => SaveClassRoomCubit(SaveClassRoomRepository(SaveClassroomApi())),
                    child: AddClassRoom(),
                  ),
                ),
              ),
            );
          }));
          // Navigator.pushNamed(context, AddClassRoom.routeName);
        },
        child: const Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      appBar: commonAppBar(context, title: "Classrooms"),
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
                  selectSubject = SubjectListEmployeeModel(subjectHead: "Select", subjectId: -1);
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
          BlocListener<DeleteClassroomCubit, DeleteClassroomState>(
            listener: (context, state) {
              if (state is DeleteClassroomLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                }
              }
              if (state is DeleteClassroomLoadSuccess) {
                setState(() {
                  classrommCustomList = [];
                });
                getClassroomList(noRows: "20", counts: "0", index: 1);
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
                  classrommCustomList = [];
                });
                getClassroomList(noRows: "20", counts: "0", index: 1);
                getEmployeeClass(selectedEmployee!.empId.toString());
              }
            },
          ),
        ],
        child: Column(
          children: [
            buildEnquiry(context),
            SizedBox(height: 10.0),
            if (showLoader)
              Container(margin: EdgeInsets.symmetric(vertical: 5), child: LinearProgressIndicator())
            else
              Divider(color: Color(0xffECECEC), thickness: 6, height: 0),
            if (showFilters) buildTopFilter(context),
            Expanded(
              child: BlocConsumer<ClassroomEmployeeCubit, ClassroomEmployeeState>(
                listener: (context, state) {
                  if (state is ClassroomEmployeeLoadInProgress) {
                    setState(() => showLoader = true);
                  }
                  if (state is ClassroomEmployeeLoadSuccess) {
                    print("running");

                    setState(() {
                      classrommCustomList.addAll(state.classroomEmpData);
                    });
                    print("testing");

                    setState(() => isLoading = false);
                    setState(() => showLoader = false);
                  }
                  if (state is ClassroomEmployeeLoadFail) {
                    if (state.failReason == "false") {
                      UserUtils.unauthorizedUser(context);
                    } else {
                      setState(() => isLoading = false);
                      setState(() => showLoader = false);
                      ScaffoldMessenger.of(context).showSnackBar(
                        commonSnackBar(title: "No More Records"),
                      );
                    }
                  }
                },
                builder: (context, state) {
                  if (state is ClassroomEmployeeLoadInProgress) {
                    return buildClassroomsBody(context);
                  } else if (state is ClassroomEmployeeLoadSuccess) {
                    return buildClassroomsBody(context);
                  } else if (state is ClassroomEmployeeLoadFail) {
                    return buildClassroomsBody(context);
                    //   Center(
                    //   child: Text(
                    //     "NO RECORD FOUND",
                    //     style: TextStyle(
                    //       fontSize: 16,
                    //       fontWeight: FontWeight.w600,
                    //     ),
                    //   ),
                    // );
                    //buildClassroomsBody(context);
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
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
                Text("Filters", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
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
              userData!.ouserType!.toLowerCase() == "c" ||
              userData!.ouserType!.toLowerCase() == "m" ||
              userData!.ouserType!.toLowerCase() == "p")
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  buildLabels(label: "Search Employee"),
                  GestureDetector(
                    onTap: () async {
                      final employeeData =
                          await Navigator.pushNamed(context, SearchEmployeeFromRecordsCommon.routeName)
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
                        context.read<EmployeeInfoForSearchCubit>().employeeInfoForSearchCubitCall(data);
                        // setState(() => userId = studentData.studentid);
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
                  if (selectedEmployee!.empId != 0 && selectedEmployee!.empId != -1)
                    Text("● ${selectedEmployee!.name!} - ${selectedEmployee!.mobileNo!}",
                        style: TextStyle(fontWeight: FontWeight.w500, color: Theme.of(context).primaryColor)),
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

//Subject Dropdown
  List<SubjectListEmployeeModel>? subjectList = [];
  SubjectListEmployeeModel? selectSubject;
  String? subjectId;

  int noOfMaleTeacher = 0;
  int noOfFemaleTeacher = 0;

  // GlobalKey<FormFieldState> _classSelectKey = GlobalKey<FormFieldState>();

  //MultiSelect Class
  List<ClassListEmployeeModel> _selectedClassList = []; // Fee Head after Seletion
  List<ClassListEmployeeModel>? classListMulti = []; // Fee Head After API
  final _classListSelectKey = GlobalKey<FormFieldState>();

  //

  //MultiSelect Students
  List<StudentListMeetingModel>? teacherList = [];
  List finalTeacherList = [];

  //

  List<Map<String, String>> studentList = [];

  String? userType = '';
  bool? classCheck = false;
  bool buttonLoader = false;
  String? empIdForAdminSearch;

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
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 18)),
            buttonText: Text(
              "Selected Classes",
              // style: TextStyle(fontSize: 16,),
            ),
            // buttonText: Text(
            //   _selectedClassList.length > 0
            //       ? "${_selectedClassList.length} Class selected"
            //       : "None selected",
            // ),
            items: classListMulti!.map((e) => MultiSelectItem(e, e.className!)).toList(),
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
              getClassroomList(noRows: "20", counts: "0", index: 0);
              setState(() {
                // showFilters = !showFilters;
                showLoader = true;
                classrommCustomList = [];
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
              textStyle: TextStyle(fontWeight: FontWeight.w900, color: Theme.of(context).primaryColor),
            ),
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
          // padding: EdgeInsets.symmetric(horizontal: 8),
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
      setState(() => streamIdFinal.add(_selectedClassList[i].iD!.split("#")[1]));
    }

    List<String> sectionIdFinal = [];
    for (int i = 0; i < _selectedClassList.length; i++) {
      setState(() => sectionIdFinal.add(_selectedClassList[i].iD!.split("#")[2]));
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
    context.read<SubjectListEmployeeCubit>().subjectListEmployeeCubitCall(getEmpSubData);
  }

  Widget buildClassroomsBody(BuildContext context) {
    return classrommCustomList.length > 0
        ? Scrollbar(
            child: Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      LazyLoadScrollView(
                        isLoading: isLoading,
                        onEndOfPage: () => loadMore(),
                        // scrollOffset: 70,
                        child: RefreshIndicator(
                          onRefresh: () => _onRefresh(),
                          child: ListView.separated(
                            separatorBuilder: (context, index) =>
                                Divider(color: Color(0xffECECEC), thickness: 6),
                            controller: _scrollController,
                            physics: AlwaysScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: classrommCustomList.length,
                            itemBuilder: (context, i) {
                              var item = classrommCustomList[i];
                              print("class room length ${classrommCustomList.length}");
                              return Stack(
                                children: [
                                  Container(
                                    // margin: const EdgeInsets.symmetric(horizontal: 10.0),
                                    // padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    decoration: BoxDecoration(
                                        // border: Border.all(color: Color(0xffDBDBDB)),
                                        ),
                                    child: ListTile(
                                      title: Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: Theme.of(context).primaryColor,
                                            radius: 20,
                                            backgroundImage: AssetImage(AppImages.dummyImage),
                                          ),
                                          SizedBox(width: 8),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              // mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  item.combName != ""
                                                      ? item.combName!.replaceAll("    ", "-")
                                                      : 'unknown',
                                                  // textScaleFactor: 1.0,
                                                  style: TextStyle(fontSize: 18),
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      item.subjectName != ""
                                                          // ? "${item.subjectName!} ● ${item.circularDate!}"
                                                          ? "${item.subjectName!}"
                                                          : 'Subject',
                                                      style: TextStyle(fontSize: 16).copyWith(
                                                        color: Colors.black.withOpacity(0.7),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(top: 10.0),
                                                      child: Text(
                                                        "${item.circularDate!}",
                                                        // style:
                                                        //     Theme.of(context).textTheme.subtitle1!.copyWith(
                                                        //           color: Colors.black.withOpacity(0.7),
                                                        //           fontSize: 12,
                                                        //         ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Divider(color: Color(0xffDBDBDB), height: 10),
                                          if (item.cirContent != null && item.cirContent != "")
                                            Text(
                                              item.cirContent!,
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                              ),
                                            ),
                                          if (item.cirContent != null && item.cirContent != "")
                                            Divider(color: Color(0xffDBDBDB), height: 10),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              if (item.circularFileurl != "")
                                                FileDownload(
                                                  fileName: item.circularFileurl!.split("/").last,
                                                  fileUrl: item.circularFileurl!,
                                                  downloadWidget: Row(
                                                    children: [
                                                      Image.asset(
                                                        getDownloadImage(
                                                            item.circularFileurl!.split(".").last),
                                                        width: 28,
                                                        color: Theme.of(context).primaryColor,
                                                      ),
                                                      SizedBox(width: 10),
                                                      Text(
                                                        "Download",
                                                        textScaleFactor: 1.0,
                                                        style: TextStyle(color: Colors.black, fontSize: 16),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              InkWell(
                                                onTap: () {
                                                  final chatData = ChatRoomCommonModel(
                                                    appbarTitle:
                                                        "${item.combName!.replaceAll("    ", "-")} / ${item.subjectName}",
                                                    iD: item.circularId,
                                                    stuEmpId: userData!.stuEmpId,
                                                    classId: item.stuid,
                                                    screenType: "classroom",
                                                  );
                                                  Navigator.pushNamed(context, ChatRoomCommon.routeName,
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
                                                      style: TextStyle(color: Colors.black, fontSize: 16),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  if (item.stuid == null || item.stuid == "")
                                    Positioned(
                                      right: 10.0,
                                      top: -10,
                                      child: IconButton(
                                        onPressed: () async {
                                          final uid = await UserUtils.idFromCache();
                                          final token = await UserUtils.userTokenFromCache();
                                          final userData = await UserUtils.userTypeFromCache();
                                          final deleteClassroom = {
                                            'OUserId': uid,
                                            'Token': token,
                                            'OrgId': userData!.organizationId,
                                            'Schoolid': userData.schoolId,
                                            'ClassRoomId': item.circularId,
                                            'EmpId': userData.stuEmpId,
                                            'UserType': userData.ouserType,
                                          };
                                          print("Sending DeleteClassroom data => $deleteClassroom");
                                          context
                                              .read<DeleteClassroomCubit>()
                                              .deleteClassroomCubitCall(deleteClassroom);
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
                      ),
                    ],
                  ),
                ),
                Divider(color: Color(0xffECECEC), thickness: 6),
                if (isLoading)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(width: 8.0),
                        Text(
                          'Loading more...',
                          textScaleFactor: 1.0,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          )
        : Container(
            child: Text(
              "NO RECORD FOUND",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          );
  }

  // Container buildTopFilter(BuildContext context) {
  //   return Container(
  //     color: Color(0xffECECEC),
  //     width: MediaQuery.of(context).size.width,
  //     child: Column(
  //       // crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         SizedBox(height: 10.0),
  //         Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 16.0),
  //           child: buildDropdown(
  //             label: "Subject",
  //             selectedValue: "",
  //             dropdown: [],
  //           ),
  //         ),
  //         buildSearchBtn(),
  //       ],
  //     ),
  //   );
  // }

  // Column buildDropdown(
  //     {String? label, String? selectedValue, List<String>? dropdown}) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     mainAxisSize: MainAxisSize.min,
  //     children: [
  //       SizedBox(height: 8),
  //       buildLabels(label: label!),
  //       SizedBox(height: 8),
  //       Container(
  //         padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
  //         decoration: BoxDecoration(
  //           border: Border.all(color: Colors.black12),
  //           // borderRadius: BorderRadius.circular(4),
  //         ),
  //         child: DropdownButton<String>(
  //           isDense: true,
  //           value: "",
  //           key: UniqueKey(),
  //           isExpanded: true,
  //           underline: Container(),
  //           items: dropdown!
  //               .map((item) => DropdownMenuItem<String>(
  //                   child: Text(item, style: TextStyle(fontSize: 12)),
  //                   value: item))
  //               .toList(),
  //           onChanged: (val) {
  //             setState(() {
  //               // _selectedAdmission = val;
  //               print("_selectedAdmission: $val");
  //             });
  //           },
  //         ),
  //       ),
  //     ],
  //   );
  // }

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
          // getFeedbackData(1);
          getClassroomList(noRows: "20", counts: "0", index: 0);
          setState(() {
            // showFilters = !showFilters;
            showLoader = true;
            classrommCustomList = [];
          });
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.search, color: Colors.white),
            SizedBox(width: 4),
            Text(
              "Search",
              style: TextStyle(fontFamily: "BebasNeue-Regular", color: Colors.white),
            ),
          ],
        ),
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

  // Text buildLabels({String? label, Color? color}) {
  //   return Text(
  //     label!,
  //     style: TextStyle(
  //       color: color ?? Color(0xff313131),
  //       fontWeight: FontWeight.bold,
  //     ),
  //   );
  // }

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
