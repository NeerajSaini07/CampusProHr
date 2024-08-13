import 'dart:convert';
import 'dart:io';
import 'package:campus_pro/secrets.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/CLASS_LIST_EMPLOYEE_CUBIT/class_list_employee_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/CURRENT_USER_EMAIL_FOR_ZOOM_CUBIT/current_user_email_for_zoom_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/DELETE_SCHEDULE_MEETING_EMPLOYEE_CUBIT/delete_schedule_meeting_employee_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/EMPLOYEE_INFO_FOR_SEARCH_CUBIT/employee_info_for_search_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/MEETING_PLATFORMS_CUBIT/meeting_platforms_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/SAVE_GOOGLE_MEET_SCHEDULE_MEETING_CUBIT/save_google_meet_schedule_meeting_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/SAVE_ZOOM_SCHEDULE_MEETING_CUBIT/save_zoom_schedule_meeting_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/SCHEDULE_MEETING_LIST_EMPLOYEE_CUBIT/schedule_meeting_list_employee_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/SCHEDULE_MEETING_TODAY_LIST_CUBIT/schedule_meeting_today_list_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/STUDENT_LIST_MEETING_CUBIT/student_list_meeting_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/SUBJECT_LIST_MEETING_CUBIT/subject_list_meeting_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/employeeInfoForSearchModel.dart';
import 'package:campus_pro/src/DATA/MODELS/classListEmployeeModel.dart';
import 'package:campus_pro/src/DATA/MODELS/currentUserEmailForZoomModel.dart';
import 'package:campus_pro/src/DATA/MODELS/meetingPlatformsModel.dart';
import 'package:campus_pro/src/DATA/MODELS/scheduleMeetingListEmployeeModel.dart';
import 'package:campus_pro/src/DATA/MODELS/searchEmployeeFromRecordsCommonModel.dart';
import 'package:campus_pro/src/DATA/MODELS/studentListMeetingModel.dart';
import 'package:campus_pro/src/DATA/MODELS/subjectListMeetingModel.dart';
import 'package:campus_pro/src/DATA/MODELS/userTypeModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonSnackbar.dart';
import 'package:campus_pro/src/UI/WIDGETS/drawerWidget.dart';
import 'package:campus_pro/src/UI/WIDGETS/googlePermission.dart';
import 'package:campus_pro/src/UI/WIDGETS/noRecordFound.dart';
import 'package:campus_pro/src/UI/WIDGETS/searchEmployeeFromRecordsCommon.dart';
import 'package:campus_pro/src/UTILS/GOOGLE_MEET/calendar_client.dart';
import 'package:campus_pro/src/UTILS/appImages.dart';
import 'package:campus_pro/src/UTILS/fieldValidators.dart';
import 'package:campus_pro/src/WIDGETS_STYLE/style_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:path_provider/path_provider.dart';

import 'package:googleapis/calendar/v3.dart' as cal;

class ScheduleClass extends StatefulWidget {
  static const routeName = "/schedule-class";
  const ScheduleClass({Key? key}) : super(key: key);

  @override
  _ScheduleClassState createState() => _ScheduleClassState();
}

class _ScheduleClassState extends State<ScheduleClass> {
  List<StudentListMeetingModel> _selectedStudentList = [];
  List<StudentListMeetingModel>? studentListMulti = [];
  final _studentSelectKey = GlobalKey<FormFieldState>();

  bool showMultiClass = false;

  bool showLoader = false;

  bool showMeetingForm = false;

  String? meetingIdFinal = "";
  String? userTypeForCondition = '';
  String? uid;
  String? token;
  UserTypeModel? userData = UserTypeModel(ouserType: "");

  List<CurrentUserEmailForZoomModel>? emailData = [];

  int totalBoys = 0;
  int totalGirls = 0;

  String classIds = "";
  String classNames = "";
  final List studentFinalList = [];

  TextEditingController searchController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  TabController? tabController;

  GlobalKey _toolTipKey = GlobalKey();

  int? _selectedPlatform;

  int? _selectedRepeatDay = 1;

  bool showEmailIdDialog = false;

  bool showEmailNotFOund = false;

  var scrollController = ScrollController();

  int _currentIndex = 0;

  EmployeeInfoForSearchModel? selectedEmployee;

  SubjectListMeetingModel? _selectedSubject;

  List<SubjectListMeetingModel> subjectDropdown = [];

  int? _selectedHour = 00;
  List<int> hourDropdown = [for (var i = 0; i <= 23; i++) i];

  int? _selectedMinute = 45;
  List<int> minuteDropdown = [for (var i = 0; i <= 59; i++) i];

