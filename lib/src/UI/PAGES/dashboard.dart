import 'dart:convert';

import 'package:campus_pro/src/DATA/MODELS/notifyCounterModel.dart';
import 'package:campus_pro/src/UI/PAGES/COORDINATOR_MODULE/dashboardCoordinator.dart';
import 'package:campus_pro/src/UI/PAGES/GATE_PASS/visitor_gate_pass.dart';
import 'package:campus_pro/src/UI/PAGES/PARENT/parentDashboard.dart';
import 'package:campus_pro/src/UI/PAGES/STUDENT_MODULE/COMMUNICATION_STUDENT/circularStudent.dart';
import 'package:campus_pro/src/UI/PAGES/STUDENT_MODULE/COMMUNICATION_STUDENT/classRoomsStudent.dart';
import 'package:campus_pro/src/UI/PAGES/STUDENT_MODULE/COMMUNICATION_STUDENT/homeWorkStudent.dart';
import 'package:campus_pro/src/UI/PAGES/STUDENT_MODULE/activityStudent.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/PAGES/ADMIN_MODULE/dashboardAdmin.dart';
import 'package:campus_pro/src/UI/PAGES/EMPLOYEE_MODULE/dashboardEmployee.dart';
import 'package:campus_pro/src/UI/PAGES/MANAGER_MODULE/dashboardManager.dart';
import 'package:campus_pro/src/UI/PAGES/STUDENT_MODULE/dashboardStudent.dart';
import 'package:campus_pro/src/UI/PAGES/account_type_screen.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/drawerWidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../UTILS/appImages.dart';
import '../../globalBlocProvidersFile.dart';

class Dashboard extends StatefulWidget {
  static const routeName = "/dashboard";
  final String? userType;

  const Dashboard({Key? key, this.userType}) : super(key: key);
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final GlobalKey<ScaffoldState>? _scaffoldKey = new GlobalKey<ScaffoldState>();

  // final GlobalKey _menuKey = GlobalKey();

  String? user = "";
  int? notiBadge = 0;
  int totalCount = 0;

  String? userType = "";

  List<NotifyCounterModel> notifyList = [];

  void getUserType() async {
    final userData = await UserUtils.userTypeFromCache();
    setState(() {
      userType = userData!.ouserType;
    });
  }

  @override
  void initState() {
    getDrawerItems();
    getUserType();
    super.initState();
  }

  getDrawerItems() async {
    final userData = await UserUtils.userTypeFromCache();
    setState(() {
      user = userData!.ouserType;
    });
    final drawerData = {
      "OrgId": userData!.organizationId!,
      "SchoolId": userData.schoolId!,
      "ID": "0",
      "UserType": userData.ouserType!,
      // "OrgId": "9998",
      // "SchoolId": "1",
      // "ID": "0",
      // "UserType": "S",
    };
    print("Sending drawer items $drawerData");
    // context.read<DrawerCubit>().drawerCubitCall(drawerData); //TODO
    if (userData.ouserType!.toLowerCase() == "s")
      getNotifyCounterList(
        "S",
      );
  }

