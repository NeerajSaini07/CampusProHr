import 'dart:convert';

import 'package:campus_pro/secrets.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/CURRENT_USER_EMAIL_FOR_ZOOM_CUBIT/current_user_email_for_zoom_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/DELETE_SCHEDULE_MEETING_EMPLOYEE_CUBIT/delete_schedule_meeting_employee_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/DEPARTMENT_WISE_EMPLOYEE_MEETING_CUBIT/department_wise_employee_meeting_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/GROUP_WISE_EMPLOYEE_MEETING_CUBIT/group_wise_employee_meeting_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/MEETING_DETAILS_ADMIN_CUBIT/meeting_details_admin_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/MEETING_PLATFORMS_CUBIT/meeting_platforms_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/SAVE_GOOGLE_MEET_SCHEDULE_MEETING_ADMIN_CUBIT/save_google_meet_schedule_meeting_admin_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/SAVE_ZOOM_SCHEDULE_MEETING_ADMIN_CUBIT/save_zoom_schedule_meeting_admin_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/SCHEDULE_MEETING_LIST_ADMIN_CUBIT/schedule_meeting_list_admin_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/SUBJECT_LIST_MEETING_CUBIT/subject_list_meeting_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/EmployeeInfoForSearchModel.dart';
import 'package:campus_pro/src/DATA/MODELS/classListEmployeeModel.dart';
import 'package:campus_pro/src/DATA/MODELS/currentUserEmailForZoomModel.dart';
import 'package:campus_pro/src/DATA/MODELS/departmentWiseEmployeeMeetingModel.dart';
import 'package:campus_pro/src/DATA/MODELS/groupWiseEmployeeMeetingModel.dart';
import 'package:campus_pro/src/DATA/MODELS/meetingPlatformsModel.dart';
import 'package:campus_pro/src/DATA/MODELS/scheduleMeetingListAdminModel.dart';
import 'package:campus_pro/src/DATA/MODELS/subjectListMeetingModel.dart';
import 'package:campus_pro/src/DATA/MODELS/userTypeModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/PAGES/STAND_ALONE_PAGES/MEETING/scheduleClass.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonSnackbar.dart';
import 'package:campus_pro/src/UI/WIDGETS/drawerWidget.dart';
import 'package:campus_pro/src/UI/WIDGETS/googlePermission.dart';
import 'package:campus_pro/src/UI/WIDGETS/noRecordFound.dart';
import 'package:campus_pro/src/UTILS/GOOGLE_MEET/calendar_client.dart';
import 'package:campus_pro/src/UTILS/appImages.dart';
import 'package:campus_pro/src/UTILS/fieldValidators.dart';
import 'package:campus_pro/src/UTILS/joinMeeting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:googleapis/calendar/v3.dart' as cal;

class ScheduleStaffMeeting extends StatefulWidget {
  static const routeName = "/schedule-staff-meeting";
  const ScheduleStaffMeeting({Key? key}) : super(key: key);

  @override
  _ScheduleStaffMeetingState createState() => _ScheduleStaffMeetingState();
}

class _ScheduleStaffMeetingState extends State<ScheduleStaffMeeting> {
  String? meetingIdOnTap;

  bool showLoader = false;

  bool showMeetingForm = false;

  String? meetingIdFinal = "";
  String? uid;
  String? token;
  UserTypeModel? userData;

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

  bool showEmailIdDialog = true;

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

  bool isSaveButton = false;

  @override
  void initState() {
    getDataFromCache();
    _selectedGroupList = [];
    getGroupList();
    super.initState();
  }

  getDataFromCache() async {
    uid = await UserUtils.idFromCache();
    token = await UserUtils.userTokenFromCache();
    userData = await UserUtils.userTypeFromCache();
    getMeetingList();
    getMeetingPlatforms();
  }

