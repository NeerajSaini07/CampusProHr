import 'dart:convert';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';

import 'package:campus_pro/src/DATA/MODELS/onlineMeetingsModel.dart';
import 'package:campus_pro/src/DATA/MODELS/studentInfoModel.dart';
import 'package:campus_pro/src/DATA/MODELS/userSchoolDetailModel.dart';
import 'package:campus_pro/src/DATA/MODELS/userTypeModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/PAGES/STAND_ALONE_PAGES/notifications.dart';
import 'package:campus_pro/src/UI/PAGES/STUDENT_MODULE/COMMUNICATION_STUDENT/circularStudent.dart';
import 'package:campus_pro/src/UI/PAGES/STUDENT_MODULE/COMMUNICATION_STUDENT/classRoomsStudent.dart';
import 'package:campus_pro/src/UI/PAGES/STUDENT_MODULE/COMMUNICATION_STUDENT/homeWorkStudent.dart';
import 'package:campus_pro/src/UI/PAGES/STUDENT_MODULE/EXAM_STUDENT/onlineTestStudent.dart';
import 'package:campus_pro/src/UI/PAGES/STUDENT_MODULE/MY_ACCOUNT_STUDENT/profileStudent.dart';
import 'package:campus_pro/src/UI/PAGES/STUDENT_MODULE/activityStudent.dart';
import 'package:campus_pro/src/UI/PAGES/STUDENT_MODULE/calendarStudent.dart';
import 'package:campus_pro/src/UI/PAGES/STUDENT_MODULE/feedbackStudent.dart';
import 'package:campus_pro/src/UI/PAGES/schoolBusLocation.dart';
import 'package:campus_pro/src/UI/WIDGETS/updateEmail.dart';
import 'package:campus_pro/src/UTILS/appImages.dart';
import 'package:campus_pro/src/UTILS/fieldValidators.dart';
import 'package:campus_pro/src/UTILS/joinMeeting.dart';
import 'package:campus_pro/src/globalBlocProvidersFile.dart';
import 'package:campus_pro/src/gotoWeb.dart';
import 'package:flutter/cupertino.dart';

import 'package:campus_pro/src/DATA/MODELS/dummyData.dart';
import 'package:campus_pro/src/UI/PAGES/STUDENT_MODULE/attendanceStudent.dart';
import 'package:campus_pro/src/UI/PAGES/STUDENT_MODULE/feePaymentStudent.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
// import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class DashboardStudent extends StatefulWidget {
  static const routeName = "/dashboard-student";

  const DashboardStudent({Key? key}) : super(key: key);
  @override
  _DashboardStudentState createState() => _DashboardStudentState();
}

class _DashboardStudentState extends State<DashboardStudent> {
  String? meetingIdOnTap;

  String? userEmail = '';

  bool showMarkAttButton = false;

  TextEditingController emailController = TextEditingController();

  String? appBarNameForWeb = "";

  UserTypeModel? userTypeData;