  getNotifyCounterList(
    String flag,
  ) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final stuInfo = await UserUtils.stuInfoDataFromCache();
    final requestPayload = {
      'OUserId': uid,
      'Token': token,
      'OrgId': userData!.organizationId,
      'Schoolid': userData.schoolId,
      'SessionId': userData.currentSessionid,
      'ClassId': stuInfo!.classId,
      'SectionId': stuInfo.classSectionId,
      'StreamId': stuInfo.streamId,
      'YearId': stuInfo.yearId,
      'StuEmpId': userData.stuEmpId,
      'Flag': flag,
      'UserType': userData.ouserType,
    };
    context.read<NotifyCounterCubit>().notificationCubitCall(requestPayload);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: userType != "G"
            ? BlocProvider<UserSchoolDetailCubit>(
                create: (_) => UserSchoolDetailCubit(
                    UserSchoolDetailRepository(UserSchoolDetailApi())),
                child: BlocProvider<EmployeeInfoCubit>(
                  create: (_) => EmployeeInfoCubit(
                      EmployeeInfoRepository(EmployeeInfoApi())),
                  child: BlocProvider<StudentInfoCubit>(
                    create: (_) => StudentInfoCubit(
                        StudentInfoRepository(StudentInfoApi())),
                    child: BlocProvider<GotoWebAppCubit>(
                      create: (_) => GotoWebAppCubit(
                          GotoWebAppRepository(GotoWebAppApi())),
                      child: DrawerWidget(),
                    ),
                  ),
                ),
              )
            : null,
        resizeToAvoidBottomInset: false,
        key: _scaffoldKey,
        appBar: commonAppBar(
          context,
          scaffoldKey: _scaffoldKey,
          centerTitle: true,
          showMenuIcon: true,
          shadowColor: Colors.transparent,
          backgroundColor: Theme.of(context).primaryColor,
          title: "DASHBOARD",
          style: GoogleFonts.quicksand(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
          icon2: IconButton(
            onPressed: () => Navigator.pushNamedAndRemoveUntil(
                context, AccountTypeScreen.routeName, (route) => false),
            icon: Container(
              height: 20,
              width: 20,
              child: Image.asset(AppImages.switchUser,
                  fit: BoxFit.cover, color: Colors.white),
            ),
          ),
          icon: user!.toLowerCase() == "s" || user!.toLowerCase() == "f"
              ? totalCount > 0
                  ? GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.4,
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: ListView.builder(
                                      itemCount: notifyList.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        var item = notifyList[index];
                                        return GestureDetector(
                                            onTap: () {
                                              if (item.title
                                                      .split("Count")[0]
                                                      .toLowerCase() ==
                                                  "homework") {
                                                setState(() {
                                                  notifyList.removeAt(index);
                                                  notiBadge =
                                                      notiBadge! - item.count;
                                                  totalCount =
                                                      totalCount - item.count;
                                                });
                                                getNotifyCounterList(
                                                  "homework",
                                                );

                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return BlocProvider<
                                                      HomeWorkStudentCubit>(
                                                    create: (_) => HomeWorkStudentCubit(
                                                        HomeWorkStudentRepository(
                                                            HomeWorkStudentApi())),
                                                    child: HomeWorkStudent(),
                                                  );
                                                })).then((value) =>
                                                    Navigator.pop(context));

                                                //   Navigator.pushNamed(
                                                //           context,
                                                //           HomeWorkStudent
                                                //               .routeName)
                                                //       .then((value) =>
                                                //           Navigator.pop(context));
                                              }
                                              if (item.title
                                                      .split("Count")[0]
                                                      .toLowerCase() ==
                                                  "classroom") {
                                                setState(() {
                                                  notifyList.removeAt(index);
                                                  notiBadge =
                                                      notiBadge! - item.count;
                                                  totalCount =
                                                      totalCount - item.count;
                                                });
                                                getNotifyCounterList(
                                                  "classroom",
                                                );
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return BlocProvider<
                                                      ClassRoomsStudentCubit>(
                                                    create: (_) =>
                                                        ClassRoomsStudentCubit(
                                                            ClassRoomsStudentRepository(
                                                                ClassRoomsStudentApi())),
                                                    child: BlocProvider<
                                                        ClassEndDrawerLocalCubit>(
                                                      create: (_) =>
                                                          ClassEndDrawerLocalCubit(),
                                                      child: BlocProvider<
                                                          TeachersListCubit>(
                                                        create: (_) =>
                                                            TeachersListCubit(
                                                                TeachersListRepository(
                                                                    TeachersListApi())),
                                                        child: BlocProvider<
                                                            SendCustomClassRoomCommentCubit>(
                                                          create: (_) =>
                                                              SendCustomClassRoomCommentCubit(
                                                                  SendCustomClassRoomCommentRepository(
                                                                      SendCustomClassRoomCommentApi())),
                                                          child:
                                                              ClassRoomsStudent(),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                })).then((value) =>
                                                    Navigator.pop(context));
                                                // Navigator.pushNamed(
                                                //         context,
                                                //         ClassRoomsStudent
                                                //             .routeName)
                                                //     .then((value) =>
                                                //         Navigator.pop(context));
                                              }
                                              if (item.title
                                                      .split("Count")[0]
                                                      .toLowerCase() ==
                                                  "circular") {
                                                setState(() {
                                                  notifyList.removeAt(index);
                                                  notiBadge =
                                                      notiBadge! - item.count;
                                                  totalCount =
                                                      totalCount - item.count;
                                                });
                                                getNotifyCounterList(
                                                    "circular");
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return BlocProvider<
                                                      CircularStudentCubit>(
                                                    create: (_) => CircularStudentCubit(
                                                        CircularStudentRepository(
                                                            CircularStudentApi())),
                                                    child: CircularStudent(),
                                                  );
                                                })).then((value) =>
                                                    Navigator.pop(context));

                                                //   Navigator.pushNamed(
                                                //           context,
                                                //           CircularStudent
                                                //               .routeName)
                                                //       .then((value) =>
                                                //           Navigator.pop(context));
                                              }
                                              if (item.title
                                                      .split("Count")[0]
                                                      .toLowerCase() ==
                                                  "activity") {
                                                setState(() {
                                                  notifyList.removeAt(index);
                                                  notiBadge =
                                                      notiBadge! - item.count;
                                                  totalCount =
                                                      totalCount - item.count;
                                                });
                                                getNotifyCounterList(
                                                  "activity",
                                                );
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return BlocProvider<
                                                      ActivityForStudentCubit>(
                                                    create: (_) =>
                                                        ActivityForStudentCubit(
                                                            ActivityForStudentRepository(
                                                                ActivityForStudentApi())),
                                                    child: ActivityStudent(),
                                                  );
                                                })).then((value) =>
                                                    Navigator.pop(context));

                                                // Navigator.pushNamed(
                                                //         context,
                                                //         ActivityStudent
                                                //             .routeName)
                                                //     .then((value) =>
                                                //         Navigator.pop(context));
                                              }
                                              if (item.title
                                                      .split("Count")[0]
                                                      .toLowerCase() ==
                                                  "meeting") {
                                                setState(() {
                                                  notifyList.removeAt(index);
                                                  notiBadge =
                                                      notiBadge! - item.count;
                                                  totalCount =
                                                      totalCount - item.count;
                                                });
                                                Navigator.pop(context);
                                              }
                                            },
                                            child: item.count > 0
                                                ? Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Image.asset(
                                                              getNotificationIcon(
                                                                  item.title.split(
                                                                      "Count")[0]),
                                                              width: 25),
                                                          SizedBox(width: 8.0),
                                                          Text(
                                                            "You have ${item.count} new ${item.title.split("Count")[0]}",
                                                            textScaleFactor:
                                                                1.2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                          SizedBox(
                                                            height: 50,
                                                          ),
                                                        ],
                                                      ),
                                                      Divider(),
                                                    ],
                                                  )
                                                : Container());
                                      }),
                                ),
                              );
                            });
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 13, right: 5),
                        child: Stack(
                          children: [
                            Icon(
                              Icons.notifications,
                              color: Colors.white,
                              size: 28,
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: new Container(
                                padding: EdgeInsets.all(2),
                                decoration: new BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                constraints: BoxConstraints(
                                  minWidth: 14,
                                  minHeight: 14,
                                ),
                                child: Text(
                                  notiBadge.toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 8,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.only(top: 13, right: 5),
                      child: Stack(
                        children: [
                          Icon(
                            Icons.notifications,
                            // color: Theme.of(context).primaryColor,
                            color: Colors.white,
                            size: 28,
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: new Container(
                              padding: EdgeInsets.all(2),
                              decoration: new BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              constraints: BoxConstraints(
                                minWidth: 14,
                                minHeight: 14,
                              ),
                              child: Text(
                                notiBadge.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
              : Container(),
        ),
        body: MultiBlocListener(
          listeners: [
            BlocListener<NotifyCounterCubit, NotifyCounterState>(
              listener: (context, state) {
                if (state is NotifyCounterLoadSuccess) {
                  print("testing:${state.notifyList}");
                  print("");

                  state.notifyList.forEach((element) {
                    totalCount += element.count;
                  });
                  print("total Count ");
                  setState(() {
                    notifyList = state.notifyList;
                    notifyList.sort((a, b) => b.count.compareTo(a.count));
                    notifyList.forEach((element) {
                      notiBadge = notiBadge! + element.count;
                    });
                    // for (var i = 0; i < notifyList.length; i++) {
                    //   if (notifyList[i].count > 0) {
                    //     dynamic stateMenu = _menuKey.currentState;
                    //     stateMenu.showButtonMenu();
                    //     break;
                    //   }
                    // }
                    // notifyList.removeWhere((element) => element.count == 0);
                  });
                }
                if (state is NotifyCounterLoadFail) {
                  if (state.failReason == "false") {
                    UserUtils.unauthorizedUser(context);
                  } else {
                    setState(() {
                      notifyList.removeWhere((element) => element.count == 0);
                    });
                  }
                }
              },
            ),
            BlocListener<DrawerCubit, DrawerState>(
                listener: (context, state) async {
              if (state is DrawerLoadSuccess) {
                /// Adding data for route to web view
                var data = [];
                state.drawerItems.forEach((element) {
                  if (element.subMenu!.length > 0) {
                    element.subMenu!.forEach((ele) {
                      print(ele.subMenuID);
                      data.add({
                        "id": ele.subMenuID,
                        "url": ele.navigateURL,
                        "flag": ele.subMenuFlag,
                        "type": "s",
                        //"murl": ele.menuURL,
                      });
                    });
                  } else {
                    print(element.menuURL);
                    data.add({
                      "id": element.menuID,
                      "url": element.menuURL,
                      "flag": element.menuFlag,
                      "type": "m",
                      //"surl": element.navigateURL,
                    });
                  }
                });
                SharedPreferences pref = await SharedPreferences.getInstance();
                await pref.remove("DrawerItemSave");
                await pref.setString("DrawerItemSave", jsonEncode(data));
              }
            }),
          ],
          child: buildDashboardBody(context, widget.userType),
        ));
  }

  buildDashboardBody(BuildContext context, String? type) {
    final userType = type!.toUpperCase();
    print("userType : $userType");
    switch (userType) {
      case 'A':
        return BlocProvider<GotoWebAppCubit>(
          create: (_) => GotoWebAppCubit(GotoWebAppRepository(GotoWebAppApi())),
          child: BlocProvider<PayModeWiseFeeCubit>(
            create: (_) => PayModeWiseFeeCubit(
                PayModeWiseFeeRepository(PayModeWiseFeeApi())),
            child: BlocProvider<DashboardAdminCubit>(
              create: (_) => DashboardAdminCubit(
                  DashboardAdminRepository(DashboardAdminApi())),
              child: DashboardAdmin(),
            ),
          ),
        );
      case 'P':
        return BlocProvider<GotoWebAppCubit>(
          create: (_) => GotoWebAppCubit(GotoWebAppRepository(GotoWebAppApi())),
          child: BlocProvider<PayModeWiseFeeCubit>(
            create: (_) => PayModeWiseFeeCubit(
                PayModeWiseFeeRepository(PayModeWiseFeeApi())),
            child: BlocProvider<DashboardAdminCubit>(
              create: (_) => DashboardAdminCubit(
                  DashboardAdminRepository(DashboardAdminApi())),
              child: DashboardAdmin(),
            ),
          ),
        );
      case 'E':
        return BlocProvider<StaffMeetingsEmployeeDashboardCubit>(
          create: (_) => StaffMeetingsEmployeeDashboardCubit(
              (StaffMeetingsEmployeeDashboardRepository(
                  StaffMeetingsEmployeeDashboardApi()))),
          child: BlocProvider<ScheduleMeetingListEmployeeCubit>(
            create: (_) => ScheduleMeetingListEmployeeCubit(
                (ScheduleMeetingListEmployeeRepository(
                    ScheduleMeetingListEmployeeApi()))),
            child: BlocProvider<EmployeeInfoCubit>(
              create: (_) =>
                  EmployeeInfoCubit(EmployeeInfoRepository(EmployeeInfoApi())),
              child: BlocProvider<GotoWebAppCubit>(
                create: (_) =>
                    GotoWebAppCubit(GotoWebAppRepository(GotoWebAppApi())),
                child: BlocProvider<SaveEmployeeImageCubit>(
                  create: (_) => SaveEmployeeImageCubit(
                      SaveEmployeeImageRepository(SaveEmployeeImageApi())),
                  child: BlocProvider<UpdateEmailCubit>(
                    create: (_) => UpdateEmailCubit(
                        UpdateEmailRepository(UpdateEmailApi())),
                    child: BlocProvider<MeetingDetailsAdminCubit>(
                      create: (_) => MeetingDetailsAdminCubit(
                          (MeetingDetailsAdminRepository(
                              MeetingDetailsAdminApi()))),
                      child: DashboardEmployee(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      case 'M':
        return BlocProvider<EmployeeInfoCubit>(
          create: (_) =>
              EmployeeInfoCubit(EmployeeInfoRepository(EmployeeInfoApi())),
          child: BlocProvider<SaveEmployeeImageCubit>(
            create: (_) => SaveEmployeeImageCubit(
                SaveEmployeeImageRepository(SaveEmployeeImageApi())),
            child: BlocProvider<GotoWebAppCubit>(
              create: (_) =>
                  GotoWebAppCubit(GotoWebAppRepository(GotoWebAppApi())),
              child: BlocProvider<UpdateEmailCubit>(
                create: (_) =>
                    UpdateEmailCubit(UpdateEmailRepository(UpdateEmailApi())),
                child: DashboardManager(),
              ),
            ),
          ),
        );
      case 'C':
        return BlocProvider<EmployeeInfoCubit>(
          create: (_) =>
              EmployeeInfoCubit(EmployeeInfoRepository(EmployeeInfoApi())),
          child: BlocProvider<SaveEmployeeImageCubit>(
            create: (_) => SaveEmployeeImageCubit(
                SaveEmployeeImageRepository(SaveEmployeeImageApi())),
            child: BlocProvider<GotoWebAppCubit>(
              create: (_) =>
                  GotoWebAppCubit(GotoWebAppRepository(GotoWebAppApi())),
              child: BlocProvider<UpdateEmailCubit>(
                create: (_) =>
                    UpdateEmailCubit(UpdateEmailRepository(UpdateEmailApi())),
                child: BlocProvider<MeetingDetailsAdminCubit>(
                  create: (_) => MeetingDetailsAdminCubit(
                      (MeetingDetailsAdminRepository(
                          MeetingDetailsAdminApi()))),
                  child: DashboardCoordinator(),
                ),
              ),
            ),
          ),
        );
      case 'S':
        return BlocProvider<EmployeeInfoCubit>(
          create: (_) =>
              EmployeeInfoCubit(EmployeeInfoRepository(EmployeeInfoApi())),
          child: BlocProvider<UserSchoolDetailCubit>(
            create: (_) => UserSchoolDetailCubit(
                UserSchoolDetailRepository(UserSchoolDetailApi())),
            child: BlocProvider<OnlineMeetingsCubit>(
              create: (_) => OnlineMeetingsCubit(
                  (OnlineMeetingsRepository(OnlineMeetingsApi()))),
              child: BlocProvider<StudentInfoCubit>(
                create: (_) =>
                    StudentInfoCubit(StudentInfoRepository(StudentInfoApi())),
                child: BlocProvider<UpdateEmailCubit>(
                  create: (_) =>
                      UpdateEmailCubit(UpdateEmailRepository(UpdateEmailApi())),
                  child: BlocProvider<GotoWebAppCubit>(
                    create: (_) =>
                        GotoWebAppCubit(GotoWebAppRepository(GotoWebAppApi())),
                    child: BlocProvider<UpdateEmailCubit>(
                      create: (_) => UpdateEmailCubit(
                          UpdateEmailRepository(UpdateEmailApi())),
                      child: BlocProvider<SelfAttendanceSettingCubit>(
                        create: (_) => SelfAttendanceSettingCubit(
                            (SelfAttendanceSettingRepository(
                                SelfAttendanceSettingApi()))),
                        child: BlocProvider<MeetingDetailsCubit>(
                          create: (_) => MeetingDetailsCubit(
                              (MeetingDetailsRepository(MeetingDetailsApi()))),
                          child: BlocProvider<MarkAttendanceCubit>(
                            create: (_) => MarkAttendanceCubit(
                                (MarkAttendanceRepository(
                                    MarkAttendanceApi()))),
                            child: DashboardStudent(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      case 'G':
        return BlocProvider<VerifyIdProofGatePassCubit>(
          create: (_) => VerifyIdProofGatePassCubit(
              VerifyIdProofGatePassRepository(VerifyIdProofGatePassApi())),
          child: BlocProvider<SaveVisitorDetailsGatePassCubit>(
            create: (_) => SaveVisitorDetailsGatePassCubit(
                SaveVisitorDetailsGatePassRepository(
                    SaveVisitorDetailsGatePassApi())),
            child: BlocProvider<VerifyOtpGatePassCubit>(
              create: (_) => VerifyOtpGatePassCubit(
                  VerifyOtpGatePassRepository(VerifyOtpGatePassApi())),
              child: BlocProvider<SendingOtpGatePassCubit>(
                create: (_) => SendingOtpGatePassCubit(
                    SendingOtpGatePassRepository(SendingOtpGatePassApi())),
                child: BlocProvider<GatePassMeetToCubit>(
                  create: (_) => GatePassMeetToCubit(
                      GatePassMeetToRepository(GatePassMeetToApi())),
                  child: VisitorGatePassCheck(),
                ),
              ),
            ),
          ),
        );

      ///
      case 'O':
        return ParentDashboard();

      case "F":
        return BlocProvider<EmployeeInfoCubit>(
          create: (_) =>
              EmployeeInfoCubit(EmployeeInfoRepository(EmployeeInfoApi())),
          child: BlocProvider<UserSchoolDetailCubit>(
            create: (_) => UserSchoolDetailCubit(
                UserSchoolDetailRepository(UserSchoolDetailApi())),
            child: BlocProvider<OnlineMeetingsCubit>(
              create: (_) => OnlineMeetingsCubit(
                  (OnlineMeetingsRepository(OnlineMeetingsApi()))),
              child: BlocProvider<StudentInfoCubit>(
                create: (_) =>
                    StudentInfoCubit(StudentInfoRepository(StudentInfoApi())),
                child: BlocProvider<UpdateEmailCubit>(
                  create: (_) =>
                      UpdateEmailCubit(UpdateEmailRepository(UpdateEmailApi())),
                  child: BlocProvider<GotoWebAppCubit>(
                    create: (_) =>
                        GotoWebAppCubit(GotoWebAppRepository(GotoWebAppApi())),
                    child: BlocProvider<UpdateEmailCubit>(
                      create: (_) => UpdateEmailCubit(
                          UpdateEmailRepository(UpdateEmailApi())),
                      child: BlocProvider<SelfAttendanceSettingCubit>(
                        create: (_) => SelfAttendanceSettingCubit(
                            (SelfAttendanceSettingRepository(
                                SelfAttendanceSettingApi()))),
                        child: BlocProvider<MeetingDetailsCubit>(
                          create: (_) => MeetingDetailsCubit(
                              (MeetingDetailsRepository(MeetingDetailsApi()))),
                          child: BlocProvider<MarkAttendanceCubit>(
                            create: (_) => MarkAttendanceCubit(
                                (MarkAttendanceRepository(
                                    MarkAttendanceApi()))),
                            child: DashboardStudent(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      // return DashboardStudent();

      ///
      default:
        return Container(
          color: Colors.white,
          child: Center(
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
          )),
        );
    }
  }

  String getNotificationIcon(String? smsType) {
    switch (smsType!.toLowerCase()) {
      case "homework":
        return AppImages.homeworkNotifyIcon;
      case "circular":
        return AppImages.bellIcon;
      case "activity":
        return AppImages.commonSmsIcon;
      case "classroom":
        return AppImages.classroomImage;
      default:
        return AppImages.bellIcon;
    }
  }
}
