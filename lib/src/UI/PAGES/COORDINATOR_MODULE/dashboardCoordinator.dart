import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:campus_pro/src/DATA/MODELS/employeeInfoModel.dart';
import 'package:campus_pro/src/DATA/MODELS/userTypeModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/PAGES/ADMIN_MODULE/EMPLOYEE_ADMIN/teacherAssignAdmin.dart';
import 'package:campus_pro/src/UI/PAGES/ADMIN_MODULE/EXAM_ADMIN/Exam_Marks/examMarksAdmin.dart';
import 'package:campus_pro/src/UI/PAGES/ADMIN_MODULE/HOMEWORK_ADMIN/HomeWork_Status_Admin/homeWorkStatusAdmin.dart';
import 'package:campus_pro/src/UI/PAGES/ADMIN_MODULE/STUDENT_ADMIN/studentRemarkAdmin.dart';
import 'package:campus_pro/src/UI/PAGES/EMPLOYEE_MODULE/ATTENDANCE_EMPLOYEE/attendanceEmployee.dart';
import 'package:campus_pro/src/UI/PAGES/EMPLOYEE_MODULE/ATTENDANCE_EMPLOYEE/markAttendanceEmployee.dart';
import 'package:campus_pro/src/UI/PAGES/EMPLOYEE_MODULE/COMMUNICATION_EMPLOYEE/CIRCULAR_EMPLOYEE/circularEmployee.dart';
import 'package:campus_pro/src/UI/PAGES/EMPLOYEE_MODULE/COMMUNICATION_EMPLOYEE/CLASS_ROOM_EMPLOYEE/classroomEmployee.dart';
import 'package:campus_pro/src/UI/PAGES/EMPLOYEE_MODULE/COMMUNICATION_EMPLOYEE/CLASS_ROOM_EMPLOYEE/homeworkEmployee.dart';
import 'package:campus_pro/src/UI/PAGES/EMPLOYEE_MODULE/WEEK_PLAN_EMPLOYEE/updatePlanEmployee.dart';
import 'package:campus_pro/src/UI/PAGES/STAND_ALONE_PAGES/MEETING/meetingStatus.dart';
import 'package:campus_pro/src/UI/PAGES/STAND_ALONE_PAGES/activity.dart';
import 'package:campus_pro/src/UI/PAGES/STAND_ALONE_PAGES/notifications.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonSnackbar.dart';
import 'package:campus_pro/src/UI/WIDGETS/updateEmail.dart';
import 'package:campus_pro/src/UTILS/appImages.dart';
import 'package:campus_pro/src/UTILS/fieldValidators.dart';
import 'package:campus_pro/src/UTILS/joinMeeting.dart';
import 'package:campus_pro/src/gotoWeb.dart';
import 'package:campus_pro/src/DATA/MODELS/dummyData.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../../globalBlocProvidersFile.dart';

class DashboardCoordinator extends StatefulWidget {
  static const routeName = "/dashboard-coordinator";

  const DashboardCoordinator({Key? key}) : super(key: key);
  @override
  _DashboardCoordinatorState createState() => _DashboardCoordinatorState();
}

class _DashboardCoordinatorState extends State<DashboardCoordinator> {
  String? meetingIdOnTap;

  String? userEmail = '';

  bool showMarkAttButton = false;

  TextEditingController emailController = TextEditingController();

  String? uid = '';
  String? token = '';
  UserTypeModel? userData;
  String? userImageUrl = "";
  String? baseApiUrl;
  File? _pickedImage;

  EmployeeInfoModel? employeeInfoData;

  String? appBarNameForWeb = "";

