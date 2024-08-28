
// import 'DATA/BLOC_CUBIT/FEE_BALANCE_GET_CLASS_EMPLOYEE_CUBIT/fee_balance_get_class_cubit.dart';
// import 'UI/PAGES/STAND_ALONE_PAGES/MEETING/scheduleStaffMeeting.dart';
// import 'globalBlocProvidersFile.dart';

// _page(BuildContext context, String page, {String? arguments}) {
//   return Navigator.pushNamed(context, page, arguments: arguments);
// }

// // class DrawerRouter {
// onSelected(BuildContext context,
//     {String? userType, String? menuId, String? subMenuId}) {
//   switch (menuId) {
//     //-----------------STUDENT DRAWER-----------------------------------------//
//     case "1":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<DrawerCubit>(
//           create: (_) => DrawerCubit(DrawerRepository(DrawerApi())),
//           child: BlocProvider<NotifyCounterCubit>(
//               create: (_) => NotifyCounterCubit(
//                   NotifyCounterRepository(NotifyCounterApi())),
//               child: Dashboard(
//                 userType: userType,
//               )),
//         );
//       }));
//     // return _page(context, Dashboard.routeName, arguments: userType);
//     case "2":
//       getSubMenu(context, subMenu: subMenuId, userType: userType);
//       break;
//     case "3":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<NotificationsCubit>(
//           create: (_) =>
//               NotificationsCubit(NotificationsRepository(NotificationsApi())),
//           child: Notifications(),
//         );
//       }));
//     // return _page(context, Notifications.routeName);
//     case "4":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<FeeTransactionHistoryCubit>(
//           create: (_) => FeeTransactionHistoryCubit(
//               FeeTransactionHistoryRepository(FeeTransactionHistoryApi())),
//           child: BlocProvider<FeeReceiptsCubit>(
//             create: (_) =>
//                 FeeReceiptsCubit(FeeReceiptsRepository(FeeReceiptsApi())),
//             child: BlocProvider<StudentFeeFineCubit>(
//               create: (_) => StudentFeeFineCubit(
//                   StudentFeeFineRepository(StudentFeeFineApi())),
//               child: BlocProvider<StudentFeeReceiptCubit>(
//                 create: (_) => StudentFeeReceiptCubit(
//                     StudentFeeReceiptRepository(StudentFeeReceiptApi())),
//                 child: BlocProvider<FeeTypeCubit>(
//                   create: (_) => FeeTypeCubit(FeeTypeRepository(FeeTypeApi())),
//                   child: BlocProvider<FeeMonthsCubit>(
//                     create: (_) =>
//                         FeeMonthsCubit(FeeMonthsRepository(FeeMonthsApi())),
//                     child: BlocProvider<TermsConditionsSettingCubit>(
//                       create: (_) => TermsConditionsSettingCubit(
//                           TermsConditionsSettingRepository(
//                               TermsConditionsSettingApi())),
//                       child: BlocProvider<FeeTypeSettingCubit>(
//                         create: (_) => FeeTypeSettingCubit(
//                             FeeTypeSettingRepository(FeeTypeSettingApi())),
//                         child: BlocProvider<StudentInfoCubit>(
//                           create: (_) => StudentInfoCubit(
//                               StudentInfoRepository(StudentInfoApi())),
//                           child: BlocProvider<PayUBizHashCubit>(
//                             create: (_) => PayUBizHashCubit(
//                                 PayUBizHashRepository(PayUBizHashApi())),
//                             child: BlocProvider<GatewayTypeCubit>(
//                               create: (_) => GatewayTypeCubit(
//                                   GatewayTypeRepository(GatewayTypeApi())),
//                               child: FeePaymentStudent(),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       }));

//     // return _page(context, FeePaymentStudent.routeName);
//     case "5":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<ActivityCubit>(
//           create: (_) => ActivityCubit(ActivityRepository(ActivityApi())),
//           child: BlocProvider<DeleteActivityCubit>(
//             create: (_) => DeleteActivityCubit(
//                 DeleteActivityRepository(DeleteActivityApi())),
//             child: Activity(),
//           ),
//         );
//       }));
//     // return _page(context, Activity.routeName);
//     case "6":
//       getSubMenu(context, subMenu: subMenuId, userType: userType);
//       break;
//     case "7":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<CalenderStudentCubit>(
//           create: (_) => CalenderStudentCubit(
//               CalenderStudentRepository(CalenderStudentApi())),
//           child: CalendarStudent(),
//         );
//       }));
//     // return _page(context, CalendarStudent.routeName);
//     case "8":
//       return _page(context, GoToSite.routeName);
//     case "9":
//       getSubMenu(context, subMenu: subMenuId, userType: userType);
//       break;
//     case "11":
//       getSubMenu(context, subMenu: subMenuId, userType: userType);
//       break;
//     case "12":
//       getSubMenu(context, subMenu: subMenuId, userType: userType);
//       break;
//     case "13":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<LeaveRequestCubit>(
//           create: (_) =>
//               LeaveRequestCubit(LeaveRequestRepository(LeaveRequestApi())),
//           child: BlocProvider<AttendanceGraphCubit>(
//             create: (_) => AttendanceGraphCubit(
//                 AttendanceGraphRepository(AttendanceGraphApi())),
//             child: BlocProvider<ApplyForLeaveCubit>(
//               create: (_) => ApplyForLeaveCubit(
//                   ApplyForLeaveRepository(ApplyForLeaveApi())),
//               child: AttendanceStudent(),
//             ),
//           ),
//         );
//       }));
//     // return _page(context, AttendanceStudent.routeName);
//     case "14":
//       getSubMenu(context, subMenu: subMenuId, userType: userType);
//       break;
//     case "17":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<DrawerCubit>(
//           create: (_) => DrawerCubit(DrawerRepository(DrawerApi())),
//           child: BlocProvider<NotifyCounterCubit>(
//               create: (_) => NotifyCounterCubit(
//                   NotifyCounterRepository(NotifyCounterApi())),
//               child: Dashboard(
//                 userType: userType,
//               )),
//         );
//       }));
//     // return _page(context, Dashboard.routeName, arguments: userType);
//     case "19":
//       getSubMenu(context, subMenu: subMenuId, userType: userType);
//       break;
//     case "20":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<DrawerCubit>(
//           create: (_) => DrawerCubit(DrawerRepository(DrawerApi())),
//           child: BlocProvider<NotifyCounterCubit>(
//               create: (_) => NotifyCounterCubit(
//                   NotifyCounterRepository(NotifyCounterApi())),
//               child: Dashboard(
//                 userType: userType,
//               )),
//         );
//       }));
//     // return _page(context, Dashboard.routeName, arguments: userType);
//     case "21":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<DrawerCubit>(
//           create: (_) => DrawerCubit(DrawerRepository(DrawerApi())),
//           child: BlocProvider<NotifyCounterCubit>(
//               create: (_) => NotifyCounterCubit(
//                   NotifyCounterRepository(NotifyCounterApi())),
//               child: Dashboard(
//                 userType: userType,
//               )),
//         );
//       }));
//     // return _page(context, Dashboard.routeName, arguments: userType);
//     case "22":
//       getSubMenu(context, subMenu: subMenuId, userType: userType);
//       break;
//     case "25":
//       getSubMenu(context, subMenu: subMenuId, userType: userType);
//       break;
//     case "26":
//       getSubMenu(context, subMenu: subMenuId, userType: userType);
//       break;
//     case "27":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<FeeBalanceEmployeeCubit>(
//           create: (_) => FeeBalanceEmployeeCubit(
//               FeeBalanceEmployeeRepository(FeeBalanceEmployeeApi())),
//           child: BlocProvider<FeeBalanceMonthListCubit>(
//             create: (_) => FeeBalanceMonthListCubit(
//                 FeeBalanceMonthListEmployeeRepository(
//                     FeeBalanceMonthListEmployeeApi())),
//             child: BlocProvider<FeeBalanceClassListEmployeeCubit>(
//               create: (_) => FeeBalanceClassListEmployeeCubit(
//                   FeeBalanceClassListEmployeeRepository(
//                       FeeBalanceClassListEmployeeApi())),
//               child: BlocProvider<FeeTypeCubit>(
//                   create: (_) => FeeTypeCubit(FeeTypeRepository(FeeTypeApi())),
//                   child: FeeBalance()),
//             ),
//           ),
//         );
//       }));
//     // return _page(context, FeeBalance.routeName);
//     case "28":
//       getSubMenu(context, subMenu: subMenuId, userType: userType);
//       break;
//     case "29":
//       getSubMenu(context, subMenu: subMenuId, userType: userType);
//       break;
//     case "30":
//       return _page(context, FeedbackStudent.routeName);
//     case "31":
//       getSubMenu(context, subMenu: subMenuId, userType: userType);
//       break;
//     case "33":
//       return _page(context, EnquiryManagement.routeName);
//     case "34":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<GetTeskDataEmployeeCubit>(
//           create: (_) => GetTeskDataEmployeeCubit(
//               GetTaskDataEmployeeRepository(GetTaskDataEmployeeApi())),
//           child: BlocProvider<GetTaskDataCubit>(
//             create: (_) =>
//                 GetTaskDataCubit(GetTaskDataRepository(GetTaskDataApi())),
//             child: BlocProvider<GetTaskListByIdCubit>(
//               create: (_) => GetTaskListByIdCubit(
//                   GetTaskListByIdRepository(GetTaskListByIdApi())),
//               child: BlocProvider<GetTaskTaskManagementCubit>(
//                 create: (_) => GetTaskTaskManagementCubit(
//                     GetEmployeeTaskManagementRepository(
//                         GetEmployeeTaskManagementApi())),
//                 child: BlocProvider<GetEmployeeTaskManagementCubit>(
//                   create: (_) => GetEmployeeTaskManagementCubit(
//                       GetEmployeeTaskManagementRepository(
//                           GetEmployeeTaskManagementApi())),
//                   child: BlocProvider<DeleteTaskDetailCubit>(
//                       create: (_) => DeleteTaskDetailCubit(
//                           SaveTaskDetailsRepository(SaveTaskDetailsApi())),
//                       child: TaskManagement(
//                         userType: userType,
//                       )),
//                 ),
//               ),
//             ),
//           ),
//         );
//       }));
//     // return _page(context, TaskManagement.routeName, arguments: userType);
//     case "35":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<DrawerCubit>(
//           create: (_) => DrawerCubit(DrawerRepository(DrawerApi())),
//           child: BlocProvider<NotifyCounterCubit>(
//               create: (_) => NotifyCounterCubit(
//                   NotifyCounterRepository(NotifyCounterApi())),
//               child: Dashboard(
//                 userType: userType,
//               )),
//         );
//       }));
//     // return _page(context, Dashboard.routeName, arguments: userType);
//     case "37":
//       return _page(context, HrEmployee.routeName);
//     // return _page(context, CheckAssignSheet.routeName);
//     case "38":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<DrawerCubit>(
//           create: (_) => DrawerCubit(DrawerRepository(DrawerApi())),
//           child: BlocProvider<NotifyCounterCubit>(
//               create: (_) => NotifyCounterCubit(
//                   NotifyCounterRepository(NotifyCounterApi())),
//               child: Dashboard(
//                 userType: userType,
//               )),
//         );
//       }));
//     //   return _page(context, VisitorGatePassNew.routeName);
//     // return _page(context, Dashboard.routeName, arguments: userType);
//     case "40":
//       return _page(context, CceGradeEntry.routeName);
//     // case "41":
//     //   return _page(context, MeetingConfigure.routeName);

