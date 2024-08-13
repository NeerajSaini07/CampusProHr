import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:campus_pro/src/DATA/MODELS/employeeInfoModel.dart';
import 'package:campus_pro/src/DATA/MODELS/scheduleMeetingListEmployeeModel.dart';
import 'package:campus_pro/src/DATA/MODELS/staffMeetingsEmployeeDashboardModel.dart';
import 'package:campus_pro/src/DATA/MODELS/userTypeModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/PAGES/ADMIN_MODULE/EMPLOYEE_ADMIN/teacherAssignAdmin.dart';
import 'package:campus_pro/src/UI/PAGES/ADMIN_MODULE/HOMEWORK_ADMIN/HomeWork_Status_Admin/homeWorkStatusAdmin.dart';
import 'package:campus_pro/src/UI/PAGES/ADMIN_MODULE/STUDENT_ADMIN/studentRemarkAdmin.dart';
import 'package:campus_pro/src/UI/PAGES/EMPLOYEE_MODULE/ATTENDANCE_EMPLOYEE/markAttendanceEmployee.dart';
import 'package:campus_pro/src/UI/PAGES/EMPLOYEE_MODULE/COMMUNICATION_EMPLOYEE/CIRCULAR_EMPLOYEE/circularEmployee.dart';
import 'package:campus_pro/src/UI/PAGES/EMPLOYEE_MODULE/COMMUNICATION_EMPLOYEE/CLASS_ROOM_EMPLOYEE/classroomEmployee.dart';
import 'package:campus_pro/src/UI/PAGES/EMPLOYEE_MODULE/COMMUNICATION_EMPLOYEE/CLASS_ROOM_EMPLOYEE/homeworkEmployee.dart';
import 'package:campus_pro/src/UI/PAGES/EMPLOYEE_MODULE/EXAM_EMPLOYEE/examMarkEntryEmployee.dart';
import 'package:campus_pro/src/UI/PAGES/EMPLOYEE_MODULE/LEAVE_EMPLOYEE/studentLeaveEmployeepending.dart';
import 'package:campus_pro/src/UI/PAGES/EMPLOYEE_MODULE/WEEK_PLAN_EMPLOYEE/updatePlanEmployee.dart';
import 'package:campus_pro/src/UI/PAGES/STAND_ALONE_PAGES/MEETING/meetingStatus.dart';
import 'package:campus_pro/src/UI/PAGES/STAND_ALONE_PAGES/activity.dart';
import 'package:campus_pro/src/UI/PAGES/STAND_ALONE_PAGES/notifications.dart';
import 'package:campus_pro/src/UI/PAGES/STUDENT_MODULE/MY_ACCOUNT_STUDENT/changePasswordStudent.dart';
import 'package:campus_pro/src/UI/PAGES/STUDENT_MODULE/MY_ACCOUNT_STUDENT/profileStudent.dart';
import 'package:campus_pro/src/UI/PAGES/STUDENT_MODULE/attendanceStudent.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonSnackbar.dart';
import 'package:campus_pro/src/UI/WIDGETS/noRecordFound.dart';
import 'package:campus_pro/src/UI/WIDGETS/toast.dart';
import 'package:campus_pro/src/UI/WIDGETS/updateEmail.dart';
import 'package:campus_pro/src/UTILS/appImages.dart';
import 'package:campus_pro/src/UTILS/fieldValidators.dart';
import 'package:campus_pro/src/UTILS/joinMeeting.dart';
import 'package:campus_pro/src/gotoWeb.dart';
import 'package:campus_pro/src/DATA/MODELS/dummyData.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../../globalBlocProvidersFile.dart';

class DashboardEmployee extends StatefulWidget {
  static const routeName = "/dashboard-employee";

  const DashboardEmployee({Key? key}) : super(key: key);
  @override
  _DashboardEmployeeState createState() => _DashboardEmployeeState();
}

class _DashboardEmployeeState extends State<DashboardEmployee> {
  String? meetingIdOnTap;

