import 'package:campus_pro/src/DATA/API_SERVICES/PAYMENT_GATEWAY_API/paymentScreen.dart';
import 'package:campus_pro/src/DATA/MODELS/classListPrevHwNotDoneStatusModel.dart';
import 'package:campus_pro/src/DATA/MODELS/markSheetModel.dart';
import 'package:campus_pro/src/DATA/MODELS/profileStudentModel.dart';
import 'package:campus_pro/src/DATA/MODELS/viewEnquiryModel.dart';
import 'package:campus_pro/src/UI/PAGES/ADMIN_MODULE/ATTENDANCE_ADMIN/leaveApplicationsAdmin.dart';
import 'package:campus_pro/src/UI/PAGES/ADMIN_MODULE/COMMUNICATION_ADMIN/customChatUserListAdmin.dart';
import 'package:campus_pro/src/UI/PAGES/ADMIN_MODULE/COMMUNICATION_ADMIN/sendSmsAdmin.dart';
import 'package:campus_pro/src/UI/PAGES/ADMIN_MODULE/COMMUNICATION_ADMIN/suggestionAdmin/suggestionAdmin.dart';
import 'package:campus_pro/src/UI/PAGES/ADMIN_MODULE/COMMUNICATION_ADMIN/suggestionAdmin/suggestionDataAdmin.dart';
import 'package:campus_pro/src/UI/PAGES/ADMIN_MODULE/EMPLOYEE_ADMIN/addEmployeeAdmin.dart';
import 'package:campus_pro/src/UI/PAGES/ADMIN_MODULE/EMPLOYEE_ADMIN/CoordinatorAssign/coordinatorAssignDetail.dart';
import 'package:campus_pro/src/UI/PAGES/ADMIN_MODULE/EMPLOYEE_ADMIN/employeeDetailAdmin.dart';
import 'package:campus_pro/src/UI/PAGES/ADMIN_MODULE/EMPLOYEE_ADMIN/teacherAssignAdmin.dart';
import 'package:campus_pro/src/UI/PAGES/ADMIN_MODULE/EXAM_ADMIN/Exam_Marks/examMarksAdminDetail.dart';
import 'package:campus_pro/src/UI/PAGES/ADMIN_MODULE/EXAM_ADMIN/Result_Announce_Admin/resultAnnounceAdmin.dart';
import 'package:campus_pro/src/UI/PAGES/ADMIN_MODULE/EXAM_ADMIN/Result_Announce_Admin/resultAnnounceStudentMarks.dart';
import 'package:campus_pro/src/UI/PAGES/ADMIN_MODULE/EXAM_ADMIN/Exam_Marks/examMarksAdmin.dart';
import 'package:campus_pro/src/UI/PAGES/ADMIN_MODULE/FEE_ADMIN/allowDiscountAdmin.dart';
import 'package:campus_pro/src/UI/PAGES/ADMIN_MODULE/FEE_ADMIN/balanceFeeAdmin.dart';
import 'package:campus_pro/src/UI/PAGES/ADMIN_MODULE/FEE_ADMIN/billApproveAdmin.dart';
import 'package:campus_pro/src/UI/PAGES/ADMIN_MODULE/FEE_ADMIN/dayClosingAdmin.dart';
import 'package:campus_pro/src/UI/PAGES/ADMIN_MODULE/FEE_ADMIN/feeCollectionAdmin.dart';
import 'package:campus_pro/src/UI/PAGES/ADMIN_MODULE/FEE_ADMIN/feeCollectionClassWiseAdmin.dart';
import 'package:campus_pro/src/UI/PAGES/ADMIN_MODULE/HOMEWORK_ADMIN/HomeWork_Status_Admin/homeWorkStatusAdmin.dart';
import 'package:campus_pro/src/UI/PAGES/ADMIN_MODULE/HOMEWORK_ADMIN/HomeWork_Status_Admin/homeWorkStatusStudentHwListAdmin.dart';
import 'package:campus_pro/src/UI/PAGES/ADMIN_MODULE/HOMEWORK_ADMIN/Previous_HW_Not_Done_Admin/previousHWNotDoneStudentListAdmin.dart';
import 'package:campus_pro/src/UI/PAGES/ADMIN_MODULE/HOMEWORK_ADMIN/Previous_HW_Not_Done_Admin/previousHomeWorkNotDoneAdmin.dart';
import 'package:campus_pro/src/UI/PAGES/ADMIN_MODULE/SETTINGS_ADMIN/manageMenuAdmin.dart';
import 'package:campus_pro/src/UI/PAGES/ADMIN_MODULE/SETTINGS_ADMIN/popUpConfigureAdmin.dart';
import 'package:campus_pro/src/UI/PAGES/ADMIN_MODULE/SETTINGS_ADMIN/smsConfigureAdmin.dart';
import 'package:campus_pro/src/UI/PAGES/ADMIN_MODULE/STUDENT_ADMIN/studentDetailAdmin.dart';
import 'package:campus_pro/src/UI/PAGES/ADMIN_MODULE/STUDENT_ADMIN/admissionStatusAdmin.dart';
import 'package:campus_pro/src/UI/PAGES/ADMIN_MODULE/TEACHER_CLASS_STATUS/teacherClassStatus.dart';
import 'package:campus_pro/src/UI/PAGES/ADMIN_MODULE/examAnalysisAdmin.dart';
import 'package:campus_pro/src/UI/PAGES/EMPLOYEE_MODULE/ATTENDANCE_EMPLOYEE/attendanceDetail.dart';
import 'package:campus_pro/src/UI/PAGES/EMPLOYEE_MODULE/ATTENDANCE_EMPLOYEE/attendanceEmployee.dart';
import 'package:campus_pro/src/UI/PAGES/EMPLOYEE_MODULE/ATTENDANCE_EMPLOYEE/attendanceReportEmployee.dart';
import 'package:campus_pro/src/UI/PAGES/EMPLOYEE_MODULE/ATTENDANCE_EMPLOYEE/markAttendanceEmployee.dart';
import 'package:campus_pro/src/UI/PAGES/EMPLOYEE_MODULE/ATTENDANCE_EMPLOYEE/excelReport.dart';
import 'package:campus_pro/src/UI/PAGES/EMPLOYEE_MODULE/COMMUNICATION_EMPLOYEE/CIRCULAR_EMPLOYEE/addCircularEmploye.dart';
import 'package:campus_pro/src/UI/PAGES/EMPLOYEE_MODULE/COMMUNICATION_EMPLOYEE/CIRCULAR_EMPLOYEE/circularEmployee.dart';
import 'package:campus_pro/src/UI/PAGES/EMPLOYEE_MODULE/COMMUNICATION_EMPLOYEE/CLASS_ROOM_EMPLOYEE/addClassRoomEmployee.dart';
import 'package:campus_pro/src/UI/PAGES/EMPLOYEE_MODULE/COMMUNICATION_EMPLOYEE/CLASS_ROOM_EMPLOYEE/classroomEmployee.dart';
import 'package:campus_pro/src/UI/PAGES/EMPLOYEE_MODULE/COMMUNICATION_EMPLOYEE/CLASS_ROOM_EMPLOYEE/homeworkEmployee.dart';
import 'package:campus_pro/src/UI/PAGES/EMPLOYEE_MODULE/EMPLOYEE_CALENDAR/applyLeaveEmployeeCal.dart';
import 'package:campus_pro/src/UI/PAGES/EMPLOYEE_MODULE/EMPLOYEE_CALENDAR/calendarEmployeeCalendar.dart';
import 'package:campus_pro/src/UI/PAGES/EMPLOYEE_MODULE/EXAM_EMPLOYEE/cceAttendanceEmployee.dart';
import 'package:campus_pro/src/UI/PAGES/EMPLOYEE_MODULE/EXAM_EMPLOYEE/cceTeacherRemarks.dart';
import 'package:campus_pro/src/UI/PAGES/EMPLOYEE_MODULE/EXAM_EMPLOYEE/changeRollNumberEmployee.dart';
import 'package:campus_pro/src/UI/PAGES/EMPLOYEE_MODULE/EXAM_EMPLOYEE/examMarkEntryEmployee.dart';
import 'package:campus_pro/src/UI/PAGES/EMPLOYEE_MODULE/EXAM_EMPLOYEE/subjectSkillEntry/subjectListEntryEmployee.dart';
import 'package:campus_pro/src/UI/PAGES/EMPLOYEE_MODULE/EXAM_EMPLOYEE/subjectSkillEntry/subjectListEntrySearchEmployee.dart';
import 'package:campus_pro/src/UI/PAGES/EMPLOYEE_MODULE/LEAVE_EMPLOYEE/studentLeaveEmployee.dart';
import 'package:campus_pro/src/UI/PAGES/EMPLOYEE_MODULE/MY_ACCOUNT_EMPLOYEE/profileEmployee.dart';
import 'package:campus_pro/src/UI/PAGES/EMPLOYEE_MODULE/WEEK_PLAN_EMPLOYEE/addPlanEmployee.dart';
import 'package:campus_pro/src/UI/PAGES/EMPLOYEE_MODULE/WEEK_PLAN_EMPLOYEE/updatePlanEmployee.dart';
import 'package:campus_pro/src/UI/PAGES/EMPLOYEE_MODULE/checkTestSheet.dart';
import 'package:campus_pro/src/UI/PAGES/EMPLOYEE_MODULE/feeBalanceEmployee.dart';
import 'package:campus_pro/src/UI/PAGES/EMPLOYEE_MODULE/hrEmployee.dart';
import 'package:campus_pro/src/UI/PAGES/GATE_PASS/gate_pass_history.dart';
import 'package:campus_pro/src/UI/PAGES/GATE_PASS/visitor_gate_pass.dart';
import 'package:campus_pro/src/UI/PAGES/GATE_PASS/visitor_gate_pass_history.dart';
import 'package:campus_pro/src/UI/PAGES/MANAGER_MODULE/Communication/manageNotice.dart';
import 'package:campus_pro/src/UI/PAGES/MANAGER_MODULE/Communication/previousManageNotice.dart';
import 'package:campus_pro/src/UI/PAGES/MANAGER_MODULE/EMPLOYEE_CALENDAR/approveLeaveEmpCal.dart';
import 'package:campus_pro/src/UI/PAGES/MANAGER_MODULE/EMPLOYEE_CALENDAR/approveProxy.dart';
import 'package:campus_pro/src/UI/PAGES/MANAGER_MODULE/ptmRemark.dart';
import 'package:campus_pro/src/UI/PAGES/PARENT/parentDashboard.dart';
import 'package:campus_pro/src/UI/PAGES/STAND_ALONE_PAGES/ENQUIRY_MANAGEMENT/addNewEnquiry.dart';
import 'package:campus_pro/src/UI/PAGES/STAND_ALONE_PAGES/ENQUIRY_MANAGEMENT/enquiryDetailsEnquiry.dart';
import 'package:campus_pro/src/UI/PAGES/STAND_ALONE_PAGES/MANAGE_USER/appUserStatus.dart';
import 'package:campus_pro/src/UI/PAGES/STAND_ALONE_PAGES/MANAGE_USER/employeeUserStatus.dart';
import 'package:campus_pro/src/UI/PAGES/STAND_ALONE_PAGES/MANAGE_USER/otpStatus.dart';
import 'package:campus_pro/src/UI/PAGES/STAND_ALONE_PAGES/MANAGE_USER/studentUserStatus.dart';
import 'package:campus_pro/src/UI/PAGES/STAND_ALONE_PAGES/MEETING/meetingStatus.dart';
import 'package:campus_pro/src/UI/PAGES/STAND_ALONE_PAGES/MEETING/scheduleClass.dart';
import 'package:campus_pro/src/UI/PAGES/STAND_ALONE_PAGES/MEETING/scheduleStaffMeeting.dart';
import 'package:campus_pro/src/UI/PAGES/STAND_ALONE_PAGES/SCHOOL_BUS_TRACKING/schoolBusHistory.dart';
import 'package:campus_pro/src/UI/PAGES/STAND_ALONE_PAGES/SCHOOL_BUS_TRACKING/schoolBusInfo.dart';
import 'package:campus_pro/src/UI/PAGES/STAND_ALONE_PAGES/SCHOOL_BUS_TRACKING/schoolBusStops.dart';
import 'package:campus_pro/src/UI/PAGES/STAND_ALONE_PAGES/Task_Management/addTask.dart';
import 'package:campus_pro/src/UI/PAGES/STAND_ALONE_PAGES/cceGradeEntry.dart';
import 'package:campus_pro/src/UI/PAGES/STAND_ALONE_PAGES/chatRoomCommon.dart';
import 'package:campus_pro/src/UI/PAGES/STAND_ALONE_PAGES/contactList.dart';
import 'package:campus_pro/src/UI/PAGES/STAND_ALONE_PAGES/enquiryManagement.dart';
import 'package:campus_pro/src/UI/PAGES/STAND_ALONE_PAGES/goToSite.dart';
import 'package:campus_pro/src/UI/PAGES/STAND_ALONE_PAGES/meetingConfigure.dart';
import 'package:campus_pro/src/UI/PAGES/STAND_ALONE_PAGES/SCHOOL_BUS_TRACKING/schoolBusList.dart';
import 'package:campus_pro/src/UI/PAGES/STAND_ALONE_PAGES/Task_Management/taskManagement.dart';
import 'package:campus_pro/src/UI/PAGES/STAND_ALONE_PAGES/Task_Management/taskManagementDetail.dart';
import 'package:campus_pro/src/UI/PAGES/STAND_ALONE_PAGES/activity.dart';
import 'package:campus_pro/src/UI/PAGES/schoolBusLocation.dart';
import 'package:campus_pro/src/UI/PAGES/ADMIN_MODULE/STUDENT_ADMIN/studentRemarkAdmin.dart';
import 'package:campus_pro/src/UI/PAGES/forgotPassword.dart';
import 'package:campus_pro/src/UI/PAGES/log_in_screen.dart';
import 'package:campus_pro/src/UI/PAGES/splashScreen.dart';
import 'package:campus_pro/src/UI/PAGES/account_type_screen.dart';
import 'package:campus_pro/src/UI/WIDGETS/bottomNavigation.dart';
import 'package:campus_pro/src/UI/WIDGETS/googlePermission.dart';
import 'package:campus_pro/src/UI/WIDGETS/searchEmployeeFromRecordsCommon.dart';
import 'package:campus_pro/src/UI/WIDGETS/searchStudentFromRecordsCommon.dart';
import 'package:campus_pro/src/gotoWeb.dart';
import 'package:flutter/material.dart';
import 'UI/PAGES/EMPLOYEE_MODULE/COMMUNICATION_EMPLOYEE/SEND_HOMEWORK_EMPLOYEE/createHomeWorkEmployee.dart';
import 'UI/PAGES/EMPLOYEE_MODULE/LEAVE_EMPLOYEE/studentLeaveEmployeepending.dart';
import 'UI/PAGES/STAND_ALONE_PAGES/notifications.dart';