//     case "42":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<DrawerCubit>(
//           create: (_) => DrawerCubit(DrawerRepository(DrawerApi())),
//           child: BlocProvider<NotifyCounterCubit>(
//               create: (_) => NotifyCounterCubit(
//                   NotifyCounterRepository(NotifyCounterApi())),
//               child: Dashboard(
//                 userType: userType,
//               )),
//         );
//       }));
//     // return _page(context, Dashboard.routeName, arguments: userType);
//     case "43":
//       {
//         return Navigator.push(context, MaterialPageRoute(builder: (context) {
//           return BlocProvider<SchoolBusDetailCubit>(
//             create: (_) => SchoolBusDetailCubit(
//                 SchoolBusDetailRepository(SchoolBusDetailApi())),
//             child: BlocProvider<SchoolBusRouteCubit>(
//                 create: (_) => SchoolBusRouteCubit(
//                     SchoolBusRouteRepository(SchoolBusRouteApi())),
//                 child: BlocProvider<CheckBusAllotCubit>(
//                   create: (_) => CheckBusAllotCubit(
//                       CheckBusAllotRepository(CheckBusAllotApi())),
//                   child: SchoolBusLocation(),
//                 )),
//           );
//         }));

//         // _page(context, SchoolBusLocation.routeName);
//       }
//     case "49":
//       if (userType!.toLowerCase() == "a") {
//         // return _page(context, ExamAnalysisAdmin.routeName);
//         return Navigator.push(context, MaterialPageRoute(builder: (context) {
//           return BlocProvider<ExamAnalysisChartAdminCubit>(
//             create: (_) => ExamAnalysisChartAdminCubit(
//                 ExamAnalysisChartAdminRepository(ExamAnalysisChartAdminApi())),
//             child: BlocProvider<SubjectListExamAnalysisCubit>(
//               create: (_) => SubjectListExamAnalysisCubit(
//                   SubjectListExamAnalysisRepository(
//                       SubjectListExamAnalysisApi())),
//               child: BlocProvider<ExamsListExamAnalysisCubit>(
//                 create: (_) => ExamsListExamAnalysisCubit(
//                     ExamsListExamAnalysisRepository(
//                         ExamsListExamAnalysisApi())),
//                 child: BlocProvider<SectionListAttendanceAdminCubit>(
//                   create: (_) => SectionListAttendanceAdminCubit(
//                       SectionListAttendanceAdminRepository(
//                           SectionListAttendanceAdminApi())),
//                   child: BlocProvider<ResultAnnounceClassCubit>(
//                     create: (_) => ResultAnnounceClassCubit(
//                         ResultAnnounceClassRepository(
//                             ResultAnnounceClassApi())),
//                     child: BlocProvider<YearSessionCubit>(
//                       create: (_) => YearSessionCubit(
//                           YearSessionRepository(YearSessionApi())),
//                       child: ExamAnalysisAdmin(),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           );
//         }));
//       } else {
//         return Navigator.push(context, MaterialPageRoute(builder: (context) {
//           return BlocProvider<ExamAnalysisLineChartCubit>(
//             create: (_) => ExamAnalysisLineChartCubit(
//                 ExamAnalysisLineChartRepository(ExamAnalysisLineChartApi())),
//             child: BlocProvider<ExamAnalysisChartCubit>(
//               create: (_) => ExamAnalysisChartCubit(
//                   ExamAnalysisChartRepository(ExamAnalysisChartApi())),
//               child: BlocProvider<ExamsListExamAnalysisCubit>(
//                 create: (_) => ExamsListExamAnalysisCubit(
//                     ExamsListExamAnalysisRepository(
//                         ExamsListExamAnalysisApi())),
//                 child: BlocProvider<YearSessionListExamAnalysisCubit>(
//                   create: (_) => YearSessionListExamAnalysisCubit(
//                       YearSessionListExamAnalysisRepository(
//                           YearSessionListExamAnalysisApi())),
//                   child: ExamAnalysisStudent(),
//                 ),
//               ),
//             ),
//           );
//         }));
//         // return _page(context, ExamAnalysisStudent.routeName);
//       }
//     case "50":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<SchoolBusListCubit>(
//           create: (_) =>
//               SchoolBusListCubit(SchoolBusListRepository(SchoolBusListApi())),
//           child: SchoolBusList(),
//         );
//       }));
//     // return _page(context, SchoolBusList.routeName, arguments: userType);

//     case "51":
//       getSubMenu(context, subMenu: subMenuId, userType: userType);
//       break;
//     case "54":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<LeaveRequestCubit>(
//           create: (_) =>
//               LeaveRequestCubit(LeaveRequestRepository(LeaveRequestApi())),
//           child: BlocProvider<AttendanceGraphCubit>(
//             create: (_) => AttendanceGraphCubit(
//                 AttendanceGraphRepository(AttendanceGraphApi())),
//             child: BlocProvider<ApplyForLeaveCubit>(
//               create: (_) => ApplyForLeaveCubit(
//                   ApplyForLeaveRepository(ApplyForLeaveApi())),
//               child: AttendanceStudent(),
//             ),
//           ),
//         );
//       }));
//     // return _page(context, AttendanceStudent.routeName, arguments: userType);

//     case "60":
//       getSubMenu(context, subMenu: subMenuId, userType: userType);
//       break;