  void tabIndexChange(int tabIndex) {
    setState(() {
      _currentIndex = tabIndex;
    });
  }

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      helpText: "SELECT START DATE",
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked;
      });
      print("selected time : ${selectedTime.hour}:${selectedTime.minute}");
    }
  }

  String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm(); //"6:00 AM"
    return format.format(dt);
  }

  @override
  void initState() {
    getDataFromCache();
    classListMulti = [];
    _selectedSubject = SubjectListMeetingModel(subjectHead: "", subjectId: 0);
    subjectDropdown = [];
    super.initState();
  }

  getDataFromCache() async {
    uid = await UserUtils.idFromCache();
    token = await UserUtils.userTokenFromCache();
    final user = await UserUtils.userTypeFromCache();
    setState(() => userTypeForCondition = user!.ouserType);
    print("userTypeForCondition - $userTypeForCondition");
    getMeetingList();
    if (userTypeForCondition!.toLowerCase() == "e") {
      getMeetingPlatforms();
    }
    // getEmployeeClass();
  }

  getMeetingList() async {
    final user = await UserUtils.userTypeFromCache();
    final meetingData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": user!.organizationId,
      "Schoolid": user.schoolId,
      "EmpId": user.stuEmpId,
      "For": "s",
      "StuEmpId": user.stuEmpId,
      "Usertype": user.ouserType,
    };
    print("Sending ScheduleMeetingListEmployee Data => $meetingData");
    context
        .read<ScheduleMeetingListEmployeeCubit>()
        .scheduleMeetingListEmployeeCubitCall(meetingData);
  }

  getMeetingPlatforms() async {
    userData = await UserUtils.userTypeFromCache();
    final platformData = {
      'OUserId': uid,
      'Token': token,
      'OrgId': userData!.organizationId,
      'Schoolid': userData!.schoolId,
      "EmpId": userData!.stuEmpId,
      "UserType": userData!.ouserType,
    };
    print("Sending Meeting Platform Data => $platformData");
    context
        .read<MeetingPlatformsCubit>()
        .meetingPlatformsCubitCall(platformData);
  }

  getEmployeeClass() async {
    final getEmpClassData = {
      "OUserId": uid!,
      "Token": token!,
      "OrgId": userData!.organizationId,
      "Schoolid": userData!.schoolId,
      "SessionId": userData!.currentSessionid,
      // "EmpID": userData!.stuEmpId,
    };
    if (userTypeForCondition!.toLowerCase() == "e") {
      getEmpClassData["EmpID"] = userData!.stuEmpId;
    } else {
      getEmpClassData["EmpID"] = selectedEmployee!.empId.toString();
    }
    print('Get EmployeeClass $getEmpClassData');
    context
        .read<ClassListEmployeeCubit>()
        .classListEmployeeCubitCall(getEmpClassData);
  }

  getTodayList(List<ClassListEmployeeModel>? classSelect) async {
    List<String> classIdFinal = [];
    for (int i = 0; i < classSelect!.length; i++) {
      setState(() => classIdFinal.add(classSelect[i].iD!));
    }

    final meetingData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData!.schoolId,
      "ClassId": classIdFinal.join(","),
      "For": "s",
      "Empid": userData!.stuEmpId,
      "UserType": userData!.ouserType!,
    };
    print('Sending ScheduleMeetingTodayList data => $meetingData');
    context
        .read<ScheduleMeetingTodayListCubit>()
        .scheduleMeetingTodayListCubitCall(meetingData);
  }

  getSubjectList(List<ClassListEmployeeModel>? classSelect) async {
    List<String> classIdFinal = [];
    for (int i = 0; i < classSelect!.length; i++) {
      setState(() => classIdFinal.add(classSelect[i].iD!.split("#")[0]));
    }

    List<String> streamIdFinal = [];
    for (int i = 0; i < classSelect.length; i++) {
      setState(() => streamIdFinal.add(classSelect[i].iD!.split("#")[1]));
    }

    List<String> sectionIdFinal = [];
    for (int i = 0; i < classSelect.length; i++) {
      setState(() => sectionIdFinal.add(classSelect[i].iD!.split("#")[2]));
    }

    List<String> yearIdFinal = [];
    for (int i = 0; i < classSelect.length; i++) {
      setState(() => yearIdFinal.add(classSelect[i].iD!.split("#")[4]));
    }

    final getSubjectData = {
      "OUserId": uid!,
      "Token": token!,
      "OrgId": userData!.organizationId,
      "Schoolid": userData!.schoolId,
      "SessionId": userData!.currentSessionid,
      // "EmpId": userData!.stuEmpId,
      "ClassID": classIdFinal.join(","),
      "StreamID": streamIdFinal.join(","),
      "SectionID": sectionIdFinal.join(","),
      "YearID": yearIdFinal.join(","),
      "UserType": userData!.ouserType,
      "EmpId": userData!.stuEmpId,
    };

    if (userTypeForCondition!.toLowerCase() == "e") {
      getSubjectData["TeacherId"] = userData!.stuEmpId;
    } else {
      getSubjectData["TeacherId"] = selectedEmployee!.empId.toString();
    }
    print('Sending SubjectListMeeting datas $getSubjectData');
    context
        .read<SubjectListMeetingCubit>()
        .subjectListMeetingCubitCall(getSubjectData);
  }

  getStudentsList() async {
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

    final getStudentData = {
      "OUserId": uid!,
      "Token": token!,
      "OrgId": userData!.organizationId,
      "Schoolid": userData!.schoolId,
      "SessionId": userData!.currentSessionid,
      // "EmpID": userData!.stuEmpId,
      "ClassId": classIdFinal.join(","),
      "StreamId": streamIdFinal.join(","),
      "SectionId": sectionIdFinal.join(","),
      "YearId": yearIdFinal.join(","),
      "SubjectId": _selectedSubject!.subjectId.toString(),
      // "StuEmpId": "334",
      "UserType": userData!.ouserType,
      "StuEmpId": userData!.stuEmpId
    };
    // if (userTypeForCondition!.toLowerCase() == "e") {
    //   getStudentData["StuEmpId"] = userData!.stuEmpId;
    //   // getStudentData["EmpID"] = userData!.stuEmpId;
    // } else {
    //   getStudentData["StuEmpId"] = selectedEmployee!.empId.toString();
    //   // getStudentData["EmpID"] = selectedEmployee!.empId.toString();
    // }
    print('Sending StudentListMeeting Data $getStudentData');
    context
        .read<StudentListMeetingCubit>()
        .studentListMeetingCubitCall(getStudentData);
  }

  //Todo:
  googleAccountPermission() async {
    print("CHAL GYA");
    var _clientID = new ClientId(Secret.getId(), "");
    const _scopes = const [cal.CalendarApi.calendarScope];

    await clientViaUserConsent(_clientID, _scopes, prompt)
        .then((AuthClient client) async {
      CalendarClient.calendar = cal.CalendarApi(client);

      // print(client.credentials.);

      print('accessToken: ${client.credentials.accessToken}');
      // print('idToken: ${client.credentials.idToken}');
      // print('refreshToken: ${client.credentials.refreshToken}');
      // print('scopes: ${client.credentials}');

      // await UserUtils.cacheAuthClient(client);
      // final storage = await UserUtils.authClientFromCache();
      // print('storage accessToken: ${storage!.client!.credentials.accessToken}');
      // print('storage idToken: ${storage.credentials.idToken}');
      // print('storage refreshToken: ${storage.credentials.refreshToken}');
      // print('storage scopes: ${storage.credentials}');
    });
    // await clientViaUserConsent(_clientID, _scopes, prompt)
    //     .then((AuthClient client) async {
    //   CalendarClient.calendar = cal.CalendarApi(client);
    //   print('accessToken: ${client.credentials.accessToken}');
    //   print('idToken: ${client.credentials.idToken}');
    //   print('refreshToken: ${client.credentials.refreshToken}');
    //   print('scopes: ${client.credentials}');
    // });
  }

  getCurrentUserEmailForZoom() async {
    final emailData = {
      'OUserId': uid!,
      'Token': token!,
      'OrgId': userData!.organizationId!,
      'SchoolId': userData!.schoolId!,
      'StuEmpId': userData!.stuEmpId!,
      'UserType': userData!.ouserType!,
      // 'Plateform': "2",
      'Plateform': "1",
    };
    if (userTypeForCondition!.toLowerCase() != "e") {
      emailData["EmpId"] = selectedEmployee!.empId.toString();
    }
    print("sending CurrentUserEmailForZoom data => $emailData");
    context
        .read<CurrentUserEmailForZoomCubit>()
        .currentUserEmailForZoomCubitCall(emailData);
  }

  saveZoomMeeting() async {
    final meetingData = {
      'UserId': uid!,
      'Token': token!,
      // 'StuEmpId': userData!.stuEmpId!,
      'tblId': '',
      'MeetingId': DateTime.now().microsecondsSinceEpoch.toString(),
      'Class': classIds,
      'Students': jsonEncode(studentFinalList),
      'MeetingDate': DateFormat('dd-MMM-yyyy').format(selectedDate),
      'MeetingTime': "${selectedTime.hour}:${selectedTime.minute}",
      'MeetingDuration': '$_selectedHour:$_selectedMinute',
      'MeetingSubject': 'Zoom-${detailsController.text}',
      'UserType': 's', //For Students
      'SubjectId': _selectedSubject!.subjectId!.toString(),
      'OrgId': userData!.organizationId!,
      'SchoolId': userData!.schoolId!,
      'MeetingPwd': '',
      'Session': userData!.currentSessionid!,
      'AuthnticateParam': '',
      'MeetingType': '1',
      'ClassName': classNames,
      'SubjectName': _selectedSubject!.subjectHead!,
      'OUserType': userData!.ouserType!,
      "StuEmpId": userData!.stuEmpId,
    };
    if (userTypeForCondition!.toLowerCase() == "e") {
      meetingData["TeacherId"] = userData!.stuEmpId!;
    } else {
      meetingData["TeacherId"] = selectedEmployee!.empId.toString();
    }
    print("Sending SaveZoomMeeting Data => $meetingData");
    context
        .read<SaveZoomScheduleMeetingCubit>()
        .saveZoomScheduleMeetingCubitCall(meetingData);
  }

  saveGoogleMeetMeeting(String? meetingLink) async {
    final meetingData = {
      'UserId': uid!,
      'Token': token!,
      'tblId': '',
      'MeetingId': meetingIdFinal!,
      'Class': classIds,
      'Students': jsonEncode(studentFinalList),
      'MeetingDate': DateFormat('dd-MMM-yyyy').format(selectedDate),
      'MeetingTime': "${selectedTime.hour}:${selectedTime.minute}",
      'MeetingDuration': '$_selectedHour:$_selectedMinute',
      'MeetingSubject': 'Google Meet-${detailsController.text}',
      'ForUserType': 's',
      'SubjectId': _selectedSubject!.subjectId!.toString(),
      'OrgId': userData!.organizationId!,
      'SchoolId': userData!.schoolId!,
      'MeetingType': '2',
      'MeetingPwd': '',
      'ClassName': classNames,
      'Session': userData!.currentSessionid!,
      'AuthnticateParam': '',
      'SubjectName': _selectedSubject!.subjectHead!,
      'Meetinglink': meetingLink!,
      'Teacheremail': userGoogle!.email,
      //"campusprowork@gmail.com",
      'UserType': userData!.ouserType!,
      "StuEmpId": userData!.stuEmpId!
    };
    if (userTypeForCondition!.toLowerCase() == "e") {
      meetingData["SearchEmpId"] = userData!.stuEmpId!;
    } else {
      meetingData["SearchEmpId"] = selectedEmployee!.empId.toString();
    }
    print("Sending SaveGoogleMeetMeeting Data => $meetingData");
    context
        .read<SaveGoogleMeetScheduleMeetingCubit>()
        .saveGoogleMeetScheduleMeetingCubitCall(meetingData);
  }

  _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000)).then((value) {
      getMeetingList();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    detailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: commonAppBar(context, title: "Schedule Class"),
      body: MultiBlocListener(
        listeners: [
          BlocListener<DeleteScheduleMeetingEmployeeCubit,
              DeleteScheduleMeetingEmployeeState>(
            listener: (context, state) {
              if (state is DeleteScheduleMeetingEmployeeLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                }
              }
              if (state is DeleteScheduleMeetingEmployeeLoadSuccess) {
                getMeetingList();
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
                getMeetingPlatforms();
              }
            },
          ),
          BlocListener<SaveZoomScheduleMeetingCubit,
              SaveZoomScheduleMeetingState>(
            listener: (context, state) {
              if (state is SaveZoomScheduleMeetingLoadSuccess) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(commonSnackBar(title: "Class Schedule"));
                Navigator.pop(context);
                Navigator.pushNamed(context, ScheduleClass.routeName);
              }
              if (state is SaveZoomScheduleMeetingLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                } else {
                  setState(() => showLoader = !showLoader);
                }
              }
            },
          ),
          BlocListener<SaveGoogleMeetScheduleMeetingCubit,
              SaveGoogleMeetScheduleMeetingState>(
            listener: (context, state) {
              if (state is SaveGoogleMeetScheduleMeetingLoadSuccess) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(commonSnackBar(title: "Class Schedule"));
                Navigator.pop(context);
                Navigator.pushNamed(context, ScheduleClass.routeName);
              }
              if (state is SaveGoogleMeetScheduleMeetingLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                } else {
                  setState(() => showLoader = !showLoader);
                }
              }
            },
          ),
          BlocListener<StudentListMeetingCubit, StudentListMeetingState>(
            listener: (context, state) {
              if (state is StudentListMeetingLoadInProgress) {
                setState(() {
                  showMultiClass = false;
                });
              }
              if (state is StudentListMeetingLoadSuccess) {
                setState(() {
                  studentListMulti = state.studentList;
                  _selectedStudentList = studentListMulti!;
                  totalBoys = studentListMulti!
                      .where(
                          (element) => element.gender!.toLowerCase() == "male")
                      .length;
                  totalGirls = studentListMulti!
                      .where((element) =>
                          element.gender!.toLowerCase() == "female")
                      .length;

                  print(
                      "StudentListMeetingLoadSuccess => totalBoys:$totalBoys, totalGirls:$totalGirls");
                  showMultiClass = true;
                });
              }
              if (state is StudentListMeetingLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                } else {
                  setState(() {
                    // _selectedStudentList = [];
                    studentListMulti = [];
                  });
                }
              }
            },
          ),
        ],
        child: DefaultTabController(
          initialIndex: _currentIndex,
          length: 2,
          child: Column(
            children: [
              buildTabBar(context),
              Expanded(
                child: TabBarView(
                  children: [
                    buildScheduleClass(context),
                    BlocConsumer<ScheduleMeetingListEmployeeCubit,
                        ScheduleMeetingListEmployeeState>(
                      listener: (context, state) {
                        if (state is ScheduleMeetingListEmployeeLoadFail) {
                          if (state.failReason == "false") {
                            UserUtils.unauthorizedUser(context);
                          }
                        }
                      },
                      builder: (context, state) {
                        if (state
                            is ScheduleMeetingListEmployeeLoadInProgress) {
                          return Center(child: CircularProgressIndicator());
                        } else if (state
                            is ScheduleMeetingListEmployeeLoadSuccess) {
                          return buildUpcomingClasses(context,
                              meetingList: state.meetingList);
                        } else if (state
                            is ScheduleMeetingListEmployeeLoadFail) {
                          return noRecordFound();
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildTabBar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 8.0),
      height: 40,
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor)),
      child: TabBar(
        unselectedLabelColor: Theme.of(context).primaryColor,
        labelColor: Colors.white,
        indicator: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        physics: ClampingScrollPhysics(),
        onTap: (int tabIndex) {
          print("tabIndex: $tabIndex");
          switch (tabIndex) {
            case 0:
              tabIndexChange(tabIndex);
              break;
            case 1:
              tabIndexChange(tabIndex);
              break;
            default:
              tabIndexChange(tabIndex);
              break;
          }
        },
        tabs: [
          buildTabs(title: 'Schedule Class', index: 0),
          buildTabs(title: 'Upcoming Classes', index: 1),
        ],
        controller: tabController,
      ),
    );
  }

  Tab buildTabs({String? title, int? index}) {
    return Tab(
      child: FittedBox(
        child: Text(title!,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            )),
      ),
    );
  }

  Container buildUpcomingClasses(BuildContext context,
      {List<ScheduleMeetingListEmployeeModel>? meetingList}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      // padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: RefreshIndicator(
        onRefresh: () => _onRefresh(),
        child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) => Divider(),
          shrinkWrap: true,
          physics: AlwaysScrollableScrollPhysics(),
          itemCount: meetingList!.length,
          itemBuilder: (context, i) {
            var item = meetingList[i];
            return ListTile(
              title: Transform.translate(
                offset: Offset(-10, 0),
                child: Text(
                  "${item.subjectHead} - ${item.combName}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              subtitle: Transform.translate(
                offset: Offset(-10, 0),
                child: Container(
                  // color: Colors.green,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.meetingSubject!
                                    .split('\r\n')[0]
                                    .split('-')
                                    .toList()
                                    .length >
                                1
                            ? "${item.meetingSubject!.split('\r\n')[0].split('-')[1]}\n${item.meetingDate1} at ${item.meetingTime!}"
                            : "${item.meetingDate1} at ${item.meetingTime!}",
                        // item.meetingDate1!.split('on: ')[1],
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: Colors.grey, fontSize: 13),
                      ),
                      item.email == ""
                          ? Text(
                              "Zoom",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                            )
                          : Text(
                              "G-Meet",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(color: Colors.grey, fontSize: 12),
                            ),
                      if (userTypeForCondition!.toLowerCase() == "a")
                        Text(
                          "created by ${item.name!}",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: Colors.grey, fontSize: 10),
                        ),
                    ],
                  ),
                ),
              ),
              trailing: Transform.translate(
                offset: Offset(10, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (item.meetinglivestatus!.toLowerCase() != 'y')
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 16.0),
                        width: 100,
                        decoration: BoxDecoration(
                          color: Color(0xffFF5545).withOpacity(0.5),
                          // color: Color(0xfff1f1f1),
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        child: Text(
                          "Ended",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.quicksand(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    SizedBox(width: 8),
                    InkResponse(
                      onTap: () {
                        deleteMeeting(item.id.toString());
                      },
                      child: Icon(Icons.delete, color: Colors.red[400]),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  deleteMeeting(String? meetingId) async {
    final user = await UserUtils.userTypeFromCache();
    final deleteMeeting = {
      "OUserId": uid,
      "Token": token,
      "OrgId": user!.organizationId,
      "Schoolid": user.schoolId,
      "EmpId": user.stuEmpId,
      "MeetingId": meetingId!,
      "Status": "0",
      "For": "s",
      "UserType": user.ouserType,
    };
    context
        .read<DeleteScheduleMeetingEmployeeCubit>()
        .deleteScheduleMeetingEmployeeCubitCall(deleteMeeting);
  }

  SingleChildScrollView buildScheduleClass(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (userTypeForCondition!.toLowerCase() != "e")
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildLabels("Search Employee"),
                  GestureDetector(
                    onTap: () async {
                      final empData = await Navigator.pushNamed(context,
                              SearchEmployeeFromRecordsCommon.routeName)
                          as SearchEmployeeFromRecordsCommonModel;
                      // final uid = await UserUtils.idFromCache();
                      // final userToken = await UserUtils.userTokenFromCache();
                      final user = await UserUtils.userTypeFromCache();
                      final employeeData = {
                        "OUserId": uid!,
                        "Token": token!,
                        "OrgId": user!.organizationId!,
                        "Schoolid": user.schoolId!,
                        "EmployeeId": empData.empId!,
                        "SessionId": user.currentSessionid!,
                        "StuEmpId": user.stuEmpId!,
                        "UserType": user.ouserType!,
                      };
                      print('Sending Employee Info Data $employeeData');
                      context
                          .read<EmployeeInfoForSearchCubit>()
                          .employeeInfoForSearchCubitCall(employeeData);
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
                ],
              ),
            buildTopMessageBox(context),
            BlocConsumer<CurrentUserEmailForZoomCubit,
                CurrentUserEmailForZoomState>(
              listener: (context, state) {
                if (state is CurrentUserEmailForZoomLoadSuccess) {
                  setState(() {
                    emailData = state.emailData;
                    showEmailIdDialog = true;
                    showEmailNotFOund = false;
                  });
                }
                if (state is CurrentUserEmailForZoomLoadFail) {
                  if (state.failReason == "false") {
                    UserUtils.unauthorizedUser(context);
                  } else {
                    setState(() {
                      showEmailIdDialog = false;
                      showEmailNotFOund = true;
                    });
                  }
                }
              },
              builder: (context, state) {
                if (state is CurrentUserEmailForZoomLoadSuccess) {
                  return Container(); //buildTopMessageBox(context);
                } else {
                  return Container();
                }
              },
            ),
            if (showEmailNotFOund) buildEmailNotRegistered(context),
            BlocConsumer<MeetingPlatformsCubit, MeetingPlatformsState>(
              listener: (context, state) {
                if (state is MeetingPlatformsLoadFail) {
                  if (state.failReason == "false") {
                    UserUtils.unauthorizedUser(context);
                  }
                }
                if (state is MeetingPlatformsLoadSuccess) {
                  setState(() {
                    _selectedPlatform = state.platformList[0].plateformid;
                  });
                  getCurrentUserEmailForZoom();
                  getEmployeeClass();
                }
              },
              builder: (context, state) {
                if (state is MeetingPlatformsLoadInProgress) {
                  return Text("");
                } else if (state is MeetingPlatformsLoadSuccess) {
                  return buildMeetingPlatform(context,
                      platformList: state.platformList);
                } else if (state is MeetingPlatformsLoadFail) {
                  return Text("refresh");
                } else {
                  return Text("");
                }
              },
            ),
            if (!showEmailNotFOund)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocConsumer<ClassListEmployeeCubit, ClassListEmployeeState>(
                    listener: (context, state) {
                      if (state is ClassListEmployeeLoadSuccess) {
                        setState(() {
                          classListMulti = state.classList;
                          // _selectedClassList = state.classList;
                          // _classSelectKey = state.classList[0];
                        });
                      }
                      if (state is ClassListEmployeeLoadFail) {
                        if (state.failReason == "false") {
                          UserUtils.unauthorizedUser(context);
                        } else {
                          setState(() {
                            classListMulti = [];
                            _selectedClassList = [];
                            // _classSelectKey =
                            //     ClassListEmployeeModel(iD: "", className: "");
                          });
                        }
                      }
                    },
                    builder: (context, state) {
                      if (state is ClassListEmployeeLoadInProgress) {
                        return buildClassMultiSelect(context);
                      } else if (state is ClassListEmployeeLoadSuccess) {
                        return buildClassMultiSelect(context);
                      } else {
                        return Container();
                      }
                    },
                  ),
                  SizedBox(height: 10),
                  BlocConsumer<SubjectListMeetingCubit,
                      SubjectListMeetingState>(
                    listener: (context, state) {
                      if (state is SubjectListMeetingLoadSuccess) {
                        setState(() {
                          subjectDropdown = state.subjectList;
                          // if (subjectDropdown[0].subjectHead != 'Select') {
                          //   subjectDropdown.insert(
                          //       0,
                          //       SubjectListMeetingModel(
                          //           subjectId: -1, subjectHead: "Select"));
                          // }
                          _selectedSubject = subjectDropdown.first;
                        });
                        getStudentsList();
                      }
                      if (state is SubjectListMeetingLoadFail) {
                        if (state.failReason == "false") {
                          UserUtils.unauthorizedUser(context);
                        } else {
                          setState(() {
                            subjectDropdown = [];
                            _selectedSubject = SubjectListMeetingModel(
                                subjectHead: "", subjectId: 0);
                          });
                        }
                      }
                    },
                    builder: (context, state) {
                      if (state is SubjectListMeetingLoadInProgress) {
                        return buildSubjectDropdown(context);
                      } else if (state is SubjectListMeetingLoadSuccess) {
                        return buildSubjectDropdown(context);
                      } else {
                        return Container();
                      }
                    },
                  ),
                  SizedBox(height: 10),
                  if (userTypeForCondition!.toLowerCase() == "e" ||
                      userTypeForCondition!.toLowerCase() != "e" &&
                          userData != null)
                    if (showMultiClass)
                      buildStudentMultiSelect(context)
                    else
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildLabels("Selected Student"),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 8.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0xffECECEC)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("♂️ Male : 0 | ♀️ Female : 0"),
                                Icon(Icons.arrow_downward),
                              ],
                            ),
                          ),
                        ],
                      ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildLabels("Date"),
                            buildDateSelector(),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildLabels("Meeting Time"),
                            buildTimeSelector(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  buildLabels("Duration"),
                  buildDuration(context),
                  // buildStudentMultiSelect(context),
                  SizedBox(height: 10),
                  buildLabels("Enter Details"),
                  buildDetailsTextField(),
                  if (_selectedPlatform == 2) buildRepeatDays(context),
                  if (showLoader)
                    SizedBox(
                      height: 10.0,
                    ),
                  if (showLoader)
                    Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(width: 12),
                        Text(
                          "Please wait...",
                          textScaleFactor: 1.0,
                        )
                      ],
                    ))
                  else
                    buildApplyBtn(),
                  BlocConsumer<ScheduleMeetingTodayListCubit,
                      ScheduleMeetingTodayListState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state is ScheduleMeetingTodayListLoadInProgress) {
                        return Container();
                      } else if (state is ScheduleMeetingTodayListLoadSuccess) {
                        return Text("");
                      } else if (state is ScheduleMeetingTodayListLoadFail) {
                        return Container();
                      } else {
                        return Container();
                      }
                    },
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget buildMeetingPlatform(BuildContext context,
      {List<MeetingPlatformsModel>? platformList}) {
    return userTypeForCondition!.toLowerCase() == "e" ||
            userTypeForCondition!.toLowerCase() != "e" &&
                userData != null &&
                !showEmailNotFOund
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildLabels("Meeting Platform"),
              selectedEmployee != null
                  ? Row(
                      children: [
                        buildRadioText(
                          title: platformList![0].name,
                          value: platformList[0].plateformid,
                          groupValue: _selectedPlatform,
                          image: AppImages.zoomIcon,
                        ),
                        buildRadioText(
                          title: platformList[1].name,
                          value: platformList[1].plateformid,
                          groupValue: _selectedPlatform,
                          image: AppImages.googleMeetIcon,
                        ),
                      ],
                    )
                  : userTypeForCondition!.toLowerCase() == "e"
                      ? Row(
                          children: [
                            buildRadioText(
                              title: platformList![0].name,
                              value: platformList[0].plateformid,
                              groupValue: _selectedPlatform,
                              image: AppImages.zoomIcon,
                            ),
                            buildRadioText(
                              title: platformList[1].name,
                              value: platformList[1].plateformid,
                              groupValue: _selectedPlatform,
                              image: AppImages.googleMeetIcon,
                            ),
                          ],
                        )
                      : Container()
            ],
          )
        : Container();
  }

  Column buildRepeatDays(BuildContext context) {
    return Column(
      children: [
        buildCheckText(
          title: "Only for 1 day",
          value: 1,
          groupValue: _selectedRepeatDay,
        ),
        buildCheckText(
          title: "Repeat for 7 days",
          value: 7,
          groupValue: _selectedRepeatDay,
        ),
        buildCheckText(
          title: "Repeat for 10 days",
          value: 10,
          groupValue: _selectedRepeatDay,
        ),
      ],
    );
  }

  Row buildDuration(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text("Hours : "),
        buildNumberDropdown(
          index: 0,
          selectedValue: _selectedHour,
          dropdown: hourDropdown,
        ),
        SizedBox(width: 10),
        Text("Minutes : "),
        buildNumberDropdown(
          index: 1,
          selectedValue: _selectedMinute,
          dropdown: minuteDropdown,
        ),
      ],
    );
  }

  Container buildStudentMultiWidget() {
    return Container(
      // padding: const EdgeInsets.all(8.0),
      // decoration: BoxDecoration(
      //   border: Border.all(color: Color(0xffECECEC)),
      // ),
      child: Row(
        children: [
          buildStudentCounter(
              icon: AppImages.boyIcon, count: totalBoys.toString()),
          buildStudentCounter(
              icon: AppImages.girlIcon, count: totalGirls.toString()),
        ],
      ),
    );
  }

  Padding buildStudentCounter({String? icon, String? count}) {
    return Padding(
      padding: const EdgeInsets.only(left: 40),
      child: Row(
        children: [
          Image.asset(icon!, width: 24),
          Text(
            ": ${count!}",
            textScaleFactor: 1.5,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  List<ClassListEmployeeModel> _selectedClassList =
      []; // Class List after Seletion
  List<ClassListEmployeeModel>? classListMulti = []; // Class List After API
  final _classSelectKey = GlobalKey<FormFieldState>();

  Widget buildClassMultiSelect(BuildContext context) {
    return userTypeForCondition!.toLowerCase() == "e" ||
            userTypeForCondition!.toLowerCase() != "e" && userData != null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildLabels("Class"),
              Container(
                alignment: Alignment.center,
                // padding: EdgeInsets.symmetric(horizontal: 10),
                child: MultiSelectBottomSheetField<ClassListEmployeeModel>(
                  autovalidateMode: AutovalidateMode.disabled,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffECECEC)),
                  ),
                  key: _classSelectKey,
                  initialValue: _selectedClassList,
                  initialChildSize: 0.7,
                  maxChildSize: 0.95,
                  searchIcon: Icon(Icons.ac_unit),
                  title: Text(
                    "All Classes",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 18),
                  ),
                  buttonText: Text(
                    _selectedClassList.length > 0
                        ? "${_selectedClassList.length} Class selected"
                        : "None selected",
                  ),
                  // items: _items,
                  items: classListMulti!
                      .map((classList) =>
                          MultiSelectItem(classList, classList.className!))
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
                    _classSelectKey.currentState!.validate();
                    getSubjectList(_selectedClassList);
                    getTodayList(_selectedClassList);
                  },
                  chipDisplay: MultiSelectChipDisplay.none(),
                ),
              ),
            ],
          )
        : Container();
  }

  Widget buildStudentMultiSelect(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildLabels("Selected Students"),
        Container(
          alignment: Alignment.center,
          // padding: EdgeInsets.symmetric(horizontal: 10),
          child: MultiSelectBottomSheetField<StudentListMeetingModel>(
            // autovalidateMode: AutovalidateMode.disabled,
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xffECECEC)),
            ),
            selectedColor: Theme.of(context).primaryColor,
            key: _studentSelectKey,
            initialChildSize: 0.7,
            maxChildSize: 0.95,
            title: Text("Selected Student",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 18)),
            buttonText: Text(
              "♂️ Male : ${totalBoys.toString()} | ♀️ Female : ${totalGirls.toString()}",
            ),
            items: studentListMulti!
                .map((student) =>
                    MultiSelectItem(student, "${student.onlyStName!}"))
                .toList(),
            searchable: false,
            initialValue: _selectedStudentList,
            validator: (values) {
              if (_selectedStudentList.isEmpty) {
                return "Required";
              }
              return null;
            },
            onConfirm: (values) {
              setState(() {
                _selectedStudentList = values;
              });
              _studentSelectKey.currentState!.validate();
              setState(() {
                totalBoys = _selectedStudentList
                    .where((element) => element.gender!.toLowerCase() == "male")
                    .length;
                totalGirls = _selectedStudentList
                    .where(
                        (element) => element.gender!.toLowerCase() == "female")
                    .length;
              });
            },
            chipDisplay: MultiSelectChipDisplay.none(),
          ),
        ),
      ],
    );
  }

  Widget buildSubjectDropdown(BuildContext context) {
    return userTypeForCondition!.toLowerCase() == "e" ||
            userTypeForCondition!.toLowerCase() != "e" && userData != null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildLabels("Subject"),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffECECEC)),
                  // borderRadius: BorderRadius.circular(4),
                ),
                child: DropdownButton<SubjectListMeetingModel>(
                  isDense: true,
                  value: _selectedSubject,
                  key: UniqueKey(),
                  hint: Text("Select"),
                  isExpanded: true,
                  underline: Container(),
                  items: subjectDropdown
                      .map((sub) => DropdownMenuItem<SubjectListMeetingModel>(
                          child: Text(sub.subjectHead!), value: sub))
                      .toList(),
                  onChanged: (val) {
                    setState(() {
                      _selectedSubject = val;
                      print("_selectedSubject: $val");
                      if (_selectedSubject!.subjectHead != "Select")
                        getStudentsList();
                      else
                        _selectedStudentList = [];
                      totalBoys = 0;
                      totalGirls = 0;
                    });
                  },
                ),
              ),
            ],
          )
        : Container();
  }

  Row buildRadioText(
      {String? title,
      required int? value,
      required int? groupValue,
      String? image}) {
    print(_selectedPlatform);
    return Row(
      children: [
        Radio<int>(
          activeColor: Theme.of(context).primaryColor,
          value: value!,
          groupValue: groupValue,
          onChanged: (int? value) async {
            setState(() => _selectedPlatform = value!);
            print('_selectedPlatform : $_selectedPlatform');
            if (classListMulti!.isEmpty) getEmployeeClass();
            if (_selectedPlatform == 1)
              getCurrentUserEmailForZoom();
            else {
              // setState(() {
              //   showEmailIdDialog = !showEmailIdDialog;
              //   showEmailNotFOund = false;
              // });
              //Todo : Add google sign in here
              await signInWithGoogle();
              //googleAccountPermission();
            }
          },
        ),
        Image.asset(
          image!,
          width: 20,
        ),
        SizedBox(width: 4),
        Text(title!),
      ],
    );
  }

  GoogleSignInAccount? userGoogle;

  Future signInWithGoogle() async {
    final _googleSignIn = GoogleSignIn(
      //clientId: Secret.getId(),
      scopes: <String>[
        cal.CalendarApi.calendarScope,
      ],
    );

    await _googleSignIn.signOut();

    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    var data = await googleUser!.authHeaders;

    final GoogleAPIClient httpClient =
        GoogleAPIClient(await googleUser.authHeaders);

    final cal.CalendarApi calendarAPI = cal.CalendarApi(httpClient);
    print(httpClient);
    CalendarClient.calendar = calendarAPI;
    setState(() {
      userGoogle = googleUser;
    });
    if (googleUser.email == "") {
      setState(() {
        userGoogle = null;
        showEmailIdDialog = false;
      });
    } else {
      print("");
      setState(() {
        showEmailIdDialog = true;
      });
      buildTopMessageBox(context);
      print("${userGoogle!.email}");
    }
  }

  Row buildCheckText(
      {String? title, required int? value, required int? groupValue}) {
    return Row(
      children: [
        Radio<int>(
          activeColor: Theme.of(context).primaryColor,
          value: value!,
          groupValue: groupValue,
          onChanged: (int? value) {
            setState(() => _selectedRepeatDay = value!);
            print('_selectedRepeatDay : $_selectedRepeatDay');
          },
        ),
        Text(title!),
      ],
    );
  }

  Expanded buildNumberDropdown({
    int? index,
    int? selectedValue,
    List<int>? dropdown,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        // width: 100,
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xffECECEC)),
          borderRadius: BorderRadius.circular(4),
        ),
        child: DropdownButton<int>(
          isDense: true,
          value: selectedValue,
          key: UniqueKey(),
          isExpanded: true,
          underline: Container(),
          items: dropdown!
              .map((item) => DropdownMenuItem<int>(
                  child: Text(
                    item.toString().length > 1
                        ? item.toString()
                        : "0${item.toString()}",
                    style: TextStyle(fontSize: 12),
                  ),
                  value: item))
              .toList(),
          onChanged: (val) {
            setState(() {
              if (index == 0) {
                _selectedHour = val;
                print("_selectedHour: $val");
              } else {
                _selectedMinute = val;
                print("_selectedMinute: $val");
              }
            });
          },
        ),
      ),
    );
  }

  //Todo
  Container buildTopMessageBox(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        onTap: () {
          final dynamic _toolTip = _toolTipKey.currentState;
          _toolTip.ensureTooltipVisible();
        },
        child: Tooltip(
          key: _toolTipKey,
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          message:
              "Note:- if you want to join meetings through Zoom Platform. You must to login from these Email and Password.",
          child: ListTile(
            tileColor: Colors.amber,
            title: Text(
                "Host Email ID : ${_selectedPlatform == 1 ? emailData!.length > 0 ? emailData![0].hostEmail : "" : userGoogle != null ? userGoogle!.email : ""}",
                textScaleFactor: 1.0,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            trailing: Icon(Icons.info),
          ),
        ),
      ),
    );
  }

  InkWell buildDateSelector() {
    return InkWell(
        onTap: () => _selectDate(context),
        child: internalTextForDateTime(
          context,
          selectedDate: DateFormat("dd MMM yyyy").format(selectedDate),
        )
        // Container(
        //   width: MediaQuery.of(context).size.width,
        //   padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        //   decoration: BoxDecoration(
        //     border: Border.all(color: Color(0xffECECEC)),
        //   ),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       Text(
        //         DateFormat("dd MMM yyyy").format(selectedDate),
        //         // "${selectedDate.toLocal()}".split(' ')[0],
        //         overflow: TextOverflow.ellipsis,
        //         maxLines: 1,
        //       ),
        //       Icon(Icons.today, color: Theme.of(context).primaryColor)
        //     ],
        //   ),
        // ),
        );
  }

  InkWell buildTimeSelector() {
    return InkWell(
      onTap: () => _selectTime(context),
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xffECECEC),
              ),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(formatTimeOfDay(selectedTime)),
            // child: Text(index == 0 ? _startDateSelected : _endDateSelected),
          ),
          Positioned(
              right: 8,
              top: 8,
              child: Icon(Icons.watch_later,
                  color: Theme.of(context).primaryColor)),
        ],
      ),
    );
  }

  Container buildSearchTextField() {
    return Container(
      color: Colors.white,
      // padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        // obscureText: !obscureText ? false : true,
        controller: searchController,
        validator: FieldValidators.globalValidator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
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
          hintText: "Search...",
          hintStyle: TextStyle(color: Color(0xffA5A5A5)),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
        ),
      ),
    );
  }

  Container buildDetailsTextField() {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: TextFormField(
        maxLines: 3,
        maxLength: 100,
        controller: detailsController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
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
          hintText: "type here...",
          hintStyle: TextStyle(color: Color(0xff77838F)),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          counterText: "",
        ),
      ),
    );
  }

  Widget buildApplyBtn() {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
        padding: EdgeInsets.symmetric(
          horizontal: 10.0,
        ),
        // width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: Theme.of(context).primaryColor,
        ),
        child: TextButton(
          onPressed: () async {
            if (_selectedClassList.length > 0 &&
                _selectedSubject!.subjectHead != "" &&
                detailsController.text != "") {
              setState(() => showLoader = !showLoader);

              print("andaknksdakjds $_selectedPlatform");

              _selectedClassList.forEach((element) {
                setState(() {
                  if (classIds != "") {
                    classIds = classIds + "," + element.iD!;
                  } else {
                    classIds = element.iD!;
                  }
                });
              });

              _selectedClassList.forEach((element) {
                setState(() {
                  if (classNames != "") {
                    classNames = classNames + "," + element.className!;
                  } else {
                    classNames = element.className!;
                  }
                });
              });

              studentListMulti!.forEach((element) {
                studentFinalList.add(StudentListFinalModel(
                  iD: "${element.studentId!}",
                  clsID: "${element.classid}",
                  clsName: element.clsName,
                  yearID: "${element.yearid}",
                  streamID: "${element.streamid}",
                  clsSectionID: "${element.classsectionid}",
                ));
              });

              if (_selectedPlatform == 1) {
                if (emailData!.length >= 0 &&
                    emailData![0].createmeetingapi == 1) {
                  saveZoomMeeting();
                }
              } else {
                List<String> _selectedAttendeessList = [];

                studentListMulti!.forEach((element) {
                  if (element.emailid != "") {
                    if (element.emailid!.contains("@")) {
                      _selectedAttendeessList.add(element.emailid!.toString());
                    }
                  }
                });

                print("_selectedAttendeessList => $_selectedAttendeessList");

                setState(() {
                  meetingIdFinal =
                      DateTime.now().microsecondsSinceEpoch.toString();
                });

                print("${meetingIdFinal}");

                print("classNames $classNames");
                print("meetingIdFinal $meetingIdFinal");
                print("detailsController ${detailsController.text}");
                print("_selectedSubject ${_selectedSubject!.subjectHead}");
                print("_selectedAttendeessList $_selectedAttendeessList");
                print("_selectedRepeatDay $_selectedRepeatDay");

                await CalendarClient()
                    .insert(
                  meetingId: meetingIdFinal!,
                  summary: "Google Meet-${detailsController.text}",
                  location: "New Delhi, India",
                  repeatCount: _selectedRepeatDay.toString(),
                  description:
                      "Online class for $classNames of ${_selectedSubject!.subjectHead}",
                  selectedAttendeesList: _selectedAttendeessList,
                  shouldNotifyAttendees: true,
                  hasConferenceSupport: true,
                  startTime: DateTime.now(),
                  endTime: DateTime.now(),
                )
                    .then((eventData) async {
                  String? eventId = eventData['id'];
                  String? eventLink = eventData['link'];

                  print('eventId: $eventId & eventLink: $eventLink');
                  saveGoogleMeetMeeting(eventLink);
                }).catchError((e) {
                  print(e);
                  setState(() => showLoader = !showLoader);
                });
              }
            } else {
              print(classListMulti![0].className);
              if (_selectedClassList.length < 1) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(commonSnackBar(title: "Please Select Class"));
              } else if (_selectedSubject!.subjectHead == "") {
                ScaffoldMessenger.of(context).showSnackBar(
                    commonSnackBar(title: "Please Select Subject"));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    commonSnackBar(title: "Please Enter Details"));
              }
              // ScaffoldMessenger.of(context)
              //     .showSnackBar(commonSnackBar(title: "Please Fill Details"));
            }
          },
          child: Text(
            "Create New Class",
            style:
                TextStyle(fontFamily: "BebasNeue-Regular", color: Colors.white),
          ),
        ),
      ),
    );
  }

  Padding buildEmailNotRegistered(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: ListTile(
        tileColor: Colors.red[400],
        title: Text(
          "Unable to create meeting because Host Email ID is not assigned.",
          textScaleFactor: 1.0,
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  Padding buildLabels(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        label,
        style: TextStyle(
          // color: Theme.of(context).primaryColor,
          color: Color(0xff3A3A3A),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Text buildText({String? title, Color? color}) {
    return Text(
      title ?? "",
      style: TextStyle(fontWeight: FontWeight.w600, color: color),
    );
  }

  void prompt(String url) async {
    final data = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => GooglePermission(gatewayUrl: url))) as String;
    print("credential : $data");
  }

  showAllStudents() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: buildLabels("All Students"),
            ),
            Divider(),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: studentListMulti!.length,
                itemBuilder: (context, i) {
                  return CheckboxListTile(
                    title: new Text(
                        "${studentListMulti![i].onlyStName!} - ${studentListMulti![i].clsName!}"),
                    value: studentListMulti![i].isSelected,
                    activeColor: Theme.of(context).primaryColor,
                    checkColor: Colors.white,
                    onChanged: (val) {
                      setState(() {
                        studentListMulti![i].isSelected =
                            !studentListMulti![i].isSelected!;
                      });
                    },
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        "Select",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class StudentListFinalModel {
  String? iD = '';
  String? clsID = '';
  String? clsName = '';
  String? yearID = '';
  String? streamID = '';
  String? clsSectionID = '';

  StudentListFinalModel(
      {this.iD,
      this.clsID,
      this.clsName,
      this.yearID,
      this.streamID,
      this.clsSectionID});

  StudentListFinalModel.fromJson(Map<String, dynamic> json) {
    iD = json['iD'];
    clsID = json['clsID'];
    clsName = json['clsName'];
    yearID = json['yearID'];
    streamID = json['streamID'];
    clsSectionID = json['clsSectionID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['iD'] = this.iD;
    data['clsID'] = this.clsID;
    data['clsName'] = this.clsName;
    data['yearID'] = this.yearID;
    data['streamID'] = this.streamID;
    data['clsSectionID'] = this.clsSectionID;
    return data;
  }
}

Future<String> getFilePath() async {
  Directory appDocumentsDirectory =
      await getApplicationDocumentsDirectory(); // 1
  String appDocumentsPath = appDocumentsDirectory.path; // 2
  String filePath = '$appDocumentsPath/demoTextFile.txt'; // 3

  return filePath;
}

void saveFile(AuthClient? client) async {
  File file = File(await getFilePath()); // 1
  file.writeAsString("$client : demoTextFile.txt"); // 2
}

void readFile() async {
  File file = File(await getFilePath()); // 1
  String fileContent = await file.readAsString(); // 2

  print('File Content: $fileContent');
}

// List<StudentListMeetingModel>? studentListMulti = [];

class GoogleAPIClient extends IOClient {
  Map<String, String> _headers;

  GoogleAPIClient(this._headers) : super();

  @override
  Future<IOStreamedResponse> send(BaseRequest request) =>
      super.send(request..headers.addAll(_headers));

  @override
  Future<Response> head(Uri url, {Map<String, String>? headers}) =>
      super.head(url, headers: headers!..addAll(_headers));
}