  String? userEmail = '';

  String? userImageUrl = '';

  bool showMarkAttButton = false;
  bool showEmpImage = true;

  File? _pickedImage;

  TextEditingController emailController = TextEditingController();

  String? uid = '';
  String? token = '';
  UserTypeModel? userData;

  String? baseApiUrl;

  //
  EmployeeInfoModel? infoModelToStoreInfo;

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
    userImageUrl = "";
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
    getMeetingData();
    getStaffMeetingList();
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

  getMeetingData() async {
    final meetingData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData!.schoolId,
      "EmpId": userData!.stuEmpId,
      "For": "s",
      "StuEmpId": userData!.stuEmpId,
      "Usertype": userData!.ouserType,
    };
    print("Sending ScheduleMeetingListEmployee Data => $meetingData");
    context
        .read<ScheduleMeetingListEmployeeCubit>()
        .scheduleMeetingListEmployeeCubitCall(meetingData);
  }

  getStaffMeetingList() async {
    final meetingData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData!.schoolId,
      "EmpId": userData!.stuEmpId,
      "MeetingDate": DateFormat("yyyy-MM-dd").format(DateTime.now()),
      "StuEmpId": userData!.stuEmpId,
      "Usertype": userData!.ouserType
    };
    print("Sending StaffMeetingsEmployeeDashboard Data => $meetingData");
    context
        .read<StaffMeetingsEmployeeDashboardCubit>()
        .staffMeetingsEmployeeDashboardCubitCall(meetingData);
  }

  getMeetingDetails({String? meetingId, String? getType}) async {
    setState(() {
      meetingIdOnTap = meetingId;
    });
    final meetingData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData!.schoolId,
      "SessionId": userData!.currentSessionid,
      "MeetingId": meetingIdOnTap,
      "StuEmpId": userData!.stuEmpId,
      "UserType": userData!.ouserType,
      "GetType": getType,
    };
    print('sending MeetingDetailsAdmin data $meetingData');
    context
        .read<MeetingDetailsAdminCubit>()
        .meetingDetailsAdminCubitCall(meetingData);
  }

  markMyAtt() async {
    final stuInfo = await UserUtils.stuInfoDataFromCache();
    final markData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId!,
      "Schoolid": userData!.schoolId!,
      "SessionID": userData!.currentSessionid,
      "StuEmpId": userData!.stuEmpId,
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
    // final ids = await UserUtils.stuInfoDataFromCache();

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
              return BlocProvider<ClassroomEmployeeCubit>(
                create: (_) => ClassroomEmployeeCubit(
                    ClassroomEmployeeRepository(ClassroomEmployeeApi())),
                child: BlocProvider<EmployeeInfoForSearchCubit>(
                  create: (_) => EmployeeInfoForSearchCubit(
                      EmployeeInfoForSearchRepository(
                          EmployeeInfoForSearchApi())),
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
          } else {
            print(url);
            appBarNameForWeb = "Classrooms";
            return gotoWeb(url: url, name: "Classrooms");
          }
        }
      case 11:
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
              return BlocProvider<HomeworkEmployeeCubit>(
                create: (_) => HomeworkEmployeeCubit(
                    HomeworkEmployeeRepository(HomeworkEmployeeApi())),
                child: BlocProvider<EmployeeInfoForSearchCubit>(
                  create: (_) => EmployeeInfoForSearchCubit(
                      EmployeeInfoForSearchRepository(
                          EmployeeInfoForSearchApi())),
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
          } else {
            print(url);
            appBarNameForWeb = "Homework";
            return gotoWeb(url: url, name: "Homework");
          }
        }
      case 12:
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
              return BlocProvider<GetExamMarksForTeacherCubit>(
                create: (_) => GetExamMarksForTeacherCubit(
                    GetExamMarksForTeacherRepository(
                        GetExamMarksForTeacherApi())),
                child: BlocProvider<GetMinMaxMarksCubit>(
                  create: (_) => GetMinMaxMarksCubit(
                      GetMinMaxmarksRepository(GetMinMaxMarksApi())),
                  child: BlocProvider<GetExamMarksForTeacherCubit>(
                    create: (_) => GetExamMarksForTeacherCubit(
                        GetExamMarksForTeacherRepository(
                            GetExamMarksForTeacherApi())),
                    child: BlocProvider<SaveExamMarksCubit>(
                      create: (_) => SaveExamMarksCubit(
                          SaveExamMarksRepository(SaveExamMarksApi())),
                      child: BlocProvider<SubjectExamMarksCubit>(
                        create: (_) => SubjectExamMarksCubit(
                            SubjectExamMarksRepository(SubjectExamMarksApi())),
                        child: BlocProvider<GetExamTypeAdminCubit>(
                          create: (_) => GetExamTypeAdminCubit(
                              GetExamTypeAdminRepository(
                                  GetExamTypeAdminApi())),
                          child: BlocProvider<ClassListEmployeeCubit>(
                            create: (_) => ClassListEmployeeCubit(
                                ClassListEmployeeRepository(
                                    ClassListEmployeeApi())),
                            child: ExamMarkEntryEmployee(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }));
            // return Navigator.pushNamed(
            //     context, ExamMarkEntryEmployee.routeName);
          } else {
            print(url);
            appBarNameForWeb = "Exam Marks Entry";
            return gotoWeb(url: url, name: "Exam Marks Entry");
          }
        }
      case 35:
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
              return BlocProvider<StudentRemarkListCubit>(
                create: (_) => StudentRemarkListCubit(
                    StudentRemarkListRepository(StudentRemarkListApi())),
                child: BlocProvider<SearchStudentFromRecordsCommonCubit>(
                  create: (_) => SearchStudentFromRecordsCommonCubit(
                      SearchStudentFromRecordsCommonRepository(
                          SearchStudentFromRecordsCommonApi())),
                  child: BlocProvider<DeleteStudentRemarkCubit>(
                    create: (_) => DeleteStudentRemarkCubit(
                        DeleteStudentRemarkRepository(
                            DeleteStudentRemarkApi())),
                    child: StudentRemarkAdmin(),
                  ),
                ),
              );
            }));
            // return Navigator.pushNamed(context, StudentRemarkAdmin.routeName);
          } else {
            print(url);
            appBarNameForWeb = "Student Remark";
            return gotoWeb(url: url, name: "Student Remark");
          }
        }

      case 75:
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
          } else {
            print(url);
            appBarNameForWeb = "Week Planner";
            return gotoWeb(url: url, name: "Week Planner");
          }
        }

      case 14:
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
                        ResultAnnounceClassRepository(
                            ResultAnnounceClassApi())),
                    child: BlocProvider<FillPeriodAttendanceCubit>(
                      create: (_) => FillPeriodAttendanceCubit(
                          FillPeriodAttendanceRepository(
                              FillPeriodAttendanceApi())),
                      child: BlocProvider<
                          MarkAttendanceUpdateAttendanceEmployeeCubit>(
                        create: (_) => MarkAttendanceUpdateAttendanceEmployeeCubit(
                            MarkAttendanceUpdateAttendanceEmployeeRepository(
                                MarkAttendanceUpdateAttendanceEmployeeApi())),
                        child: BlocProvider<
                            MarkAttendanceSaveAttendanceEmployeeCubit>(
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
          } else {
            print(url);
            appBarNameForWeb = "Attendance Mark";
            return gotoWeb(url: url, name: "Attendance Mark");
          }
        }

      case 10:
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

      case 5:
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

      case 17:
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
              return BlocProvider<StudentHistoryLeaveEmployeeCubit>(
                create: (_) => StudentHistoryLeaveEmployeeCubit(
                    StudentLeaveEmployeeHistoryRepository(
                        StudentLeaveEmployeeHistoryApi())),
                child: BlocProvider<StudentLeavePendingRejectAcceptCubit>(
                  create: (_) => StudentLeavePendingRejectAcceptCubit(
                      studentLeavePendingRejectAcceptRepository(
                          StudentLeaveEmployeeHistoryRejAcpApi())),
                  child: StudentLeave(),
                ),
              );
            }));
            // return Navigator.pushNamed(context, StudentLeave.routeName);
          } else {
            print(url);
            appBarNameForWeb = "Student Leave";
            return gotoWeb(url: url, name: "Student Leave");
          }
        }

      case 54:
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
              return BlocProvider<ChangePasswordStudentCubit>(
                create: (_) => ChangePasswordStudentCubit(
                    ChangePasswordStudentRepository(
                        ChangePasswordStudentApi())),
                child: ChangePasswordStudent(),
              );
            }));
            // return Navigator.pushNamed(
            //     context, ChangePasswordStudent.routeName);
          } else {
            print(url);
            appBarNameForWeb = "Change Password";
            return gotoWeb(url: url, name: "Change Password");
          }
        }

      case 16:
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
            appBarNameForWeb = "Employee Leave";
            return gotoWeb(url: url, name: "Employee Leave");
          }
        }

      case 29:
        return Navigator.push(context, MaterialPageRoute(builder: (context) {
          return BlocProvider<ClassListHwStatusAdminCubit>(
            create: (_) => ClassListHwStatusAdminCubit(
                ClassListHwStatusAdminRepository(ClassListHwStatusAdminApi())),
            child: HomeWorkStatusAdmin(),
          );
        }));
      // return Navigator.pushNamed(context, HomeWorkStatusAdmin.routeName);
      case 28:
        return Navigator.push(context, MaterialPageRoute(builder: (context) {
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
      case 25:
        return Navigator.push(context, MaterialPageRoute(builder: (context) {
          return BlocProvider<NotificationsCubit>(
            create: (_) =>
                NotificationsCubit(NotificationsRepository(NotificationsApi())),
            child: Notifications(),
          );
        }));
      // return Navigator.pushNamed(context, Notifications.routeName);
      case 38:
        return Navigator.push(context, MaterialPageRoute(builder: (context) {
          return BlocProvider<LoadClassForSmsCubit>(
            create: (_) => LoadClassForSmsCubit(
                LoadClassForSmsRepository(LoadClassForSmsApi())),
            child: BlocProvider<GetSelectClassTeacherCubit>(
              create: (_) => GetSelectClassTeacherCubit(
                  GetSelectClassTeacherRepository(GetSelectClassTeacherApi())),
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
                          child: BlocProvider<GetClasswiseSubjectAdminCubit>(
                            create: (_) => GetClasswiseSubjectAdminCubit(
                                GetClasswiseSubjectAdminRepository(
                                    GetClasswiseSubjectAdminApi())),
                            child: BlocProvider<LoadClassForSubjectAdminCubit>(
                              create: (_) => LoadClassForSubjectAdminCubit(
                                  LoadClassForSubjectAdminRepository(
                                      LoadClassForSubjectAdminApi())),
                              child: BlocProvider<AssignClassTeacherAdminCubit>(
                                create: (_) => AssignClassTeacherAdminCubit(
                                    AssignClassTeacherAdminRepository(
                                        AssignClassTeacherAdminApi())),
                                child: BlocProvider<EmployeeInfoForSearchCubit>(
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
      case 20:
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
      case 27:
        return Navigator.push(context, MaterialPageRoute(builder: (context) {
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
      case 48:
        return Navigator.push(context, MaterialPageRoute(builder: (context) {
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
      default:
    }
  }

  createRoute() {
    return PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) => MarkAttendance(),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          var tween = Tween(begin: Offset(0.0, 1.0), end: Offset.zero)
              .chain(CurveTween(curve: Curves.ease));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        });
  }

  _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000)).then((value) {
      getDashboardData();
      getMeetingData();
      getStaffMeetingList();
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
                if (state.meetingDetailData.meetingSubject ==
                    "Please Join Class on time.") {
                  ScaffoldMessenger.of(context).showSnackBar(
                      commonSnackBar(title: "Please Join Class on time."));
                } else {
                  JoinMeeting().checkPlatform(
                      meetingSubject: state.meetingDetailData.meetingSubject,
                      meetingId: meetingIdOnTap);
                }
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
          BlocListener<SaveEmployeeImageCubit, SaveEmployeeImageState>(
            listener: (context, state) {
              if (state is SaveEmployeeImageLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                } else {
                  toast("Failed!");
                }
              }
              if (state is SaveEmployeeImageLoadSuccess) {
                ///
                //Used to remove the cache of the images soo that our image can update...
                imageCache.clear();
                //
                userImageUrl = "";
                Future.delayed(Duration(microseconds: 300)).then((value) {
                  setState(() {
                    userImageUrl =
                        "${baseApiUrl}StudentImage/${userData!.organizationId}/${userData!.schoolId}/${userData!.ouserType}/${userData!.stuEmpId}.jpg";
                  });
                  setState(() {
                    userImageUrl = userImageUrl;
                  });
                  ScaffoldMessenger.of(context)
                      .showSnackBar(commonSnackBar(title: "Success"));
                  //Todo
                  buildICardNew(context,
                      employeeInfo: infoModelToStoreInfo, image: userImageUrl);
                });
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
              BlocConsumer<EmployeeInfoCubit, EmployeeInfoState>(
                listener: (context, state) {
                  if (state is EmployeeInfoLoadFail) {
                    if (state.failReason == "false") {
                      UserUtils.unauthorizedUser(context);
                    }
                  }
                  if (state is EmployeeInfoLoadSuccess) {
                    setState(() {
                      infoModelToStoreInfo = state.employeeInfo;
                      baseApiUrl = state.employeeInfo.baseApiUrl;
                    });
                    setState(() {
                      userImageUrl =
                          // "https://mobileweb.eiterp.com/StudentImage/${userData!.organizationId}/${userData!.schoolId}/${userData!.ouserType}/${userData!.stuEmpId}.jpg";
                          "${baseApiUrl}StudentImage/${userData!.organizationId}/${userData!.schoolId}/${userData!.ouserType}/${userData!.stuEmpId}.jpg";
                    });
                    print("image url $userImageUrl");
                  }
                },
                builder: (context, state) {
                  if (state is EmployeeInfoLoadInProgress) {
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
                        employeeInfo: state.employeeInfo, image: userImageUrl);
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
                    return LinearProgressIndicator();
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
                            quickList: employeeCategoryListAcademics),
                        SizedBox(
                          height: 10,
                        ),
                        buildEmployeeHomeCategorys(
                            title: "Circulars",
                            quickList: employeeCategoryListCirculars),
                        SizedBox(
                          height: 10,
                        ),
                        buildEmployeeHomeCategorys(
                            title: "Others",
                            quickList: employeeCategoryListOthers),
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
                                    textScaleFactor: 1.1,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16),
                                  ),
                                ),
                              ),
                              BlocConsumer<ScheduleMeetingListEmployeeCubit,
                                  ScheduleMeetingListEmployeeState>(
                                listener: (context, state) {},
                                builder: (context, state) {
                                  if (state
                                      is ScheduleMeetingListEmployeeLoadInProgress) {
                                    return Center(
                                        child: Container(
                                            height: 10,
                                            width: 10,
                                            child:
                                                CircularProgressIndicator()));
                                  } else if (state
                                      is ScheduleMeetingListEmployeeLoadSuccess) {
                                    return buildTodayMeetings(context,
                                        onlineMeetingData: state.meetingList);
                                  } else if (state
                                      is ScheduleMeetingListEmployeeLoadFail) {
                                    return Center(
                                        child: Text(
                                      "No Classes",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ));
                                  } else {
                                    return Container();
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
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
                                    "Upcoming Staff Meetings",
                                    textScaleFactor: 1.1,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16),
                                  ),
                                ),
                              ),
                              BlocConsumer<StaffMeetingsEmployeeDashboardCubit,
                                  StaffMeetingsEmployeeDashboardState>(
                                listener: (context, state) {},
                                builder: (context, state) {
                                  if (state
                                      is StaffMeetingsEmployeeDashboardLoadInProgress) {
                                    return Center(
                                        child: Container(
                                            height: 10,
                                            width: 10,
                                            child:
                                                CircularProgressIndicator()));
                                  } else if (state
                                      is StaffMeetingsEmployeeDashboardLoadSuccess) {
                                    return buildStaffMeeting(context,
                                        meetingList: state.staffMeetingsList);
                                  } else if (state
                                      is StaffMeetingsEmployeeDashboardLoadFail) {
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
              )
            ],
          ),
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

  // PageController _pageController = PageController(viewportFraction: 0.95);

  Widget buildICardNew(BuildContext context,
      {EmployeeInfoModel? employeeInfo, String? image}) {
    return Container(
      height: MediaQuery.of(context).size.height / 4.1,
      child: PageView.builder(
        itemCount: 2,
        // controller: _pageController,
        itemBuilder: (BuildContext context, index) {
          print(index);
          return index == 0
              ? Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          left: 20, right: 10, top: 20, bottom: 10),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.55,
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
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "${employeeInfo.department}",
                                    textScaleFactor: 1.2,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "${employeeInfo.mobileNo}",
                                    textScaleFactor: 1.2,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              Stack(
                                children: [
                                  InkWell(
                                    //Todo:image upload
                                    onTap: () => showUploadSheet(),
                                    child: Stack(
                                      children: [
                                        if (showEmpImage)
                                          CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: 48,
                                            child: CircleAvatar(
                                              backgroundColor: Colors.grey,
                                              radius: 46,
                                              backgroundImage: image == null
                                                  ? NetworkImage(userImageUrl!)
                                                  : NetworkImage(image),
                                              key: ValueKey(
                                                  new Random().nextInt(1000)),
                                              onBackgroundImageError:
                                                  (error, stackTrace) =>
                                                      AssetImage(
                                                          AppImages.dummyImage),
                                            ),
                                          ),
                                        Positioned(
                                          right: 6,
                                          bottom: -1,
                                          child: CircleAvatar(
                                            backgroundColor: Colors.black,
                                            radius: 14,
                                            child: Icon(
                                              Icons.photo_camera,
                                              size: 14,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 15,
                      right: 30,
                      child: Icon(
                        Icons.keyboard_arrow_right,
                      ),
                    ),
                  ],
                )
              : Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(
                          left: 20, right: 10, top: 20, bottom: 10),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "D.O.B : ${employeeInfo!.dateOfBirth}",
                            textScaleFactor: 1.2,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "${employeeInfo.emailid}",
                            textScaleFactor: 1.2,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          employeeInfo.fatherName != ""
                              ? Text(
                                  "F.N : ${employeeInfo.fatherName}",
                                  textScaleFactor: 1.2,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                )
                              : Text(""),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 15,
                      left: 30,
                      child: Icon(
                        Icons.keyboard_arrow_left,
                      ),
                    ),
                  ],
                );
        },
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
            style: Theme.of(context).textTheme.titleLarge,
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
          // Container(
          //   padding: const EdgeInsets.only(left: 10),
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(8.0),
          //     color: Colors.orange,
          //     border: Border.all(color: Colors.orange),
          //   ),
          //   child: Container(
          //     padding: EdgeInsets.symmetric(vertical: 8),
          //     decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(8.0),
          //         color: Colors.white),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         Container(
          //           padding: const EdgeInsets.only(left: 10),
          //           width: MediaQuery.of(context).size.width / 1.5,
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Text(
          //                 "Tomorrow is holiday",
          //                 textScaleFactor: 1.5,
          //                 overflow: TextOverflow.ellipsis,
          //                 maxLines: 1,
          //                 style: TextStyle(fontSize: 12, color: Colors.orange),
          //               ),
          //             ],
          //           ),
          //         ),
          //         Row(
          //           children: [
          //             Text(
          //               "June 9",
          //               textScaleFactor: 1.5,
          //               style: TextStyle(color: Colors.grey, fontSize: 10),
          //             ),
          //             Icon(Icons.arrow_forward_ios_outlined,
          //                 color: Colors.grey, size: 12),
          //             SizedBox(width: 10),
          //           ],
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
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
                    "Your email is not registered.",
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
                  "Register now",
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
                        onTap: () => Navigator.pushNamed(
                            context, ProfileStudent.routeName),
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
          height: MediaQuery.of(context).size.height * 0.18,
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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

  Container buildTodayMeetings(BuildContext context,
      {List<ScheduleMeetingListEmployeeModel>? onlineMeetingData}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      height: MediaQuery.of(context).size.height * 0.2,
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
                "${item.subjectHead}-${item.combName}",
                // "${item.meetingSubject!.split('\r\n')[0].split('-')[0]}",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            subtitle: Transform.translate(
              offset: Offset(-10, 0),
              child: Container(
                // color: Colors.green,
                child: RichText(
                  text: TextSpan(
                    text: item.meetingSubject!
                                .split('\r\n')[0]
                                .split('-')
                                .toList()
                                .length >
                            1
                        ? "${item.meetingSubject!.split('\r\n')[0].split('-')[1]}\n${item.meetingDate1} at ${item.meetingTime!}"
                        : "${item.meetingDate1} at ${item.meetingTime!}",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Colors.grey, fontSize: 13),
                    children: [
                      TextSpan(text: "\n${item.email}", children: [
                        TextSpan(
                          text:
                              "${item.meetingSubject!.split("-")[0] != "Zoom" ? "\nGoogle Meet" : "Zoom"}",
                        )
                      ]),
                    ],
                  ),
                ),
              ),
            ),
            trailing: Transform.translate(
              offset: Offset(10, 0),
              child: InkWell(
                onTap: () {
                  if (item.meetinglivestatus!.toLowerCase() == 'y') {
                    print("item => ${item.meetingId}");

                    getMeetingDetails(
                        meetingId: item.id.toString(), getType: "ts");
                  }
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
                        ? "Join Class"
                        : "Ended",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.quicksand(
                        color: item.meetinglivestatus!.toLowerCase() == 'y'
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

  Widget buildStaffMeeting(BuildContext context,
      {List<StaffMeetingsEmployeeDashboardModel>? meetingList}) {
    return meetingList!.length > 0
        ? Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            height: MediaQuery.of(context).size.height * 0.2,
            child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) => Divider(),
              shrinkWrap: true,
              itemCount: meetingList.length,
              itemBuilder: (context, i) {
                var item = meetingList[i];
                return ListTile(
                  title: Transform.translate(
                    offset: Offset(-10, 0),
                    child: Text(
                      "${item.comment!.split('\r\n')[0].split('-')[0]}",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  subtitle: Transform.translate(
                    offset: Offset(-10, 0),
                    child: Container(
                      // color: Colors.green,
                      child: Text(
                        "${item.comment!.split('on:')[1]}",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: Colors.grey, fontSize: 12),
                      ),
                    ),
                  ),
                  trailing: Transform.translate(
                    offset: Offset(10, 0),
                    child: InkWell(
                      onTap: () {
                        if (item.meetinglivestatus!.toLowerCase() == 'y') {
                          print("item => $item");

                          getMeetingDetails(
                              meetingId: item.id.toString(), getType: "tt");
                        }
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
                              ? "Join Meeting"
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
                  ),
                );
              },
            ),
          )
        : Center(
            child: Text(
              "No Meetings",
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
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
}