_page(Widget page) {
  return MaterialPageRoute(builder: (_) => page);
}

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case SplashScreen.routeName:
        return _page(
          SplashScreen(),
        );
      case LogInScreen.routeName:
        return _page(
          LogInScreen(),
        );
      // case Dashboard.routeName:
      //   return _page(
      //     Dashboard(userType: args as String),
      //   );
      // case FeePaymentStudent.routeName:
      //   return _page(
      //     FeePaymentStudent(),
      //   );
      // case AttendanceStudent.routeName:
      //   return _page(
      //     AttendanceStudent(),
      //   );
      // case PayByChequeStudent.routeName:
      //   return _page(
      //     PayByChequeStudent(feeData: args as Map<String, String>),
      //   );
      case AccountTypeScreen.routeName:
        return _page(
          AccountTypeScreen(),
        );
      // case ProfileStudent.routeName:
      //   return _page(
      //     ProfileStudent(),
      //   );
      // case ProfileEditRequest.routeName:
      //   return _page(
      //     ProfileEditRequest(profileData: args as ProfileStudentModel),
      //   );
      // case HomeWorkStudent.routeName:
      //   return _page(
      //     HomeWorkStudent(),
      //   );
      // case ClassRoomsStudent.routeName:
      //   return _page(
      //     ClassRoomsStudent(),
      //   );
      case ClassroomEmployee.routeName:
        return _page(
          ClassroomEmployee(),
        );
      case ContactList.routeName:
        return _page(
          ContactList(),
        );
      case ChatRoomCommon.routeName:
        return _page(
          ChatRoomCommon(chatData: args as ChatRoomCommonModel),
        );
      case Notifications.routeName:
        return _page(
          Notifications(),
        );
      // case ChangePasswordStudent.routeName:
      //   return _page(
      //     ChangePasswordStudent(),
      //   );
      // case FeedbackStudent.routeName:
      //   return _page(
      //     FeedbackStudent(),
      //   );
      // case CircularStudent.routeName:
      //   return _page(
      //     CircularStudent(),
      //   );
      // case DateSheetStudent.routeName:
      //   return _page(
      //     DateSheetStudent(),
      //   );
      // case MarkSheetStudent.routeName:
      //   return _page(
      //     MarkSheetStudent(userType: args as String),
      //   );
      // case OpenMarksheet.routeName:
      //   return _page(
      //     OpenMarksheet(marksheet: args as MarkSheetStudentModel),
      //   );
      case StudentRemarkAdmin.routeName:
        return _page(
          StudentRemarkAdmin(),
        );
      // case StudentDetailAdmin.routeName:
      //   return _page(
      //     StudentDetailAdmin(),
      //   );
      case StudentDetailsAdmin.routeName:
        return _page(
          StudentDetailsAdmin(),
        );
      case AdmissionStatusAdmin.routeName:
        return _page(
          AdmissionStatusAdmin(),
        );
      case AddNewRemark.routeName:
        return _page(
          AddNewRemark(),
        );
      case ScheduleClass.routeName:
        return _page(
          ScheduleClass(),
        );
      case ScheduleStaffMeeting.routeName:
        return _page(
          ScheduleStaffMeeting(),
        );
      case MeetingStatus.routeName:
        return _page(
          MeetingStatus(),
        );
      // case ExamTestResultStudent.routeName:
      //   return _page(
      //     ExamTestResultStudent(),
      //   );
      case TaskManagement.routeName:
        return _page(
          TaskManagement(userType: args as String),
        );
      case AddTask.routeName:
        return _page(
          AddTask(),
        );
      case TaskManagementDetail.routeName:
        return _page(
          TaskManagementDetail(),
        );
      case Activity.routeName:
        return _page(
          Activity(),
        );

      case MeetingConfigure.routeName:
        return _page(
          MeetingConfigure(),
        );

      case FeeCollectionAdmin.routeName:
        return _page(
          FeeCollectionAdmin(),
        );

      case FeeCollectionClassWiseAdmin.routeName:
        return _page(
          FeeCollectionClassWiseAdmin(),
        );
      case BalanceFeeAdmin.routeName:
        return _page(
          BalanceFeeAdmin(),
        );
      case AllowDiscountAdmin.routeName:
        return _page(
          AllowDiscountAdmin(),
        );
      case DayClosingAdmin.routeName:
        return _page(
          DayClosingAdmin(),
        );
      case BillApproveAdmin.routeName:
        return _page(
          BillApproveAdmin(),
        );

      case StudentUserStatus.routeName:
        return _page(
          StudentUserStatus(),
        );
      case EmployeeUserStatus.routeName:
        return _page(
          EmployeeUserStatus(),
        );
      case AppUserStatus.routeName:
        return _page(
          AppUserStatus(),
        );
      case OtpStatus.routeName:
        return _page(
          OtpStatus(),
        );

      case EnquiryManagement.routeName:
        return _page(
          EnquiryManagement(),
        );
      case CceGradeEntry.routeName:
        return _page(
          CceGradeEntry(),
        );
      // case CalendarStudent.routeName:
      //   return _page(
      //     CalendarStudent(),
      //   );
      case GoToSite.routeName:
        return _page(
          GoToSite(),
        );
      // case OnlineTestStudent.routeName:
      //   return _page(
      //     OnlineTestStudent(),
      //   );
      // case ExamAnalysisStudent.routeName:
      //   return _page(
      //     ExamAnalysisStudent(),
      //   );
      case ExamAnalysisAdmin.routeName:
        return _page(
          ExamAnalysisAdmin(),
        );
      case ForgotPassword.routeName:
        return _page(
          ForgotPassword(),
        );
      case SchoolBusLocation.routeName:
        return _page(
          SchoolBusLocation(),
        );
      case BottomNavigation.routeName:
        return _page(
          BottomNavigation(),
        );
      case ProfileEmployee.routeName:
        return _page(
          ProfileEmployee(),
        );
      case AddNewEnquiry.routeName:
        return _page(
          AddNewEnquiry(updateData: args as ViewEnquiryModel),
        );
      case ChangeRollNumberEmployee.routeName:
        return _page(
          ChangeRollNumberEmployee(),
        );
      case FeeBalance.routeName:
        return _page(
          FeeBalance(),
        );
      case CircularEmployee.routeName:
        return _page(
          CircularEmployee(),
        );
      case StudentLeaveEmployee.routeName:
        return _page(
          StudentLeaveEmployee(),
        );
      case AddCircularEmployee.routeName:
        return _page(
          AddCircularEmployee(),
        );
      case CreateSendHomeWorkEmployee.routeName:
        return _page(
          CreateSendHomeWorkEmployee(),
        );
      case HrEmployee.routeName:
        return _page(
          HrEmployee(),
        );
      case AddPlanEmployee.routeName:
        return _page(
          AddPlanEmployee(),
        );
      case WeekPlanEmployee.routeName:
        return _page(
          WeekPlanEmployee(),
        );
      case CheckAssignSheet.routeName:
        return _page(
          CheckAssignSheet(),
        );
      case MarkAttendance.routeName:
        return _page(
          MarkAttendance(),
        );
      case AttendanceEmployee.routeName:
        return _page(
          AttendanceEmployee(),
        );
      case AttendanceReport.routeName:
        return _page(
          AttendanceReport(),
        );
      case AddPlanEmployee.routeName:
        return _page(
          AddPlanEmployee(),
        );
      case WeekPlanEmployee.routeName:
        return _page(
          WeekPlanEmployee(),
        );
      case StudentLeave.routeName:
        return _page(StudentLeave());

      case EnquiryDetailsEnquiry.routeName:
        return _page(
          EnquiryDetailsEnquiry(updateData: args as ViewEnquiryModel),
        );
      case SendSmsAdmin.routeName:
        return _page(SendSmsAdmin());

      case ExcelReport.routeName:
        return _page(ExcelReport());

      case AttendanceDetail.routeName:
        return _page(AttendanceDetail());

      case HomeWorkStatusAdmin.routeName:
        return _page(HomeWorkStatusAdmin());

      case PreviousHomeWorkNotDoneAdmin.routeName:
        return _page(PreviousHomeWorkNotDoneAdmin());

      case EmployeeDetail.routeName:
        return _page(EmployeeDetail());

      case AddEmployee.routeName:
        return _page(AddEmployee());

      case ResultAnnounce.routeName:
        return _page(ResultAnnounce());

      case ResultAnnounceStudentMarks.routeName:
        return _page(ResultAnnounceStudentMarks());

      case ExamMarksAdmin.routeName:
        return _page(ExamMarksAdmin());

      case ManageMenuAdmin.routeName:
        return _page(ManageMenuAdmin());

      case LeaveApplicationAdmin.routeName:
        return _page(LeaveApplicationAdmin());

      case PreviousHWNotDoneStudentList.routeName:
        return _page(PreviousHWNotDoneStudentList(
          className: args as String,
          classData: args as List<ClassListPrevHwNotDoneStatusModel>,
        ));

      case TeacherAssignAdmin.routeName:
        return _page(TeacherAssignAdmin());

      case HomeWorkStatusStudentHwListAdmin.routeName:
        return _page(HomeWorkStatusStudentHwListAdmin());

      case SuggestionAdmin.routeName:
        return _page(SuggestionAdmin());

      case SuggestionDataAdmin.routeName:
        return _page(SuggestionDataAdmin());

      case SmsConfigureAdmin.routeName:
        return _page(SmsConfigureAdmin());

      case PopUpConfigureAdmin.routeName:
        return _page(PopUpConfigureAdmin());

      case AddNewPopUpConfigureAdmin.routeName:
        return _page(AddNewPopUpConfigureAdmin());

      case SearchEmployeeFromRecordsCommon.routeName:
        return _page(SearchEmployeeFromRecordsCommon());

      case SearchStudentFromRecordsCommon.routeName:
        return _page(SearchStudentFromRecordsCommon());

      case PaymentScreen.routeName:
        return _page(PaymentScreen(gatewayUrl: args as String));

      case ExamMarksDetailAdmin.routeName:
        return _page(ExamMarksDetailAdmin(
          name: args as String,
          rollNo: args,
          admNo: args,
          homeWorkMarks: args,
          internalMarks: args,
          markObt: args,
          practicalMarks: args,
        ));

      case AddClassRoom.routeName:
        return _page(AddClassRoom());

      case CoordinatorAssign.routeName:
        return _page(CoordinatorAssign());

      case ExamMarkEntryEmployee.routeName:
        return _page(ExamMarkEntryEmployee());
      case CoordinatorAssign.routeName:
        return _page(CoordinatorAssign());

      case PreviousManageNotice.routeName:
        return _page(PreviousManageNotice());

      case CceTeacherRemarks.routeName:
        return _page(CceTeacherRemarks());

      case ExamMarkEntryEmployee.routeName:
        return _page(ExamMarkEntryEmployee());

      case ManageNotice.routeName:
        return _page(ManageNotice(
          prevDesc: args as Map<String, String>,
        ));
      case CCEAttendance.routeName:
        return _page(CCEAttendance());

      case SchoolBusList.routeName:
        return _page(SchoolBusList());

      case SchoolBusGridsOptions.routeName:
        return _page(SchoolBusGridsOptions());

      case SchoolBusStops.routeName:
        return _page(SchoolBusStops());

      case SchoolBusHistory.routeName:
        return _page(SchoolBusHistory());

      case SubjectListEntrySearchEmployee.routeName:
        return _page(SubjectListEntrySearchEmployee());

      case SubjectListEntryEmployee.routeName:
        return _page(SubjectListEntryEmployee());

      case HomeworkEmployee.routeName:
        return _page(HomeworkEmployee());

      case CustomChatUserListAdmin.routeName:
        return _page(CustomChatUserListAdmin());

      // case ActivityStudent.routeName:
      //   return _page(ActivityStudent());

      case TeacherClassStatus.routeName:
        return _page(TeacherClassStatus());

      case TeacherClassDateWiseDetails.routeName:
        return _page(TeacherClassDateWiseDetails(
          classDetails: args as List<List>,
        ));

      // case RestrictionPage.routeName:
      //   return _page(RestrictionPage());
      case GooglePermission.routeName:
        return _page(GooglePermission());

      // case PopUpConfigureAdmin.routeName:
      //   return _page(PopUpConfigureAdmin());
      // case OpenExcelFile.routeName:
      //   return _page(OpenExcelFile());

      case VisitorGatePassCheck.routeName:
        return _page(VisitorGatePassCheck());

      case VisitorHistory.routeName:
        return _page(VisitorHistory());

      case SchoolBusInfo.routeName:
        return _page(SchoolBusInfo());

      case GoToWeb.routeName:
        return _page(GoToWeb());

      case GatePassHistory.routeName:
        return _page(GatePassHistory());

      case PtmRemark.routeName:
        return _page(PtmRemark());

      case EmployeeCalendar.routeName:
        return _page(EmployeeCalendar());

      case EmployeeLeaveCal.routeName:
        return _page(EmployeeLeaveCal());

      case ApproveProxy.routeName:
        return _page(ApproveProxy());

      case ApproveLeaveEmpCal.routeName:
        return _page(ApproveLeaveEmpCal());

      ///
      case ParentDashboard.routeName:
        return _page(ParentDashboard());

      ///

      default:
        return _page(SplashScreen());
    }
  }
}
