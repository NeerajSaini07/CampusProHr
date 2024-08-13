import 'dart:convert';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/dashboardAdminModel.dart';
import 'package:campus_pro/src/DATA/MODELS/studentInfoModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/PAGES/ADMIN_MODULE/COMMUNICATION_ADMIN/suggestionAdmin/suggestionAdmin.dart';
import 'package:campus_pro/src/UI/PAGES/ADMIN_MODULE/EXAM_ADMIN/Result_Announce_Admin/resultAnnounceAdmin.dart';
import 'package:campus_pro/src/UI/PAGES/ADMIN_MODULE/FEE_ADMIN/dayClosingAdmin.dart';
import 'package:campus_pro/src/UI/PAGES/ADMIN_MODULE/FEE_ADMIN/feeCollectionAdmin.dart';
import 'package:campus_pro/src/UI/PAGES/ADMIN_MODULE/STUDENT_ADMIN/admissionStatusAdmin.dart';
import 'package:campus_pro/src/UI/PAGES/ADMIN_MODULE/STUDENT_ADMIN/studentDetailAdmin.dart';
import 'package:campus_pro/src/UI/PAGES/STAND_ALONE_PAGES/MEETING/meetingStatus.dart';
import 'package:campus_pro/src/UI/PAGES/STAND_ALONE_PAGES/notifications.dart';
import 'package:campus_pro/src/UI/PAGES/STUDENT_MODULE/MY_ACCOUNT_STUDENT/profileStudent.dart';
import 'package:campus_pro/src/UI/WIDGETS/CHARTS/barPieCommonChart.dart';
import 'package:campus_pro/src/UI/WIDGETS/bottomNavigation.dart';
import 'package:campus_pro/src/UTILS/appImages.dart';
import 'package:campus_pro/src/gotoWeb.dart';
import 'package:campus_pro/src/DATA/MODELS/dummyData.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../globalBlocProvidersFile.dart';
// import 'package:location/location.dart';

class DashboardAdmin extends StatefulWidget {
  static const routeName = "/dashboard-admin";

  const DashboardAdmin({Key? key}) : super(key: key);
  @override
  _DashboardAdminState createState() => _DashboardAdminState();
}

class _DashboardAdminState extends State<DashboardAdmin> {
  String? currentUserType = "";

  List<CommonListGraph> attendanceList = [];

  DashboardAdminModel? dashboardData;

  String? appBarNameForWeb = "";

  gotoWeb({String? url, String? name}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final sendingData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "SessionId": userData.currentSessionid,
      "AppUrl": userData.appUrl,
      "PageUrl": url,
      "StuEmpId": userData.stuEmpId,
      "UserType": userData.ouserType,
      "Flag": "F",
      "PageName": name,
    };

    print("Sending data for goto web $sendingData");