  @override
  void initState() {
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
    setDataFromCache();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  setDataFromCache() async {
    uid = await UserUtils.idFromCache();
    token = await UserUtils.userTokenFromCache();
    userData = await UserUtils.userTypeFromCache();
    getDashboardData();
  }

  getDashboardData() async {
    final employeeData = {
      "OUserId": uid!,
      "Token": token!,
      "OrgId": userData!.organizationId!,
      "Schoolid": userData!.schoolId!,
      "EmpId": userData!.stuEmpId!,
      "SessionId": userData!.currentSessionid!,
      "SearchEmpId": userData!.stuEmpId!,
      "UserType": userData!.ouserType!,
    };
    print('Sending Employee Info Data $employeeData');
    context.read<EmployeeInfoCubit>().employeeInfoCubitCall(employeeData);
  }

  showEmailBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return UpdateEmail();
      },
    );
  }

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

    switch (iD) {
      case 8:
        return Navigator.push(context, MaterialPageRoute(builder: (context) {
          return BlocProvider<ClassroomEmployeeCubit>(
            create: (_) => ClassroomEmployeeCubit(
                ClassroomEmployeeRepository(ClassroomEmployeeApi())),
            child: BlocProvider<EmployeeInfoForSearchCubit>(
              create: (_) => EmployeeInfoForSearchCubit(
                  EmployeeInfoForSearchRepository(EmployeeInfoForSearchApi())),
              child: BlocProvider<DeleteClassroomCubit>(
                create: (_) => DeleteClassroomCubit(
                    DeleteClassroomRepository(DeleteClassroomApi())),
                child: BlocProvider<ClassListEmployeeCubit>(
                  create: (_) => ClassListEmployeeCubit(
                      ClassListEmployeeRepository(ClassListEmployeeApi())),
                  child: BlocProvider<SubjectListEmployeeCubit>(
                    create: (_) => SubjectListEmployeeCubit(
                        SubjectListEmployeeRepository(
                            SubjectListEmployeeApi())),
                    child: ClassroomEmployee(),
                  ),
                ),
              ),
            ),
          );
        }));
      // return Navigator.pushNamed(context, ClassroomEmployee.routeName);
      case 11:
        return Navigator.push(context, MaterialPageRoute(builder: (context) {
          return BlocProvider<HomeworkEmployeeCubit>(
            create: (_) => HomeworkEmployeeCubit(
                HomeworkEmployeeRepository(HomeworkEmployeeApi())),
            child: BlocProvider<EmployeeInfoForSearchCubit>(
              create: (_) => EmployeeInfoForSearchCubit(
                  EmployeeInfoForSearchRepository(EmployeeInfoForSearchApi())),
              child: BlocProvider<DeleteHomeworkCubit>(
                create: (_) => DeleteHomeworkCubit(
                    DeleteHomeworkRepository(DeleteHomeworkApi())),
                child: BlocProvider<ClassListEmployeeCubit>(
                  create: (_) => ClassListEmployeeCubit(
                      ClassListEmployeeRepository(ClassListEmployeeApi())),
                  child: BlocProvider<SubjectListEmployeeCubit>(
                    create: (_) => SubjectListEmployeeCubit(
                        SubjectListEmployeeRepository(
                            SubjectListEmployeeApi())),
                    child: HomeworkEmployee(),
                  ),
                ),
              ),
            ),
          );
        }));
      // return Navigator.pushNamed(context, HomeworkEmployee.routeName);
      case 12:
        return Navigator.pushNamed(context, ExamMarksAdmin.routeName);
      case 35:
        return Navigator.push(context, MaterialPageRoute(builder: (context) {
          return BlocProvider<StudentRemarkListCubit>(
            create: (_) => StudentRemarkListCubit(
                StudentRemarkListRepository(StudentRemarkListApi())),
            child: BlocProvider<SearchStudentFromRecordsCommonCubit>(
              create: (_) => SearchStudentFromRecordsCommonCubit(
                  SearchStudentFromRecordsCommonRepository(
                      SearchStudentFromRecordsCommonApi())),
              child: BlocProvider<DeleteStudentRemarkCubit>(
                create: (_) => DeleteStudentRemarkCubit(
                    DeleteStudentRemarkRepository(DeleteStudentRemarkApi())),
                child: StudentRemarkAdmin(),
              ),
            ),
          );
        }));
      // return Navigator.pushNamed(context, StudentRemarkAdmin.routeName);
      case 75:
        return Navigator.push(context, MaterialPageRoute(builder: (context) {
          return BlocProvider<UpdatePlanEmployeeCubit>(
            create: (_) => UpdatePlanEmployeeCubit(
                UpdatePlanEmployeeRepository(UpdatePlanEmployeeApi())),
            child: BlocProvider<WeekPlanSubjectListCubit>(
              create: (_) => WeekPlanSubjectListCubit(
                  WeekPlanSubjectListRepository(WeekPlanSubjectListApi())),
              child: BlocProvider<ClassListEmployeeCubit>(
                create: (_) => ClassListEmployeeCubit(
                    ClassListEmployeeRepository(ClassListEmployeeApi())),
                child: BlocProvider<AddPlanEmployeeCubit>(
                  create: (_) => AddPlanEmployeeCubit(
                      AddPlanEmployeeRepository(AddPlanEmployeeApi())),
                  child: WeekPlanEmployee(),
                ),
              ),
            ),
          );
        }));
      // return Navigator.pushNamed(context, WeekPlanEmployee.routeName);
      case 14:
        return Navigator.push(context, MaterialPageRoute(builder: (context) {
          return BlocProvider<MarkAttendanceListEmployeeCubit>(
            create: (_) => MarkAttendanceListEmployeeCubit(
                MarkAttendanceListEmployeeRepository(
                    MarkAttendanceListEmployeeApi())),
            child: BlocProvider<MarkAttendancePeriodsEmployeeCubit>(
              create: (_) => MarkAttendancePeriodsEmployeeCubit(
                  MarkAttendancePeriodsEmployeeRepository(
                      MarkAttendancePeriodsEmployeeApi())),
              child: BlocProvider<ResultAnnounceClassCubit>(
                create: (_) => ResultAnnounceClassCubit(
                    ResultAnnounceClassRepository(ResultAnnounceClassApi())),
                child: BlocProvider<FillPeriodAttendanceCubit>(
                  create: (_) => FillPeriodAttendanceCubit(
                      FillPeriodAttendanceRepository(
                          FillPeriodAttendanceApi())),
                  child:
                      BlocProvider<MarkAttendanceUpdateAttendanceEmployeeCubit>(
                    create: (_) => MarkAttendanceUpdateAttendanceEmployeeCubit(
                        MarkAttendanceUpdateAttendanceEmployeeRepository(
                            MarkAttendanceUpdateAttendanceEmployeeApi())),
                    child:
                        BlocProvider<MarkAttendanceSaveAttendanceEmployeeCubit>(
                      create: (_) => MarkAttendanceSaveAttendanceEmployeeCubit(
                          MarkAttendanceSaveAttendanceEmployeeRepository(
                              MarkAttendanceSaveAttendanceEmployeeApi())),
                      child: MarkAttendance(),
                    ),
                  ),
                ),
              ),
            ),
          );
        }));
      // return Navigator.pushNamed(context, MarkAttendance.routeName);
      //
      case 29:
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
              return BlocProvider<ClassListHwStatusAdminCubit>(
                create: (_) => ClassListHwStatusAdminCubit(
                    ClassListHwStatusAdminRepository(
                        ClassListHwStatusAdminApi())),
                child: HomeWorkStatusAdmin(),
              );
            }));
            // return Navigator.pushNamed(context, HomeWorkStatusAdmin.routeName);
          } else {
            print(url);
            appBarNameForWeb = "HomeWork Status";
            return gotoWeb(url: url, name: "HomeWork Status");
          }
        }
      case 28:
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
              return BlocProvider<CircularEmployeeCubit>(
                create: (_) => CircularEmployeeCubit(
                    CircularEmployeeRepository(CircularEmployeeApi())),
                child: BlocProvider<DeleteCircularCubit>(
                  create: (_) => DeleteCircularCubit(
                      DeleteCircularRepository(DeleteCircularApi())),
                  child: CircularEmployee(),
                ),
              );
            }));
            // return Navigator.pushNamed(context, CircularEmployee.routeName);
          } else {
            print(url);
            appBarNameForWeb = "Circular";

            return gotoWeb(url: url, name: "Circular");
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
          } else {
            print(url);
            appBarNameForWeb = "Notification";
            return gotoWeb(url: url, name: "Notification");
          }
        }
      case 38:
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
              return BlocProvider<LoadClassForSmsCubit>(
                create: (_) => LoadClassForSmsCubit(
                    LoadClassForSmsRepository(LoadClassForSmsApi())),
                child: BlocProvider<GetSelectClassTeacherCubit>(
                  create: (_) => GetSelectClassTeacherCubit(
                      GetSelectClassTeacherRepository(
                          GetSelectClassTeacherApi())),
                  child: BlocProvider<AssignPeriodAdminCubit>(
                    create: (_) => AssignPeriodAdminCubit(
                        AssignPeriodAdminRepository(AssignPeriodAdminApi())),
                    child: BlocProvider<MarkAttendancePeriodsEmployeeCubit>(
                      create: (_) => MarkAttendancePeriodsEmployeeCubit(
                          MarkAttendancePeriodsEmployeeRepository(
                              MarkAttendancePeriodsEmployeeApi())),
                      child: BlocProvider<RemoveAllottedSubjectCubit>(
                        create: (_) => RemoveAllottedSubjectCubit(
                            RemoveAllottedSubjectsRepository(
                                RemoveAllottedSubjectsApi())),
                        child: BlocProvider<LoadAllottedSubjectCubit>(
                          create: (_) => LoadAllottedSubjectCubit(
                              LoadAllottedSubjectsRepository(
                                  LoadAllottedSubjectsApi())),
                          child: BlocProvider<SubjectAlloteToTeacherCubit>(
                            create: (_) => SubjectAlloteToTeacherCubit(
                                SubjectAlloteToTeacherRepository(
                                    SubjectAlloteToTeacherApi())),
                            child: BlocProvider<GetClassSectionAdminCubit>(
                              create: (_) => GetClassSectionAdminCubit(
                                  GetClassSectionAdminRepository(
                                      GetClassSectionAdminApi())),
                              child:
                                  BlocProvider<GetClasswiseSubjectAdminCubit>(
                                create: (_) => GetClasswiseSubjectAdminCubit(
                                    GetClasswiseSubjectAdminRepository(
                                        GetClasswiseSubjectAdminApi())),
                                child:
                                    BlocProvider<LoadClassForSubjectAdminCubit>(
                                  create: (_) => LoadClassForSubjectAdminCubit(
                                      LoadClassForSubjectAdminRepository(
                                          LoadClassForSubjectAdminApi())),
                                  child: BlocProvider<
                                      AssignClassTeacherAdminCubit>(
                                    create: (_) => AssignClassTeacherAdminCubit(
                                        AssignClassTeacherAdminRepository(
                                            AssignClassTeacherAdminApi())),
                                    child: BlocProvider<
                                        EmployeeInfoForSearchCubit>(
                                      create: (_) => EmployeeInfoForSearchCubit(
                                          EmployeeInfoForSearchRepository(
                                              EmployeeInfoForSearchApi())),
                                      child: TeacherAssignAdmin(),
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
                ),
              );
            }));
            // return Navigator.pushNamed(context, TeacherAssignAdmin.routeName);
          } else {
            print(url);
            appBarNameForWeb = "Teacher Assign";
            return gotoWeb(url: url, name: "Teacher Assign");
          }
        }
      case 20:
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
              return BlocProvider<AttendanceOfEmployeeAdminCubit>(
                create: (_) => AttendanceOfEmployeeAdminCubit(
                    AttendanceOfEmployeeAdminRepository(
                        AttendanceOfEmployeeAdminApi())),
                child: BlocProvider<AttendanceEmployeeCubit>(
                  create: (_) => AttendanceEmployeeCubit(
                      AttendanceEmployeeRepository(AttendanceEmployeeApi())),
                  child: AttendanceEmployee(),
                ),
              );
            }));
            // return Navigator.pushNamed(context, AttendanceEmployee.routeName);
          } else {
            print(url);
            appBarNameForWeb = "Attendance Employee";
            return gotoWeb(url: url, name: "Attendance Employee");
          }
        }
      case 27:
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
              return BlocProvider<ActivityCubit>(
                create: (_) => ActivityCubit(ActivityRepository(ActivityApi())),
                child: BlocProvider<DeleteActivityCubit>(
                  create: (_) => DeleteActivityCubit(
                      DeleteActivityRepository(DeleteActivityApi())),
                  child: Activity(),
                ),
              );
            }));
            // return Navigator.pushNamed(context, Activity.routeName);
          } else {
            print(url);
            appBarNameForWeb = "Activity";
            return gotoWeb(url: url, name: "Activity");
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

  _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000)).then((value) {
      getDashboardData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _onRefresh(),
      child: MultiBlocListener(
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
              //buildGotoSite(context, state.url);
            }
            if (state is GotoWebAppLoadFail) {
              if (state.failReason == "false") {
                UserUtils.unauthorizedUser(context);
              }
            }
          }),
          BlocListener<SaveEmployeeImageCubit, SaveEmployeeImageState>(
              listener: (context, state) {
            if (state is SaveEmployeeImageLoadFail) {
              if (state.failReason == "false") {
                UserUtils.unauthorizedUser(context);
              }
            }
            if (state is SaveEmployeeImageLoadSuccess) {
              imageCache.clear();
              userImageUrl = "";

              setState(() {
                userImageUrl =
                    "${baseApiUrl}StudentImage/${userData!.organizationId}/${userData!.schoolId}/${userData!.ouserType}/${userData!.stuEmpId}.jpg";
              });

              ScaffoldMessenger.of(context)
                  .showSnackBar(commonSnackBar(title: "Success"));

              print("$userImageUrl");
              buildICardNew(context,
                  employeeInfo: employeeInfoData, image: userImageUrl);
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
              BlocConsumer<EmployeeInfoCubit, EmployeeInfoState>(
                listener: (context, state) {
                  if (state is EmployeeInfoLoadFail) {
                    if (state.failReason == "false") {
                      UserUtils.unauthorizedUser(context);
                    }
                  }
                  if (state is EmployeeInfoLoadSuccess) {
                    setState(() {
                      employeeInfoData = state.employeeInfo;
                      baseApiUrl = state.employeeInfo.baseApiUrl;
                      userImageUrl =
                          "${baseApiUrl}StudentImage/${userData!.organizationId}/${userData!.schoolId}/${userData!.ouserType}/${userData!.stuEmpId}.jpg";
                    });
                  }
                },
                builder: (context, state) {
                  if (state is EmployeeInfoForSearchLoadInProgress) {
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
                  if (state is EmployeeInfoLoadSuccess) {
                    return buildICardNew(context,
                        employeeInfo: state.employeeInfo);
                  } else if (state is EmployeeInfoLoadFail) {
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
                },
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(bottom: 20, top: 10),
                    decoration: BoxDecoration(
                      color: Color(0xff045D98).withOpacity(0.03),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        buildEmployeeHomeCategorys(
                            title: "Academics",
                            quickList: cordinatorCategoryListAcademics),
                        SizedBox(
                          height: 10,
                        ),
                        buildEmployeeHomeCategorys(
                            title: "Circulars",
                            quickList: cordinatorCategoryListCirculars),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // buildEmployeeHomeCategorys(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildEmployeeHomeCategorys(
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
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          // margin: const EdgeInsets.symmetric(horizontal: 8.0),
          // padding: const EdgeInsets.all(8.0),
          // height: 120,
          // decoration: BoxDecoration(
          //   border: Border.all(color: Colors.black12),
          //   borderRadius: BorderRadius.circular(8.0),
          // ),
          height: MediaQuery.of(context).size.height * 0.18,
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: ListView.separated(
            separatorBuilder: (context, index) {
              return SizedBox(width: 10);
            },
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            physics: ClampingScrollPhysics(),
            itemCount: quickList!.length,
            itemBuilder: (context, i) {
              var item = quickList[i];
              return Container(
                child: InkWell(
                  onTap: () => navigate(item.id),
                  child: Container(
                    // decoration: BoxDecoration(
                    //   color: Colors.white,
                    //   borderRadius: BorderRadius.circular(8.0),
                    //   boxShadow: [
                    //     BoxShadow(
                    //       color: Colors.grey,
                    //       blurRadius: 5.0,
                    //     ),
                    //   ],
                    // ),
                    // padding: const EdgeInsets.all(8.0),
                    // margin: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 5,
                            spreadRadius: 1,
                            // color: Colors.grey.shade400,
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
                                fontSize: 25, fontWeight: FontWeight.w600),
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

  Widget buildICardNew(BuildContext context,
      {EmployeeInfoModel? employeeInfo, String? image}) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(left: 20, right: 10, top: 20, bottom: 10),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.2,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.55,
                    child: RichText(
                      text: TextSpan(
                          text: "Hi ",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                          children: [
                            TextSpan(
                              text: "${employeeInfo!.name}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ]),
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Emp No : ${employeeInfo.empno}",
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
                    "Dep : ${employeeInfo.designation}",
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
                    "D.O.B : ${employeeInfo.dateOfBirth}",
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
                    employeeInfo.mobileNo!,
                    textScaleFactor: 1.2,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  showUploadSheet();
                },
                child: Stack(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 48,
                      child: CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 46,
                        key: ValueKey(Random().nextInt(1000)),
                        backgroundImage: NetworkImage(
                          userImageUrl!,
                        ),
                        onBackgroundImageError: (error, stackTrace) =>
                            AssetImage(AppImages.dummyImage),
                      ),
                    ),
                    Positioned(
                      bottom: -1,
                      right: 6,
                      child: CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 14,
                        child: Icon(
                          Icons.photo_camera,
                          color: Colors.white,
                          size: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
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
            style: Theme.of(context).textTheme.titleMedium,
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
                        style: TextStyle(
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
                      style: TextStyle(
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

  Column buildIdentityCard({EmployeeInfoModel? employeeInfo}) {
    return Column(
      children: [
        Container(
          color: Theme.of(context).primaryColor,
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(10.0),
                child: Center(
                    child: Text(
                  "Demo School",
                  textScaleFactor: 1.5,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )),
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
                            MediaQuery.of(context).size.width / 4),
                        1: FlexColumnWidth(
                            MediaQuery.of(context).size.width / 2),
                        2: FlexColumnWidth(
                            MediaQuery.of(context).size.width / 3.5),
                      },
                      children: [
                        buildCardRows(
                            title: 'Emp No.', value: "${employeeInfo!.empId}"),
                        buildCardRows(
                            title: 'Name.', value: "${employeeInfo.name}"),
                        buildCardRows(
                            title: 'F / Name',
                            value: "${employeeInfo.fatherName}"),
                        buildCardRows(
                            title: 'DOB', value: "${employeeInfo.dateOfBirth}"),
                        buildCardRows(
                            title: 'Mobile No.',
                            value: "${employeeInfo.mobileNo}"),
                        buildCardRows(
                            title: 'Email Id',
                            value: "${employeeInfo.emailid}"),
                        buildCardRows(
                            title: 'Department',
                            value: "${employeeInfo.designation}"),
                      ],
                    ),
                    Positioned(
                      right: 0,
                      child: InkWell(
                        onTap: () {},
                        // onTap: () => Navigator.pushNamed(
                        //     context, ProfileStudent.routeName),
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.width / 4,
                              width: MediaQuery.of(context).size.width / 4,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey, width: 4),
                                  color: Colors.white,
                                  image: DecorationImage(
                                      image: AssetImage(AppImages.dummyImage))),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.width / 22,
                              width: MediaQuery.of(context).size.width / 4,
                              color: Colors.grey,
                              child: FittedBox(
                                child: Text(
                                  'Profile',
                                  style: TextStyle(
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
        ),
        // if (studentInfo.emailId == '' || studentInfo.emailId == null)
        //   buildEmailAlert(context),
      ],
    );
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
          child: RichText(
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
                text: "$title : ",
                style: TextStyle(color: Colors.black, fontSize: 16)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: RichText(
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              text: "$value",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
            ),
          ),
        ),
        Container(),
      ],
    );
  }

  // Widget buildEmployeeHomeCategorys() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Container(
  //         padding: EdgeInsets.only(left: 15, bottom: 5),
  //         child: Text(
  //           "Quick Access",
  //           textScaleFactor: 1.2,
  //           style: TextStyle(
  //             fontSize: 18,
  //             fontWeight: FontWeight.w600,
  //           ),
  //         ),
  //       ),
  //       Container(
  //         margin: const EdgeInsets.symmetric(horizontal: 8.0),
  //         padding: const EdgeInsets.all(8.0),
  //         height: 120,
  //         decoration: BoxDecoration(
  //           border: Border.all(color: Colors.black12),
  //           borderRadius: BorderRadius.circular(8.0),
  //         ),
  //         child: ListView.builder(
  //           shrinkWrap: true,
  //           itemCount: cordinatorCategoryList.length,
  //           scrollDirection: Axis.horizontal,
  //           itemBuilder: (context, i) {
  //             var item = cordinatorCategoryList[i];
  //             return Container(
  //               width: 150,
  //               height: 40,
  //               child: InkWell(
  //                 onTap: () => navigate(item.id),
  //                 child: Container(
  //                   decoration: BoxDecoration(
  //                     color: Colors.white,
  //                     borderRadius: BorderRadius.circular(8.0),
  //                     boxShadow: [
  //                       BoxShadow(
  //                         color: Colors.grey,
  //                         blurRadius: 5.0,
  //                       ),
  //                     ],
  //                   ),
  //                   padding: const EdgeInsets.all(8.0),
  //                   margin: const EdgeInsets.all(4.0),
  //                   child: Center(
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.center,
  //                       mainAxisAlignment: MainAxisAlignment.start,
  //                       mainAxisSize: MainAxisSize.min,
  //                       children: [
  //                         Image.asset(
  //                           item.image!,
  //                           // AppImages.switchUser,
  //                           height: 40,
  //                           width: 40,
  //                         ),
  //                         SizedBox(height: 8),
  //                         Text(
  //                           item.title!,
  //                           textScaleFactor: 1,
  //                           maxLines: 2,
  //                           overflow: TextOverflow.ellipsis,
  //                           textAlign: TextAlign.center,
  //                           style: TextStyle(
  //                               color: Colors.black,
  //                               fontSize: 16,
  //                               fontWeight: FontWeight.w600),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             );
  //           },
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Container buildTextField() {
    return Container(
      child: TextFormField(
        // obscureText: !obscureText ? false : true,
        controller: emailController,
        validator: FieldValidators.emailValidator,
        keyboardType: TextInputType.emailAddress,
        // autovalidateMode: AutovalidateMode.onUserInteraction,
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

  showUploadSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                "Upload via",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(vertical: 30),
              child: Row(
                children: [
                  buildUploadOption(
                    context,
                    icon: Icons.camera_alt,
                    title: "Camera",
                    onTap: () async {
                      File? tempFile =
                          await getImage(source: ImageSource.camera);
                      if (mounted && tempFile != null) {
                        setState(() {
                          _pickedImage = tempFile;
                        });
                        sendImageToApi();
                      }
                    },
                    // onTap: () => getImage(source: ImageSource.camera),
                  ),
                  buildUploadOption(
                    context,
                    icon: Icons.photo_library,
                    title: "Gallery",
                    onTap: () async {
                      File? tempFile =
                          await getImage(source: ImageSource.gallery);
                      if (mounted && tempFile != null) {
                        setState(() {
                          _pickedImage = tempFile;
                        });
                        sendImageToApi();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Expanded buildUploadOption(BuildContext context,
      {IconData? icon, String? title, void Function()? onTap}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, color: Theme.of(context).primaryColor, size: 28),
            Text(
              title.toString(),
              textScaleFactor: 1.0,
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  Future<File?> getImage({ImageSource source = ImageSource.gallery}) async {
    Navigator.pop(context);
    final pickedFile = await ImagePicker().pickImage(
        // source: source, imageQuality: source == ImageSource.gallery ? 50 : 30);
        source: source,
        imageQuality: 30,
        maxHeight: 480,
        maxWidth: 640);
    if (pickedFile != null) {
      print('Wow! Image selected.');
      final image = File(pickedFile.path);
      return image;
    } else {
      print('Ops! No Image selected.');
    }
    return null;
  }

  sendImageToApi() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final updateImage = {
      'UserId': uid!,
      'Token': token!,
      'OrgId': userData!.organizationId!,
      'SchoolId': userData.schoolId!,
      'SessionId': userData.currentSessionid!,
      'StuEmpId': userData.stuEmpId!,
      'FileFormat': "",
      'UserType': userData.ouserType!,
    };
    context
        .read<SaveEmployeeImageCubit>()
        .saveEmployeeImageCubitCall(updateImage, _pickedImage);
  }
}