  getMeetingList() async {
    final meetingData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData!.schoolId,
      "EmpId": userData!.stuEmpId,
      "For": "E",
      "UserType": userData!.ouserType
    };
    print("Sending ScheduleMeetingListAdmin Data => $meetingData");
    context
        .read<ScheduleMeetingListAdminCubit>()
        .scheduleMeetingListAdminCubitCall(meetingData);
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
      "UserType": userData!.ouserType,
    };
    context
        .read<DeleteScheduleMeetingEmployeeCubit>()
        .deleteScheduleMeetingEmployeeCubitCall(deleteMeeting);
  }

  getMeetingDetails(ScheduleMeetingListAdminModel? data) async {
    setState(() {
      meetingIdOnTap = data!.id.toString();
    });
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final meetingData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "SessionId": userData.currentSessionid,
      "MeetingId": meetingIdOnTap,
      "StuEmpId": userData.stuEmpId,
      "UserType": userData.ouserType,
      "GetType": "tt",
    };
    print('sending MeetingDetailsAdmin data $meetingData');
    context
        .read<MeetingDetailsAdminCubit>()
        .meetingDetailsAdminCubitCall(meetingData);
  }

  getMeetingPlatforms() async {
    final userData = await UserUtils.userTypeFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userDatas = await UserUtils.userTypeFromCache();
    final platformData = {
      'OUserId': uid,
      'Token': token,
      'OrgId': userDatas!.organizationId,
      'Schoolid': userDatas.schoolId,
      "EmpId": userDatas.stuEmpId,
      "UserType": userDatas.ouserType,
    };
    print("Sending Meeting Platform Data => $platformData");
    context
        .read<MeetingPlatformsCubit>()
        .meetingPlatformsCubitCall(platformData);
  }

  getGroupList() async {
    final uid = await UserUtils.idFromCache();

    final groupData = {
      "OUserId": uid!,
      "Token": token!,
      "OrgId": userData!.organizationId!,
      "Schoolid": userData!.schoolId!,
      "EmpStuId": userData!.stuEmpId!,
      "UserType": userData!.ouserType!,
      "ParamType": "Group",
    };
    print('Sending GroupWiseEmployeeMeeting Data => $groupData');
    context
        .read<GroupWiseEmployeeMeetingCubit>()
        .groupWiseEmployeeMeetingCubitCall(groupData);
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
    };
    if (userData!.ouserType!.toLowerCase() == "e") {
      getSubjectData["EmpId"] = userData!.stuEmpId;
    } else {
      getSubjectData["EmpId"] = selectedEmployee!.empId.toString();
    }
    print('Sending SubjectListMeeting datas $getSubjectData');
    context
        .read<SubjectListMeetingCubit>()
        .subjectListMeetingCubitCall(getSubjectData);
  }

  getEmployeeList(List<GroupWiseEmployeeMeetingModel>? groupSelect) async {
    List<String> departmentIds = [];
    for (int i = 0; i < groupSelect!.length; i++) {
      setState(() => departmentIds.add(groupSelect[i].iD!));
    }

    final getEmployeeData = {
      "OUserId": uid!,
      "Token": token!,
      "OrgId": userData!.organizationId!,
      "Schoolid": userData!.schoolId!,
      "StuEmpId": userData!.stuEmpId!,
      "UserType": userData!.ouserType!,
      "DepartmentId": departmentIds.join(","),
    };
    print('Sending DepartmentWiseEmployeeMeeting Data $getEmployeeData');
    context
        .read<DepartmentWiseEmployeeMeetingCubit>()
        .departmentWiseEmployeeMeetingCubitCall(getEmployeeData);
  }

  googleAccountPermission() async {
    print("CHAL GYA");
    var _clientID = new ClientId(Secret.getId(), "");
    var _scopes = const [cal.CalendarApi.calendarScope];

    await clientViaUserConsent(_clientID, _scopes, prompt)
        .then((AuthClient client) async {
      CalendarClient.calendar = cal.CalendarApi(client);
      print('accessToken: ${client.credentials.accessToken}');
    });
  }

  getCurrentUserEmailForZoom() async {
    final emailData = {
      'OUserId': uid!,
      'Token': token!,
      'OrgId': userData!.organizationId!,
      'SchoolId': userData!.schoolId!,
      'StuEmpId': userData!.stuEmpId!,
      'UserType': userData!.ouserType!.toLowerCase(),
      // 'Plateform': "2",
      'Plateform': "1",
      "EmpId": userData!.stuEmpId!,
      "StuEmpId": userData!.stuEmpId!,
    };
    print("sending CurrentUserEmailForZoom data => $emailData");
    context
        .read<CurrentUserEmailForZoomCubit>()
        .currentUserEmailForZoomCubitCall(emailData);
  }

  saveZoomMeetingAdmin() async {
    final List employeeList = [];

    _selectedEmployeeList.forEach((element) {
      employeeList.add({"ID": "${element.empId!}"});
      // studentsList.add(StudentListFinalModel(
      //   iD: "${element.studentId!}",
      // ));
    });

    final meetingData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData!.schoolId,
      "tblId": "",
      "StuEmpId": userData!.stuEmpId,
      "Usertype": userData!.ouserType,
      "MeetingId": DateTime.now().microsecondsSinceEpoch.toString(),
      "Class": classIds,
      "MeetingDate": DateFormat('dd-MMM-yyyy').format(selectedDate),
      "MeetingTime": "${selectedTime.hour}:${selectedTime.minute}",
      "MeetingDuration": '$_selectedHour:$_selectedMinute',
      "MeetingSubject": 'Zoom-${detailsController.text}',
      "SubjectId": "0",
      "MeetingPwd": "",
      "Session": userData!.currentSessionid!,
      "AuthnticateParam": "",
      "MeetingType": "1",
      "Hostmail": emailData![0].hostEmail,
      "ForStuEmp": "e",
      "Students": jsonEncode(employeeList),

      //"cpt130@enableit.co.in"
    };
    print("Sending saveZoomMeetingAdmin Data => $meetingData");
    context
        .read<SaveZoomScheduleMeetingAdminCubit>()
        .saveZoomScheduleMeetingAdminCubitCall(meetingData);
  }

  saveGoogleMeetMeetingAdmin(String? meetingLink) async {
    final List employeeList = [];

    _selectedEmployeeList.forEach((element) {
      employeeList.add({"ID": "${element.empId!}"});
      // studentsList.add(StudentListFinalModel(
      //   iD: "${element.studentId!}",
      // ));
    });

    final meetingData = {
      // "MeetingLink": meetingLink!,
      "UserId": uid!,
      "Token": token!,
      "StuEmpId": userData!.stuEmpId,
      "tblId": "",
      "MeetingId": meetingIdFinal!,
      "Class": classIds,
      "Students": jsonEncode(employeeList),
      "MeetingDate": DateFormat('dd-MMM-yyyy').format(selectedDate),
      "MeetingTime": "${selectedTime.hour}:${selectedTime.minute}",
      "MeetingDuration": '$_selectedHour:$_selectedMinute',
      "MeetingSubject": 'Google Meet-${detailsController.text}',
      "UserType": userData!.ouserType!,
      // "UserType": "e",
      // "OUserType": userData!.ouserType!,
      "SubjectId": "0",
      "OrgId": userData!.organizationId!,
      "SchoolId": userData!.schoolId!,
      "MeetingPwd": "",
      "Session": userData!.currentSessionid!,
      "AuthnticateParam": "",
      "MeetingType": "2",
      "Hostmail": "${userGoogle!.email}",
      //"campusprowork@gmail.com",
      "MeetingLink": meetingLink!,
    };
    print(
        "Sending SaveGoogleMeetScheduleMeetingAdmin Data => $meetingLink & Data $meetingData");
    context
        .read<SaveGoogleMeetScheduleMeetingAdminCubit>()
        .saveGoogleMeetScheduleMeetingAdminCubitCall(meetingData);
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
      appBar: commonAppBar(context, title: "Schedule Staff Meeting"),
      body: MultiBlocListener(
        listeners: [
          BlocListener<MeetingDetailsAdminCubit, MeetingDetailsAdminState>(
            listener: (context, state) {
              if (state is MeetingDetailsAdminLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                }
              }
              if (state is MeetingDetailsAdminLoadSuccess) {
                JoinMeeting().checkPlatform(
                    meetingSubject: state.meetingDetailData.meetingSubject,
                    meetingId: meetingIdOnTap);
              }
            },
          ),
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
          BlocListener<SaveZoomScheduleMeetingAdminCubit,
              SaveZoomScheduleMeetingAdminState>(
            listener: (context, state) {
              if (state is SaveZoomScheduleMeetingAdminLoadInProgress) {
                setState(() {
                  isSaveButton = true;
                });
              }
              if (state is SaveZoomScheduleMeetingAdminLoadSuccess) {
                setState(() {
                  isSaveButton = false;
                });
                ScaffoldMessenger.of(context)
                    .showSnackBar(commonSnackBar(title: "Meeting Schedule"));
                Navigator.pop(context);
                Navigator.pushNamed(context, ScheduleStaffMeeting.routeName);
              }
              if (state is SaveZoomScheduleMeetingAdminLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                } else {
                  setState(() => showLoader = !showLoader);
                  setState(() {
                    isSaveButton = false;
                  });
                }
              }
            },
          ),
          BlocListener<SaveGoogleMeetScheduleMeetingAdminCubit,
              SaveGoogleMeetScheduleMeetingAdminState>(
            listener: (context, state) {
              if (state is SaveGoogleMeetScheduleMeetingAdminLoadInProgress) {
                setState(() {
                  isSaveButton = true;
                });
              }
              if (state is SaveGoogleMeetScheduleMeetingAdminLoadSuccess) {
                setState(() {
                  isSaveButton = false;
                });
                ScaffoldMessenger.of(context)
                    .showSnackBar(commonSnackBar(title: "Meeting Schedule"));
                Navigator.pop(context);
                Navigator.pushNamed(context, ScheduleStaffMeeting.routeName);
              }
              if (state is SaveGoogleMeetScheduleMeetingAdminLoadFail) {
                setState(() {
                  isSaveButton = false;
                });
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                } else {
                  setState(() => showLoader = !showLoader);
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
              // SizedBox(height: 20),
              buildTabBar(context),
              Expanded(
                child: TabBarView(
                  children: [
                    buildScheduleClass(context),
                    BlocConsumer<ScheduleMeetingListAdminCubit,
                        ScheduleMeetingListAdminState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        if (state is ScheduleMeetingListAdminLoadInProgress) {
                          return Center(child: CircularProgressIndicator());
                        } else if (state
                            is ScheduleMeetingListAdminLoadSuccess) {
                          return buildUpcomingClasses(context,
                              meetingList: state.meetingList);
                        } else if (state is ScheduleMeetingListAdminLoadFail) {
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
          // gradient: customGradient,
          color: Theme.of(context).primaryColor,
        ),
        physics: ClampingScrollPhysics(),
        onTap: (int tabIndex) {
          print("tabIndex: $tabIndex");
          switch (tabIndex) {
            case 0:
              tabIndexChange(tabIndex);
              // getSample();
              break;
            case 1:
              tabIndexChange(tabIndex);
              // getMeetingPlatforms();
              // getGroupList();
              break;
            default:
              tabIndexChange(tabIndex);
              // getSample();
              break;
          }
        },
        tabs: [
          buildTabs(title: 'Schedule Meeting', index: 0),
          buildTabs(title: 'Upcoming Meetings', index: 1),
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

  // Container buildScheduleClass(BuildContext context) {
  //   return Container(
  //     padding: const EdgeInsets.all(10.0),
  //     child: ListView.builder(
  //       shrinkWrap: true,
  //       physics: AlwaysScrollableScrollPhysics(),
  //       itemCount: categoryList.length,
  //       itemBuilder: (context, i) {
  //         var item = categoryList[i];
  //         return Container(
  //           margin: const EdgeInsets.all(8.0),
  //           padding: const EdgeInsets.symmetric(vertical: 8.0),
  //           decoration: BoxDecoration(
  //             border: Border.all(color: Color(0xffE1E3E8)),
  //             borderRadius: BorderRadius.circular(8.0),
  //           ),
  //           child: Stack(
  //             children: [
  //               ListTile(
  //                 leading: Container(
  //                   color: Theme.of(context).primaryColor,
  //                   padding: const EdgeInsets.symmetric(
  //                       vertical: 8.0, horizontal: 16.0),
  //                   child: Text(
  //                     "${i + 1}",
  //                     style: TextStyle(color: Colors.white),
  //                   ),
  //                 ),
  //                 title: Text(
  //                   "Meeting",
  //                   style: TextStyle(fontWeight: FontWeight.w600),
  //                 ),
  //                 subtitle: Text(
  //                   "Meeting Details",
  //                   style: TextStyle(fontSize: 12.0),
  //                 ),
  //               ),
  //               Positioned(
  //                 right: 16,
  //                 top: 16,
  //                 child: Column(
  //                   children: [
  //                     Icon(
  //                       Icons.videocam,
  //                       color: Theme.of(context).primaryColor,
  //                     ),
  //                     Text("Join",
  //                         textScaleFactor: 1.0,
  //                         style: TextStyle(
  //                             fontSize: 16.0,
  //                             color: Theme.of(context).primaryColor)),
  //                   ],
  //                 ),
  //               )
  //             ],
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }

  _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000)).then((value) {
      getMeetingList();
    });
  }

  Container buildUpcomingClasses(BuildContext context,
      {List<ScheduleMeetingListAdminModel>? meetingList}) {
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
                  "${item.meetingSubject!.split('\r\n')[0].split('-')[0]}",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
              ),
              subtitle: Transform.translate(
                offset: Offset(-10, 0),
                child: Container(
                  // color: Colors.green,
                  child: Text(
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
                ),
              ),
              trailing: Transform.translate(
                offset: Offset(10, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () {
                        if (item.meetinglivestatus!.toLowerCase() == 'y')
                          getMeetingDetails(item);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 16.0),
                        width: 100,
                        decoration: BoxDecoration(
                          color: item.meetinglivestatus!.toLowerCase() == 'y'
                              ? Color(0xff6CC164).withOpacity(0.5)
                              : Color(0xffFF5545).withOpacity(0.5),
                          // color: Color(0xfff1f1f1),
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        child: Text(
                          item.meetinglivestatus!.toLowerCase() == 'y'
                              ? "Join"
                              : "Ended",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.quicksand(
                              color:
                                  item.meetinglivestatus!.toLowerCase() == 'y'
                                      ? Colors.black
                                      // ? Theme.of(context).primaryColor
                                      : Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
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

  // Container buildUpcomingClasses(BuildContext context,
  //     {List<ScheduleMeetingListAdminModel>? meetingList}) {
  //   return Container(
  //     padding: const EdgeInsets.symmetric(horizontal: 10.0),
  //     margin: const EdgeInsets.symmetric(vertical: 10),
  //     child: ListView.separated(
  //       separatorBuilder: (BuildContext context, int index) =>
  //           SizedBox(height: 10),
  //       shrinkWrap: true,
  //       physics: NeverScrollableScrollPhysics(),
  //       itemCount: 5,
  //       itemBuilder: (context, i) {
  //         // var item = onlineMeetingData[i];
  //         return Container(
  //           padding: const EdgeInsets.symmetric(vertical: 8.0),
  //           decoration: BoxDecoration(
  //             border: Border.all(color: Color(0xffE1E3E8)),
  //             borderRadius: BorderRadius.circular(8.0),
  //           ),
  //           child: Stack(
  //             children: [
  //               ListTile(
  //                 title: Text('English',
  //                     style: TextStyle(fontWeight: FontWeight.w600)),
  //                 subtitle: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Row(
  //                       children: [
  //                         // CircleAvatar(
  //                         //   radius: 4,
  //                         //   backgroundColor: Colors.green,
  //                         // ),
  //                         // SizedBox(width: 4),
  //                         Text(
  //                           'English',
  //                           style: TextStyle(fontSize: 14.0),
  //                         ),
  //                       ],
  //                     ),
  //                     Row(
  //                       children: [
  //                         // CircleAvatar(
  //                         //   radius: 4,
  //                         //   backgroundColor: Colors.green,
  //                         // ),
  //                         // SizedBox(width: 4),
  //                         Text(
  //                           '115654',
  //                           style: TextStyle(fontSize: 14.0),
  //                         ),
  //                       ],
  //                     ),
  //                     // Text(
  //                     //   item.cirContent!.split('\r\n')[0],
  //                     //   style: TextStyle(fontSize: 12.0),
  //                     // ),
  //                     SizedBox(height: 8),
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Row(
  //                           children: [
  //                             Image.asset(
  //                               AppImages.googleMeetIcon,
  //                               // cacheHeight: 20,
  //                               width: 20,
  //                             ),
  //                             // Image.asset(
  //                             //   item.cirContent!.contains('Google')
  //                             //       ? AppImages.googleMeetIcon
  //                             //       : AppImages.zoomIcon,
  //                             //   // cacheHeight: 20,
  //                             //   width: 20,
  //                             // ),
  //                             SizedBox(width: 4),
  //                             Container(
  //                               // padding: const EdgeInsets.symmetric(
  //                               //     vertical: 4, horizontal: 18),
  //                               // decoration: BoxDecoration(
  //                               //   color: Theme.of(context).primaryColor,
  //                               // ),
  //                               child: Text(
  //                                 'Google Meet',
  //                                 textScaleFactor: 1.5,
  //                                 style: TextStyle(
  //                                   fontSize: 10.0,
  //                                   color: Colors.black,
  //                                 ),
  //                               ),
  //                               // child: Text(
  //                               //   item.cirContent!.contains('Google')
  //                               //       ? 'Google Meet'
  //                               //       : 'Zoom',
  //                               //   textScaleFactor: 1.5,
  //                               //   style: TextStyle(
  //                               //     fontSize: 10.0,
  //                               //     color: Colors.black,
  //                               //   ),
  //                               // ),
  //                             ),
  //                           ],
  //                         ),
  //                         InkWell(
  //                           // onTap: () => getMeetingDetails(item),
  //                           onTap: () {
  //                             // if (item.cirContent!.contains('Google')) {
  //                             //   getMeetingDetails(item);
  //                             // } else {
  //                             //   getMeetingDetails(item);
  //                             // }
  //                           },
  //                           child: Row(
  //                             children: [
  //                               Icon(
  //                                 Icons.videocam,
  //                                 color: Theme.of(context).primaryColor,
  //                                 size: 32,
  //                               ),
  //                               Text(
  //                                 'Join Class',
  //                                 // textScaleFactor: 1.5,
  //                                 style: TextStyle(
  //                                     // fontSize: 12.0,
  //                                     // color: Colors.white70,
  //                                     color: Theme.of(context).primaryColor,
  //                                     fontWeight: FontWeight.bold),
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }

  SingleChildScrollView buildScheduleClass(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                  // return buildTopMessageBox(context);
                  return Container();
                } else {
                  return Container();
                }
              },
            ),
            buildTopMessageBox(context),
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
                  getGroupList();
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
            BlocConsumer<GroupWiseEmployeeMeetingCubit,
                GroupWiseEmployeeMeetingState>(
              listener: (context, state) {
                if (state is GroupWiseEmployeeMeetingLoadSuccess) {
                  setState(() {
                    groupListMulti = state.groupData;
                    // _selectedGroupList = state.classList;
                    // _groupSelectKey = state.classList[0];
                  });
                }
                if (state is GroupWiseEmployeeMeetingLoadFail) {
                  if (state.failReason == "false") {
                    UserUtils.unauthorizedUser(context);
                  } else {
                    setState(() {
                      groupListMulti = [];
                      _selectedGroupList = [];
                      // _groupSelectKey =
                      //     ClassListEmployeeModel(iD: "", className: "");
                    });
                  }
                }
              },
              builder: (context, state) {
                if (state is GroupWiseEmployeeMeetingLoadInProgress) {
                  return buildGroupMultiSelect(context);
                } else if (state is GroupWiseEmployeeMeetingLoadSuccess) {
                  return buildGroupMultiSelect(context);
                } else {
                  return Container();
                }
              },
            ),
            // SizedBox(height: 10),
            // BlocConsumer<SubjectListMeetingCubit, SubjectListMeetingState>(
            //   listener: (context, state) {
            //     if (state is SubjectListMeetingLoadSuccess) {
            //       setState(() {
            //         subjectDropdown = state.subjectList;
            //         _selectedSubject = state.subjectList[0];
            //       });
            //     }
            //     if (state is SubjectListMeetingLoadFail) {
            //       setState(() {
            //         subjectDropdown = [];
            //         _selectedSubject =
            //             SubjectListMeetingModel(subjectHead: "", subjectId: 0);
            //       });
            //     }
            //   },
            //   builder: (context, state) {
            //     if (state is SubjectListMeetingLoadInProgress) {
            //       return buildSubjectDropdown(context);
            //     } else if (state is SubjectListMeetingLoadSuccess) {
            //       return buildSubjectDropdown(context);
            //     } else {
            //       return Container();
            //     }
            //   },
            // ),
            // SizedBox(height: 10),
            BlocConsumer<DepartmentWiseEmployeeMeetingCubit,
                DepartmentWiseEmployeeMeetingState>(
              listener: (context, state) {
                if (state is DepartmentWiseEmployeeMeetingLoadSuccess) {
                  setState(() {
                    _selectedEmployeeList = state.departmentData;
                    employeeListMulti = state.departmentData;
                    totalBoys = _selectedEmployeeList
                        .where((element) =>
                            element.gender!.toLowerCase() == "male")
                        .length;
                    totalGirls = _selectedEmployeeList
                        .where((element) =>
                            element.gender!.toLowerCase() == "female")
                        .length;
                  });
                }
                if (state is DepartmentWiseEmployeeMeetingLoadFail) {
                  if (state.failReason == "false") {
                    UserUtils.unauthorizedUser(context);
                  } else {
                    setState(() {
                      _selectedEmployeeList = [];
                      employeeListMulti = [];
                    });
                  }
                }
              },
              builder: (context, state) {
                if (state is DepartmentWiseEmployeeMeetingLoadInProgress) {
                  // return buildEmployeeMultiSelect(context);
                  return buildLoadEmployee(context);
                } else if (state is DepartmentWiseEmployeeMeetingLoadSuccess) {
                  return buildEmployeeMultiSelect(context);
                } else {
                  return Container();
                }
              },
            ),
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
            SizedBox(height: 10),
            buildLabels("Enter Details"),
            buildDetailsTextField(),
            // if (_selectedPlatform == 2) buildRepeatDays(context),
            // if (showLoader)
            //   Center(
            //       child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       CircularProgressIndicator(),
            //       SizedBox(width: 12),
            //       Text(
            //         "Please wait...",
            //         textScaleFactor: 1.0,
            //       )
            //     ],
            //   ))
            // else
            buildApplyBtn(),
          ],
        ),
        // ],
      ),
      // ),
    );
  }

  Widget buildMeetingPlatform(BuildContext context,
      {List<MeetingPlatformsModel>? platformList}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildLabels("Meeting Platform"),
        Row(
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
        ),
      ],
    );
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

  List<GroupWiseEmployeeMeetingModel> _selectedGroupList =
      []; // Class List after Seletion
  List<GroupWiseEmployeeMeetingModel>? groupListMulti =
      []; // Class List After API
  final _groupSelectKey = GlobalKey<FormFieldState>();

  Widget buildGroupMultiSelect(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildLabels("Select Groups"),
        Container(
          alignment: Alignment.center,
          // padding: EdgeInsets.symmetric(horizontal: 10),
          child: MultiSelectBottomSheetField<GroupWiseEmployeeMeetingModel>(
            autovalidateMode: AutovalidateMode.disabled,
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xffECECEC)),
            ),
            key: _groupSelectKey,
            initialValue: _selectedGroupList,
            initialChildSize: 0.7,
            maxChildSize: 0.95,
            searchIcon: Icon(Icons.ac_unit),
            title: Text("All Groups",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 18)),
            buttonText: Text(
              _selectedGroupList.length > 0
                  ? "${_selectedGroupList.length} Group selected"
                  : "None selected",
            ),
            // items: _items,
            items: groupListMulti!
                .map((classList) =>
                    MultiSelectItem(classList, classList.paramname!))
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
                _selectedGroupList = values;
              });
              _groupSelectKey.currentState!.validate();
              getEmployeeList(_selectedGroupList);
            },
            chipDisplay: MultiSelectChipDisplay(
              shape: RoundedRectangleBorder(),
              textStyle: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).primaryColor),
              // chipColor: Colors.grey,
              // onTap: (item) {
              //   setState(() {
              //     _selectedGroupList.remove(item);
              //   });
              //   _groupSelectKey.currentState!.validate();
              // },
            ),
          ),
        ),
      ],
    );
  }

  List<DepartmentWiseEmployeeMeetingModel> _selectedEmployeeList =
      []; // Student List after Seletion
  List<DepartmentWiseEmployeeMeetingModel>? employeeListMulti =
      []; // Student List After API
  final _employeeSelectKey = GlobalKey<FormFieldState>();

  Widget buildLoadEmployee(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildLabels("Selected Employees"),
        Container(
          padding: EdgeInsets.only(
            left: 12,
            top: 12,
            bottom: 12,
          ),
          width: MediaQuery.of(context).size.width * 0.95,
          // height: MediaQuery.of(context).size.height * 0.06,
          decoration: BoxDecoration(
            border: Border.all(width: 0.1),
            borderRadius: BorderRadius.circular(
              4.0,
            ),
          ),
          child: Text(
            "♂️ Male : 0 | ♀️ Female : 0",
          ),
        ),
      ],
    );
  }

  Widget buildEmployeeMultiSelect(BuildContext context) {
    return
        // userData!.ouserType!.toLowerCase() == "e" ||
        //       userData!.ouserType!.toLowerCase() != "e" && userData != null
        //   ?
        Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildLabels("Selected Employees"),
        Container(
          alignment: Alignment.center,
          // padding: EdgeInsets.symmetric(horizontal: 10),
          child:
              MultiSelectBottomSheetField<DepartmentWiseEmployeeMeetingModel>(
            autovalidateMode: AutovalidateMode.disabled,
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xffECECEC)),
            ),
            key: _employeeSelectKey,
            initialChildSize: 0.7,
            maxChildSize: 0.95,
            title: Text("Selected Employees",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 18)),
            buttonText: Text(
              "♂️ Male : ${totalBoys.toString()} | ♀️ Female : ${totalGirls.toString()}",
            ),
            items: employeeListMulti!
                .map((employee) => MultiSelectItem(
                    employee, "${employee.name!} - ${employee.paramName}"))
                .toList(),
            searchable: false,
            initialValue: _selectedEmployeeList,
            validator: (values) {
              if (_selectedEmployeeList.isEmpty) {
                return "Required";
              }
              return null;
            },
            onConfirm: (values) {
              setState(() {
                _selectedEmployeeList = values;
              });
              _employeeSelectKey.currentState!.validate();
              setState(() {
                totalBoys = _selectedEmployeeList
                    .where((element) => element.gender!.toLowerCase() == "male")
                    .length;
                totalGirls = _selectedEmployeeList
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
    // : Container();
  }

  Widget buildSubjectDropdown(BuildContext context) {
    return userData!.ouserType!.toLowerCase() == "e" ||
            userData!.ouserType!.toLowerCase() != "e" && userData != null
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
    return Row(
      children: [
        Radio<int>(
          activeColor: Theme.of(context).primaryColor,
          value: value!,
          groupValue: groupValue,
          onChanged: (int? value) {
            setState(() => _selectedPlatform = value!);
            print('_selectedPlatform : $_selectedPlatform');
            getGroupList();
            if (_selectedPlatform == 1) {
              getCurrentUserEmailForZoom();
              getGroupList();
            } else {
              //googleAccountPermission();
              signInWithGoogle();
            }
          },
        ),
        Image.asset(image!, width: 20),
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
      print("Success");
      setState(() {
        showEmailIdDialog = true;
      });
      print(showEmailIdDialog);
      // buildTopMessageBox(context);
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

  Container buildTopMessageBox(BuildContext context) {
    return showEmailIdDialog
        ? Container(
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
                    "Note:- If you want to join meeting through Zoom Platform. You have to login from this Email in Zoom App.",
                child: ListTile(
                  tileColor: Colors.amber,
                  title: Text(
                      "Host Email ID : ${_selectedPlatform == 1 ? emailData!.length > 0 ? emailData![0].hostEmail != null ? emailData![0].hostEmail : "" : "" : userGoogle != null ? userGoogle!.email : ""}",
                      textScaleFactor: 1.0,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  trailing: Icon(Icons.info),
                ),
              ),
            ),
          )
        : Container();
  }

  InkWell buildDateSelector() {
    return InkWell(
      onTap: () => _selectDate(context),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xffECECEC)),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(DateFormat("dd MMM yyyy").format(selectedDate),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                )),
            Icon(Icons.today, color: Theme.of(context).primaryColor)
          ],
        ),
      ),
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
              border: Border.all(color: Color(0xffECECEC)),
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
          // suffixIcon: suffixIcon
          //     ? InkWell(
          //         onTap: () {
          //           setState(() {
          //             _showPassword = !_showPassword;
          //           });
          //         },
          //         child: !_showPassword
          //             ? Icon(Icons.remove_red_eye_outlined)
          //             : Icon(Icons.remove_red_eye),
          //       )
          //     : null,
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
    return isSaveButton == false
        ? Center(
            child: Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
              // width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                color: Theme.of(context).primaryColor,
              ),
              child: TextButton(
                onPressed: () async {
                  setState(() => showLoader = !showLoader);
                  _selectedGroupList.forEach((element) {
                    setState(() {
                      if (classIds != "") {
                        classIds = classIds + "," + element.iD!;
                      } else {
                        classIds = element.iD!;
                      }
                    });
                  });

                  List<String> _selectedAttendeessList = [];

                  _selectedEmployeeList.forEach((element) {
                    if (element.emailId != "" &&
                        element.emailId != "null" &&
                        element.emailId != null) {
                      if (element.emailId!.contains("@")) {
                        _selectedAttendeessList
                            .add(element.emailId!.toString());
                      }
                    }
                  });

                  print("_selectedPlatform final : $_selectedPlatform");

                  if (_selectedGroupList.length > 0 &&
                      detailsController.text != "") {
                    if (_selectedPlatform == 1) {
                      if (emailData!.length >= 0 &&
                          emailData![0].createmeetingapi == 1) {
                        saveZoomMeetingAdmin();
                      }
                    } else {
                      setState(() {
                        meetingIdFinal =
                            DateTime.now().microsecondsSinceEpoch.toString();
                      });
                      await CalendarClient()
                          .insert(
                        meetingId: meetingIdFinal!,
                        summary: "Google Meet-${detailsController.text}",
                        location: "New Delhi, India",
                        repeatCount: "1",
                        description: "Online Meeting for staff",
                        // description:
                        //     "Online class for $classNames of ${_selectedSubject!.subjectHead}",
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
                        saveGoogleMeetMeetingAdmin(eventLink);
                      }).catchError((e) {
                        print(e);
                        setState(() => showLoader = !showLoader);
                      });
                    }
                  } else {
                    print(_selectedGroupList);
                    print(_selectedGroupList.length);
                    if (_selectedGroupList.length < 1) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          commonSnackBar(title: "Please Select Group"));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          commonSnackBar(title: "Please Enter Details"));
                    }
                  }
                },
                child: Text(
                  "Create New Meeting",
                  style: TextStyle(
                      fontFamily: "BebasNeue-Regular", color: Colors.white),
                ),
              ),
            ),
          )
        : Center(
            child: Container(
                margin: EdgeInsets.all(10.0),
                child: CircularProgressIndicator()),
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
    // setState(() {
    // _selectedPlatform = 1;
    // });
    // getCurrentUserEmailForZoom();
    // if (await canLaunch(url)) {
    //   await launch(url);
    // } else {
    //   throw 'Could not launch $url';
    // }
  }

  // void prompt(String url) async {
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }
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