//     default:
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<DrawerCubit>(
//           create: (_) => DrawerCubit(DrawerRepository(DrawerApi())),
//           child: BlocProvider<NotifyCounterCubit>(
//               create: (_) => NotifyCounterCubit(
//                   NotifyCounterRepository(NotifyCounterApi())),
//               child: Dashboard(
//                 userType: userType,
//               )),
//         );
//       }));
//     // return _page(context, Dashboard.routeName, arguments: userType);
//   }
// }

// getSubMenu(BuildContext context, {String? subMenu, String? userType}) {
//   switch (subMenu) {
//     case "1":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<HomeWorkStudentCubit>(
//           create: (_) => HomeWorkStudentCubit(
//               HomeWorkStudentRepository(HomeWorkStudentApi())),
//           child: HomeWorkStudent(),
//         );
//       }));

//     // return _page(context, HomeWorkStudent.routeName);
//     case "2":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<ClassRoomsStudentCubit>(
//           create: (_) => ClassRoomsStudentCubit(
//               ClassRoomsStudentRepository(ClassRoomsStudentApi())),
//           child: BlocProvider<ClassEndDrawerLocalCubit>(
//             create: (_) => ClassEndDrawerLocalCubit(),
//             child: BlocProvider<TeachersListCubit>(
//               create: (_) =>
//                   TeachersListCubit(TeachersListRepository(TeachersListApi())),
//               child: BlocProvider<SendCustomClassRoomCommentCubit>(
//                 create: (_) => SendCustomClassRoomCommentCubit(
//                     SendCustomClassRoomCommentRepository(
//                         SendCustomClassRoomCommentApi())),
//                 child: ClassRoomsStudent(),
//               ),
//             ),
//           ),
//         );
//       }));
//     // return _page(context, ClassRoomsStudent.routeName);
//     case "3":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<CircularStudentCubit>(
//           create: (_) => CircularStudentCubit(
//               CircularStudentRepository(CircularStudentApi())),
//           child: CircularStudent(),
//         );
//       }));
//     // return _page(context, CircularStudent.routeName);
//     case "4":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<MarkSheetStudentCubit>(
//           create: (_) => MarkSheetStudentCubit(
//               MarkSheetStudentRepository(MarkSheetStudentApi())),
//           child: BlocProvider<ClassListCubit>(
//             create: (_) => ClassListCubit(ClassListRepository(ClassListApi())),
//             child: BlocProvider<StudentSessionCubit>(
//               create: (_) => StudentSessionCubit(
//                   StudentSessionRepository(StudentSessionApi())),
//               child: BlocProvider<StudentChoiceSessionCubit>(
//                 create: (_) => StudentChoiceSessionCubit(
//                     StudentChoiceSessionRepository(StudentChoiceSessionApi())),
//                 child: BlocProvider<OpenMarksheetCubit>(
//                   create: (_) => OpenMarksheetCubit(
//                       OpenMarksheetRepository(OpenMarksheetApi())),
//                   child: MarkSheetStudent(),
//                 ),
//               ),
//             ),
//           ),
//         );
//       }));
//     // return _page(context, MarkSheetStudent.routeName);
//     case "5":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<DateSheetStudentCubit>(
//           create: (_) => DateSheetStudentCubit(
//               DateSheetStudentRepository(DateSheetStudentApi())),
//           child: DateSheetStudent(),
//         );
//       }));
//     // return _page(context, DateSheetStudent.routeName);
//     case "6":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<OnlineTestStudentCubit>(
//           create: (_) => OnlineTestStudentCubit(
//               OnlineTestStudentRepository(OnlineTestStudentApi())),
//           child: OnlineTestStudent(),
//         );
//       }));
//     // return _page(context, OnlineTestStudent.routeName);
//     case "7":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<OnlineTestStudentCubit>(
//           create: (_) => OnlineTestStudentCubit(
//               OnlineTestStudentRepository(OnlineTestStudentApi())),
//           child: ExamTestResultStudent(),
//         );
//       }));
//     // return _page(context, ExamTestResultStudent.routeName);
//     case "8":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<ClassroomEmployeeCubit>(
//           create: (_) => ClassroomEmployeeCubit(
//               ClassroomEmployeeRepository(ClassroomEmployeeApi())),
//           child: BlocProvider<EmployeeInfoForSearchCubit>(
//             create: (_) => EmployeeInfoForSearchCubit(
//                 EmployeeInfoForSearchRepository(EmployeeInfoForSearchApi())),
//             child: BlocProvider<DeleteClassroomCubit>(
//               create: (_) => DeleteClassroomCubit(
//                   DeleteClassroomRepository(DeleteClassroomApi())),
//               child: BlocProvider<ClassListEmployeeCubit>(
//                 create: (_) => ClassListEmployeeCubit(
//                     ClassListEmployeeRepository(ClassListEmployeeApi())),
//                 child: BlocProvider<SubjectListEmployeeCubit>(
//                   create: (_) => SubjectListEmployeeCubit(
//                       SubjectListEmployeeRepository(SubjectListEmployeeApi())),
//                   child: ClassroomEmployee(),
//                 ),
//               ),
//             ),
//           ),
//         );
//       }));
//     // return _page(context, ClassroomEmployee.routeName);
//     case "10":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<CircularEmployeeCubit>(
//           create: (_) => CircularEmployeeCubit(
//               CircularEmployeeRepository(CircularEmployeeApi())),
//           child: BlocProvider<DeleteCircularCubit>(
//             create: (_) => DeleteCircularCubit(
//                 DeleteCircularRepository(DeleteCircularApi())),
//             child: CircularEmployee(),
//           ),
//         );
//       }));
//     // return _page(context, CircularEmployee.routeName);
//     case "11":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<HomeworkEmployeeCubit>(
//           create: (_) => HomeworkEmployeeCubit(
//               HomeworkEmployeeRepository(HomeworkEmployeeApi())),
//           child: BlocProvider<EmployeeInfoForSearchCubit>(
//             create: (_) => EmployeeInfoForSearchCubit(
//                 EmployeeInfoForSearchRepository(EmployeeInfoForSearchApi())),
//             child: BlocProvider<DeleteHomeworkCubit>(
//               create: (_) => DeleteHomeworkCubit(
//                   DeleteHomeworkRepository(DeleteHomeworkApi())),
//               child: BlocProvider<ClassListEmployeeCubit>(
//                 create: (_) => ClassListEmployeeCubit(
//                     ClassListEmployeeRepository(ClassListEmployeeApi())),
//                 child: BlocProvider<SubjectListEmployeeCubit>(
//                   create: (_) => SubjectListEmployeeCubit(
//                       SubjectListEmployeeRepository(SubjectListEmployeeApi())),
//                   child: HomeworkEmployee(),
//                 ),
//               ),
//             ),
//           ),
//         );
//       }));
//     // return _page(context, HomeworkEmployee.routeName);
//     case "12":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<GetExamMarksForTeacherCubit>(
//           create: (_) => GetExamMarksForTeacherCubit(
//               GetExamMarksForTeacherRepository(GetExamMarksForTeacherApi())),
//           child: BlocProvider<GetMinMaxMarksCubit>(
//             create: (_) => GetMinMaxMarksCubit(
//                 GetMinMaxmarksRepository(GetMinMaxMarksApi())),
//             child: BlocProvider<GetExamMarksForTeacherCubit>(
//               create: (_) => GetExamMarksForTeacherCubit(
//                   GetExamMarksForTeacherRepository(
//                       GetExamMarksForTeacherApi())),
//               child: BlocProvider<SaveExamMarksCubit>(
//                 create: (_) => SaveExamMarksCubit(
//                     SaveExamMarksRepository(SaveExamMarksApi())),
//                 child: BlocProvider<SubjectExamMarksCubit>(
//                   create: (_) => SubjectExamMarksCubit(
//                       SubjectExamMarksRepository(SubjectExamMarksApi())),
//                   child: BlocProvider<GetExamTypeAdminCubit>(
//                     create: (_) => GetExamTypeAdminCubit(
//                         GetExamTypeAdminRepository(GetExamTypeAdminApi())),
//                     child: BlocProvider<ClassListEmployeeCubit>(
//                       create: (_) => ClassListEmployeeCubit(
//                           ClassListEmployeeRepository(ClassListEmployeeApi())),
//                       child: ExamMarkEntryEmployee(),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       }));
//     // return _page(context, ExamMarkEntryEmployee.routeName);
//     case "13":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<StudentListForChangeRollNoCubit>(
//           create: (_) => StudentListForChangeRollNoCubit(
//               StudentListForChangeRollNoRepository(
//                   StudentListForChangeRollNoApi())),
//           child: BlocProvider<ResultAnnounceClassCubit>(
//             create: (_) => ResultAnnounceClassCubit(
//                 ResultAnnounceClassRepository(ResultAnnounceClassApi())),
//             child: BlocProvider<UpdateRollNoEmployeeCubit>(
//               create: (_) => UpdateRollNoEmployeeCubit(
//                   UpdateRollNoEmployeeRepository(UpdateRollNoEmployeeApi())),
//               child: ChangeRollNumberEmployee(),
//             ),
//           ),
//         );
//       }));
//     // return _page(context, ChangeRollNumberEmployee.routeName);
//     case "14":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<MarkAttendanceListEmployeeCubit>(
//           create: (_) => MarkAttendanceListEmployeeCubit(
//               MarkAttendanceListEmployeeRepository(
//                   MarkAttendanceListEmployeeApi())),
//           child: BlocProvider<MarkAttendancePeriodsEmployeeCubit>(
//             create: (_) => MarkAttendancePeriodsEmployeeCubit(
//                 MarkAttendancePeriodsEmployeeRepository(
//                     MarkAttendancePeriodsEmployeeApi())),
//             child: BlocProvider<ResultAnnounceClassCubit>(
//               create: (_) => ResultAnnounceClassCubit(
//                   ResultAnnounceClassRepository(ResultAnnounceClassApi())),
//               child: BlocProvider<FillPeriodAttendanceCubit>(
//                 create: (_) => FillPeriodAttendanceCubit(
//                     FillPeriodAttendanceRepository(FillPeriodAttendanceApi())),
//                 child:
//                     BlocProvider<MarkAttendanceUpdateAttendanceEmployeeCubit>(
//                   create: (_) => MarkAttendanceUpdateAttendanceEmployeeCubit(
//                       MarkAttendanceUpdateAttendanceEmployeeRepository(
//                           MarkAttendanceUpdateAttendanceEmployeeApi())),
//                   child:
//                       BlocProvider<MarkAttendanceSaveAttendanceEmployeeCubit>(
//                     create: (_) => MarkAttendanceSaveAttendanceEmployeeCubit(
//                         MarkAttendanceSaveAttendanceEmployeeRepository(
//                             MarkAttendanceSaveAttendanceEmployeeApi())),
//                     child: MarkAttendance(),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       }));
//     // return _page(context, MarkAttendance.routeName);
//     case "16":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<LeaveRequestCubit>(
//           create: (_) =>
//               LeaveRequestCubit(LeaveRequestRepository(LeaveRequestApi())),
//           child: BlocProvider<AttendanceGraphCubit>(
//             create: (_) => AttendanceGraphCubit(
//                 AttendanceGraphRepository(AttendanceGraphApi())),
//             child: BlocProvider<ApplyForLeaveCubit>(
//               create: (_) => ApplyForLeaveCubit(
//                   ApplyForLeaveRepository(ApplyForLeaveApi())),
//               child: AttendanceStudent(),
//             ),
//           ),
//         );
//       }));
//     // return _page(context, AttendanceStudent.routeName);
//     case "17":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<StudentHistoryLeaveEmployeeCubit>(
//           create: (_) => StudentHistoryLeaveEmployeeCubit(
//               StudentLeaveEmployeeHistoryRepository(
//                   StudentLeaveEmployeeHistoryApi())),
//           child: BlocProvider<StudentLeavePendingRejectAcceptCubit>(
//             create: (_) => StudentLeavePendingRejectAcceptCubit(
//                 studentLeavePendingRejectAcceptRepository(
//                     StudentLeaveEmployeeHistoryRejAcpApi())),
//             child: StudentLeave(),
//           ),
//         );
//       }));
//     // return _page(context, StudentLeave.routeName);
//     case "18":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<MainModeWiseFeeCubit>(
//           create: (_) => MainModeWiseFeeCubit(
//               MainModeWiseFeeRepository(MainModeWiseFeeApi())),
//           child: BlocProvider<PayModeWiseFeeCubit>(
//             create: (_) => PayModeWiseFeeCubit(
//                 PayModeWiseFeeRepository(PayModeWiseFeeApi())),
//             child: BlocProvider<YearSessionCubit>(
//               create: (_) =>
//                   YearSessionCubit(YearSessionRepository(YearSessionApi())),
//               child: FeeCollectionAdmin(),
//             ),
//           ),
//         );
//       }));
//     // return _page(context, FeeCollectionAdmin.routeName);
//     case "19":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<BalanceFeeAdminCubit>(
//           create: (_) => BalanceFeeAdminCubit(
//               BalanceFeeAdminRepository(BalanceFeeAdminApi())),
//           child: BlocProvider<FeeHeadBalanceFeeCubit>(
//             create: (_) => FeeHeadBalanceFeeCubit(
//                 FeeHeadBalanceFeeRepository(FeeHeadBalanceFeeApi())),
//             child: BlocProvider<FeeTypeCubit>(
//               create: (_) => FeeTypeCubit(FeeTypeRepository(FeeTypeApi())),
//               child: BlocProvider<FeeBalanceMonthListCubit>(
//                 create: (_) => FeeBalanceMonthListCubit(
//                     FeeBalanceMonthListEmployeeRepository(
//                         FeeBalanceMonthListEmployeeApi())),
//                 child: BalanceFeeAdmin(),
//               ),
//             ),
//           ),
//         );
//       }));
//     //  return _page(context, BalanceFeeAdmin.routeName);
//     case "20":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<AttendanceOfEmployeeAdminCubit>(
//           create: (_) => AttendanceOfEmployeeAdminCubit(
//               AttendanceOfEmployeeAdminRepository(
//                   AttendanceOfEmployeeAdminApi())),
//           child: BlocProvider<AttendanceEmployeeCubit>(
//             create: (_) => AttendanceEmployeeCubit(
//                 AttendanceEmployeeRepository(AttendanceEmployeeApi())),
//             child: AttendanceEmployee(),
//           ),
//         );
//       }));
//     // return _page(context, AttendanceEmployee.routeName);
//     case "21":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<StudentHistoryLeaveEmployeeCubit>(
//           create: (_) => StudentHistoryLeaveEmployeeCubit(
//               StudentLeaveEmployeeHistoryRepository(
//                   StudentLeaveEmployeeHistoryApi())),
//           child: BlocProvider<StudentLeavePendingRejectAcceptCubit>(
//             create: (_) => StudentLeavePendingRejectAcceptCubit(
//                 studentLeavePendingRejectAcceptRepository(
//                     StudentLeaveEmployeeHistoryRejAcpApi())),
//             child: LeaveApplicationAdmin(),
//           ),
//         );
//       }));
//     // return _page(context, LeaveApplicationAdmin.routeName,
//     //     arguments: userType);
//     case "23":
//       return _page(context, ExamMarksAdmin.routeName, arguments: userType);
//     case "24":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<GetExamResultPublishCubit>(
//           create: (_) => GetExamResultPublishCubit(
//               GetExamResultPublishRepository(GetExamResultPublishApi())),
//           child: BlocProvider<GetStudentListResultAnnounceCubit>(
//             create: (_) => GetStudentListResultAnnounceCubit(
//                 GetStudentListResultAnnounceRepository(
//                     GetStudentListResultAnnounceApi())),
//             child: BlocProvider<ResultAnnounceExamCubit>(
//               create: (_) => ResultAnnounceExamCubit(
//                   ResultAnnounceExamRepository(ResultAnnounceExamApi())),
//               child: BlocProvider<ResultAnnounceClassCubit>(
//                 create: (_) => ResultAnnounceClassCubit(
//                     ResultAnnounceClassRepository(ResultAnnounceClassApi())),
//                 child: BlocProvider<YearSessionCubit>(
//                   create: (_) =>
//                       YearSessionCubit(YearSessionRepository(YearSessionApi())),
//                   child: BlocProvider<PublishResultAdminCubit>(
//                     create: (_) => PublishResultAdminCubit(
//                         PublishResultAdminRepository(PublishResultAdminApi())),
//                     child: ResultAnnounce(),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       }));
//     // return _page(context, ResultAnnounce.routeName, arguments: userType);
//     case "25":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<NotificationsCubit>(
//           create: (_) =>
//               NotificationsCubit(NotificationsRepository(NotificationsApi())),
//           child: Notifications(),
//         );
//       }));
//     // return _page(context, Notifications.routeName);
//     case "26":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<SendSmsAdminCubit>(
//           create: (_) =>
//               SendSmsAdminCubit(SendSmsAdminRepository(SendSmsAdminApi())),
//           child: BlocProvider<LoadAddressGroupCubit>(
//             create: (_) => LoadAddressGroupCubit(
//                 LoadAddressGroupRepository(LoadAddressGroupApi())),
//             child: BlocProvider<LoadHouseGroupCubit>(
//               create: (_) => LoadHouseGroupCubit(
//                   LoadHouseGroupRepository(LoadHouseGroupApi())),
//               child: BlocProvider<LoadEmployeeGroupsCubit>(
//                 create: (_) => LoadEmployeeGroupsCubit(
//                     LoadEmployeeGroupsRepository(LoadEmployeeGroupsApi())),
//                 child: BlocProvider<LoadBusRoutesCubit>(
//                   create: (_) => LoadBusRoutesCubit(
//                       LoadBusRoutesRepository(LoadBusRoutesApi())),
//                   child: BlocProvider<LoadClassForSmsCubit>(
//                     create: (_) => LoadClassForSmsCubit(
//                         LoadClassForSmsRepository(LoadClassForSmsApi())),
//                     child: SendSmsAdmin(),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       }));
//     // return _page(context, SendSmsAdmin.routeName, arguments: userType);
//     case "27":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<ActivityCubit>(
//           create: (_) => ActivityCubit(ActivityRepository(ActivityApi())),
//           child: BlocProvider<DeleteActivityCubit>(
//             create: (_) => DeleteActivityCubit(
//                 DeleteActivityRepository(DeleteActivityApi())),
//             child: Activity(),
//           ),
//         );
//       }));
//     // return _page(context, Activity.routeName, arguments: userType);
//     case "28":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<CircularEmployeeCubit>(
//           create: (_) => CircularEmployeeCubit(
//               CircularEmployeeRepository(CircularEmployeeApi())),
//           child: BlocProvider<DeleteCircularCubit>(
//             create: (_) => DeleteCircularCubit(
//                 DeleteCircularRepository(DeleteCircularApi())),
//             child: CircularEmployee(),
//           ),
//         );
//       }));
//     // return _page(context, CircularEmployee.routeName, arguments: userType);
//     case "29":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<ClassListHwStatusAdminCubit>(
//           create: (_) => ClassListHwStatusAdminCubit(
//               ClassListHwStatusAdminRepository(ClassListHwStatusAdminApi())),
//           child: HomeWorkStatusAdmin(),
//         );
//       }));
//     // return _page(context, HomeWorkStatusAdmin.routeName, arguments: userType);
//     case "30":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<ClassListPrevHwNotDoneStatusCubit>(
//           create: (_) => ClassListPrevHwNotDoneStatusCubit(
//               ClassListPrevHwNotDoneStatusRepository(
//                   ClassListPrevHwNotDoneStatusApi())),
//           child: PreviousHomeWorkNotDoneAdmin(),
//         );
//       }));
//     // return _page(context, PreviousHomeWorkNotDoneAdmin.routeName,
//     //     arguments: userType);
//     case "32":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<FeeCollectionsClassWiseCubit>(
//           create: (_) => FeeCollectionsClassWiseCubit(
//               FeeCollectionsClassWiseRepository(FeeCollectionsClassWiseApi())),
//           child: FeeCollectionClassWiseAdmin(),
//         );
//       }));
//     // return _page(context, FeeCollectionClassWiseAdmin.routeName);
//     case "33":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<CustomChatUserListCubit>(
//           create: (_) => CustomChatUserListCubit(
//               CustomChatUserListRepository(CustomChatUserListApi())),
//           child: CustomChatUserListAdmin(),
//         );
//       }));
//     // return _page(context, CustomChatUserListAdmin.routeName);
//     case "34":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<YearSessionCubit>(
//           create: (_) =>
//               YearSessionCubit(YearSessionRepository(YearSessionApi())),
//           child: BlocProvider<ExamMarksChartCubit>(
//             create: (_) => ExamMarksChartCubit(
//                 ExamMarksChartRepository(ExamMarksChartApi())),
//             child: BlocProvider<ExamMarksCubit>(
//               create: (_) =>
//                   ExamMarksCubit(ExamMarksRepository(ExamMarksApi())),
//               child: BlocProvider<AttendanceGraphCubit>(
//                 create: (_) => AttendanceGraphCubit(
//                     AttendanceGraphRepository(AttendanceGraphApi())),
//                 child: BlocProvider<GetStudentAmountCubit>(
//                   create: (_) => GetStudentAmountCubit(
//                       GetStudentMonthlyAmountRepository(
//                           GetStudentMonthlyAmountApi())),
//                   child: BlocProvider<FeeMonthsCubit>(
//                     create: (_) =>
//                         FeeMonthsCubit(FeeMonthsRepository(FeeMonthsApi())),
//                     child: BlocProvider<ExamSelectedListCubit>(
//                       create: (_) => ExamSelectedListCubit(
//                           ExamSelectedListRepository(ExamSelectedListApi())),
//                       child: BlocProvider<StudentRemarkListCubit>(
//                         create: (_) => StudentRemarkListCubit(
//                             StudentRemarkListRepository(
//                                 StudentRemarkListApi())),
//                         child: BlocProvider<FeeReceiptsCubit>(
//                           create: (_) => FeeReceiptsCubit(
//                               FeeReceiptsRepository(FeeReceiptsApi())),
//                           child: BlocProvider<FeeTypeCubit>(
//                             create: (_) =>
//                                 FeeTypeCubit(FeeTypeRepository(FeeTypeApi())),
//                             child: BlocProvider<ProfileStudentCubit>(
//                               create: (_) => ProfileStudentCubit(
//                                   ProfileStudentRepository(
//                                       ProfileStudentApi())),
//                               child: StudentDetailsAdmin(),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       }));
//     // return _page(context, StudentDetailsAdmin.routeName);
//     case "35":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<StudentRemarkListCubit>(
//           create: (_) => StudentRemarkListCubit(
//               StudentRemarkListRepository(StudentRemarkListApi())),
//           child: BlocProvider<SearchStudentFromRecordsCommonCubit>(
//             create: (_) => SearchStudentFromRecordsCommonCubit(
//                 SearchStudentFromRecordsCommonRepository(
//                     SearchStudentFromRecordsCommonApi())),
//             child: BlocProvider<DeleteStudentRemarkCubit>(
//               create: (_) => DeleteStudentRemarkCubit(
//                   DeleteStudentRemarkRepository(DeleteStudentRemarkApi())),
//               child: StudentRemarkAdmin(),
//             ),
//           ),
//         );
//       }));
//     // return _page(context, StudentRemarkAdmin.routeName);
//     case "37":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<AttendanceOfEmployeeAdminCubit>(
//           create: (_) => AttendanceOfEmployeeAdminCubit(
//               AttendanceOfEmployeeAdminRepository(
//                   AttendanceOfEmployeeAdminApi())),
//           child: BlocProvider<FeeTypeCubit>(
//             create: (_) => FeeTypeCubit(FeeTypeRepository(FeeTypeApi())),
//             child: EmployeeDetail(),
//           ),
//         );
//       }));
//     // return _page(context, EmployeeDetail.routeName, arguments: userType);
//     case "38":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<LoadClassForSmsCubit>(
//           create: (_) => LoadClassForSmsCubit(
//               LoadClassForSmsRepository(LoadClassForSmsApi())),
//           child: BlocProvider<GetSelectClassTeacherCubit>(
//             create: (_) => GetSelectClassTeacherCubit(
//                 GetSelectClassTeacherRepository(GetSelectClassTeacherApi())),
//             child: BlocProvider<AssignPeriodAdminCubit>(
//               create: (_) => AssignPeriodAdminCubit(
//                   AssignPeriodAdminRepository(AssignPeriodAdminApi())),
//               child: BlocProvider<MarkAttendancePeriodsEmployeeCubit>(
//                 create: (_) => MarkAttendancePeriodsEmployeeCubit(
//                     MarkAttendancePeriodsEmployeeRepository(
//                         MarkAttendancePeriodsEmployeeApi())),
//                 child: BlocProvider<RemoveAllottedSubjectCubit>(
//                   create: (_) => RemoveAllottedSubjectCubit(
//                       RemoveAllottedSubjectsRepository(
//                           RemoveAllottedSubjectsApi())),
//                   child: BlocProvider<LoadAllottedSubjectCubit>(
//                     create: (_) => LoadAllottedSubjectCubit(
//                         LoadAllottedSubjectsRepository(
//                             LoadAllottedSubjectsApi())),
//                     child: BlocProvider<SubjectAlloteToTeacherCubit>(
//                       create: (_) => SubjectAlloteToTeacherCubit(
//                           SubjectAlloteToTeacherRepository(
//                               SubjectAlloteToTeacherApi())),
//                       child: BlocProvider<GetClassSectionAdminCubit>(
//                         create: (_) => GetClassSectionAdminCubit(
//                             GetClassSectionAdminRepository(
//                                 GetClassSectionAdminApi())),
//                         child: BlocProvider<GetClasswiseSubjectAdminCubit>(
//                           create: (_) => GetClasswiseSubjectAdminCubit(
//                               GetClasswiseSubjectAdminRepository(
//                                   GetClasswiseSubjectAdminApi())),
//                           child: BlocProvider<LoadClassForSubjectAdminCubit>(
//                             create: (_) => LoadClassForSubjectAdminCubit(
//                                 LoadClassForSubjectAdminRepository(
//                                     LoadClassForSubjectAdminApi())),
//                             child: BlocProvider<AssignClassTeacherAdminCubit>(
//                               create: (_) => AssignClassTeacherAdminCubit(
//                                   AssignClassTeacherAdminRepository(
//                                       AssignClassTeacherAdminApi())),
//                               child: BlocProvider<EmployeeInfoForSearchCubit>(
//                                 create: (_) => EmployeeInfoForSearchCubit(
//                                     EmployeeInfoForSearchRepository(
//                                         EmployeeInfoForSearchApi())),
//                                 child: TeacherAssignAdmin(),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       }));
//     // return _page(context, TeacherAssignAdmin.routeName, arguments: userType);
//     case "39":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<AdmissionStatusCubit>(
//           create: (_) => AdmissionStatusCubit(
//               AdmissionStatusRepository(AdmissionStatusApi())),
//           child: BlocProvider<YearSessionCubit>(
//             create: (_) =>
//                 YearSessionCubit(YearSessionRepository(YearSessionApi())),
//             child: AdmissionStatusAdmin(),
//           ),
//         );
//       }));
//     // return _page(context, AdmissionStatusAdmin.routeName);
//     case "40":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<SendStudentDetailsCubit>(
//           create: (_) => SendStudentDetailsCubit(
//               SendStudentDetailsRepository(SendStudentDetailsApi())),
//           child: BlocProvider<StudentDetailSearchCubit>(
//             create: (_) => StudentDetailSearchCubit(
//                 StudentDetailSearchRepository(StudentDetailSearchApi())),
//             child: BlocProvider<UpdateStudentPasswordCubit>(
//               create: (_) => UpdateStudentPasswordCubit(
//                   UpdateStudentPasswordRepository(UpdateStudentPasswordApi())),
//               child: BlocProvider<UpdateStudentMobileNoCubit>(
//                 create: (_) => UpdateStudentMobileNoCubit(
//                     UpdateStudentMobileNoRepository(
//                         UpdateStudentMobileNoApi())),
//                 child: BlocProvider<UpdateStudentAccountStatusCubit>(
//                   create: (_) => UpdateStudentAccountStatusCubit(
//                       UpdateStudentAccountStatusRepository(
//                           UpdateStudentAccountStatusApi())),
//                   child: BlocProvider<CreateUserStudentStatusCubit>(
//                     create: (_) => CreateUserStudentStatusCubit(
//                         CreateUserStudentStatusRepository(
//                             CreateUserStudentStatusApi())),
//                     child: StudentUserStatus(),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       }));
//     // return _page(context, StudentUserStatus.routeName);
//     case "41":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<UpdateStudentPasswordCubit>(
//           create: (_) => UpdateStudentPasswordCubit(
//               UpdateStudentPasswordRepository(UpdateStudentPasswordApi())),
//           child: BlocProvider<EmployeeInfoCubit>(
//             create: (_) =>
//                 EmployeeInfoCubit(EmployeeInfoRepository(EmployeeInfoApi())),
//             child: BlocProvider<EmployeeStatusListCubit>(
//               create: (_) => EmployeeStatusListCubit(
//                   EmployeeStatusListRepository(EmployeeStatusListApi())),
//               child: BlocProvider<DeleteUserEmployeeStatusCubit>(
//                 create: (_) => DeleteUserEmployeeStatusCubit(
//                     DeleteUserEmployeeStatusRepository(
//                         DeleteUserEmployeeStatusApi())),
//                 child: BlocProvider<CreateUserEmployeeStatusCubit>(
//                   create: (_) => CreateUserEmployeeStatusCubit(
//                       CreateUserEmployeeStatusRepository(
//                           CreateUserEmployeeStatusApi())),
//                   child: EmployeeUserStatus(),
//                 ),
//               ),
//             ),
//           ),
//         );
//       }));
//     // return _page(context, EmployeeUserStatus.routeName);
//     case "42":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<AppUserListCubit>(
//           create: (_) =>
//               AppUserListCubit(AppUserListRepository(AppUserListApi())),
//           child: BlocProvider<DownloadAppUserDataCubit>(
//             create: (_) => DownloadAppUserDataCubit(
//                 DownloadAppUserDataRepository(DownloadAppUserDataApi())),
//             child: BlocProvider<AppUserDetailCubit>(
//               create: (_) => AppUserDetailCubit(
//                   AppUserDetailRepository(AppUserDetailApi())),
//               child: AppUserStatus(),
//             ),
//           ),
//         );
//       }));
//     // return _page(context, AppUserStatus.routeName);
//     case "43":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<ScheduleMeetingTodayListCubit>(
//           create: (_) => ScheduleMeetingTodayListCubit(
//               ScheduleMeetingTodayListRepository(
//                   ScheduleMeetingTodayListApi())),
//           child: BlocProvider<SubjectListMeetingCubit>(
//             create: (_) => SubjectListMeetingCubit(
//                 (SubjectListMeetingRepository(SubjectListMeetingApi()))),
//             child: BlocProvider<ClassListEmployeeCubit>(
//               create: (_) => ClassListEmployeeCubit(
//                   ClassListEmployeeRepository(ClassListEmployeeApi())),
//               child: BlocProvider<MeetingPlatformsCubit>(
//                 create: (_) => MeetingPlatformsCubit(
//                     (MeetingPlatformsRepository(MeetingPlatformsApi()))),
//                 child: BlocProvider<CurrentUserEmailForZoomCubit>(
//                   create: (_) => CurrentUserEmailForZoomCubit(
//                       CurrentUserEmailForZoomRepository(
//                           CurrentUserEmailForZoomApi())),
//                   child: BlocProvider<ScheduleMeetingListEmployeeCubit>(
//                     create: (_) => ScheduleMeetingListEmployeeCubit(
//                         (ScheduleMeetingListEmployeeRepository(
//                             ScheduleMeetingListEmployeeApi()))),
//                     child: BlocProvider<StudentListMeetingCubit>(
//                       create: (_) => StudentListMeetingCubit(
//                           (StudentListMeetingRepository(
//                               StudentListMeetingApi()))),
//                       child: BlocProvider<SaveGoogleMeetScheduleMeetingCubit>(
//                         create: (_) => SaveGoogleMeetScheduleMeetingCubit(
//                             SaveGoogleMeetScheduleMeetingRepository(
//                                 SaveGoogleMeetScheduleMeetingApi())),
//                         child: BlocProvider<SaveZoomScheduleMeetingCubit>(
//                           create: (_) => SaveZoomScheduleMeetingCubit(
//                               SaveZoomScheduleMeetingRepository(
//                                   SaveZoomScheduleMeetingApi())),
//                           child: BlocProvider<EmployeeInfoForSearchCubit>(
//                             create: (_) => EmployeeInfoForSearchCubit(
//                                 EmployeeInfoForSearchRepository(
//                                     EmployeeInfoForSearchApi())),
//                             child: BlocProvider<
//                                 DeleteScheduleMeetingEmployeeCubit>(
//                               create: (_) => DeleteScheduleMeetingEmployeeCubit(
//                                   (DeleteScheduleMeetingEmployeeRepository(
//                                       DeleteScheduleMeetingEmployeeApi()))),
//                               child: ScheduleClass(),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       }));
//     // return _page(context, ScheduleClass.routeName);
//     case "44":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<DepartmentWiseEmployeeMeetingCubit>(
//           create: (_) => DepartmentWiseEmployeeMeetingCubit(
//               DepartmentWiseEmployeeMeetingRepository(
//                   DepartmentWiseEmployeeMeetingApi())),
//           child: BlocProvider<GroupWiseEmployeeMeetingCubit>(
//             create: (_) => GroupWiseEmployeeMeetingCubit(
//                 GroupWiseEmployeeMeetingRepository(
//                     GroupWiseEmployeeMeetingApi())),
//             child: BlocProvider<MeetingPlatformsCubit>(
//               create: (_) => MeetingPlatformsCubit(
//                   (MeetingPlatformsRepository(MeetingPlatformsApi()))),
//               child: BlocProvider<CurrentUserEmailForZoomCubit>(
//                 create: (_) => CurrentUserEmailForZoomCubit(
//                     CurrentUserEmailForZoomRepository(
//                         CurrentUserEmailForZoomApi())),
//                 child: BlocProvider<ScheduleMeetingListAdminCubit>(
//                   create: (_) => ScheduleMeetingListAdminCubit(
//                       (ScheduleMeetingListAdminRepository(
//                           ScheduleMeetingListAdminApi()))),
//                   child: BlocProvider<SaveGoogleMeetScheduleMeetingAdminCubit>(
//                     create: (_) => SaveGoogleMeetScheduleMeetingAdminCubit(
//                         SaveGoogleMeetScheduleMeetingAdminRepository(
//                             SaveGoogleMeetScheduleMeetingAdminApi())),
//                     child: BlocProvider<SaveZoomScheduleMeetingAdminCubit>(
//                       create: (_) => SaveZoomScheduleMeetingAdminCubit(
//                           SaveZoomScheduleMeetingAdminRepository(
//                               SaveZoomScheduleMeetingAdminApi())),
//                       child: BlocProvider<DeleteScheduleMeetingEmployeeCubit>(
//                         create: (_) => DeleteScheduleMeetingEmployeeCubit(
//                             (DeleteScheduleMeetingEmployeeRepository(
//                                 DeleteScheduleMeetingEmployeeApi()))),
//                         child: BlocProvider<MeetingDetailsAdminCubit>(
//                           create: (_) => MeetingDetailsAdminCubit(
//                               (MeetingDetailsAdminRepository(
//                                   MeetingDetailsAdminApi()))),
//                           child: ScheduleStaffMeeting(),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       }));
//     // return _page(context, ScheduleStaffMeeting.routeName);
//     case "45":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<GetUserAssignMenuCubit>(
//           create: (_) => GetUserAssignMenuCubit(
//               GetUserAssignMenuRepository(GetUserAssignMenuApi())),
//           child: BlocProvider<UpdateAssignMenuCubit>(
//             create: (_) => UpdateAssignMenuCubit(
//                 UpdateAssignMenuRepository(UpdateAssignMenuApi())),
//             child: ManageMenuAdmin(),
//           ),
//         );
//       }));
//     // return _page(context, ManageMenuAdmin.routeName, arguments: userType);
//     case "46":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<DiscountGivenAllowDiscountCubit>(
//           create: (_) => DiscountGivenAllowDiscountCubit(
//               DiscountGivenAllowDiscountRepository(
//                   DiscountGivenAllowDiscountApi())),
//           child: BlocProvider<AllowDiscountListCubit>(
//             create: (_) => AllowDiscountListCubit(
//                 AllowDiscountListRepository(AllowDiscountListApi())),
//             child: BlocProvider<DiscountApplyAndRejectCubit>(
//               create: (_) => DiscountApplyAndRejectCubit(
//                   DiscountApplyAndRejectRepository(
//                       DiscountApplyAndRejectApi())),
//               child: AllowDiscountAdmin(),
//             ),
//           ),
//         );
//       }));
//     // return _page(context, AllowDiscountAdmin.routeName);
//     case "47":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<DayClosingDataCubit>(
//           create: (_) => DayClosingDataCubit(
//               DayClosingDataRepository(DayClosingDataApi())),
//           child: DayClosingAdmin(),
//         );
//       }));
//     // return _page(context, DayClosingAdmin.routeName);
//     case "48":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<FillPeriodAttendanceCubit>(
//           create: (_) => FillPeriodAttendanceCubit(
//               FillPeriodAttendanceRepository(FillPeriodAttendanceApi())),
//           child: BlocProvider<MarkAttendanceSaveAttendanceEmployeeCubit>(
//             create: (_) => MarkAttendanceSaveAttendanceEmployeeCubit(
//                 MarkAttendanceSaveAttendanceEmployeeRepository(
//                     MarkAttendanceSaveAttendanceEmployeeApi())),
//             child: BlocProvider<MarkAttendancePeriodsEmployeeCubit>(
//               create: (_) => MarkAttendancePeriodsEmployeeCubit(
//                   MarkAttendancePeriodsEmployeeRepository(
//                       MarkAttendancePeriodsEmployeeApi())),
//               child: BlocProvider<MeetingRecipientListAdminCubit>(
//                 create: (_) => MeetingRecipientListAdminCubit(
//                     MeetingRecipientListAdminRepository(
//                         MeetingRecipientListAdminApi())),
//                 child: BlocProvider<ResultAnnounceClassCubit>(
//                   create: (_) => ResultAnnounceClassCubit(
//                       ResultAnnounceClassRepository(ResultAnnounceClassApi())),
//                   child: BlocProvider<MeetingDetailsAdminCubit>(
//                     create: (_) => MeetingDetailsAdminCubit(
//                         (MeetingDetailsAdminRepository(
//                             MeetingDetailsAdminApi()))),
//                     child: BlocProvider<WeekPlanSubjectListCubit>(
//                       create: (_) => WeekPlanSubjectListCubit(
//                           WeekPlanSubjectListRepository(
//                               WeekPlanSubjectListApi())),
//                       child: BlocProvider<TeachersListCubit>(
//                         create: (_) => TeachersListCubit(
//                             TeachersListRepository(TeachersListApi())),
//                         child: MeetingStatus(),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       }));
//     // return _page(context, MeetingStatus.routeName);
//     case "49":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<OtpUserListCubit>(
//           create: (_) =>
//               OtpUserListCubit(OtpUserListRepository(OtpUserListApi())),
//           child: BlocProvider<ChangeOtpUserLogsCubit>(
//             create: (_) => ChangeOtpUserLogsCubit(
//                 ChangeOtpUserLogsRepository(ChangeOtpUserLogsApi())),
//             child: OtpStatus(),
//           ),
//         );
//       }));
//     // return _page(context, OtpStatus.routeName);
//     case "50":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<FeeTypeCubit>(
//           create: (_) => FeeTypeCubit(FeeTypeRepository(FeeTypeApi())),
//           child: BlocProvider<AddNewEmployeeCubit>(
//             create: (_) => AddNewEmployeeCubit(
//                 AddNewEmployeeRepository(AddNewEmployeeApi())),
//             child: BlocProvider<LoadLastEmpNoCubit>(
//               create: (_) => LoadLastEmpNoCubit(
//                   LoadLastEmpNoRepository(LoadLastEmpNoApi())),
//               child: AddEmployee(),
//             ),
//           ),
//         );
//       }));
//     // return _page(context, AddEmployee.routeName, arguments: userType);
//     case "51":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<FeeTypeCubit>(
//           create: (_) => FeeTypeCubit(FeeTypeRepository(FeeTypeApi())),
//           child: BlocProvider<BillsListBillApproveCubit>(
//             create: (_) => BillsListBillApproveCubit(
//                 BillsListBillApproveRepository(BillsListBillApproveApi())),
//             child: BlocProvider<PartyTypeBillApproveCubit>(
//               create: (_) => PartyTypeBillApproveCubit(
//                   PartyTypeBillApproveRepository(PartyTypeBillApproveApi())),
//               child: BillApproveAdmin(),
//             ),
//           ),
//         );
//       }));
//     // return _page(context, BillApproveAdmin.routeName);
//     case "52":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<SectionListAttendanceAdminCubit>(
//           create: (_) => SectionListAttendanceAdminCubit(
//               SectionListAttendanceAdminRepository(
//                   SectionListAttendanceAdminApi())),
//           child: BlocProvider<SectionListAttendanceCubit>(
//             create: (_) => SectionListAttendanceCubit(
//                 SectionListAttendanceRepository(SectionListAttendanceApi())),
//             child: BlocProvider<ClassListAttendanceReportAdminCubit>(
//               create: (_) => ClassListAttendanceReportAdminCubit(
//                   ClassListAttendanceReportAdminRepository(
//                       ClassListAttendanceReportAdminApi())),
//               child: BlocProvider<ClassListAttendanceReportCubit>(
//                 create: (_) => ClassListAttendanceReportCubit(
//                     ClassListAttendanceReportRepository(
//                         ClassListAttendanceReportApi())),
//                 child: BlocProvider<AttendanceReportEmployeeCubit>(
//                   create: (_) => AttendanceReportEmployeeCubit(
//                       AttendanceReportEmployeeRepository(
//                           AttendanceReportEmployeeApi())),
//                   child: AttendanceReport(),
//                 ),
//               ),
//             ),
//           ),
//         );
//       }));
//     // return _page(context, AttendanceReport.routeName);
//     case "53":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<ProfileStudentCubit>(
//           create: (_) => ProfileStudentCubit(
//               ProfileStudentRepository(ProfileStudentApi())),
//           child: ProfileStudent(),
//         );
//       }));
//     // return _page(context, ProfileStudent.routeName);
//     case "54":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<ChangePasswordStudentCubit>(
//           create: (_) => ChangePasswordStudentCubit(
//               ChangePasswordStudentRepository(ChangePasswordStudentApi())),
//           child: ChangePasswordStudent(),
//         );
//       }));
//     // return _page(context, ChangePasswordStudent.routeName);
//     case "55":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<TeachersListMeetingCubit>(
//           create: (_) => TeachersListMeetingCubit(
//               TeachersListMeetingRepository(TeachersListMeetingApi())),
//           child: BlocProvider<TeacherStatusListCubit>(
//             create: (_) => TeacherStatusListCubit(
//                 TeacherStatusListRepository(TeachersStatusListApi())),
//             child: TeacherClassStatus(),
//           ),
//         );
//       }));
//     // return _page(context, TeacherClassStatus.routeName);
//     case "56":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<CoordinatorListDetailCubit>(
//           create: (_) => CoordinatorListDetailCubit(
//               CoordinatorListDetailRepository(CoordinatorListDetailApi())),
//           child: BlocProvider<DeleteCoordinatorCubit>(
//             create: (_) => DeleteCoordinatorCubit(
//                 DeleteCoordinatorRepository(DeleteCoordinatorApi())),
//             child: CoordinatorAssign(),
//           ),
//         );
//       }));
//     // return _page(context, CoordinatorAssign.routeName);
//     case "59":
//       return _page(context, PreviousManageNotice.routeName);

//     // case "60":
//     //   return _page(context, PtmRemark.routeName);

//     case "64":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<DeleteAlertPopupCubit>(
//           create: (_) => DeleteAlertPopupCubit(
//               DeleteAlertPopupRepository(DeleteAlertPopupApi())),
//           child: BlocProvider<DeleteMessagePopupCubit>(
//             create: (_) => DeleteMessagePopupCubit(
//                 DeleteMessagePopupRepository(DeleteMessagePopupApi())),
//             child: BlocProvider<GetPopupAlertListCubit>(
//               create: (_) => GetPopupAlertListCubit(
//                   GetPopupAlertListRepository(GetPopupAlertListApi())),
//               child: BlocProvider<GetPopupMessageListCubit>(
//                 create: (_) => GetPopupMessageListCubit(
//                     GetPopupMessageListRepository(GetPopupMessageListApi())),
//                 child: PopUpConfigureAdmin(),
//               ),
//             ),
//           ),
//         );
//       }));
//     // return _page(context, PopUpConfigureAdmin.routeName);
//     case "65":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<MeetingPlatformsCubit>(
//           create: (_) => MeetingPlatformsCubit(
//               (MeetingPlatformsRepository(MeetingPlatformsApi()))),
//           child: BlocProvider<SetPlatformCubit>(
//             create: (_) =>
//                 SetPlatformCubit(SetPlateformRepository(SetPlateformApi())),
//             child: BlocProvider<GetEmployeeOnlineCredCubit>(
//               create: (_) => GetEmployeeOnlineCredCubit(
//                   GetEmployeeOnlineClassCredentialsRepository(
//                       GetEmployeeOnlineClassCredentialsApi())),
//               child: BlocProvider<EmployeeInfoForSearchCubit>(
//                 create: (_) => EmployeeInfoForSearchCubit(
//                     EmployeeInfoForSearchRepository(
//                         EmployeeInfoForSearchApi())),
//                 child: MeetingConfigure(),
//               ),
//             ),
//           ),
//         );
//       }));
//     // return _page(context, MeetingConfigure.routeName);
//     case "66":
//       return _page(context, GoToSite.routeName);

//     case "67":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<GetSmsTypeSmsConfigCubit>(
//           create: (_) => GetSmsTypeSmsConfigCubit(
//               GetSmsTypeSmsConfigRepository(GetSmsTypeSmsConfigApi())),
//           child: BlocProvider<LoadUserTypeSendSmsCubit>(
//             create: (_) => LoadUserTypeSendSmsCubit(
//                 LoadUserTypeSendSmsRepository(LoadUserTypeSendSmsApi())),
//             child: BlocProvider<SaveSmsTypeCubit>(
//               create: (_) => SaveSmsTypeCubit(
//                   SaveSmsTypeSmsRepository(SaveSmsTypeSmsApi())),
//               child: BlocProvider<GetSmsTypeDetailSmsConfgCubit>(
//                 create: (_) => GetSmsTypeDetailSmsConfgCubit(
//                     GetSmsTypeDetailSmsConfigRepository(
//                         GetSmsTypeDetailSmsConfigApi())),
//                 child: SmsConfigureAdmin(),
//               ),
//             ),
//           ),
//         );
//       }));
//     // return _page(context, SmsConfigureAdmin.routeName);
//     case "68":
//       return _page(context, BottomNavigation.routeName);
//     case "70":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<GetComplainSuggestionListAdminCubit>(
//           create: (_) => GetComplainSuggestionListAdminCubit(
//               GetComplainSuggestionListAdminRepository(
//                   GetComplainSuggestionListAdminApi())),
//           child: BlocProvider<InactiveCompOrSuggCubit>(
//             create: (_) => InactiveCompOrSuggCubit(
//                 InactiveCompOrSuggRepository(InactiveCompOrSuggApi())),
//             child: BlocProvider<ReplyComplainSuggestionAdminCubit>(
//               create: (_) => ReplyComplainSuggestionAdminCubit(
//                   ReplyComplainSuggestionAdminRepository(
//                       ReplyComplainSuggestionAdminApi())),
//               child: SuggestionAdmin(),
//             ),
//           ),
//         );
//       }));
//     // return _page(context, SuggestionAdmin.routeName);
//     case "73":
//       return _page(context, CceGradeEntry.routeName);
//     case "75":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<UpdatePlanEmployeeCubit>(
//           create: (_) => UpdatePlanEmployeeCubit(
//               UpdatePlanEmployeeRepository(UpdatePlanEmployeeApi())),
//           child: BlocProvider<WeekPlanSubjectListCubit>(
//             create: (_) => WeekPlanSubjectListCubit(
//                 WeekPlanSubjectListRepository(WeekPlanSubjectListApi())),
//             child: BlocProvider<ClassListEmployeeCubit>(
//               create: (_) => ClassListEmployeeCubit(
//                   ClassListEmployeeRepository(ClassListEmployeeApi())),
//               child: BlocProvider<AddPlanEmployeeCubit>(
//                 create: (_) => AddPlanEmployeeCubit(
//                     AddPlanEmployeeRepository(AddPlanEmployeeApi())),
//                 child: WeekPlanEmployee(),
//               ),
//             ),
//           ),
//         );
//       }));
//     // return _page(context, WeekPlanEmployee.routeName);
//     case "76":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<AddPlanEmployeeCubit>(
//           create: (_) => AddPlanEmployeeCubit(
//               AddPlanEmployeeRepository(AddPlanEmployeeApi())),
//           child: BlocProvider<CoordinatorListDetailCubit>(
//             create: (_) => CoordinatorListDetailCubit(
//                 CoordinatorListDetailRepository(CoordinatorListDetailApi())),
//             child: BlocProvider<ClassListEmployeeCubit>(
//               create: (_) => ClassListEmployeeCubit(
//                   ClassListEmployeeRepository(ClassListEmployeeApi())),
//               child: AddPlanEmployee(),
//             ),
//           ),
//         );
//       }));
//     // return _page(context, AddPlanEmployee.routeName);
//     case "77":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<SubjectListEmployeeCubit>(
//           create: (_) => SubjectListEmployeeCubit(
//               SubjectListEmployeeRepository(SubjectListEmployeeApi())),
//           child: BlocProvider<ResultAnnounceClassCubit>(
//             create: (_) => ResultAnnounceClassCubit(
//                 ResultAnnounceClassRepository(ResultAnnounceClassApi())),
//             child: BlocProvider<LoadStudentForSubjectListCubit>(
//               create: (_) => LoadStudentForSubjectListCubit(
//                   LoadStudentForSubjectListRepository(
//                       LoadStudentForSubjectListApi())),
//               child: BlocProvider<GetTopicAndSkillCubit>(
//                 create: (_) => GetTopicAndSkillCubit(
//                     GetTopicAndSkillRepository(GetTopicAndSkillApi())),
//                 child: SubjectListEntrySearchEmployee(),
//               ),
//             ),
//           ),
//         );
//       }));
//     // return _page(context, SubjectListEntrySearchEmployee.routeName);

//     case "70":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<GetComplainSuggestionListAdminCubit>(
//           create: (_) => GetComplainSuggestionListAdminCubit(
//               GetComplainSuggestionListAdminRepository(
//                   GetComplainSuggestionListAdminApi())),
//           child: BlocProvider<InactiveCompOrSuggCubit>(
//             create: (_) => InactiveCompOrSuggCubit(
//                 InactiveCompOrSuggRepository(InactiveCompOrSuggApi())),
//             child: BlocProvider<ReplyComplainSuggestionAdminCubit>(
//               create: (_) => ReplyComplainSuggestionAdminCubit(
//                   ReplyComplainSuggestionAdminRepository(
//                       ReplyComplainSuggestionAdminApi())),
//               child: SuggestionAdmin(),
//             ),
//           ),
//         );
//       }));
//     // return _page(context, SuggestionAdmin.routeName);

//     case "78":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<CceAttendanceClassDataCubit>(
//           create: (_) => CceAttendanceClassDataCubit(
//               CceAttendanceClassDataRepository(CceAttendanceClassDataApi())),
//           child: BlocProvider<ResultAnnounceClassCubit>(
//             create: (_) => ResultAnnounceClassCubit(
//                 ResultAnnounceClassRepository(ResultAnnounceClassApi())),
//             child: BlocProvider<SaveCceAttendanceCubit>(
//               create: (_) => SaveCceAttendanceCubit(
//                   SaveCceAttendanceRepository(SaveCceAttendanceApi())),
//               child: CCEAttendance(),
//             ),
//           ),
//         );
//       }));
//     // return _page(context, CCEAttendance.routeName);

//     case "79":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<CceGeneralTeacherRemarksListCubit>(
//           create: (_) => CceGeneralTeacherRemarksListCubit(
//               CceGeneralTeacherRemarksListRepository(
//                   CceGeneralTeacherRemarksListApi())),
//           child: BlocProvider<SaveCceSubjectTeacherRemarksCubit>(
//             create: (_) => SaveCceSubjectTeacherRemarksCubit(
//                 SaveCceSubjectTeacherRemarksRepository(
//                     SaveCceSubjectTeacherRemarksApi())),
//             child: BlocProvider<SaveCceGeneralTeacherRemarksCubit>(
//               create: (_) => SaveCceGeneralTeacherRemarksCubit(
//                   SaveCceGeneralTeacherRemarksRepository(
//                       SaveCceGeneralTeacherRemarksApi())),
//               child: BlocProvider<ResultAnnounceClassCubit>(
//                 create: (_) => ResultAnnounceClassCubit(
//                     ResultAnnounceClassRepository(ResultAnnounceClassApi())),
//                 child: BlocProvider<TeacherRemarksListCubit>(
//                   create: (_) => TeacherRemarksListCubit(
//                       TeacherRemarksListRepository(TeacherRemarksListApi())),
//                   child: BlocProvider<CceSubjectTeacherRemarksListCubit>(
//                     create: (_) => CceSubjectTeacherRemarksListCubit(
//                         CceSubjectTeacherRemarksListRepository(
//                             CceSubjectTeacherRemarksListApi())),
//                     child: BlocProvider<CceGeneralTeacherRemarksListCubit>(
//                       create: (_) => CceGeneralTeacherRemarksListCubit(
//                           CceGeneralTeacherRemarksListRepository(
//                               CceGeneralTeacherRemarksListApi())),
//                       child: CceTeacherRemarks(),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       }));
//     // return _page(context, CceTeacherRemarks.routeName);

//     case "80":
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<ActivityForStudentCubit>(
//           create: (_) => ActivityForStudentCubit(
//               ActivityForStudentRepository(ActivityForStudentApi())),
//           child: ActivityStudent(),
//         );
//       }));

//     // return _page(context, ActivityStudent.routeName);

//     case "83":
//       return _page(context, EmployeeCalendar.routeName);

//     case "86":
//       return _page(context, ApproveProxy.routeName);

//     case "90":
//       return _page(context, ApproveLeaveEmpCal.routeName);

//     default:
//       return Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return BlocProvider<DrawerCubit>(
//           create: (_) => DrawerCubit(DrawerRepository(DrawerApi())),
//           child: BlocProvider<NotifyCounterCubit>(
//               create: (_) => NotifyCounterCubit(
//                   NotifyCounterRepository(NotifyCounterApi())),
//               child: Dashboard(
//                 userType: userType,
//               )),
//         );
//       }));
//     // return _page(context, Dashboard.routeName, arguments: userType);
//   }
// }
// // }