    context.read<GotoWebAppCubit>().gotoWebAppCubitCall(sendingData);
  }

  navigate(int? iD) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    String? data = pref.getString("DrawerItemSave");
    List dataList = jsonDecode(data!);

    print("iD : $iD");
    switch (iD) {
      case 39:
        {
          var url = "";
          var flag = "";
          var type = "s";
          dataList.forEach((element) {
            if (int.parse(element["id"]) == iD && type == element['type']) {
              url = element["url"];
              flag = element['flag'];
            }
          });
          if (flag.toLowerCase() == "f") {
            return Navigator.push(context,
                MaterialPageRoute(builder: (context) {
              return BlocProvider<AdmissionStatusCubit>(
                create: (_) => AdmissionStatusCubit(
                    AdmissionStatusRepository(AdmissionStatusApi())),
                child: BlocProvider<YearSessionCubit>(
                  create: (_) =>
                      YearSessionCubit(YearSessionRepository(YearSessionApi())),
                  child: AdmissionStatusAdmin(),
                ),
              );
            }));
            // return Navigator.pushNamed(context, AdmissionStatusAdmin.routeName);
          } else {
            print(url);
            appBarNameForWeb = "Admission Status";
            return gotoWeb(url: url, name: "Admission Status");
          }
        }
      case 47:
        {
          var url = "";
          var flag = "";
          var type = "s";
          dataList.forEach((element) {
            if (int.parse(element["id"]) == iD && type == element['type']) {
              url = element["url"];
              flag = element['flag'];
            }
          });
          if (flag.toLowerCase() == "f") {
            return Navigator.push(context,
                MaterialPageRoute(builder: (context) {
              return BlocProvider<DayClosingDataCubit>(
                create: (_) => DayClosingDataCubit(
                    DayClosingDataRepository(DayClosingDataApi())),
                child: DayClosingAdmin(),
              );
            }));
            // return Navigator.pushNamed(context, DayClosingAdmin.routeName);
          } else {
            print(url);
            appBarNameForWeb = "Day Closing";
            return gotoWeb(url: url, name: "Day Closing");
          }
        }
      case 25:
        {
          var url = "";
          var flag = "";
          var type = "s";
          dataList.forEach((element) {
            if (int.parse(element["id"]) == iD && type == element['type']) {
              url = element["url"];
              flag = element['flag'];
            }
          });
          if (flag.toLowerCase() == "f") {
            return Navigator.push(context,
                MaterialPageRoute(builder: (context) {
              return BlocProvider<NotificationsCubit>(
                create: (_) => NotificationsCubit(
                    NotificationsRepository(NotificationsApi())),
                child: Notifications(),
              );
            }));
            // return Navigator.pushNamed(context, Notifications.routeName);
            // return Navigator.pushNamed(context, SchoolBusList.routeName);
          } else {
            print(url);
            appBarNameForWeb = "Notification";
            return gotoWeb(url: url, name: "Notification");
          }
        }
      case 70:
        {
          var url = "";
          var flag = "";
          var type = "s";
          dataList.forEach((element) {
            if (int.parse(element["id"]) == iD && type == element['type']) {
              url = element["url"];
              flag = element['flag'];
            }
          });
          if (flag.toLowerCase() == "f") {
            return Navigator.push(context,
                MaterialPageRoute(builder: (context) {
              return BlocProvider<GetComplainSuggestionListAdminCubit>(
                create: (_) => GetComplainSuggestionListAdminCubit(
                    GetComplainSuggestionListAdminRepository(
                        GetComplainSuggestionListAdminApi())),
                child: BlocProvider<InactiveCompOrSuggCubit>(
                  create: (_) => InactiveCompOrSuggCubit(
                      InactiveCompOrSuggRepository(InactiveCompOrSuggApi())),
                  child: BlocProvider<ReplyComplainSuggestionAdminCubit>(
                    create: (_) => ReplyComplainSuggestionAdminCubit(
                        ReplyComplainSuggestionAdminRepository(
                            ReplyComplainSuggestionAdminApi())),
                    child: SuggestionAdmin(),
                  ),
                ),
              );
            }));
            // return Navigator.pushNamed(context, SuggestionAdmin.routeName);
          } else {
            print(url);
            appBarNameForWeb = "Suggestion";
            return gotoWeb(url: url, name: "Suggestion");
          }
        }
      case 68:
        {
          var url = "";
          var flag = "";
          var type = "s";
          dataList.forEach((element) {
            if (int.parse(element["id"]) == iD && type == element['type']) {
              url = element["url"];
              flag = element['flag'];
            }
          });
          if (flag.toLowerCase() == "f") {
            return Navigator.pushNamed(context, BottomNavigation.routeName);
          } else {
            print(url);
            appBarNameForWeb = "Enquiry Management";
            return gotoWeb(url: url, name: "Enquiry Management");
          }
        }
      case 34:
        {
          var url = "";
          var flag = "";
          var type = "s";
          dataList.forEach((element) {
            if (int.parse(element["id"]) == iD && type == element['type']) {
              url = element["url"];
              flag = element['flag'];
            }
          });
          if (flag.toLowerCase() == "f") {
            return Navigator.push(context,
                MaterialPageRoute(builder: (context) {
              return BlocProvider<YearSessionCubit>(
                create: (_) =>
                    YearSessionCubit(YearSessionRepository(YearSessionApi())),
                child: BlocProvider<ExamMarksChartCubit>(
                  create: (_) => ExamMarksChartCubit(
                      ExamMarksChartRepository(ExamMarksChartApi())),
                  child: BlocProvider<ExamMarksCubit>(
                    create: (_) =>
                        ExamMarksCubit(ExamMarksRepository(ExamMarksApi())),
                    child: BlocProvider<AttendanceGraphCubit>(
                      create: (_) => AttendanceGraphCubit(
                          AttendanceGraphRepository(AttendanceGraphApi())),
                      child: BlocProvider<GetStudentAmountCubit>(
                        create: (_) => GetStudentAmountCubit(
                            GetStudentMonthlyAmountRepository(
                                GetStudentMonthlyAmountApi())),
                        child: BlocProvider<FeeMonthsCubit>(
                          create: (_) => FeeMonthsCubit(
                              FeeMonthsRepository(FeeMonthsApi())),
                          child: BlocProvider<ExamSelectedListCubit>(
                            create: (_) => ExamSelectedListCubit(
                                ExamSelectedListRepository(
                                    ExamSelectedListApi())),
                            child: BlocProvider<StudentRemarkListCubit>(
                              create: (_) => StudentRemarkListCubit(
                                  StudentRemarkListRepository(
                                      StudentRemarkListApi())),
                              child: BlocProvider<FeeReceiptsCubit>(
                                create: (_) => FeeReceiptsCubit(
                                    FeeReceiptsRepository(FeeReceiptsApi())),
                                child: BlocProvider<FeeTypeCubit>(
                                  create: (_) => FeeTypeCubit(
                                      FeeTypeRepository(FeeTypeApi())),
                                  child: BlocProvider<ProfileStudentCubit>(
                                    create: (_) => ProfileStudentCubit(
                                        ProfileStudentRepository(
                                            ProfileStudentApi())),
                                    child: StudentDetailsAdmin(),
                                  ),
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
            }));
            // return Navigator.pushNamed(context, StudentDetailsAdmin.routeName);
          } else {
            print(url);
            appBarNameForWeb = "Student Details";
            return gotoWeb(url: url, name: "Student Details");
          }
        }
      case 24:
        {
          var url = "";
          var flag = "";
          var type = "s";
          dataList.forEach((element) {
            if (int.parse(element["id"]) == iD && type == element['type']) {
              url = element["url"];
              flag = element['flag'];
            }
          });
          if (flag.toLowerCase() == "f") {
            return Navigator.push(context,
                MaterialPageRoute(builder: (context) {
              return BlocProvider<GetExamResultPublishCubit>(
                create: (_) => GetExamResultPublishCubit(
                    GetExamResultPublishRepository(GetExamResultPublishApi())),
                child: BlocProvider<GetStudentListResultAnnounceCubit>(
                  create: (_) => GetStudentListResultAnnounceCubit(
                      GetStudentListResultAnnounceRepository(
                          GetStudentListResultAnnounceApi())),
                  child: BlocProvider<ResultAnnounceExamCubit>(
                    create: (_) => ResultAnnounceExamCubit(
                        ResultAnnounceExamRepository(ResultAnnounceExamApi())),
                    child: BlocProvider<ResultAnnounceClassCubit>(
                      create: (_) => ResultAnnounceClassCubit(
                          ResultAnnounceClassRepository(
                              ResultAnnounceClassApi())),
                      child: BlocProvider<YearSessionCubit>(
                        create: (_) => YearSessionCubit(
                            YearSessionRepository(YearSessionApi())),
                        child: BlocProvider<PublishResultAdminCubit>(
                          create: (_) => PublishResultAdminCubit(
                              PublishResultAdminRepository(
                                  PublishResultAdminApi())),
                          child: ResultAnnounce(),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }));
            // return Navigator.pushNamed(context, ResultAnnounce.routeName);
          } else {
            print(url);
            appBarNameForWeb = "Result Announce";
            return gotoWeb(url: url, name: "Result Announce");
          }
        }
      case 48:
        {
          var url = "";
          var flag = "";
          var type = "s";
          dataList.forEach((element) {
            if (int.parse(element["id"]) == iD && type == element['type']) {
              url = element["url"];
              flag = element['flag'];
            }
          });
          if (flag.toLowerCase() == "f") {
            return Navigator.push(context,
                MaterialPageRoute(builder: (context) {
              return BlocProvider<FillPeriodAttendanceCubit>(
                create: (_) => FillPeriodAttendanceCubit(
                    FillPeriodAttendanceRepository(FillPeriodAttendanceApi())),
                child: BlocProvider<MarkAttendanceSaveAttendanceEmployeeCubit>(
                  create: (_) => MarkAttendanceSaveAttendanceEmployeeCubit(
                      MarkAttendanceSaveAttendanceEmployeeRepository(
                          MarkAttendanceSaveAttendanceEmployeeApi())),
                  child: BlocProvider<MarkAttendancePeriodsEmployeeCubit>(
                    create: (_) => MarkAttendancePeriodsEmployeeCubit(
                        MarkAttendancePeriodsEmployeeRepository(
                            MarkAttendancePeriodsEmployeeApi())),
                    child: BlocProvider<MeetingRecipientListAdminCubit>(
                      create: (_) => MeetingRecipientListAdminCubit(
                          MeetingRecipientListAdminRepository(
                              MeetingRecipientListAdminApi())),
                      child: BlocProvider<ResultAnnounceClassCubit>(
                        create: (_) => ResultAnnounceClassCubit(
                            ResultAnnounceClassRepository(
                                ResultAnnounceClassApi())),
                        child: BlocProvider<MeetingDetailsAdminCubit>(
                          create: (_) => MeetingDetailsAdminCubit(
                              (MeetingDetailsAdminRepository(
                                  MeetingDetailsAdminApi()))),
                          child: BlocProvider<WeekPlanSubjectListCubit>(
                            create: (_) => WeekPlanSubjectListCubit(
                                WeekPlanSubjectListRepository(
                                    WeekPlanSubjectListApi())),
                            child: BlocProvider<TeachersListCubit>(
                              create: (_) => TeachersListCubit(
                                  TeachersListRepository(TeachersListApi())),
                              child: MeetingStatus(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }));
            // return Navigator.pushNamed(context, MeetingStatus.routeName);
          } else {
            print(url);
            appBarNameForWeb = "Meeting Status";
            return gotoWeb(url: url, name: "Meeting Status");
          }
        }
      default:
    }
  }

  // getLocationForGps() async {
  //   Location loc = Location();
  //   await loc.getLocation();
  // }

  @override
  void initState() {
    dashboardData = DashboardAdminModel(
      feeCollection: '0',
      adminName: '0',
      payment: '0',
      sessionID: -1,
      totalStudent: '0',
      presentStudent: '0',
      schoolName: '0',
      absentStudent: '0',
      leaveStudent: '0',
    );
    getData();
    getFeeCollectionData();
    //
    // getLocationForGps();
    super.initState();
  }

  getData() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    setState(() {
      currentUserType = userData!.ouserType;
    });
    final data = {
      'OUserId': uid,
      'Token': token,
      'OrgId': userData!.organizationId,
      'Schoolid': userData.schoolId,
      'SessionId': userData.currentSessionid,
      'EmpId': userData.stuEmpId,
      'UserType': userData.ouserType,
      'Date': DateFormat("dd-MMM-yyyy").format(DateTime.now()),
    };
    print("Sending DashboardAdmin Data => $data");
    context.read<DashboardAdminCubit>().dashboardAdminCubitCall(data);
  }

  getFeeCollectionData() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final collectionData = {
      'OUserId': uid,
      'Token': token,
      'OrgId': userData!.organizationId,
      'Schoolid': userData.schoolId,
      'SessionID': userData.currentSessionid,
      'EmpId': userData.stuEmpId,
      'UserType': userData.ouserType,
      'FromDate': DateFormat("dd-MMM-yyyy").format(DateTime.now()),
      'TillDate': DateFormat("dd-MMM-yyyy").format(DateTime.now()),
    };
    print("Sending MainAndPayModeWiseFee data => $collectionData");

    context.read<PayModeWiseFeeCubit>().payModeWiseFeeCubitCall(collectionData);
  }

  createGraphList() {
    attendanceList.add(
      CommonListGraph(
        iD: 1,
        title: " ",
        value: double.parse(dashboardData!.presentStudent!),
        // color: Color(0xffF79566),
        color: Colors.green[800],
      ),
    );
    attendanceList.add(
      CommonListGraph(
        iD: 1,
        title: "   ",
        value: double.parse(dashboardData!.leaveStudent!),
        // color: Color(0xff88D4EE),
        color: Color.fromRGBO(250, 196, 47, 1.0),
      ),
    );
    attendanceList.add(
      CommonListGraph(
        iD: 1,
        title: "  ",
        value: double.parse(dashboardData!.absentStudent!),
        // color: Color(0xff88D4EE),
        color: Colors.red[300],
      ),
    );
  }

  String? totalCollection = "";

  _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000)).then((value) {
      getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<DashboardAdminCubit, DashboardAdminState>(
          listener: (context, state) {
            if (state is DashboardAdminLoadSuccess) {
              setState(() => dashboardData = state.dashboardData);
              createGraphList();
            }
          },
        ),
        BlocListener<PayModeWiseFeeCubit, PayModeWiseFeeState>(
            listener: (context, state) {
          if (state is PayModeWiseFeeLoadSuccess) {
            totalCollection = state.payModeWiseFeeList.total;
          }
        }),
        BlocListener<GotoWebAppCubit, GotoWebAppState>(
            listener: (context, state) {
          if (state is GotoWebAppLoadSuccess) {
            print("Success");
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return GoToWeb(
                    url: state.url.split(",,")[0],
                    appBarName: state.url.split(",,")[1],
                  );
                },
              ),
            );
            //buildGotoSite(context, state.url);
          }
          if (state is GotoWebAppLoadFail) {
            if (state.failReason == "false") {
              UserUtils.unauthorizedUser(context);
            }
          }
        }),
      ],
      child: RefreshIndicator(
        onRefresh: () => _onRefresh(),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              image: DecorationImage(
                image:
                    AssetImage("assets/images/userTypePageBackgroundImage.png"),
              ),
            ),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.height,
                  height: MediaQuery.of(context).size.height * 0.3,
                  margin:
                      EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(13),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(
                            left: 50, right: 50, bottom: 0, top: 5),
                        child: Center(
                          child: Text(
                            "Today's Status ",
                            textScaleFactor: 1.3,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BlocBuilder<DashboardAdminCubit, DashboardAdminState>(
                            builder: (context, state) {
                              if (state is DashboardAdminLoadSuccess) {
                                return Expanded(
                                  child: Container(
                                    child: BarPieCommonChart(
                                      height:
                                          MediaQuery.of(context).size.width /
                                              3.0,
                                      subjectName: "",
                                      chartType: 'bar chart dashboard',
                                      commonDataList: attendanceList,
                                    ),
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            },
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: Text(
                                    "Total Strength : ${dashboardData!.totalStudent}",
                                    textScaleFactor: 1.3,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                SizedBox(),
                                Row(
                                  children: [
                                    Container(
                                      height: 16.0,
                                      width: 16.0,
                                      margin:
                                          const EdgeInsets.only(right: 10.0),
                                      color: Colors.green[800],
                                    ),
                                    Text(
                                      "Present : ${dashboardData!.presentStudent}",
                                      textScaleFactor: 1.2,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 16.0,
                                        width: 16.0,
                                        margin:
                                            const EdgeInsets.only(right: 10.0),
                                        color:
                                            Color.fromRGBO(250, 196, 47, 1.0),
                                      ),
                                      Text(
                                        "Leave : ${dashboardData!.leaveStudent}",
                                        textScaleFactor: 1.2,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 16.0,
                                      width: 16.0,
                                      margin:
                                          const EdgeInsets.only(right: 10.0),
                                      color: Colors.red[300],
                                    ),
                                    Text(
                                      "Absent : ${dashboardData!.absentStudent}",
                                      textScaleFactor: 1.2,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                currentUserType!.toLowerCase() == "a"
                    ? Row(
                        children: [
                          SizedBox(width: 20.0),
                          buildCollections(
                              title: "Collections",
                              color: Colors.green,
                              amount: totalCollection,
                              onTap: navigateToCollection),
                          SizedBox(width: 20.0),
                          buildCollections(
                              title: "Payments",
                              color: Colors.red,
                              amount: dashboardData!.payment,
                              onTap: navigateToPayment),
                          SizedBox(width: 20.0),
                        ],
                      )
                    : Container(),
                SizedBox(
                  height: 10,
                ),
                buildAdminCategorys(
                    title: "Academics", guessList: adminCategoryListAcademics),
                SizedBox(
                  height: 10,
                ),
                buildAdminCategorys(
                    title: "Circulars", guessList: adminCategoryListCircular),
              ],
            ),
          ),
        ),
      ),
    );
  }

  navigateToPayment() {
    print("payment");
   
    // Navigator.pushNamed(context, FeeCollectionAdmin.routeName);
  }

  navigateToCollection() {
    print("collection");
   return Navigator.push(context, MaterialPageRoute(builder: (context) {
      return BlocProvider<MainModeWiseFeeCubit>(
        create: (_) => MainModeWiseFeeCubit(
            MainModeWiseFeeRepository(MainModeWiseFeeApi())),
        child: BlocProvider<PayModeWiseFeeCubit>(
          create: (_) => PayModeWiseFeeCubit(
              PayModeWiseFeeRepository(PayModeWiseFeeApi())),
          child: BlocProvider<YearSessionCubit>(
            create: (_) =>
                YearSessionCubit(YearSessionRepository(YearSessionApi())),
            child: FeeCollectionAdmin(),
          ),
        ),
      );
    }));
    // Navigator.pushNamed(context, FeeCollectionAdmin.routeName);
  }

  Widget buildCollections(
      {String? title, Color? color, String? amount, VoidCallback? onTap}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 5.0,
              ),
            ],
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(radius: 8.0, backgroundColor: color),
                  SizedBox(width: 10.0),
                  Text(
                    title!,
                    textScaleFactor: 1.2,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Text(
                "$RUPEES ${amount == null || amount == "" ? "0" : amount}",
                textScaleFactor: 1.5,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildAnnouncements(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Announcements",
            style: Theme.of(context).textTheme.titleSmall,
          ),
          SizedBox(height: 8.0),
          Container(
            padding: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.orange,
              border: Border.all(color: Colors.orange),
            ),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 10),
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Tomorrow is holiday",
                          textScaleFactor: 1.5,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(fontSize: 12, color: Colors.orange),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "June 9",
                        textScaleFactor: 1.5,
                        style: TextStyle(color: Colors.grey, fontSize: 10),
                      ),
                      Icon(Icons.arrow_forward_ios_outlined,
                          color: Colors.grey, size: 12),
                      SizedBox(width: 10),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }

  Container buildIdentityCard({StudentInfoModel? studentInfo}) {
    return Container(
      color: Theme.of(context).primaryColor,
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Stack(
        children: [
          ListTile(
            title: RichText(
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                text: "Hi ",
                style: TextStyle(color: Colors.white, fontSize: 30),
                children: <TextSpan>[
                  TextSpan(
                    text: studentInfo!.stName,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                    // recognizer: TapGestureRecognizer()..onTap = () {},
                  ),
                ],
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: "Class " + studentInfo.compClass!.split(" ").join(),
                    style: TextStyle(color: Color(0xffFFFFFF), fontSize: 18),
                    children: <TextSpan>[
                      TextSpan(
                        text: " | ",
                        style:
                            TextStyle(color: Color(0xffFFFFFF), fontSize: 18),
                        children: <TextSpan>[
                          TextSpan(
                            text: "Adm no: " + studentInfo.admNo!,
                            style: TextStyle(
                                color: Color(0xffFFFFFF), fontSize: 18),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  child: RichText(
                    text: TextSpan(
                      text: "Today's Attendance: ",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor, fontSize: 18),
                      children: <TextSpan>[
                        TextSpan(
                          text: studentInfo.attStatus!.toUpperCase() == "A"
                              ? "Absent"
                              : studentInfo.attStatus!.toUpperCase() == "P"
                                  ? "Present"
                                  : "Not Marked",
                          style: TextStyle(
                            color: studentInfo.attStatus!.toUpperCase() == "A"
                                ? Colors.red
                                : studentInfo.attStatus!.toUpperCase() == "P"
                                    ? Colors.green
                                    : Colors.black,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 16.0,
            top: 12.0,
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return BlocProvider<ProfileStudentCubit>(
                    create: (_) => ProfileStudentCubit(
                        ProfileStudentRepository(ProfileStudentApi())),
                    child: ProfileStudent(),
                  );
                }));
                // Navigator.pushNamed(context, ProfileStudent.routeName);
              },
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 38,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 36,
                  backgroundImage: AssetImage(AppImages.dummyImage),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildAdminCategorys(
      {String? title, List<CategoryDummyModel>? guessList}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(left: 15, bottom: 5),
          child: Text(
            "$title",
            style: GoogleFonts.quicksand(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.18,
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: ListView.separated(
            separatorBuilder: (context, index) {
              return SizedBox(width: 10);
            },
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: guessList!.length,
            itemBuilder: (context, i) {
              var item = guessList[i];
              return InkWell(
                onTap: () => navigate(item.id),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 5,
                          spreadRadius: 1,
                          color: Color(0xff045D98).withOpacity(0.1),
                          offset: Offset(0, 10),
                        )
                      ],
                      color: Colors.white),
                  height: 100,
                  width: 125,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          item.image!,
                          height: 50,
                          width: 50,
                        ),
                        SizedBox(height: 8),
                        Text(
                          item.title!,
                          textScaleFactor: 1,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Container buildTodayMeetings(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Today's Meetings",
              style: Theme.of(context).textTheme.titleSmall),
          SizedBox(height: 10),
          ListView.separated(
            separatorBuilder: (BuildContext context, int index) =>
                SizedBox(height: 10),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: studentCategoryListAcademics.length,
            itemBuilder: (context, i) {
              // var item = studentCategoryListAcademics[i];
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffE1E3E8)),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Stack(
                  children: [
                    ListTile(
                      title: Text("${i + 1}. Teacher",
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Subject",
                            style: TextStyle(fontSize: 12.0),
                          ),
                          Text(
                            "Meeting Details",
                            style: TextStyle(fontSize: 12.0),
                          ),
                        ],
                      ),
                      trailing: Icon(
                        Icons.videocam,
                        color: Theme.of(context).primaryColor,
                        size: 32,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