  _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000)).then((value) {
      getDashboardData();
      getUserSchoolData();
    });
  }

  // getLocationForGps() async {
  //   Location loc = Location();
  //   await loc.getLocation();
  // }

  void getUserTypeData() async {
    userTypeData = await UserUtils.userTypeFromCache();
  }

  @override
  void initState() {
    getDashboardData();
    getUserSchoolData();
    //Todo:For getting gps permission before map screen open.
    // getLocationForGps();
    getUserTypeData();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  getDashboardData() async {
    final uid = await UserUtils.idFromCache();
    final userToken = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final studentData = {
      "OUserId": uid!,
      "Token": userToken!,
      "OrgId": userData!.organizationId!,
      "Schoolid": userData.schoolId!,
      "StudentId": userData.stuEmpId!,
      "SessionId": userData.currentSessionid!,
      "UserType": userData.ouserType!,
    };
    context.read<StudentInfoCubit>().studentInfoCubitCall(studentData);
  }

  getUserSchoolData() async {
    final uid = await UserUtils.idFromCache();
    final userToken = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final schoolData = {
      "OUserId": uid!,
      "Token": userToken!,
      "OrgId": userData!.organizationId!,
      "OUserType": userData.ouserType!,
      "SchoolId": userData.schoolId!,
      "StuEmpId": userData.stuEmpId!,
    };
    context.read<UserSchoolDetailCubit>().userSchoolDetailCubitCall(schoolData);
  }

  getSelfAttData() async {
    final uid = await UserUtils.idFromCache();
    final userToken = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final stuInfo = await UserUtils.stuInfoDataFromCache();
    final attData = {
      "OUserId": uid!,
      "Token": userToken!,
      "OrgId": userData!.organizationId!,
      "Schoolid": userData.schoolId!,
      "ClassId": stuInfo!.classId,
    };
    context
        .read<SelfAttendanceSettingCubit>()
        .selfAttendanceSettingCubitCall(attData);
  }

  getMeetingData(StudentInfoModel? stuInfo) async {
    final uid = await UserUtils.idFromCache();
    final userToken = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final meetingData = {
      "OUserId": uid,
      "Token": userToken,
      "OrgId": userData!.organizationId!,
      "Schoolid": userData.schoolId!,
      "SessionId": userData.currentSessionid!,
      'Todate': DateFormat('dd-MMM-yyyy').format(DateTime.now()),
      'EmpId': '',
      'SubjectId': '',
      'NoRows': '50',
      'Counts': '0',
      'ClassId':
          '${stuInfo!.classId}#${stuInfo.streamId}#${stuInfo.classSectionId}#${stuInfo.yearId}', //'204#204#1445#1',
      "StudentId": userData.stuEmpId!,
      'LastId': ''
    };
    print('sending OnlineMeetings data => $meetingData');
    context.read<OnlineMeetingsCubit>().onlineMeetingsCubitCall(meetingData);
  }

  getMeetingDetails(OnlineMeetingsModel? data) async {
    setState(() {
      meetingIdOnTap = data!.meetingId;
    });
    final uid = await UserUtils.idFromCache();
    final userToken = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final stuInfo = await UserUtils.stuInfoDataFromCache();

    final meetingData = {
      "OUserId": uid,
      "Token": userToken,
      "OrgId": userData!.organizationId!,
      "Schoolid": userData.schoolId!,
      "SessionId": userData.currentSessionid!,
      'ClassId': stuInfo!.classId,
      'SectionId': stuInfo.classSectionId,
      'StreamId': stuInfo.streamId,
      'YearId': stuInfo.yearId,
      'MeetingId': meetingIdOnTap,
      "StuEmpId": userData.stuEmpId!,
      'UserType': userData.ouserType,
    };
    print('sending MeetingDetails data $meetingData');
    context.read<MeetingDetailsCubit>().meetingDetailsCubitCall(meetingData);
  }

  markMyAtt() async {
    final uid = await UserUtils.idFromCache();
    final userToken = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final stuInfo = await UserUtils.stuInfoDataFromCache();
    final markData = {
      "OUserId": uid,
      "Token": userToken,
      "OrgId": userData!.organizationId!,
      "Schoolid": userData.schoolId!,
      "SessionID": userData.currentSessionid,
      "StuEmpId": userData.stuEmpId,
      "ClassData":
          "${stuInfo!.classId}#${stuInfo.classSectionId}#${stuInfo.streamId}#${stuInfo.yearId}",
      "PeriodId": '0',
    };
    context.read<MarkAttendanceCubit>().markAttendanceCubitCall(markData);
  }

  // showEmailDialog() {
  //   showDialog(
  //     barrierDismissible: true,
  //     context: context,
  //     builder: (context) {
  //       return Material(child: UpdateEmail());
  //       // return AlertDialog(
  //       //   title: Text('Update Email'),
  //       //   content: buildTextField(),
  //       // );
  //     },
  //   );
  // }

  gotoWeb({String? url, String? name}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final ids = await UserUtils.stuInfoDataFromCache();

    final sendingData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "SessionId": userData.currentSessionid,
      "AppUrl": userData.appUrl,
      "PageUrl": url,
      "StuEmpId": userData.stuEmpId,
      //"UserName": userData.stuEmpName,
      "UserType": userData.ouserType,
      "Flag": "F",
      "PageName": name,
      //"ClassId": ids!.classId,
      //"SectionId": ids.classSectionId,
      //"StreamId": ids.streamId,
      //"YearId": ids.yearId,
      //"LogoImgPath": userData.logoImgPath,
    };

    print("Sending data for goto web $sendingData");

    context.read<GotoWebAppCubit>().gotoWebAppCubitCall(sendingData);
  }

  showEmailBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return UpdateEmail();
      },
    );
  }

  navigate(int? iD, {String? name}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    String? data = pref.getString("DrawerItemSave");
    List dataList = jsonDecode(data!);

    switch (iD) {
      case 1:
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
              return BlocProvider<HomeWorkStudentCubit>(
                create: (_) => HomeWorkStudentCubit(
                    HomeWorkStudentRepository(HomeWorkStudentApi())),
                child: HomeWorkStudent(),
              );
            }));

            // return Navigator.pushNamed(context, HomeWorkStudent.routeName);
          } else {
            print(url);
            appBarNameForWeb = "Homework";
            return gotoWeb(url: url, name: "Homework");
          }
          //return Navigator.pushNamed(context, HomeWorkStudent.routeName);
        }
      case 2:
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
              return BlocProvider<ClassRoomsStudentCubit>(
                create: (_) => ClassRoomsStudentCubit(
                    ClassRoomsStudentRepository(ClassRoomsStudentApi())),
                child: BlocProvider<ClassEndDrawerLocalCubit>(
                  create: (_) => ClassEndDrawerLocalCubit(),
                  child: BlocProvider<TeachersListCubit>(
                    create: (_) => TeachersListCubit(
                        TeachersListRepository(TeachersListApi())),
                    child: BlocProvider<SendCustomClassRoomCommentCubit>(
                      create: (_) => SendCustomClassRoomCommentCubit(
                          SendCustomClassRoomCommentRepository(
                              SendCustomClassRoomCommentApi())),
                      child: ClassRoomsStudent(),
                    ),
                  ),
                ),
              );
            }));
            // return Navigator.pushNamed(context, ClassRoomsStudent.routeName);
          } else {
            print(url);
            appBarNameForWeb = "Classrooms";
            return gotoWeb(url: url, name: "Classrooms");
          }
        }
      case 3:
        {
          var url = "";
          var flag = "";
          var type = name;
          dataList.forEach((element) {
            if (int.parse(element["id"]) == iD && type == element['type']) {
              url = element["url"];
              flag = element['flag'];
            }
          });

          if (flag.toLowerCase() == "f") {
            if (type == "m") {
              return Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                return BlocProvider<NotificationsCubit>(
                  create: (_) => NotificationsCubit(
                      NotificationsRepository(NotificationsApi())),
                  child: Notifications(),
                );
              }));
              // return Navigator.pushNamed(context, Notifications.routeName);
            } else {
              return Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                return BlocProvider<CircularStudentCubit>(
                  create: (_) => CircularStudentCubit(
                      CircularStudentRepository(CircularStudentApi())),
                  child: CircularStudent(),
                );
              }));
              // return Navigator.pushNamed(context, CircularStudent.routeName);
            }
          } else {
            print(url);
            appBarNameForWeb = type == "m" ? "Notifications" : "Circular";
            return gotoWeb(
                url: url, name: type == "m" ? "Notifications" : "Circular");
          }
        }
      case 4:
        {
          var url = "";
          var flag = "";
          var type = "m";
          dataList.forEach((element) {
            if (int.parse(element["id"]) == iD && type == element['type']) {
              url = element["url"];
              flag = element['flag'];
            }
          });
          if (flag.toLowerCase() == "f") {
            return Navigator.push(context,
                MaterialPageRoute(builder: (context) {
              return BlocProvider<FeeTransactionHistoryCubit>(
                create: (_) => FeeTransactionHistoryCubit(
                    FeeTransactionHistoryRepository(
                        FeeTransactionHistoryApi())),
                child: BlocProvider<FeeReceiptsCubit>(
                  create: (_) =>
                      FeeReceiptsCubit(FeeReceiptsRepository(FeeReceiptsApi())),
                  child: BlocProvider<StudentFeeFineCubit>(
                    create: (_) => StudentFeeFineCubit(
                        StudentFeeFineRepository(StudentFeeFineApi())),
                    child: BlocProvider<StudentFeeReceiptCubit>(
                      create: (_) => StudentFeeReceiptCubit(
                          StudentFeeReceiptRepository(StudentFeeReceiptApi())),
                      child: BlocProvider<FeeTypeCubit>(
                        create: (_) =>
                            FeeTypeCubit(FeeTypeRepository(FeeTypeApi())),
                        child: BlocProvider<FeeMonthsCubit>(
                          create: (_) => FeeMonthsCubit(
                              FeeMonthsRepository(FeeMonthsApi())),
                          child: BlocProvider<TermsConditionsSettingCubit>(
                            create: (_) => TermsConditionsSettingCubit(
                                TermsConditionsSettingRepository(
                                    TermsConditionsSettingApi())),
                            child: BlocProvider<FeeTypeSettingCubit>(
                              create: (_) => FeeTypeSettingCubit(
                                  FeeTypeSettingRepository(
                                      FeeTypeSettingApi())),
                              child: BlocProvider<StudentInfoCubit>(
                                create: (_) => StudentInfoCubit(
                                    StudentInfoRepository(StudentInfoApi())),
                                child: BlocProvider<PayUBizHashCubit>(
                                  create: (_) => PayUBizHashCubit(
                                      PayUBizHashRepository(PayUBizHashApi())),
                                  child: BlocProvider<GatewayTypeCubit>(
                                    create: (_) => GatewayTypeCubit(
                                        GatewayTypeRepository(
                                            GatewayTypeApi())),
                                    child: FeePaymentStudent(),
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
            // return Navigator.pushNamed(context, FeePaymentStudent.routeName);
          } else {
            print(url);
            appBarNameForWeb = "Fee Payment";
            return gotoWeb(url: url, name: "Fee Payment");
          }
        }
      case 6:
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
              return BlocProvider<OnlineTestStudentCubit>(
                create: (_) => OnlineTestStudentCubit(
                    OnlineTestStudentRepository(OnlineTestStudentApi())),
                child: OnlineTestStudent(),
              );
            }));
            // return Navigator.pushNamed(context, OnlineTestStudent.routeName);
          } else {
            appBarNameForWeb = "Online Test";
            print(url);
            return gotoWeb(url: url, name: "Online Test");
          }
        }
      case 13:
        {
          var url = "";
          var flag = "";
          var type = "m";
          dataList.forEach((element) {
            if (int.parse(element["id"]) == iD && type == element['type']) {
              url = element["url"];
              flag = element['flag'];
            }
          });
          if (flag.toLowerCase() == "f") {
            return Navigator.push(context,
                MaterialPageRoute(builder: (context) {
              return BlocProvider<LeaveRequestCubit>(
                create: (_) => LeaveRequestCubit(
                    LeaveRequestRepository(LeaveRequestApi())),
                child: BlocProvider<AttendanceGraphCubit>(
                  create: (_) => AttendanceGraphCubit(
                      AttendanceGraphRepository(AttendanceGraphApi())),
                  child: BlocProvider<ApplyForLeaveCubit>(
                    create: (_) => ApplyForLeaveCubit(
                        ApplyForLeaveRepository(ApplyForLeaveApi())),
                    child: AttendanceStudent(),
                  ),
                ),
              );
            }));
            // return Navigator.pushNamed(context, AttendanceStudent.routeName);
          } else {
            print(url);
            appBarNameForWeb = "Attendance";
            return gotoWeb(url: url, name: "Attendance");
          }
        }
      case 43:
        {
          var url = "";
          var flag = "";
          var type = "m";
          dataList.forEach((element) {
            if (int.parse(element["id"]) == iD && type == element['type']) {
              url = element["url"];
              flag = element['flag'];
            }
          });
          if (flag.toLowerCase() == "f") {
            return Navigator.push(context,
                MaterialPageRoute(builder: (context) {
              return BlocProvider<SchoolBusDetailCubit>(
                create: (_) => SchoolBusDetailCubit(
                    SchoolBusDetailRepository(SchoolBusDetailApi())),
                child: BlocProvider<SchoolBusRouteCubit>(
                    create: (_) => SchoolBusRouteCubit(
                        SchoolBusRouteRepository(SchoolBusRouteApi())),
                    child: BlocProvider<CheckBusAllotCubit>(
                      create: (_) => CheckBusAllotCubit(
                          CheckBusAllotRepository(CheckBusAllotApi())),
                      child: SchoolBusLocation(),
                    )),
              );
            }));

            //  Navigator.push(context, SchoolBusLocation.routeName){};
          } else {
            print(url);
            appBarNameForWeb = "Student Bus Location";
            return gotoWeb(url: url, name: "Student Bus Location");
          }
        }
      case 54:
        {
          var url = "";
          var flag = "";
          var type = "m";
          dataList.forEach((element) {
            if (int.parse(element["id"]) == iD && type == element['type']) {
              url = element["url"];
              flag = element['flag'];
            }
          });
          if (flag.toLowerCase() == "f") {
            return Navigator.push(context,
                MaterialPageRoute(builder: (context) {
              return BlocProvider<LeaveRequestCubit>(
                create: (_) => LeaveRequestCubit(
                    LeaveRequestRepository(LeaveRequestApi())),
                child: BlocProvider<AttendanceGraphCubit>(
                  create: (_) => AttendanceGraphCubit(
                      AttendanceGraphRepository(AttendanceGraphApi())),
                  child: BlocProvider<ApplyForLeaveCubit>(
                    create: (_) => ApplyForLeaveCubit(
                        ApplyForLeaveRepository(ApplyForLeaveApi())),
                    child: AttendanceStudent(),
                  ),
                ),
              );
            }));
            // return Navigator.pushNamed(context, AttendanceStudent.routeName);
          } else {
            print(url);
            appBarNameForWeb = "Attendance";
            return gotoWeb(url: url, name: "Attendance");
          }
        }
      case 80:
        {
          var url = "";
          var flag = "";
          var type = "s";
          dataList.forEach((element) {
            if (int.parse(element["id"]) == iD && type == element['type']) {
              print("Success $iD $type");
              url = element["url"];
              flag = element['flag'];
            }
          });
          print("flag $flag");
          if (flag.toLowerCase() == "f") {
            return Navigator.push(context,
                MaterialPageRoute(builder: (context) {
              return BlocProvider<ActivityForStudentCubit>(
                create: (_) => ActivityForStudentCubit(
                    ActivityForStudentRepository(ActivityForStudentApi())),
                child: ActivityStudent(),
              );
            }));
            // return Navigator.pushNamed(context, ActivityStudent.routeName);
            // return Navigator.pushNamed(context, SchoolBusLocation.routeName);
          } else {
            appBarNameForWeb = "Activity";
            return gotoWeb(url: url, name: "Activity");
          }
        }
      case 7:
        {
          var url = "";
          var flag = "";
          var type = "m";
          dataList.forEach((element) {
            if (int.parse(element["id"]) == iD && type == element['type']) {
              url = element["url"];
              flag = element['flag'];
            }
          });
          if (flag.toLowerCase() == "f") {
            return Navigator.push(context,
                MaterialPageRoute(builder: (context) {
              return BlocProvider<CalenderStudentCubit>(
                create: (_) => CalenderStudentCubit(
                    CalenderStudentRepository(CalenderStudentApi())),
                child: CalendarStudent(),
              );
            }));
            // return Navigator.pushNamed(context, CalendarStudent.routeName);
          } else {
            appBarNameForWeb = "Calendar";
            return gotoWeb(url: url, name: "Calendar");
          }
        }
      case 30:
        {
          var url = "";
          var flag = "";
          var type = "m";
          dataList.forEach((element) {
            if (int.parse(element["id"]) == iD && type == element['type']) {
              url = element["url"];
              flag = element['flag'];
            }
          });
          if (flag.toLowerCase() == "f") {
            
            return Navigator.pushNamed(context, FeedbackStudent.routeName);
          } else {
            appBarNameForWeb = "Feedback";
            return gotoWeb(url: url, name: "Feedback");
          }
        }
      default:
    }
  }

  bool _switchValue = false;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _onRefresh(),
      child: MultiBlocListener(
        listeners: [
          BlocListener<MarkAttendanceCubit, MarkAttendanceState>(
            listener: (context, state) {
              if (state is MarkAttendanceLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                }
              }
              if (state is MarkAttendanceLoadSuccess) {
                getDashboardData();
              }
            },
          ),
          BlocListener<MeetingDetailsCubit, MeetingDetailsState>(
            listener: (context, state) {
              if (state is MeetingDetailsLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                }
              }
              if (state is MeetingDetailsLoadSuccess) {
                JoinMeeting().checkPlatform(
                    meetingSubject: state.meetingDetailData.meetingSubject,
                    meetingId: meetingIdOnTap);
              }
            },
          ),
          BlocListener<SelfAttendanceSettingCubit, SelfAttendanceSettingState>(
            listener: (context, state) {
              if (state is SelfAttendanceSettingLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                }
              }
              if (state is SelfAttendanceSettingLoadSuccess) {
                setState(() => showMarkAttButton = state.status);
              }
            },
          ),
          BlocListener<UpdateEmailCubit, UpdateEmailState>(
            listener: (context, state) {
              if (state is UpdateEmailLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                }
              }
              if (state is UpdateEmailLoadSuccess) {
                getDashboardData();
              }
            },
          ),
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
            }
            if (state is GotoWebAppLoadFail) {
              print("401 error ha");
              if (state.failReason == "false") {
                UserUtils.unauthorizedUser(context);
              }
            }
          }),
        ],
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image:
                  AssetImage("assets/images/userTypePageBackgroundImage.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              BlocConsumer<StudentInfoCubit, StudentInfoState>(
                listener: (context, state) {
                  if (state is StudentInfoLoadFail) {
                    if (state.failReason == "false") {
                      UserUtils.unauthorizedUser(context);
                    }
                  }
                  if (state is StudentInfoLoadSuccess) {
                    getMeetingData(state.studentInfoData);
                    getSelfAttData();
                  }
                },
                builder: (context, state) {
                  if (state is StudentInfoLoadInProgress) {
                    return Container(
                      margin: EdgeInsets.only(
                          left: 20, right: 10, top: 20, bottom: 10),
                      padding: EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 0),
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.2,
                      ),
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
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Shimmer.fromColors(
                                  baseColor: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.3),
                                  highlightColor: Colors.black
                                      .withOpacity(0.6), // highlightColor:
                                  // Theme.of(context).primaryColor,
                                  child: Container(
                                    width: 100,
                                    height: 7,
                                    child: Container(),
                                    decoration: BoxDecoration(
                                        // shape: BoxShape.circle,
                                        color: Colors.white),
                                  ),
                                ),
                                Shimmer.fromColors(
                                  // baseColor: Colors.grey.withOpacity(0.4),
                                  // highlightColor: Colors.black,
                                  baseColor: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.3),
                                  highlightColor: Colors.black.withOpacity(0.6),
                                  child: Container(
                                    width: 100,
                                    height: 7,
                                    child: Container(),
                                    decoration: BoxDecoration(
                                        // shape: BoxShape.circle,
                                        color: Colors.white),
                                  ),
                                ),
                                // SizedBox(
                                //   width: 100,
                                //   child: LinearProgressIndicator(
                                //     backgroundColor: Colors.grey,
                                //     color: Colors.black.withOpacity(0.5),
                                //   ),
                                // ),
                                Shimmer.fromColors(
                                  baseColor: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.3),
                                  highlightColor: Colors.black.withOpacity(0.6),
                                  child: Container(
                                    width: 100,
                                    height: 7,
                                    child: Container(),
                                    decoration: BoxDecoration(
                                        // shape: BoxShape.circle,
                                        color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                            Shimmer.fromColors(
                              baseColor: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.3),
                              highlightColor: Colors.black.withOpacity(0.6),
                              child: Container(
                                width: 90,
                                height: 90,
                                child: Container(),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }
                  if (state is StudentInfoLoadSuccess) {
                    print("StudentInfoLoadSuccess");
                    return buildICardNew(context,
                        studentInfo: state.studentInfoData);
                  } else if (state is StudentInfoLoadFail) {
                    print("StudentInfoLoadFail");
                    return Container(
                      color: Theme.of(context).primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      height: MediaQuery.of(context).size.height / 3.5,
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 80.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(18.0),
                          child: Image.asset(AppImages.logo),
                        ),
                      ),
                    );
                  } else {
                    return LinearProgressIndicator();
                  }
                },
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Color(0xff045D98).withOpacity(0.03),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(children: [
                      buildStudentHomeCategorys(
                          title: "Academics",
                          quickList: studentCategoryListAcademics),
                      SizedBox(
                        height: 10,
                      ),
                      buildStudentHomeCategorys(
                          title: "Communication",
                          quickList: studentCategoryListCircular),
                      SizedBox(
                        height: 10,
                      ),
                      buildStudentHomeCategorys(
                          title: "Others",
                          quickList: studentCategoryListOthers),
                      Container(
                        margin: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width,
                              color: Colors.blue.withOpacity(0.06),
                              child: Center(
                                child: Text(
                                  "Upcoming Online Classes",
                                  // style: Theme.of(context)
                                  //     .textTheme
                                  //     .headline6!
                                  //     .copyWith(
                                  //         fontWeight: FontWeight.w600,
                                  //         fontSize: 16),
                                ),
                              ),
                            ),
                            BlocConsumer<OnlineMeetingsCubit,
                                OnlineMeetingsState>(
                              listener: (context, state) {
                                if (state is OnlineMeetingsLoadFail) {
                                  if (state.failReason == "false") {
                                    UserUtils.unauthorizedUser(context);
                                  }
                                }
                              },
                              builder: (context, state) {
                                if (state is OnlineMeetingsLoadInProgress) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                } else if (state is OnlineMeetingsLoadSuccess) {
                                  return buildTodayMeetings(context,
                                      onlineMeetingData:
                                          state.onlineMeetingData);
                                } else if (state is OnlineMeetingsLoadFail) {
                                  return Center(
                                    child: Column(
                                      children: [
                                        Image.asset(AppImages.noClassImage1,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                300),
                                        Text(
                                          "No Class Yet",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                } else {
                                  return Center(child: Text(NO_RECORD_FOUND));
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildICardNew(BuildContext context, {StudentInfoModel? studentInfo}) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 10, top: 20, bottom: 10),
      padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 0),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.2,
      ),
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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                        text: "Hi ",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                        children: [
                          TextSpan(
                            text:
                                "${studentInfo!.stName![0].toUpperCase()}${studentInfo.stName!.substring(1)}",
                            // textScaleFactor: 1.5,
                            // maxLines: 2,
                            // overflow: TextOverflow.visible,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          )
                        ]),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Class : ${studentInfo.compClass}",
                    textScaleFactor: 1.2,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Adm No : ${studentInfo.admNo}",
                    textScaleFactor: 1.2,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    studentInfo.mobile!,
                    textScaleFactor: 1.2,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  showMarkAttButton == true
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Mark Att",
                              textScaleFactor: 1.3,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                            (showMarkAttButton && studentInfo.attStatus == '_')
                                ? Transform.scale(
                                    scale: 0.6,
                                    child: CupertinoSwitch(
                                      value: _switchValue,
                                      trackColor: Colors.grey,
                                      onChanged: (value) {
                                        setState(() {
                                          _switchValue = value;
                                        });
                                        markMyAtt();
                                      },
                                    ),
                                  )
                                : Transform.scale(
                                    scale: 0.6,
                                    child: CupertinoSwitch(
                                      value: true,
                                      trackColor: Colors.green,
                                      onChanged: (value) {},
                                    ),
                                  )
                          ],
                        )
                      : Container(),
                ],
              ),
              Stack(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    // backgroundColor: Color(0xff8457e6),
                    // backgroundColor: Theme.of(context).primaryColor,
                    radius: 48,
                    child: CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 46,
                      backgroundImage: NetworkImage(studentInfo.imageUrl!),
                      onBackgroundImageError: (error, stackTrace) =>
                          AssetImage(AppImages.dummyImage),
                    ),
                  ),
                  Positioned(
                    right: 4,
                    bottom: 4,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 12,
                      child: CircleAvatar(
                        backgroundColor:
                            getAttendanceName(studentInfo.attStatus),
                        radius: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
    //   Stack(
    //   children: [
    //     Container(
    //       margin: EdgeInsets.only(left: 50, right: 10, top: 20, bottom: 10),
    //       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    //       constraints: BoxConstraints(
    //         maxHeight: MediaQuery.of(context).size.height * 0.2,
    //       ),
    //       decoration: BoxDecoration(
    //         color: Color(0xff8457e6).withOpacity(0.5),
    //         borderRadius: BorderRadius.circular(20),
    //         gradient: LinearGradient(
    //           begin: Alignment.centerLeft, end: Alignment.centerRight,
    //           colors: [
    //             Theme.of(context).primaryColor,
    //             Color(0xff5b86e5),
    //           ], //
    //         ),
    //         boxShadow: [
    //           BoxShadow(
    //             color: Colors.grey.withOpacity(0.5),
    //             spreadRadius: 5,
    //             blurRadius: 7,
    //             offset: Offset(0, 3),
    //           ),
    //         ],
    //       ),
    //       child: Container(
    //         padding:
    //             EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           mainAxisSize: MainAxisSize.min,
    //           children: [
    //             Text(
    //               "${studentInfo!.stName![0].toUpperCase()}${studentInfo.stName!.substring(1)}",
    //               textScaleFactor: 1.5,
    //               maxLines: 2,
    //               overflow: TextOverflow.visible,
    //               style: TextStyle(
    //                   fontSize: 14,
    //                   fontWeight: FontWeight.w500,
    //                   color: Colors.white),
    //             ),
    //             SizedBox(
    //               height: 2,
    //             ),
    //             Text(
    //               "Class : ${studentInfo.compClass}",
    //               textScaleFactor: 1.2,
    //               style: TextStyle(
    //                   fontSize: 14,
    //                   fontWeight: FontWeight.w500,
    //                   color: Colors.white),
    //             ),
    //             SizedBox(
    //               height: 2,
    //             ),
    //             Text(
    //               "Adm No : ${studentInfo.admNo}",
    //               textScaleFactor: 1.2,
    //               style: TextStyle(
    //                   fontSize: 14,
    //                   fontWeight: FontWeight.w500,
    //                   color: Colors.white),
    //             ),
    //             SizedBox(
    //               height: 2,
    //             ),
    //             Text(
    //               studentInfo.mobile!,
    //               textScaleFactor: 1.2,
    //               style: TextStyle(
    //                   fontSize: 14,
    //                   fontWeight: FontWeight.w500,
    //                   color: Colors.white),
    //             ),
    //             showMarkAttButton == true
    //                 ? Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                     children: [
    //                       Text(
    //                         "Mark Att",
    //                         textScaleFactor: 1.3,
    //                         style: TextStyle(
    //                             fontSize: 14,
    //                             fontWeight: FontWeight.w500,
    //                             color: Colors.white),
    //                       ),
    //                       (showMarkAttButton && studentInfo.attStatus == '_')
    //                           ? Transform.scale(
    //                               scale: 0.6,
    //                               child: CupertinoSwitch(
    //                                 value: _switchValue,
    //                                 trackColor: Colors.grey,
    //                                 onChanged: (value) {
    //                                   setState(() {
    //                                     _switchValue = value;
    //                                   });
    //                                   markMyAtt();
    //                                 },
    //                               ),
    //                             )
    //                           : Transform.scale(
    //                               scale: 0.6,
    //                               child: CupertinoSwitch(
    //                                 value: true,
    //                                 trackColor: Colors.green,
    //                                 onChanged: (value) {},
    //                               ),
    //                             )
    //                     ],
    //                   )
    //                 : Container(),
    //           ],
    //         ),
    //       ),
    //     ),
    //     Positioned(
    //       left: 5,
    //       top: 46,
    //       child: Stack(
    //         children: [
    //           CircleAvatar(
    //             backgroundColor: Colors.white,
    //             // backgroundColor: Color(0xff8457e6),
    //             // backgroundColor: Theme.of(context).primaryColor,
    //             radius: 48,
    //             child: CircleAvatar(
    //               backgroundColor: Colors.grey,
    //               radius: 46,
    //               backgroundImage: NetworkImage(studentInfo.imageUrl!),
    //               onBackgroundImageError: (error, stackTrace) =>
    //                   AssetImage(AppImages.dummyImage),
    //             ),
    //           ),
    //           Positioned(
    //             right: 4,
    //             bottom: 4,
    //             child: CircleAvatar(
    //               backgroundColor: Colors.white,
    //               radius: 12,
    //               child: CircleAvatar(
    //                 backgroundColor: getAttendanceName(studentInfo.attStatus),
    //                 radius: 10,
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ],
    // );
  }

  Container buildAnnouncements(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Announcements",
            // style: Theme.of(context).textTheme.headline5,
          ),
          SizedBox(height: 8.0),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(8.0),
              border: Border(
                left: BorderSide(width: 10, color: Colors.orange),
                right: BorderSide(width: 1, color: Colors.orange),
                top: BorderSide(width: 1, color: Colors.orange),
                bottom: BorderSide(width: 1, color: Colors.orange),
              ),
            ),
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
                        // textScaleFactor: 1.5,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: GoogleFonts.quicksand(
                          // fontSize: 12,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "June 9",
                      // textScaleFactor: 1.5,
                      style: GoogleFonts.quicksand(
                        color: Colors.grey,
                        // fontSize: 10,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Colors.grey,
                      size: 12,
                    ),
                    SizedBox(width: 10),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }

  InkWell buildEmailAlert(BuildContext context) {
    return InkWell(
      onTap: () => showEmailBottomSheet(),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.red),
          color: Colors.red[100],
        ),
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
                    "Your Email is not registered.",
                    textScaleFactor: 1.5,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(fontSize: 12, color: Colors.red),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Text(
                  "register now",
                  textScaleFactor: 1.5,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                      fontWeight: FontWeight.bold),
                ),
                // Icon(Icons.arrow_forward_ios_outlined,
                //     color: Colors.grey, size: 12),
                SizedBox(width: 10),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Column buildIdentityCard({StudentInfoModel? studentInfo}) {
    return Column(
      children: [
        Container(
          color: Theme.of(context).primaryColor,
          padding: const EdgeInsets.all(10),
          child: Stack(
            children: [
              Column(
                children: [
                  BlocConsumer<UserSchoolDetailCubit, UserSchoolDetailState>(
                    listener: (context, state) {
                      if (state is UserSchoolDetailLoadFail) {
                        if (state.failReason == "false") {
                          UserUtils.unauthorizedUser(context);
                        }
                      }
                    },
                    builder: (context, state) {
                      if (state is UserSchoolDetailLoadInProgress) {
                        return Text("");
                      } else if (state is UserSchoolDetailLoadSuccess) {
                        return buildLogoAndName(context,
                            schoolData: state.schoolData);
                      } else if (state is UserSchoolDetailLoadFail) {
                        return Text("");
                      } else {
                        return Text("");
                      }
                    },
                  ),
                  Container(
                    // height: 200,
                    // width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      // border:
                      //     Border.all(color: Theme.of(context).primaryColor, width: 10),
                      color: Colors.white,
                    ),
                    child: Stack(
                      children: [
                        Table(
                          // border: TableBorder.all(),
                          columnWidths: {
                            0: FlexColumnWidth(
                                MediaQuery.of(context).size.width / 3.5),
                            1: FlexColumnWidth(
                                MediaQuery.of(context).size.width / 2.5),
                            2: FlexColumnWidth(
                                MediaQuery.of(context).size.width / 3.5),
                          },
                          children: [
                            buildCardRows(
                                title: 'Adm No.', value: studentInfo!.admNo),
                            buildCardRows(
                                title: 'Name.', value: studentInfo.stName),
                            buildCardRows(
                                title: 'F / Name',
                                value: studentInfo.fatherName),
                            buildCardRows(
                                title: 'Class',
                                value:
                                    studentInfo.compClass!.split(" ").join()),
                            buildCardRows(
                                title: 'Phone', value: studentInfo.mobile),
                            buildCardRows(
                                title: 'Email Id', value: studentInfo.emailId),
                            // buildCardRows(
                            //   title: 'Today Att',
                            //   value: getAttendanceName(studentInfo.attStatus),
                            // ),
                          ],
                        ),
                        Positioned(
                          right: 0,
                          child: InkWell(
                            onTap: () => Navigator.pushNamed(
                                context, ProfileStudent.routeName),
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                Container(
                                  height: MediaQuery.of(context).size.width / 4,
                                  width: MediaQuery.of(context).size.width / 4,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey, width: 4),
                                    color: Colors.white,
                                    image: studentInfo.imageUrl != ""
                                        ? DecorationImage(
                                            image: NetworkImage(
                                                studentInfo.imageUrl!),
                                            onError: (exception, stackTrace) =>
                                                AssetImage(
                                                    AppImages.dummyImage),
                                            fit: BoxFit.cover)
                                        : DecorationImage(
                                            image: AssetImage(
                                                AppImages.dummyImage)),
                                  ),
                                ),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.width / 22,
                                  width: MediaQuery.of(context).size.width / 4,
                                  color: Colors.grey,
                                  child: FittedBox(
                                    child: Text(
                                      'Profile',
                                      style: GoogleFonts.quicksand(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (showMarkAttButton && studentInfo.attStatus == '_')
                Positioned(
                  right: 10,
                  bottom: 0,
                  child: TextButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xff2ab57d))),
                    onPressed: () {},
                    // onPressed: () => markMyAtt(),
                    child: Row(
                      children: [
                        Icon(Icons.check_box, color: Colors.white70),
                        SizedBox(width: 4),
                        Text('Mark', style: TextStyle(color: Colors.white70))
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
        // if (studentInfo.emailId == '' || studentInfo.emailId == null)
        //   buildEmailAlert(context),
      ],
    );
  }

  Container buildLogoAndName(BuildContext context,
      {UserSchoolDetailModel? schoolData}) {
    return Container(
      // width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 30.0,
            backgroundImage: NetworkImage(schoolData!.logoImgPath!),
          ),
          SizedBox(width: 10),
          Flexible(
            child: Text(
              schoolData.schoolName!,
              textScaleFactor: 1.5,
              textAlign: TextAlign.center,
              style: GoogleFonts.quicksand(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color? getAttendanceName(String? attName) {
    switch (attName!.toUpperCase()) {
      case 'Y':
        // return 'Present';
        return Colors.green[800];
      case 'N':
        // return 'Absent';
        return Colors.red;
      case 'L':
        return Color.fromRGBO(250, 196, 47, 1.0);
      default:
        return Colors.grey;
    }
  }

  Container buildTableRowText(
          {String? title,
          FontWeight? fontWeight,
          Color? color,
          AlignmentGeometry? alignment}) =>
      Container(
        color: color,
        padding: const EdgeInsets.all(4),
        child: Align(
          alignment: alignment!,
          child: Text(title!,
              textScaleFactor: 1.5,
              style: TextStyle(fontWeight: fontWeight ?? FontWeight.normal)),
        ),
      );

  TableRow buildCardRows({String? title, String? value}) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Text("$title : ",
              style: GoogleFonts.quicksand(color: Colors.black, fontSize: 16)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Text(
            value != "" && value != null ? "$value" : "",
            style: GoogleFonts.quicksand(
                fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black),
          ),
        ),
        Container(),
      ],
    );
  }

  Widget buildStudentHomeCategorys(
      {String? title, List<CategoryDummyModel>? quickList}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(left: 15, bottom: 5),
          child: Text(
            "$title",
            textScaleFactor: 1.2,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
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
            itemCount: quickList!.length,
            scrollDirection: Axis.horizontal,
            physics: ClampingScrollPhysics(),
            itemBuilder: (context, i) {
              var item = quickList[i];
              return userTypeData == null
                  ? Container()
                  : userTypeData!.ouserType!.toLowerCase() == "s" &&
                          item.title == "Fees"
                      ? Container()
                      : Container(
                          child: InkWell(
                            onTap: () {
                              if (userTypeData!.ouserType!.toLowerCase() ==
                                      "f" &&
                                  item.id == 13) {
                                navigate(54,
                                    name: item.title == "Notifications"
                                        ? "m"
                                        : item.title == "Circular"
                                            ? "s"
                                            : "");
                              } else {
                                navigate(item.id,
                                    name: item.title == "Notifications"
                                        ? "m"
                                        : item.title == "Circular"
                                            ? "s"
                                            : "");
                              }
                            },
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
                                      textScaleFactor: 0.7,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
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

  Container buildTodayMeetings(BuildContext context,
      {List<OnlineMeetingsModel>? onlineMeetingData}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      // height: MediaQuery.of(context).size.height * 0.3,
      child: ListView.separated(
        separatorBuilder: (BuildContext context, int index) => Divider(),
        shrinkWrap: true,
        itemCount: onlineMeetingData!.length,
        itemBuilder: (context, i) {
          var item = onlineMeetingData[i];
          return ListTile(
            title: Transform.translate(
              offset: Offset(-10, 0),
              child: Text(
                "${item.subjectName!.split('-')[1]} - ${item.subjectName!.split('-')[0]}",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            subtitle: Transform.translate(
              offset: Offset(-10, 0),
              child: Container(
                child: Text(
                  item.cirContent!.split('on: ')[1],
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Colors.grey, fontSize: 13),
                ),
              ),
            ),
            trailing: Transform.translate(
              offset: Offset(10, 0),
              child: InkWell(
                onTap: () => item.meetingLiveStatus!.toLowerCase() == 'y'
                    ? getMeetingDetails(item)
                    : null,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 4.0, horizontal: 16.0),
                  width: 100,
                  decoration: BoxDecoration(
                    color: item.meetingLiveStatus!.toLowerCase() == 'y'
                        ? Color(0xff6CC164).withOpacity(0.5)
                        : Color(0xffFF5545).withOpacity(0.5),
                    // color: Color(0xfff1f1f1),
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  child: Text(
                    item.meetingLiveStatus!.toLowerCase() == 'y'
                        ? "Join"
                        : "Ended",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.quicksand(
                        color: item.meetingLiveStatus!.toLowerCase() == 'y'
                            ? Colors.black
                            // ? Theme.of(context).primaryColor
                            : Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Container buildTextField() {
    return Container(
      child: TextFormField(
        // obscureText: !obscureText ? false : true,
        controller: emailController,
        validator: FieldValidators.emailValidator,
        keyboardType: TextInputType.emailAddress,
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
          hintText: "type here",
          hintStyle: TextStyle(color: Color(0xffA5A5A5)),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
        ),
      ),
    );
  }
}
