import 'package:campus_pro/src/globalBlocProvidersFile.dart';
import 'package:provider/single_child_widget.dart';

globalBlocProviders(BuildContext _) {
  try {
    List<SingleChildWidget> providers = <BlocProvider>[
      // BlocProvider<ClassEndDrawerLocalCubit>(
      //   create: (_) => ClassEndDrawerLocalCubit(),
      // ),
      // BlocProvider<DrawerCubit>(
      //     create: (_) => DrawerCubit(DrawerRepository(DrawerApi()))),
      BlocProvider<LogInCubit>(
          create: (_) => LogInCubit(LogInRepository(LogInApi()))),
      BlocProvider<SignInWithGoogleCubit>(
          create: (_) => SignInWithGoogleCubit(SignInWithGoogleApi())),
      BlocProvider<AccountTypeCubit>(
          create: (_) => AccountTypeCubit(AccountTypeRepository(AccountTypeApi()))),
      BlocProvider<FcmTokenStoreCubit>(
          create: (_) =>
              FcmTokenStoreCubit(FcmTokenStoreRepository(FcmTokenStoreApi()))),
      BlocProvider<StudentInfoForSearchCubit>(
          create: (_) => StudentInfoForSearchCubit(
              StudentInfoForSearchRepository(StudentInfoForSearchApi()))),
      // BlocProvider<FeedbackStudentCubit>(
      //     create: (_) => FeedbackStudentCubit(
      //         FeedbackStudentRepository(FeedbackStudentApi()))),
      // BlocProvider<StudentDetailSearchCubit>(
      //     create: (_) => StudentDetailSearchCubit(
      //         StudentDetailSearchRepository(StudentDetailSearchApi()))),
      // BlocProvider<DateSheetStudentCubit>(
      //     create: (_) => DateSheetStudentCubit(
      //         DateSheetStudentRepository(DateSheetStudentApi()))),
      // BlocProvider<ActivityCubit>(
      //     create: (_) => ActivityCubit(ActivityRepository(ActivityApi()))),
      // BlocProvider<CreateActivityCubit>(
      //     create: (_) =>
      //         CreateActivityCubit(CreateActivityRepository(CreateActivityApi()))),
      // BlocProvider<CircularStudentCubit>(
      //     create: (_) => CircularStudentCubit(
      //         CircularStudentRepository(CircularStudentApi()))),
      // BlocProvider<MarkSheetStudentCubit>(
      //     create: (_) => MarkSheetStudentCubit(
      //         MarkSheetStudentRepository(MarkSheetStudentApi()))),
      // BlocProvider<NotificationsCubit>(
      //     create: (_) =>
      //         NotificationsCubit(NotificationsRepository(NotificationsApi()))),
      // BlocProvider<ChangePasswordStudentCubit>(
      //     create: (_) => ChangePasswordStudentCubit(
      //         ChangePasswordStudentRepository(ChangePasswordStudentApi()))),
      // BlocProvider<YearSessionCubit>(
      //     create: (_) =>
      //         YearSessionCubit(YearSessionRepository(YearSessionApi()))),
      // BlocProvider<ClassListCubit>(
      //     create: (_) => ClassListCubit(ClassListRepository(ClassListApi()))),
      // BlocProvider<ClassListEnquiryCubit>(
      //     create: (_) => ClassListEnquiryCubit(
      //         ClassListEnquiryRepository(ClassListEnquiryApi()))),
      // BlocProvider<CheckEmailRegistrationCubit>(
      //     create: (_) => CheckEmailRegistrationCubit(
      //         CheckEmailRegistrationRepository(CheckEmailRegistrationApi()))),
      // BlocProvider<UpdateEmailCubit>(
      //     create: (_) =>
      //         UpdateEmailCubit(UpdateEmailRepository(UpdateEmailApi()))),
      BlocProvider<ForgotPasswordCubit>(
          create: (_) => ForgotPasswordCubit(
              ForgotPasswordRepository(ForgotPasswordApi()))),
      BlocProvider<VerifyOtpCubit>(
          create: (_) => VerifyOtpCubit(VerifyOtpRepository(VerifyOtpApi()))),
      // BlocProvider<ClassRoomsStudentCubit>(
      //     create: (_) => ClassRoomsStudentCubit(
      //         ClassRoomsStudentRepository(ClassRoomsStudentApi()))),
      // BlocProvider<FeeReceiptsCubit>(
      //     create: (_) =>
      //         FeeReceiptsCubit(FeeReceiptsRepository(FeeReceiptsApi()))),
      // BlocProvider<FeeTransactionHistoryCubit>(
      //     create: (_) => FeeTransactionHistoryCubit(
      //         FeeTransactionHistoryRepository(FeeTransactionHistoryApi()))),
      // BlocProvider<StudentFeeReceiptCubit>(
      //     create: (_) => StudentFeeReceiptCubit(
      //         StudentFeeReceiptRepository(StudentFeeReceiptApi()))),
      // BlocProvider<ExamTestResultStudentCubit>(
      //     create: (_) => ExamTestResultStudentCubit(
      //         ExamTestResultStudentRepository(ExamTestResultStudentApi()))),
      // BlocProvider<CalenderStudentCubit>(
      //     create: (_) => CalenderStudentCubit(
      //         CalenderStudentRepository(CalenderStudentApi()))),
      // BlocProvider<AttendanceGraphCubit>(
      //     create: (_) => AttendanceGraphCubit(
      //         AttendanceGraphRepository(AttendanceGraphApi()))),
      // BlocProvider<LeaveRequestCubit>(
      //     create: (_) =>
      //         LeaveRequestCubit(LeaveRequestRepository(LeaveRequestApi()))),
      // BlocProvider<ApplyForLeaveCubit>(
      //     create: (_) =>
      //         ApplyForLeaveCubit(ApplyForLeaveRepository(ApplyForLeaveApi()))),
      // BlocProvider<ProfileStudentCubit>(
      //     create: (_) => ProfileStudentCubit(
      //         ProfileStudentRepository(ProfileStudentApi()))),
      // BlocProvider<ProfileEditRequestCubit>(
      //     create: (_) => ProfileEditRequestCubit(
      //         ProfileEditRequestRepository(ProfileEditRequestApi()))),
      // BlocProvider<FeeTypeCubit>(
      //     create: (_) => FeeTypeCubit(FeeTypeRepository(FeeTypeApi()))),
      // BlocProvider<FeeMonthsCubit>(
      //     create: (_) => FeeMonthsCubit(FeeMonthsRepository(FeeMonthsApi()))),
      // BlocProvider<FeeRemarkCubit>(
      //     create: (_) => FeeRemarkCubit(FeeRemarksRepository(FeeRemarksApi()))),
      BlocProvider<StudentFeeFineCubit>(
          create: (_) => StudentFeeFineCubit(
              StudentFeeFineRepository(StudentFeeFineApi()))),
      // BlocProvider<AssignTeacherCubit>(
      //     create: (_) =>
      //         AssignTeacherCubit(AssignTeacherRepository(AssignTeacherApi()))),
      // BlocProvider<ExamSelectedListCubit>(
      //     create: (_) => ExamSelectedListCubit(
      //         ExamSelectedListRepository(ExamSelectedListApi()))),
      // BlocProvider<ExamMarksCubit>(
      //     create: (_) => ExamMarksCubit(ExamMarksRepository(ExamMarksApi()))),
      // BlocProvider<ExamMarksChartCubit>(
      //     create: (_) =>
      //         ExamMarksChartCubit(ExamMarksChartRepository(ExamMarksChartApi()))),
      // BlocProvider<StudentSessionCubit>(
      //     create: (_) =>
      //         StudentSessionCubit(StudentSessionRepository(StudentSessionApi()))),
      // BlocProvider<StudentChoiceSessionCubit>(
      //     create: (_) => StudentChoiceSessionCubit(
      //         StudentChoiceSessionRepository(StudentChoiceSessionApi()))),
      // BlocProvider<TeachersListCubit>(
      //     create: (_) =>
      //         TeachersListCubit(TeachersListRepository(TeachersListApi()))),
      // BlocProvider<PayByChequeStudentCubit>(
      //     create: (_) => PayByChequeStudentCubit(
      //         PayByChequeStudentRepository(PayByChequeStudentApi()))),
      // BlocProvider<ChatRoomCommentsCommonCubit>(
      //     create: (_) => ChatRoomCommentsCommonCubit(
      //         (ChatRoomCommentsCommonRepository(ChatRoomCommentsCommonApi())))),
      // BlocProvider<GatewayTypeCubit>(
      //     create: (_) =>
      //         GatewayTypeCubit(GatewayTypeRepository(GatewayTypeApi()))),
      // BlocProvider<PayUMoneyHashCubit>(
      //     create: (_) =>
      //         PayUMoneyHashCubit(PayUMoneyHashRepository(PayUMoneyHashApi()))),
      // BlocProvider<EbsHashCubit>(
      //     create: (_) => EbsHashCubit(EbsHashRepository(EbsHashApi()))),
      // BlocProvider<PayUBizHashCubit>(
      //     create: (_) =>
      //         PayUBizHashCubit(PayUBizHashRepository(PayUBizHashApi()))),
      // BlocProvider<TechProcessHashCubit>(
      //     create: (_) => TechProcessHashCubit(
      //         (TechProcessHashRepository(TechProcessHashApi())))),
      // BlocProvider<CCAvenueHashCubit>(
      //     create: (_) =>
      //         CCAvenueHashCubit(CCAvenueHashRepository(CCAvenueHashApi()))),
      // BlocProvider<WorldLineHashCubit>(
      //     create: (_) =>
      //         WorldLineHashCubit(WorldLineHashRepository(WorldLineHashApi()))),
      // BlocProvider<MarkAttendanceCubit>(
      //     create: (_) => MarkAttendanceCubit(
      //         (MarkAttendanceRepository(MarkAttendanceApi())))),
      // BlocProvider<SendClassRoomCommentCubit>(
      //     create: (_) => SendClassRoomCommentCubit(
      //         (SendClassRoomCommentRepository(SendClassRoomCommentApi())))),
      // BlocProvider<SendHomeworkCommentCubit>(
      //     create: (_) => SendHomeworkCommentCubit(
      //         (SendHomeworkCommentRepository(SendHomeworkCommentApi())))),
      // BlocProvider<DeleteHomeworkCommentCubit>(
      //     create: (_) => DeleteHomeworkCommentCubit(
      //         (DeleteHomeworkCommentRepository(DeleteHomeworkCommentApi())))),
      // BlocProvider<OnlineMeetingsCubit>(
      //     create: (_) => OnlineMeetingsCubit(
      //         (OnlineMeetingsRepository(OnlineMeetingsApi())))),
      // BlocProvider<StaffMeetingsEmployeeDashboardCubit>(
      //     create: (_) => StaffMeetingsEmployeeDashboardCubit(
      //         (StaffMeetingsEmployeeDashboardRepository(
      //             StaffMeetingsEmployeeDashboardApi())))),
      // BlocProvider<MeetingDetailsCubit>(
      //     create: (_) => MeetingDetailsCubit(
      //         (MeetingDetailsRepository(MeetingDetailsApi())))),
      // BlocProvider<MeetingDetailsAdminCubit>(
      //     create: (_) => MeetingDetailsAdminCubit(
      //         (MeetingDetailsAdminRepository(MeetingDetailsAdminApi())))),
      // BlocProvider<SelfAttendanceSettingCubit>(
      //     create: (_) => SelfAttendanceSettingCubit(
      //         (SelfAttendanceSettingRepository(SelfAttendanceSettingApi())))),
      BlocProvider<AppConfigSettingCubit>(
          create: (_) => AppConfigSettingCubit(
              (AppConfigSettingRepository(AppConfigSettingApi())))),
      // BlocProvider<StudentLeaveEmployeeCubit>(
      //     create: (_) => StudentLeaveEmployeeCubit(
      //         StudentLeaveEmployeeRepository(StudentLeaveEmployeeApi()))),
      // BlocProvider<SendHomeworkEmployeeCubit>(
      //     create: (_) => SendHomeworkEmployeeCubit(
      //         SendHomeWorkEmployeeRepository(SendHomeWorkEmployeeApi()))),
      // BlocProvider<ClassListEmployeeCubit>(
      //     create: (_) => ClassListEmployeeCubit(
      //         ClassListEmployeeRepository(ClassListEmployeeApi()))),
      // BlocProvider<AddNewEnquiryCubit>(
      //     create: (_) =>
      //         AddNewEnquiryCubit(AddNewEnquiryRepository(AddNewEnquiryApi()))),
      // BlocProvider<ViewEnquiryCubit>(
      //     create: (_) =>
      //         ViewEnquiryCubit(ViewEnquiryRepository(ViewEnquiryApi()))),
      // BlocProvider<UpdateEnquiryStatusCubit>(
      //     create: (_) => UpdateEnquiryStatusCubit(
      //         UpdateEnquiryStatusRepository(UpdateEnquiryStatusApi()))),
      // BlocProvider<EnquiryCommentListCubit>(
      //     create: (_) => EnquiryCommentListCubit(
      //         (EnquiryCommentListRepository(EnquiryCommentListApi())))),
      // BlocProvider<DashboardEnquiryCubit>(
      //     create: (_) => DashboardEnquiryCubit(
      //         (DashboardEnquiryRepository(DashboardEnquiryApi())))),
      BlocProvider<EmployeeInfoCubit>(
          create: (_) =>
              EmployeeInfoCubit(EmployeeInfoRepository(EmployeeInfoApi()))),
      // BlocProvider<HomeWorkStudentCubit>(
      //     create: (_) => HomeWorkStudentCubit(
      //         HomeWorkStudentRepository(HomeWorkStudentApi()))),
      // BlocProvider<AirPayHashCubit>(
      //     create: (_) => AirPayHashCubit(AirPayHashRepository(AirPayHashApi()))),
      // BlocProvider<SendCustomClassRoomCommentCubit>(
      //     create: (_) => SendCustomClassRoomCommentCubit(
      //         SendCustomClassRoomCommentRepository(
      //             SendCustomClassRoomCommentApi()))),
      // BlocProvider<AttendanceEmployeeCubit>(
      //     create: (_) => AttendanceEmployeeCubit(
      //         AttendanceEmployeeRepository(AttendanceEmployeeApi()))),
      // BlocProvider<FeeBalanceClassListEmployeeCubit>(
      //     create: (_) => FeeBalanceClassListEmployeeCubit(
      //         FeeBalanceClassListEmployeeRepository(
      //             FeeBalanceClassListEmployeeApi()))),
      // BlocProvider<FeeBalanceMonthListCubit>(
      //     create: (_) => FeeBalanceMonthListCubit(
      //         FeeBalanceMonthListEmployeeRepository(
      //             FeeBalanceMonthListEmployeeApi()))),
      // BlocProvider<StudentHistoryLeaveEmployeeCubit>(
      //     create: (_) => StudentHistoryLeaveEmployeeCubit(
      //         StudentLeaveEmployeeHistoryRepository(
      //             StudentLeaveEmployeeHistoryApi()))),
      // BlocProvider<AddCircularEmployeeCubit>(
      //     create: (_) => AddCircularEmployeeCubit(
      //         AddCircularEmployeeRepository(AddCircularEmployeeApi()))),
      // BlocProvider<SubjectListEmployeeCubit>(
      //     create: (_) => SubjectListEmployeeCubit(
      //         SubjectListEmployeeRepository(SubjectListEmployeeApi()))),
      // BlocProvider<ClassListAttendanceCubit>(
      //     create: (_) => ClassListAttendanceCubit(
      //         ClassListAttendanceRepository(ClassListAttendanceApi()))),
      // BlocProvider<SectionListAttendanceCubit>(
      //     create: (_) => SectionListAttendanceCubit(
      //         SectionListAttendanceRepository(SectionListAttendanceApi()))),
      // BlocProvider<MarkAttendancePeriodsEmployeeCubit>(
      //     create: (_) => MarkAttendancePeriodsEmployeeCubit(
      //         MarkAttendancePeriodsEmployeeRepository(
      //             MarkAttendancePeriodsEmployeeApi()))),
      // BlocProvider<StudentLeavePendingRejectAcceptCubit>(
      //     create: (_) => StudentLeavePendingRejectAcceptCubit(
      //         studentLeavePendingRejectAcceptRepository(
      //             StudentLeaveEmployeeHistoryRejAcpApi()))),
      // BlocProvider<AddPlanEmployeeCubit>(
      //     create: (_) => AddPlanEmployeeCubit(
      //         AddPlanEmployeeRepository(AddPlanEmployeeApi()))),
      // BlocProvider<UpdatePlanEmployeeCubit>(
      //     create: (_) => UpdatePlanEmployeeCubit(
      //         UpdatePlanEmployeeRepository(UpdatePlanEmployeeApi()))),
      // BlocProvider<FeeBalanceEmployeeCubit>(
      //     create: (_) => FeeBalanceEmployeeCubit(
      //         FeeBalanceEmployeeRepository(FeeBalanceEmployeeApi()))),
      // BlocProvider<MarkAttendanceListEmployeeCubit>(
      //     create: (_) => MarkAttendanceListEmployeeCubit(
      //         MarkAttendanceListEmployeeRepository(
      //             MarkAttendanceListEmployeeApi()))),
      // BlocProvider<MarkAttendanceSaveAttendanceEmployeeCubit>(
      //     create: (_) => MarkAttendanceSaveAttendanceEmployeeCubit(
      //         MarkAttendanceSaveAttendanceEmployeeRepository(
      //             MarkAttendanceSaveAttendanceEmployeeApi()))),
      // BlocProvider<FeedbackEnquiryCubit>(
      //     create: (_) => FeedbackEnquiryCubit(
      //         (FeedbackEnquiryRepository(FeedbackEnquiryApi())))),
      // BlocProvider<MarkAttendanceUpdateAttendanceEmployeeCubit>(
      //     create: (_) => MarkAttendanceUpdateAttendanceEmployeeCubit(
      //         MarkAttendanceUpdateAttendanceEmployeeRepository(
      //             MarkAttendanceUpdateAttendanceEmployeeApi()))),
      // BlocProvider<MeetingPlatformsCubit>(
      //     create: (_) => MeetingPlatformsCubit(
      //         (MeetingPlatformsRepository(MeetingPlatformsApi())))),
      // BlocProvider<StudentListMeetingCubit>(
      //     create: (_) => StudentListMeetingCubit(
      //         (StudentListMeetingRepository(StudentListMeetingApi())))),
      // BlocProvider<SubjectListMeetingCubit>(
      //     create: (_) => SubjectListMeetingCubit(
      //         (SubjectListMeetingRepository(SubjectListMeetingApi())))),
      // BlocProvider<ScheduleMeetingListEmployeeCubit>(
      //     create: (_) => ScheduleMeetingListEmployeeCubit(
      //         (ScheduleMeetingListEmployeeRepository(
      //             ScheduleMeetingListEmployeeApi())))),
      // BlocProvider<ScheduleMeetingListAdminCubit>(
      //     create: (_) => ScheduleMeetingListAdminCubit(
      //         (ScheduleMeetingListAdminRepository(
      //             ScheduleMeetingListAdminApi())))),
      // BlocProvider<DeleteScheduleMeetingEmployeeCubit>(
      //     create: (_) => DeleteScheduleMeetingEmployeeCubit(
      //         (DeleteScheduleMeetingEmployeeRepository(
      //             DeleteScheduleMeetingEmployeeApi())))),
      // BlocProvider<EmailCheckScheduleMeetingCubit>(
      //     create: (_) => EmailCheckScheduleMeetingCubit(
      //         (EmailCheckScheduleMeetingRepository(
      //             EmailCheckScheduleMeetingApi())))),
      // BlocProvider<AttendanceReportEmployeeCubit>(
      //     create: (_) => AttendanceReportEmployeeCubit(
      //         AttendanceReportEmployeeRepository(AttendanceReportEmployeeApi()))),
      // BlocProvider<ClassListAttendanceReportCubit>(
      //     create: (_) => ClassListAttendanceReportCubit(
      //         ClassListAttendanceReportRepository(
      //             ClassListAttendanceReportApi()))),
      // BlocProvider<UserSchoolDetailCubit>(
      //     create: (_) => UserSchoolDetailCubit(
      //         UserSchoolDetailRepository(UserSchoolDetailApi()))),
      // BlocProvider<SchoolBusRouteCubit>(
      //     create: (_) =>
      //         SchoolBusRouteCubit(SchoolBusRouteRepository(SchoolBusRouteApi()))),
      // BlocProvider<SaveScheduleMeetingCubit>(
      //     create: (_) => SaveScheduleMeetingCubit(
      //         SaveScheduleMeetingRepository(SaveScheduleMeetingApi()))),
      // BlocProvider<FetchClientSecretIdCubit>(
      //     create: (_) => FetchClientSecretIdCubit(
      //         FetchClientSecretIdRepository(FetchClientSecretIdApi()))),
      // BlocProvider<SchoolBusDetailCubit>(
      //     create: (_) => SchoolBusDetailCubit(
      //         SchoolBusDetailRepository(SchoolBusDetailApi()))),
      // BlocProvider<RemarkForStudentsListCubit>(
      //     create: (_) => RemarkForStudentsListCubit(
      //         RemarkForStudentListRepository(RemarkForStudentListApi()))),
      // BlocProvider<SearchStudentFromRecordsCommonCubit>(
      //     create: (_) => SearchStudentFromRecordsCommonCubit(
      //         SearchStudentFromRecordsCommonRepository(
      //             SearchStudentFromRecordsCommonApi()))),
      // BlocProvider<SaveStudentRemarkCubit>(
      //     create: (_) => SaveStudentRemarkCubit(
      //         SaveStudentRemarkRepository(SaveStudentRemarkApi()))),
      // BlocProvider<StudentRemarkListCubit>(
      //     create: (_) => StudentRemarkListCubit(
      // StudentRemarkListRepository(StudentRemarkListApi()))),
      // BlocProvider<DeleteStudentRemarkCubit>(
      //     create: (_) => DeleteStudentRemarkCubit(
      //         DeleteStudentRemarkRepository(DeleteStudentRemarkApi()))),
      BlocProvider<AuthTokenForBusLocationCubit>(
          create: (_) => AuthTokenForBusLocationCubit(
              AuthTokenForBusLocationRepository(AuthTokenForBusLocationApi()))),

      //====111111======
      // BlocProvider<CurrentUserEmailForZoomCubit>(
      //     create: (_) => CurrentUserEmailForZoomCubit(
      //         CurrentUserEmailForZoomRepository(CurrentUserEmailForZoomApi()))),
      // BlocProvider<AttendanceOfEmployeeAdminCubit>(
      //     create: (_) => AttendanceOfEmployeeAdminCubit(
      //         AttendanceOfEmployeeAdminRepository(
      //             AttendanceOfEmployeeAdminApi()))),
      // BlocProvider<AttendanceDetailCubit>(
      //     create: (_) => AttendanceDetailCubit(
      //         AttendanceDetailRepository(AttendanceDetailApi()))),
      // BlocProvider<WeekPlanSubjectListCubit>(
      //     create: (_) => WeekPlanSubjectListCubit(
      //         WeekPlanSubjectListRepository(WeekPlanSubjectListApi()))),
      // BlocProvider<ClassListHwStatusAdminCubit>(
      //     create: (_) => ClassListHwStatusAdminCubit(
      //         ClassListHwStatusAdminRepository(ClassListHwStatusAdminApi()))),
      // BlocProvider<ClassListPrevHwNotDoneStatusCubit>(
      //     create: (_) => ClassListPrevHwNotDoneStatusCubit(
      //         ClassListPrevHwNotDoneStatusRepository(
      //             ClassListPrevHwNotDoneStatusApi()))),
      // BlocProvider<ClassListAttendanceReportAdminCubit>(
      //     create: (_) => ClassListAttendanceReportAdminCubit(
      //         ClassListAttendanceReportAdminRepository(
      //             ClassListAttendanceReportAdminApi()))),
      // BlocProvider<SectionListAttendanceAdminCubit>(
      //     create: (_) => SectionListAttendanceAdminCubit(
      //         SectionListAttendanceAdminRepository(
      //             SectionListAttendanceAdminApi()))),
      // BlocProvider<SaveGoogleMeetScheduleMeetingCubit>(
      //     create: (_) => SaveGoogleMeetScheduleMeetingCubit(
      //         SaveGoogleMeetScheduleMeetingRepository(
      //             SaveGoogleMeetScheduleMeetingApi()))),
      // BlocProvider<SaveGoogleMeetScheduleMeetingAdminCubit>(
      //     create: (_) => SaveGoogleMeetScheduleMeetingAdminCubit(
      //         SaveGoogleMeetScheduleMeetingAdminRepository(
      //             SaveGoogleMeetScheduleMeetingAdminApi()))),
      // BlocProvider<TeacherListSubjectWiseCubit>(
      //     create: (_) => TeacherListSubjectWiseCubit(
      //         TeacherListSubjectWiseRepository(TeacherListSubjectWiseApi()))),
      // BlocProvider<FillClassOnlyWithSectionCubit>(
      //     create: (_) => FillClassOnlyWithSectionCubit(
      //         FillClassOnlyWithSectionAdminRepository(
      //             FillClassOnlyWithSectionAdminApi()))),
      // BlocProvider<GetClasswiseSubjectAdminCubit>(
      //     create: (_) => GetClasswiseSubjectAdminCubit(
      //         GetClasswiseSubjectAdminRepository(GetClasswiseSubjectAdminApi()))),
      // BlocProvider<EmployeeInfoForSearchCubit>(
      //     create: (_) => EmployeeInfoForSearchCubit(
      //         EmployeeInfoForSearchRepository(EmployeeInfoForSearchApi()))),
      // BlocProvider<SaveZoomScheduleMeetingCubit>(
      //     create: (_) => SaveZoomScheduleMeetingCubit(
      //         SaveZoomScheduleMeetingRepository(SaveZoomScheduleMeetingApi()))),
      // BlocProvider<SaveZoomScheduleMeetingAdminCubit>(
      //     create: (_) => SaveZoomScheduleMeetingAdminCubit(
      //         SaveZoomScheduleMeetingAdminRepository(
      //             SaveZoomScheduleMeetingAdminApi()))),
      // BlocProvider<MeetingStatusListAdminCubit>(
      //     create: (_) => MeetingStatusListAdminCubit(
      //         MeetingStatusListAdminRepository(MeetingStatusListAdminApi()))),
      // BlocProvider<MeetingRecipientListAdminCubit>(
      //     create: (_) => MeetingRecipientListAdminCubit(
      //         MeetingRecipientListAdminRepository(
      //             MeetingRecipientListAdminApi()))),
      // BlocProvider<SearchEmployeeFromRecordsCommonCubit>(
      //     create: (_) => SearchEmployeeFromRecordsCommonCubit(
      //         SearchEmployeeFromRecordsCommonRepository(
      //             SearchEmployeeFromRecordsCommonApi()))),
      // BlocProvider<GetComplainSuggestionListAdminCubit>(
      //     create: (_) => GetComplainSuggestionListAdminCubit(
      //         GetComplainSuggestionListAdminRepository(
      //             GetComplainSuggestionListAdminApi()))),
      // BlocProvider<ReplyComplainSuggestionAdminCubit>(
      //     create: (_) => ReplyComplainSuggestionAdminCubit(
      //         ReplyComplainSuggestionAdminRepository(
      //             ReplyComplainSuggestionAdminApi()))),
      // BlocProvider<InactiveCompOrSuggCubit>(
      //     create: (_) => InactiveCompOrSuggCubit(
      //         InactiveCompOrSuggRepository(InactiveCompOrSuggApi()))),
      // BlocProvider<GroupWiseEmployeeMeetingCubit>(
      //     create: (_) => GroupWiseEmployeeMeetingCubit(
      //         GroupWiseEmployeeMeetingRepository(GroupWiseEmployeeMeetingApi()))),
      // BlocProvider<DepartmentWiseEmployeeMeetingCubit>(
      //     create: (_) => DepartmentWiseEmployeeMeetingCubit(
      //         DepartmentWiseEmployeeMeetingRepository(
      //             DepartmentWiseEmployeeMeetingApi()))),
      // BlocProvider<LoadLastEmpNoCubit>(
      //     create: (_) =>
      //         LoadLastEmpNoCubit(LoadLastEmpNoRepository(LoadLastEmpNoApi()))),
      // BlocProvider<AddNewEmployeeCubit>(
      //     create: (_) =>
      //         AddNewEmployeeCubit(AddNewEmployeeRepository(AddNewEmployeeApi()))),
      // BlocProvider<ResultAnnounceClassCubit>(
      //     create: (_) => ResultAnnounceClassCubit(
      //         ResultAnnounceClassRepository(ResultAnnounceClassApi()))),
      // BlocProvider<ResultAnnounceExamCubit>(
      //     create: (_) => ResultAnnounceExamCubit(
      //         ResultAnnounceExamRepository(ResultAnnounceExamApi()))),
      // BlocProvider<GetExamResultPublishCubit>(
      //     create: (_) => GetExamResultPublishCubit(
      //         GetExamResultPublishRepository(GetExamResultPublishApi()))),
      // BlocProvider<PublishResultAdminCubit>(
      //     create: (_) => PublishResultAdminCubit(
      //         PublishResultAdminRepository(PublishResultAdminApi()))),
      // BlocProvider<OnlineTestStudentCubit>(
      //     create: (_) => OnlineTestStudentCubit(
      //         OnlineTestStudentRepository(OnlineTestStudentApi()))),
      // BlocProvider<OpenMarksheetCubit>(
      //     create: (_) =>
      //         OpenMarksheetCubit(OpenMarksheetRepository(OpenMarksheetApi()))),
      // BlocProvider<ExamsListExamAnalysisCubit>(
      //     create: (_) => ExamsListExamAnalysisCubit(
      //         ExamsListExamAnalysisRepository(ExamsListExamAnalysisApi()))),
      // //Todo:
      // BlocProvider<ExamAnalysisChartCubit>(
      //     create: (_) => ExamAnalysisChartCubit(
      //         ExamAnalysisChartRepository(ExamAnalysisChartApi()))),
      // BlocProvider<ExamAnalysisLineChartCubit>(
      //     create: (_) => ExamAnalysisLineChartCubit(
      //         ExamAnalysisLineChartRepository(ExamAnalysisLineChartApi()))),
      // BlocProvider<YearSessionListExamAnalysisCubit>(
      //     create: (_) => YearSessionListExamAnalysisCubit(
      //         YearSessionListExamAnalysisRepository(
      //             YearSessionListExamAnalysisApi()))),
      // BlocProvider<ScheduleMeetingTodayListCubit>(
      //     create: (_) => ScheduleMeetingTodayListCubit(
      //         ScheduleMeetingTodayListRepository(ScheduleMeetingTodayListApi()))),
      // BlocProvider<GetUserAssignMenuCubit>(
      //     create: (_) => GetUserAssignMenuCubit(
      //         GetUserAssignMenuRepository(GetUserAssignMenuApi()))),
      // BlocProvider<UpdateAssignMenuCubit>(
      //     create: (_) => UpdateAssignMenuCubit(
      //         UpdateAssignMenuRepository(UpdateAssignMenuApi()))),
      // BlocProvider<LoadClassForSmsCubit>(
      //     create: (_) => LoadClassForSmsCubit(
      //         LoadClassForSmsRepository(LoadClassForSmsApi()))),
      // BlocProvider<GetExamTypeAdminCubit>(
      //     create: (_) => GetExamTypeAdminCubit(
      //         GetExamTypeAdminRepository(GetExamTypeAdminApi()))),
      // BlocProvider<GetSubjectAdminCubit>(
      //     create: (_) => GetSubjectAdminCubit(
      //         GetSubjectAdminRepository(GetSubjectAdminApi()))),
      // BlocProvider<GetExamMarksForTeacherCubit>(
      //     create: (_) => GetExamMarksForTeacherCubit(
      //         GetExamMarksForTeacherRepository(GetExamMarksForTeacherApi()))),
      // BlocProvider<GetMinMaxMarksCubit>(
      //     create: (_) =>
      //         GetMinMaxMarksCubit(GetMinMaxmarksRepository(GetMinMaxMarksApi()))),
      // BlocProvider<LoadBusRoutesCubit>(
      //     create: (_) =>
      //         LoadBusRoutesCubit(LoadBusRoutesRepository(LoadBusRoutesApi()))),
      // BlocProvider<LoadEmployeeGroupsCubit>(
      //   create: (_) => LoadEmployeeGroupsCubit(
      //       LoadEmployeeGroupsRepository(LoadEmployeeGroupsApi())),
      // ),
      // BlocProvider<LoadHouseGroupCubit>(
      //     create: (_) =>
      //         LoadHouseGroupCubit(LoadHouseGroupRepository(LoadHouseGroupApi()))),
      // BlocProvider<LoadAddressGroupCubit>(
      //     create: (_) => LoadAddressGroupCubit(
      //         LoadAddressGroupRepository(LoadAddressGroupApi()))),
      // BlocProvider<SendSmsAdminCubit>(
      //   create: (_) =>
      //       SendSmsAdminCubit(SendSmsAdminRepository(SendSmsAdminApi())),
      // ),
      // BlocProvider<AssignClassTeacherAdminCubit>(
      //     create: (_) => AssignClassTeacherAdminCubit(
      //         AssignClassTeacherAdminRepository(AssignClassTeacherAdminApi()))),
      // BlocProvider<LoadClassForSubjectAdminCubit>(
      //     create: (_) => LoadClassForSubjectAdminCubit(
      //         LoadClassForSubjectAdminRepository(LoadClassForSubjectAdminApi()))),
      // BlocProvider<GetClassSectionAdminCubit>(
      //     create: (_) => GetClassSectionAdminCubit(
      //         GetClassSectionAdminRepository(GetClassSectionAdminApi()))),
      // BlocProvider<SubjectAlloteToTeacherCubit>(
      //     create: (_) => SubjectAlloteToTeacherCubit(
      //         SubjectAlloteToTeacherRepository(SubjectAlloteToTeacherApi()))),
      // BlocProvider<LoadAllottedSubjectCubit>(
      //     create: (_) => LoadAllottedSubjectCubit(
      //         LoadAllottedSubjectsRepository(LoadAllottedSubjectsApi()))),
      // BlocProvider<RemoveAllottedSubjectCubit>(
      //     create: (_) => RemoveAllottedSubjectCubit(
      //         RemoveAllottedSubjectsRepository(RemoveAllottedSubjectsApi()))),
      // BlocProvider<AssignPeriodAdminCubit>(
      //   create: (_) => AssignPeriodAdminCubit(
      //       AssignPeriodAdminRepository(AssignPeriodAdminApi())),
      // ),
      // BlocProvider<GetSelectClassTeacherCubit>(
      //     create: (_) => GetSelectClassTeacherCubit(
      //         GetSelectClassTeacherRepository(GetSelectClassTeacherApi()))),
      // BlocProvider<UpdateStudentAccountStatusCubit>(
      //     create: (_) => UpdateStudentAccountStatusCubit(
      //         UpdateStudentAccountStatusRepository(
      //             UpdateStudentAccountStatusApi()))),
      // BlocProvider<UpdateStudentPasswordCubit>(
      //     create: (_) => UpdateStudentPasswordCubit(
      //         UpdateStudentPasswordRepository(UpdateStudentPasswordApi()))),
      // BlocProvider<UpdateStudentMobileNoCubit>(
      //     create: (_) => UpdateStudentMobileNoCubit(
      //         UpdateStudentMobileNoRepository(UpdateStudentMobileNoApi()))),
      // BlocProvider<SendStudentDetailsCubit>(
      //     create: (_) => SendStudentDetailsCubit(
      //         SendStudentDetailsRepository(SendStudentDetailsApi()))),
      // BlocProvider<CreateUserStudentStatusCubit>(
      //     create: (_) => CreateUserStudentStatusCubit(
      //         CreateUserStudentStatusRepository(CreateUserStudentStatusApi()))),
      // BlocProvider<ClassroomEmployeeCubit>(
      //     create: (_) => ClassroomEmployeeCubit(
      //         ClassroomEmployeeRepository(ClassroomEmployeeApi()))),
      // BlocProvider<HomeworkEmployeeCubit>(
      //     create: (_) => HomeworkEmployeeCubit(
      //         HomeworkEmployeeRepository(HomeworkEmployeeApi()))),
      // BlocProvider<DeleteClassroomCubit>(
      //     create: (_) => DeleteClassroomCubit(
      //         DeleteClassroomRepository(DeleteClassroomApi()))),
      // BlocProvider<DeleteHomeworkCubit>(
      //     create: (_) =>
      //         DeleteHomeworkCubit(DeleteHomeworkRepository(DeleteHomeworkApi()))),
      // BlocProvider<CustomChatUserListCubit>(
      //     create: (_) => CustomChatUserListCubit(
      //         CustomChatUserListRepository(CustomChatUserListApi()))),
      // BlocProvider<CustomChatCubit>(
      //     create: (_) => CustomChatCubit(CustomChatRepository(CustomChatApi()))),
      // BlocProvider<SendCustomChatCubit>(
      //     create: (_) =>
      //         SendCustomChatCubit(SendCustomChatRepository(SendCustomChatApi()))),
      // BlocProvider<DeleteCustomChatCubit>(
      //     create: (_) => DeleteCustomChatCubit(
      //         DeleteCustomChatRepository(DeleteCustomChatApi()))),
      // BlocProvider<SaveExamMarksCubit>(
      //     create: (_) =>
      //         SaveExamMarksCubit(SaveExamMarksRepository(SaveExamMarksApi()))),
      // BlocProvider<SubjectExamMarksCubit>(
      //     create: (_) => SubjectExamMarksCubit(
      //         SubjectExamMarksRepository(SubjectExamMarksApi()))),
      // BlocProvider<ExamListGradeEntryCubit>(
      //     create: (_) => ExamListGradeEntryCubit(
      //         ExamListGradeEntryRepository(ExamListGradeEntryApi()))),
      // BlocProvider<AssignAdminCubit>(
      //     create: (_) =>
      //         AssignAdminCubit(AssignAdminRepository(AssignAdminApi()))),
      // BlocProvider<SaveGradeEntryCubit>(
      //     create: (_) =>
      //         SaveGradeEntryCubit(SaveGradeEntryRepository(SaveGradeEntryApi()))),
      // BlocProvider<GradeEntryListCubit>(
      //     create: (_) =>
      //         GradeEntryListCubit(GradeEntryListRepository(GradeEntryListApi()))),
      // BlocProvider<GradesListGradeEntryCubit>(
      //     create: (_) => GradesListGradeEntryCubit(
      //         GradeListGradeEntryRepository(GradeListGradeEntryApi()))),
      // BlocProvider<CircularEmployeeCubit>(
      //     create: (_) => CircularEmployeeCubit(
      //         CircularEmployeeRepository(CircularEmployeeApi()))),
      // BlocProvider<DeleteCircularCubit>(
      //     create: (_) =>
      //         DeleteCircularCubit(DeleteCircularRepository(DeleteCircularApi()))),
      // BlocProvider<CceGeneralTeacherRemarksListCubit>(
      //     create: (_) => CceGeneralTeacherRemarksListCubit(
      //         CceGeneralTeacherRemarksListRepository(
      //             CceGeneralTeacherRemarksListApi()))),
      // BlocProvider<CceSubjectTeacherRemarksListCubit>(
      //     create: (_) => CceSubjectTeacherRemarksListCubit(
      //         CceSubjectTeacherRemarksListRepository(
      //             CceSubjectTeacherRemarksListApi()))),
      // BlocProvider<TeacherRemarksListCubit>(
      //     create: (_) => TeacherRemarksListCubit(
      //         TeacherRemarksListRepository(TeacherRemarksListApi()))),
      // BlocProvider<SaveCceSubjectTeacherRemarksCubit>(
      //     create: (_) => SaveCceSubjectTeacherRemarksCubit(
      //         SaveCceSubjectTeacherRemarksRepository(
      //             SaveCceSubjectTeacherRemarksApi()))),
      // BlocProvider<SaveCceGeneralTeacherRemarksCubit>(
      //     create: (_) => SaveCceGeneralTeacherRemarksCubit(
      //         SaveCceGeneralTeacherRemarksRepository(
      //             SaveCceGeneralTeacherRemarksApi()))),
      // BlocProvider<SaveClassRoomCubit>(
      //     create: (_) =>
      //         SaveClassRoomCubit(SaveClassRoomRepository(SaveClassroomApi()))),
      // BlocProvider<ActivityForStudentCubit>(
      //     create: (_) => ActivityForStudentCubit(
      //         ActivityForStudentRepository(ActivityForStudentApi()))),
      // BlocProvider<DeleteActivityCubit>(
      //   create: (_) =>
      //       DeleteActivityCubit(DeleteActivityRepository(DeleteActivityApi())),
      // ),
      // BlocProvider<FillPeriodAttendanceCubit>(
      //     create: (_) => FillPeriodAttendanceCubit(
      //         FillPeriodAttendanceRepository(FillPeriodAttendanceApi()))),
      // BlocProvider<StudentListForChangeRollNoCubit>(
      //     create: (_) => StudentListForChangeRollNoCubit(
      //         StudentListForChangeRollNoRepository(
      //             StudentListForChangeRollNoApi()))),
      // BlocProvider<UpdateRollNoEmployeeCubit>(
      //     create: (_) => UpdateRollNoEmployeeCubit(
      //         UpdateRollNoEmployeeRepository(UpdateRollNoEmployeeApi()))),
      // BlocProvider<CceAttendanceClassDataCubit>(
      //     create: (_) => CceAttendanceClassDataCubit(
      //         CceAttendanceClassDataRepository(CceAttendanceClassDataApi()))),
      // BlocProvider<SaveCceAttendanceCubit>(
      //     create: (_) => SaveCceAttendanceCubit(
      //         SaveCceAttendanceRepository(SaveCceAttendanceApi()))),
      // BlocProvider<PayModeWiseFeeCubit>(
      //     create: (_) => PayModeWiseFeeCubit(
      //         PayModeWiseFeeRepository(PayModeWiseFeeApi()))),
      // BlocProvider<ApproveBillCubit>(
      //     create: (_) =>
      //         ApproveBillCubit(ApproveBillRepository(ApproveBillApi()))),
      // BlocProvider<BillDetailsBillApproveCubit>(
      //     create: (_) => BillDetailsBillApproveCubit(
      //         BillDetailsBillApproveRepository(BillDetailsBillApproveApi()))),
      // BlocProvider<BillsListBillApproveCubit>(
      //     create: (_) => BillsListBillApproveCubit(
      //         BillsListBillApproveRepository(BillsListBillApproveApi()))),
      // BlocProvider<PartyTypeBillApproveCubit>(
      //     create: (_) => PartyTypeBillApproveCubit(
      //         PartyTypeBillApproveRepository(PartyTypeBillApproveApi()))),
      // BlocProvider<DayClosingDataCubit>(
      //     create: (_) => DayClosingDataCubit(
      //         DayClosingDataRepository(DayClosingDataApi()))),
      // BlocProvider<DiscountGivenAllowDiscountCubit>(
      //     create: (_) => DiscountGivenAllowDiscountCubit(
      //         DiscountGivenAllowDiscountRepository(
      //             DiscountGivenAllowDiscountApi()))),
      // BlocProvider<SchoolSettingAllowDiscountCubit>(
      //     create: (_) => SchoolSettingAllowDiscountCubit(
      //         SchoolSettingAllowDiscountRepository(
      //             SchoolSettingAllowDiscountApi()))),
      // BlocProvider<DiscountApplyAndRejectCubit>(
      //     create: (_) => DiscountApplyAndRejectCubit(
      //         DiscountApplyAndRejectRepository(DiscountApplyAndRejectApi()))),
      // BlocProvider<AllowDiscountListCubit>(
      //     create: (_) => AllowDiscountListCubit(
      //         AllowDiscountListRepository(AllowDiscountListApi()))),
      // BlocProvider<BalanceFeeAdminCubit>(
      //     create: (_) => BalanceFeeAdminCubit(
      //         BalanceFeeAdminRepository(BalanceFeeAdminApi()))),
      // BlocProvider<FeeCollectionsClassWiseCubit>(
      //     create: (_) => FeeCollectionsClassWiseCubit(
      //         FeeCollectionsClassWiseRepository(FeeCollectionsClassWiseApi()))),
      // BlocProvider<MainModeWiseFeeCubit>(
      //     create: (_) => MainModeWiseFeeCubit(
      //         MainModeWiseFeeRepository(MainModeWiseFeeApi()))),
      // BlocProvider<FeeHeadBalanceFeeCubit>(
      //     create: (_) => FeeHeadBalanceFeeCubit(
      //         FeeHeadBalanceFeeRepository(FeeHeadBalanceFeeApi()))),
      // BlocProvider<TeachersListMeetingCubit>(
      //     create: (_) => TeachersListMeetingCubit(
      //         TeachersListMeetingRepository(TeachersListMeetingApi()))),
      // BlocProvider<TeacherStatusListCubit>(
      //     create: (_) => TeacherStatusListCubit(
      //         TeacherStatusListRepository(TeachersStatusListApi()))),
      // BlocProvider<AdmissionStatusCubit>(
      //     create: (_) => AdmissionStatusCubit(
      //         AdmissionStatusRepository(AdmissionStatusApi()))),
      // BlocProvider<EmployeeStatusListCubit>(
      //     create: (_) => EmployeeStatusListCubit(
      //         EmployeeStatusListRepository(EmployeeStatusListApi()))),
      // BlocProvider<CreateUserEmployeeStatusCubit>(
      //     create: (_) => CreateUserEmployeeStatusCubit(
      //         CreateUserEmployeeStatusRepository(CreateUserEmployeeStatusApi()))),
      // BlocProvider<DeleteUserEmployeeStatusCubit>(
      //     create: (_) => DeleteUserEmployeeStatusCubit(
      //         DeleteUserEmployeeStatusRepository(DeleteUserEmployeeStatusApi()))),
      // BlocProvider<SaveSubjectEnrichmentDetailCubit>(
      //     create: (_) => SaveSubjectEnrichmentDetailCubit(
      //         SaveSubjectEnrichmentDetailsRepository(
      //             SaveSubjectEnrichmentDetailsApi()))),
      // BlocProvider<LoadUserTypeSendSmsCubit>(
      //     create: (_) => LoadUserTypeSendSmsCubit(
      //         LoadUserTypeSendSmsRepository(LoadUserTypeSendSmsApi()))),
      // BlocProvider<GetSmsTypeSmsConfigCubit>(
      //     create: (_) => GetSmsTypeSmsConfigCubit(
      //         GetSmsTypeSmsConfigRepository(GetSmsTypeSmsConfigApi()))),
      // BlocProvider<GetSmsTypeDetailSmsConfgCubit>(
      //   create: (_) => GetSmsTypeDetailSmsConfgCubit(
      //       GetSmsTypeDetailSmsConfigRepository(GetSmsTypeDetailSmsConfigApi())),
      // ),
      // BlocProvider<SaveSmsTypeCubit>(
      //   create: (_) =>
      //       SaveSmsTypeCubit(SaveSmsTypeSmsRepository(SaveSmsTypeSmsApi())),
      // ),
      // BlocProvider<GetStudentAmountCubit>(
      //     create: (_) => GetStudentAmountCubit(
      //         GetStudentMonthlyAmountRepository(GetStudentMonthlyAmountApi()))),
      // BlocProvider<OtpUserListCubit>(
      //     create: (_) =>
      //         OtpUserListCubit(OtpUserListRepository(OtpUserListApi()))),
      // BlocProvider<ChangeOtpUserLogsCubit>(
      //     create: (_) => ChangeOtpUserLogsCubit(
      //         ChangeOtpUserLogsRepository(ChangeOtpUserLogsApi()))),
      // BlocProvider<AppUserListCubit>(
      //     create: (_) =>
      //         AppUserListCubit(AppUserListRepository(AppUserListApi()))),
      // BlocProvider<AppUserDetailCubit>(
      //     create: (_) =>
      //         AppUserDetailCubit(AppUserDetailRepository(AppUserDetailApi()))),
      // BlocProvider<DownloadAppUserDataCubit>(
      //     create: (_) => DownloadAppUserDataCubit(
      //         DownloadAppUserDataRepository(DownloadAppUserDataApi()))),
      // BlocProvider<DashboardAdminCubit>(
      //     create: (_) => DashboardAdminCubit(
      //         DashboardAdminRepository(DashboardAdminApi()))),
      // BlocProvider<PreClassExamAnalysisCubit>(
      //     create: (_) => PreClassExamAnalysisCubit(
      //         PreClassExamAnalysisRepository(PreClassExamAnalysisApi()))),
      // BlocProvider<SubjectListExamAnalysisCubit>(
      //     create: (_) => SubjectListExamAnalysisCubit(
      //         SubjectListExamAnalysisRepository(SubjectListExamAnalysisApi()))),
      // BlocProvider<ExamAnalysisChartAdminCubit>(
      //     create: (_) => ExamAnalysisChartAdminCubit(
      //         ExamAnalysisChartAdminRepository(ExamAnalysisChartAdminApi()))),
      // BlocProvider<GetEmployeeOnlineCredCubit>(
      //     create: (_) => GetEmployeeOnlineCredCubit(
      //         GetEmployeeOnlineClassCredentialsRepository(
      //             GetEmployeeOnlineClassCredentialsApi()))),
      // BlocProvider<SetPlatformCubit>(
      //   create: (_) =>
      //       SetPlatformCubit(SetPlateformRepository(SetPlateformApi())),
      // ),
      // BlocProvider<CoordinatorListDetailCubit>(
      //     create: (_) => CoordinatorListDetailCubit(
      //         CoordinatorListDetailRepository(CoordinatorListDetailApi()))),
      // BlocProvider<DeleteCoordinatorCubit>(
      //     create: (_) => DeleteCoordinatorCubit(
      //         DeleteCoordinatorRepository(DeleteCoordinatorApi()))),
      // BlocProvider<GetCoordinatorListCubit>(
      //     create: (_) => GetCoordinatorListCubit(
      //         GetCoordinatorListRepository(GetCoordinatorListApi()))),
      // BlocProvider<GetCoordinatorProfileCubit>(
      //     create: (_) => GetCoordinatorProfileCubit(
      //         GetCoordinatorProfileRepository(GetCoordinatorProfileApi()))),
      // BlocProvider<GetSelectClassCoordinatorCubit>(
      //     create: (_) => GetSelectClassCoordinatorCubit(
      //         GetSelectClassCoordinatorRepository(
      //             GetSelectClassCoordinatorApi()))),
      // BlocProvider<AssignClassCoordinatorCubit>(
      //     create: (_) => AssignClassCoordinatorCubit(
      //         AssignClassCoordinatorRepository(AssignClassCoordinatorApi()))),
      // BlocProvider<GetTopicAndSkillCubit>(
      //     create: (_) => GetTopicAndSkillCubit(
      //         GetTopicAndSkillRepository(GetTopicAndSkillApi()))),
      // BlocProvider<LoadStudentForSubjectListCubit>(
      //   create: (_) => LoadStudentForSubjectListCubit(
      //       LoadStudentForSubjectListRepository(LoadStudentForSubjectListApi())),
      // ),
      // BlocProvider<GetGradeCubit>(
      //   create: (_) => GetGradeCubit(GetGradeRepository(GetGradeApi())),
      // ),
      // BlocProvider<GetPopupMessageListCubit>(
      //     create: (_) => GetPopupMessageListCubit(
      //         GetPopupMessageListRepository(GetPopupMessageListApi()))),
      // BlocProvider<GetPopupAlertListCubit>(
      //     create: (_) => GetPopupAlertListCubit(
      //         GetPopupAlertListRepository(GetPopupAlertListApi()))),
      // BlocProvider<DeleteMessagePopupCubit>(
      //     create: (_) => DeleteMessagePopupCubit(
      //         DeleteMessagePopupRepository(DeleteMessagePopupApi()))),
      // BlocProvider<DeleteAlertPopupCubit>(
      //     create: (_) => DeleteAlertPopupCubit(
      //         DeleteAlertPopupRepository(DeleteAlertPopupApi()))),
      // BlocProvider<SavePopupMessageCubit>(
      //     create: (_) => SavePopupMessageCubit(
      //         SavePopupMessageRepository(SavePopupMessageApi()))),
      // BlocProvider<SavePopupAlertCubit>(
      //   create: (_) =>
      //       SavePopupAlertCubit(SavePopupAlertRepository(SavePopupAlertApi())),
      // ),
      // BlocProvider<ClassesForCoordinatorCubit>(
      //     create: (_) => ClassesForCoordinatorCubit(
      //         ClassesForCoordinatorRepository(ClassesForCoordinatorApi()))),
      // BlocProvider<GetStudentListResultAnnounceCubit>(
      //     create: (_) => GetStudentListResultAnnounceCubit(
      //         GetStudentListResultAnnounceRepository(
      //             GetStudentListResultAnnounceApi()))),
      // BlocProvider<GetEmployeeTaskManagementCubit>(
      //     create: (_) => GetEmployeeTaskManagementCubit(
      //         GetEmployeeTaskManagementRepository(
      //             GetEmployeeTaskManagementApi()))),
      // BlocProvider<SaveTaskDetailsCubit>(
      //     create: (_) => SaveTaskDetailsCubit(
      //         SaveTaskDetailsRepository(SaveTaskDetailsApi()))),
      // BlocProvider<GetTaskDataCubit>(
      //     create: (_) =>
      //         GetTaskDataCubit(GetTaskDataRepository(GetTaskDataApi()))),
      // BlocProvider<DeleteTaskDetailCubit>(
      //     create: (_) => DeleteTaskDetailCubit(
      //         SaveTaskDetailsRepository(SaveTaskDetailsApi()))),
      // BlocProvider<GetTaskTaskManagementCubit>(
      //     create: (_) => GetTaskTaskManagementCubit(
      //         GetEmployeeTaskManagementRepository(
      //             GetEmployeeTaskManagementApi()))),
      // BlocProvider<GetFollowerListTaskManagementCubit>(
      //     create: (_) => GetFollowerListTaskManagementCubit(
      //         AssignFollowerListTaskManagementReporisoty(
      //             AssignFollowerListTaskManagementApi()))),
      // BlocProvider<GetAssignListTaskManagementCubit>(
      //     create: (_) => GetAssignListTaskManagementCubit(
      //         AssignFollowerListTaskManagementReporisoty(
      //             AssignFollowerListTaskManagementApi()))),
      // BlocProvider<GetTaskListByIdCubit>(
      //     create: (_) => GetTaskListByIdCubit(
      //         GetTaskListByIdRepository(GetTaskListByIdApi()))),
      // BlocProvider<GetEmployeeTaskManagement2Cubit>(
      //     create: (_) => GetEmployeeTaskManagement2Cubit(
      //         GetEmployeeTaskManagementRepository(
      //             GetEmployeeTaskManagementApi()))),
      // BlocProvider<GetTeskDataEmployeeCubit>(
      //     create: (_) => GetTeskDataEmployeeCubit(
      //         GetTaskDataEmployeeRepository(GetTaskDataEmployeeApi()))),
      // BlocProvider<GetEmployeeTaskStatusCubit>(
      //     create: (_) => GetEmployeeTaskStatusCubit(
      //         GetEmployeeTaskManagementRepository(
      //             GetEmployeeTaskManagementApi()))),
      // BlocProvider<GetCommentsEmployeeTaskCubit>(
      //     create: (_) => GetCommentsEmployeeTaskCubit(
      //         GetCommentsEmployeeTaskRepository(GetCommentsEmployeeTaskApi()))),
      // BlocProvider<GatePassMeetToCubit>(
      //     create: (_) => GatePassMeetToCubit(
      //         GatePassMeetToRepository(GatePassMeetToApi()))),
      // BlocProvider<SendingOtpGatePassCubit>(
      //     create: (_) => SendingOtpGatePassCubit(
      //         SendingOtpGatePassRepository(SendingOtpGatePassApi()))),
      // BlocProvider<VerifyOtpGatePassCubit>(
      //     create: (_) => VerifyOtpGatePassCubit(
      //         VerifyOtpGatePassRepository(VerifyOtpGatePassApi()))),
      // BlocProvider<SaveVisitorDetailsGatePassCubit>(
      //     create: (_) => SaveVisitorDetailsGatePassCubit(
      //         SaveVisitorDetailsGatePassRepository(
      //             SaveVisitorDetailsGatePassApi()))),
      // BlocProvider<VisitorListGatePassCubit>(
      //   create: (_) => VisitorListGatePassCubit(
      //       VisitorListTodayGatePassRepository(VisitorListTodayGatePassApi())),
      // ),
      // BlocProvider<MarkVisitorExitCubit>(
      //   create: (_) => MarkVisitorExitCubit(
      //       MarkVisitorExitRepository(MarkVisitorExitApi())),
      // ),
      // BlocProvider<VerifyIdProofGatePassCubit>(
      //     create: (_) => VerifyIdProofGatePassCubit(
      //         VerifyIdProofGatePassRepository(VerifyIdProofGatePassApi()))),
      BlocProvider<CheckAppRestrictionCubit>(
          create: (_) => CheckAppRestrictionCubit(
              CheckAppRestrictionRepository(CheckAppRestrictionApi()))),
      // BlocProvider<NotifyCounterCubit>(
      //     create: (_) =>
      //         NotifyCounterCubit(NotifyCounterRepository(NotifyCounterApi()))),
      // BlocProvider<FeeTypeSettingCubit>(
      //     create: (_) =>
      //         FeeTypeSettingCubit(FeeTypeSettingRepository(FeeTypeSettingApi()))),
      // BlocProvider<TermsConditionsSettingCubit>(
      //     create: (_) => TermsConditionsSettingCubit(
      //         TermsConditionsSettingRepository(TermsConditionsSettingApi()))),
      // BlocProvider<SchoolBusListCubit>(
      //     create: (_) =>
      //         SchoolBusListCubit(SchoolBusListRepository(SchoolBusListApi()))),
      // BlocProvider<SaveEmployeeImageCubit>(
      //     create: (_) => SaveEmployeeImageCubit(
      //         SaveEmployeeImageRepository(SaveEmployeeImageApi()))),
      // BlocProvider<RestrictionPageCubit>(
      //     create: (_) => RestrictionPageCubit(
      //         RestrictionPageRepository(RestrictionPageApi()))),
      // BlocProvider<SchoolBusStopsCubit>(
      //     create: (_) =>
      //         SchoolBusStopsCubit(SchoolBusStopsRepository(SchoolBusStopsApi()))),
      // BlocProvider<SchoolBusInfoCubit>(
      //     create: (_) =>
      //         SchoolBusInfoCubit(SchoolBusInfoRepository(SchoolBusInfoApi()))),
      // BlocProvider<GotoWebAppCubit>(
      //     create: (_) =>
      //         GotoWebAppCubit(GotoWebAppRepository(GotoWebAppApi()))),
      // BlocProvider<GetGatePassHistoryCubit>(
      //   create: (_) => GetGatePassHistoryCubit(
      //       GetGatePassHistoryRepository(GetGatePassHistoryApi())),
      // ),
      // BlocProvider<CheckBusAllotCubit>(
      //     create: (_) =>
      //         CheckBusAllotCubit(CheckBusAllotRepository(CheckBusAllotApi()))),
      // BlocProvider<GetBusHistoryCubit>(
      //     create: (_) =>
      //         GetBusHistoryCubit(GetBusHistoryRepository(GetBusHistoryApi()))),
    ];
    return providers.toList();
  } catch (e) {
    debugPrint(e.toString());
  }
}
