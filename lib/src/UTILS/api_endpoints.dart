import 'dart:convert';
import 'package:campus_pro/src/DATA/userUtils.dart';

class ApiEndpoints {
  ApiEndpoints._();

  // static const baseUrl = "https://mobileweb.rugerp.com/api/";
  // static const baseUrl = "https://appdev.rugerp.com/api/";

  static const baseUrl = "https://mobiledevweb.rugerp.com/api/";

  static const saveFcmToken = baseUrl + "UpdateLastActive_fcmtokenwebnew";

  static const userSchoolDetailApi = baseUrl + "GetSchoolNameandlogo";

  static const String getHeaderToken = baseUrl + 'GetHeaderToken';

  // static const gotoWebAppApi = baseUrl + "GotoWebApp";
  static const gotoWebAppApi = baseUrl + "GotoWebApp";

  static const signInWithGoogle = baseUrl + "AuthByGmail";

  //-------APP SETTINGS APIs----------------------------------------------------
  static const appConfigSettingApi = baseUrl + "getAppConfig";
  static const selfAttendanceSettingApi = baseUrl + "checkStudentSelfAttedance";
  static const getUserAssignMenuApi = baseUrl + "GetUserAssignMenu";
  static const getUpdateAssignMenuApi = baseUrl + "UpdateAssignMenu";

  //-------LOGIN----------------------------------------------------------------
  static const String loginApi = baseUrl + "AutheticateLogin";

  //-------FORGOT PASSWORD----------------------------------------------------------------
  static const forgotPasswordApi = baseUrl + "GenerateOtp";
  static const verifyOtpApi = baseUrl + "VerifyOtp";

  //-------Account TYPE----------------------------------------------------------------
  static const accountTypes = baseUrl + "getUserCompany";

  //-------PROFILE----------------------------------------------------------------
  static const viewProfileApi = baseUrl + "getStuProfile";
  static const profileEditApi = baseUrl + "requestStudentDataUpdate";
  static const employeeInfoApi = baseUrl + "getEmpProfilenew";
  //searchEmpId

  //-------CHANGE PASSWORD----------------------------------------------------------------
  static const checkEmailRegistrationApi =
      baseUrl + "GetSettingForChangePassword";
  // static const updateEmailApi = baseUrl + "GetUserEmail"; - OLD
  static const updateEmailApi = baseUrl + "UpdateDashboardEmail";
  static const changePasswordApi = baseUrl + "ChangePassword";

  //////////////////PRIYANSHI APIs LIST//////////////////////////////////////////////////////////////////////////////////////////
  //-------ACTIVITY FORM--------------------------------------------------------
  // static const getActivityApi = baseUrl + "getActivities";
  static const activityApi = baseUrl + "getActivities";
  static const saveActivityApi = baseUrl + "saveActivities_v1";
  static const getActivityStudentApi = baseUrl + "getActivityHtmlContent";
  static const deleteActivityApi = baseUrl + "delActivity";
  //static const deleteCircularApi = baseUrl + "deleteCircular";
  // static const verifyOtpApi = baseUrl + "loadClassForSms";
  // static const verifyOtpApi = baseUrl + "getClassesOfEmployee";

  //-------ATTENDANCE-----------------------------------------------------------
  static const attendanceGraphApi = baseUrl + "GetStuAttendance";
  static const leaveRequestApi = baseUrl + "getRequestedLeaveStatuses";
  static const assignTeacherApi = baseUrl + "getClassTeacher";
  static const applyForLeaveApi = baseUrl + "RequestForLeave";
  static const attendanceEmployee = baseUrl + "GetStuAttForAdminV3";
  //
  static const getClassAttendanceReportApi = baseUrl + "fillclassonly";

  static const getClassSectionAttendanceReportApi =
      baseUrl + "fillclasssectiononly";

  static const ClassAttendanceReportApi = baseUrl + "fillteacherclassonly";

  static const getSectionAttendanceReportApi =
      baseUrl + "fillteachersectiononly";
  //"fillclasssectiononly";

  static const getfillperiodattendancemarkAttendanceApi =
      baseUrl + "fillperiodattendance";

  //both for mark attendance period api
  static const getPeriodsMarkAttendance = baseUrl + "getPeriodForAttendance";
  static const getPeriodsMarkAttendance1 =
      baseUrl + "GetAssignPeriodToEmployee";
  //

  static const getMarkAttendanceStuListEmployee =
      baseUrl + "getstudentforMarkAtt";
  static const markAttendanceSaveAttendance = baseUrl + "CheckAttendance";

  static const markAttendanceUpdateAttendance = baseUrl + "MarkAttendance";

  static const getAttendanceReportEmployee =
      baseUrl + "GetAttendanceStatusPeriodwise";

  static const getAttendanceDetailApi = baseUrl + 'getStudentAttOnDateV2';
  static const getAttendanceofEmployeeAdminApi =
      baseUrl + "GetTeacherAttForAdminV1";

  //-------School Bus Location-------------------------------------------------------------

  static const authTokenForBusLocationApi = "getbusmapauthtoken";

  static const schoolBusLiveLocationApi = baseUrl + "VehicleDetails";
  // static const schoolBusLiveLocationApi =
  //     "https://loconav.com/api/v3/device/details?vehicle_number=";
  static const nearByBusesApi = baseUrl + "LocateNearByBus";
  static const schoolBusRouteApi = baseUrl + "MapRealData";
  static const schoolBusDetailApi = baseUrl + "Stutansportreport";
  static const checkBusAllotApii = baseUrl + "CheckBusAllot";
  static const getBusHistoryApi = baseUrl + "GetBusHistory";

  //-------RESTRICTION-
  static const restrictionPageApi = baseUrl + "PopupDashboard";
  static const checkAppRestrictionApi = baseUrl + "CheckFlag";

  static const notifyCounterApi = baseUrl + "GetNotificationCount";

  //-------CIRCULAR-------------------------------------------------------------
  static const circularStudentApi = baseUrl + "getCircularV4";
  //static const addCircularEmployee = baseUrl + "AddcircularNew";
  static const addCircularEmployee = baseUrl + "Addcircular_V1";
  static const circularClassForCoordinator =
      baseUrl + "GetselectClassCoordinatorDropdownwithSection";

  //-------CIRCULAR EMPLOYEE-------------------------------------------------------------
  static const circularEmployeeApi = baseUrl + "getCircular";
  static const deleteCircularApi = baseUrl + "DeleteCircularnew";

  // static const getCircular = baseUrl + "";

  //=============================================================================================================================

  //-------FEE COLLECTIONS-----------------------------------------------------------
  static const payModeWiseFeeApi = baseUrl + "GetFeeCollectionPayModeWiseV2";
  static const mainModeWiseFeeApi = baseUrl + "GetFeeCollectionMainHeadWiseV2";

  //-------FEE COLLECTIONS CLASS WISE-----------------------------------------------------------
  static const feeCollectionsClassWiseApi = baseUrl + "getCollectionUptoMonth";

  //-------BALANCE FEE-----------------------------------------------------------
  static const feeHeadBalanceFeeApi = baseUrl + "GetFeeHead";
  static const balanceFeeAdminApi = baseUrl + "GetClasswiseHeadwiseBalance";

  //-------ALLOW DISCOUNT-----------------------------------------------------------
  static const allowDiscountListApi = baseUrl + "GetAllowDiscountData";
  static const discountApplyAndRejectApi = baseUrl + "DiscountApplyandReject";
  static const schoolSettingAllowDiscountApi = baseUrl + "CheckSchoolSettingV1";
  static const discountGivenAllowDiscountApi = baseUrl + "GetDiscountGivenBy";

  //-------DAY CLOSING-----------------------------------------------------------
  static const dayClosingDataApi = baseUrl + "getClosingData";

  //-------BILL APPROVE-----------------------------------------------------------
  static const partyTypeBillApproveApi = baseUrl + "GetVendor";
  static const billsListBillApproveApi = baseUrl + "LoadBillDetail";
  static const billDetailsBillApproveApi = baseUrl + "LoadBillDetail";
  static const approveBillApi = baseUrl + "ApproveAmount";

  //=============================================================================================================================

  //-------CLASSROOMS-----------------------------------------------------------
  static const customChatUsersListApi = baseUrl + "GetChatUsers";
  static const customChatApi = baseUrl + "getChatDetails";
  static const sendCustomChatApi = baseUrl + "AddChatroomComments";
  static const deleteCustomChatApi = baseUrl + "delchatcomment";

  //-------CLASSROOMS-----------------------------------------------------------
  static const teachersListApi = baseUrl + "getClassTeacherWithSubject";
  static const classroomsApi = baseUrl + "getClassRoomSNew";
  // static const classroomsApi = baseUrl + "getClassRoomSnew";
  static const classRoomCommentsApi = baseUrl + "GetComments";
  static const sendClassRoomCommentApi = baseUrl + "AddComments";
  // static const sendCustomClassRoomCommentApi = baseUrl + "saveClassroom4_v2";
  static const sendCustomClassRoomCommentApi = baseUrl + "saveClassroom4";
  // static const sendCustomClassRoomCommentApi = baseUrl + "saveClassroom4";
  static const classroomEmployeeApi = baseUrl + "getClassRoomNewData2";
  static const deleteClassroomApi = baseUrl + "UpdateClassRoomStatus";
  // static const LeaveRequestApi = baseUrl + "GetunreadComments";
  // static const LeaveRequestApi = baseUrl + "getMeetingDetails";
  static const saveClassRoomApi = baseUrl + "saveClassroom4_v2";

  //-------DASHBOARD-----------------------------------------------------------
  // static const studentInfoApi = baseUrl + "getStuInfo";
  static const studentInfoApi = baseUrl + "getStuIfo";
  static const drawerApi = baseUrl + "GetAssignMenuFlutter";
  static const markAttendanceApi = baseUrl + "MarkSingleAttendance";
  static const onlineMeetingsApi = baseUrl + "getClassRoomSIndex";
  static const staffMeetingsEmployeeDashboardApi =
      baseUrl + "getStaffMeetingDetails";
  // static const meetingDetailsApi = baseUrl + "getMeetingDetails"; //old
  static const meetingDetailsApi = baseUrl + "GetMeetingJoiningDetails";
  static const dashboardAdminApi = baseUrl + "GetAdminLoggedInData";
  static const saveEmployeeeImageApi = baseUrl + "SaveUserImage";

  //-------DATESHEET-----------------------------------------------------------
  static const dateSheetStudentApi = baseUrl + "getDateSheetOfStudent";

  //-------STUDENT-----------------------------------------------------------
  static const admissionStatusApi = baseUrl + "AdmissionStatus";

  //-------CCE TEACHER REMARKS-----------------------------------------------------------
  static const teacherRemarksListApi = baseUrl + "GetTeacherRemarks";
  static const cceGeneralTeacherRemarksListApi =
      baseUrl + "GetGeneralRemaksGrid";
  static const saveCceGeneralTeacherRemarksApi = baseUrl + "SaveGenralRemark";
  static const cceSubjectTeacherRemarksListApi =
      baseUrl + "StudentRemarkSubjectWise";
  static const saveCceSubjectTeacherRemarksApi =
      baseUrl + "SaveSubjectWiseRemarks";

  //-------CCE GRADE ENTRY-----------------------------------------------------------
  static const examListGradeEntryApi = baseUrl + "GetExamSection";
  static const gradesListGradeEntryApi = baseUrl + "GetGradeDesc";
  static const gradeEntryListApi = baseUrl + "GetStudentForGradeEntry";
  static const saveGradeEntryApi = baseUrl + "createCCEGrades";
  // assignAdminApi

  //-------EXAM/TEST RESULTS-----------------------------------------------------------
  static const yearSessionApi = baseUrl + "getSession";
  static const examSelectedListApi = baseUrl + "GetStudentExam";
  static const examMarksApi = baseUrl + "GetStuMarks4SingleExam";
  static const examMarksChartApi =
      baseUrl + "GetIndividualVsHighestMarksDataOfExam";
  static const getSessionApi = baseUrl + "GetStuMarks";
  static const onlineStudentTestApi = baseUrl + "OnlineExam";

  static const getResultAnnounceClassApi = baseUrl + "fillclassMarkAtt";
  static const getResultAnnounceExamApi = baseUrl + "getClassWiseExam";
  static const getResultAnnounceStudentListApi =
      baseUrl + "getExamResultPublishDataV2";
  static const resultAnnounceAdmin = baseUrl + "PublishUnPublishResultV3";
  static const getClassForExamMarks = baseUrl + "loadClassForSms";
  static const getExamForExamMarks = baseUrl + "GetExamTypeForTech";
  static const getSubjectForExamMarks = baseUrl + "getExamClassSubject";
  static const getExamMarksForAdmin = baseUrl + "GetExamMarksForTeacher_V1";
  // static const getExamMarksForAdmin = baseUrl + "GetExamMarksForTeacher";
  static const getMinMaxExamAdmin = baseUrl + "GetMinMaxmarks";
  static const subjectExamMarkApi = baseUrl + "getExamClassSubjectV1";
  static const saveExamMarksApi = baseUrl + "AddExamMarks";

  static const studentListForChangeRollNo = baseUrl + "getClassStudents";
  static const updateRollNoApi = baseUrl + "updateRollNo";

  static const getCceAttendanceClassData =
      baseUrl + "GetCCEAttendanceClassData";

  static const saveCceAttendanceClassApi = baseUrl + "SaveCCEAttendance";

  static const getGradeApi = baseUrl + "GetGrade";
  static const getTopicAndSkillApi = baseUrl + "GetTopicAndSkills";
  static const getStudentList = baseUrl + "LoadStudent4SubjectEnrichment";
  static const saveSubjectEnchDetailApi =
      baseUrl + "SaveSubjectEnrichmentDetails";

  static const getStudentListResultAnnounce = baseUrl + "getStudentList";

  //-------FEE PAYMENT-----------------------------------------------------------
  static const feeReceiptsApi = baseUrl + "GetStudentFeeReceipt";
  static const feeTransactionApi = baseUrl + "getStudentOnlineTransactions";

  static const feeTypeApi = baseUrl + "getParams";
  static const feeMonthsApi = baseUrl + "GetStudentFeeMonth";
  static const feeRemarksApi = baseUrl + "GetFeeRemarks";
  static const studentFeeReceiptApi = baseUrl + "getStudentMonthlyAmountNeww";

  static const studentFeeFineApi = baseUrl + "getStudentFine";

  static const payByChequeApi = baseUrl + "OnlineFeeDeposit";

  static const feeBalanceEmployeeFeeListApi =
      baseUrl + "PaymentStatusReportNew";

  static const termsConditionsSettingApi = baseUrl + "getPaymentTerms";
  static const feeTypeSettingApi = baseUrl + "CheckFeecatIds";
  // static const yearSessionApi = baseUrl + "getPaymentTerms";
  // static const yearSessionApi = baseUrl + "getPaymentDetails";
  // static const yearSessionApi = baseUrl + "initPayment";
  // static const yearSessionApi = baseUrl + "pro_SaveTransactiondetails";
  // static const yearSessionApi = baseUrl + "getHInfoPYBZ";
  // static const yearSessionApi = baseUrl + "CheckFeecatIds";

  //-------FEEDBACK-----------------------------------------------------------
  static const feedBackStudentApi = baseUrl + "OnlineCompliantSuggestion";

  //-------HOMEWORK-----------------------------------------------------------
  static const homeworkEmployeeApi = baseUrl + "loadteacherhomeworknew";
  static const deleteHomeworkApi = baseUrl + "Deletehomework";
  static const homeWorkStudentCalenderDates =
      baseUrl + "GetHomeworkDetailsForCal";
  static const homeWorkStudent = baseUrl + "GetStudentHomeworkCurrentDate";
  static const homeworkCommentsApi = baseUrl + "GetReplys";
  static const subjectListEmployeeApi = baseUrl + "GetTeacherSubjectNew";
  static const weekPlanSubjectListEmployeeApi = baseUrl + "GetTeacherSubject";
  static const sendHomeworkCommentsApi = baseUrl + "AddHomeworkComments";
  static const deleteHomeworkCommentsApi = baseUrl + "delhomeworkcomment";
  // static const homeWorkStudent = baseUrl + "GetStudentHomeworkBetweenDate";
  static const classListEmployeeApi =
      baseUrl + "GetEmployeeClassAllocatedSubjects";
  static const getClassListHwStatusAdmin = baseUrl + "getHwSmsSendingStatus";
  static const getClassListPrevHwNotDoneStatusAdmin =
      baseUrl + "GetPrvHomeNotDoneV1";

  static const sendHomeWorkEmployeeApi = baseUrl + "SendTeacherhomework";

  static const teacherListSubjectWise = baseUrl + "getTeacherListSubjectWise";

  static const fillClassOnlyWithSectionAdmin =
      baseUrl + "fillclassonlywithSection";

  static const getClasswiseSubjectAdminApi = baseUrl + "GetClasswiseSubject";

  static const allMonthHwForCalApi = baseUrl + "GetHomeworkDetailsForCal";

  //-------CALENDER-----------------------------------------------------------
  static const calenderStudentApi = baseUrl + "getCalender";

  //-------MARKSHEET-----------------------------------------------------------
  static const studentSessionApi = baseUrl + "getStudentSession";
  static const classListApi = baseUrl + "fillClasses";
  static const studentChoiceSessionApi = baseUrl + "StudentSessionClass";
  static const markSheetStudentApi = baseUrl + "loadGeneratedMarksheets";
  static const openMarksheetApi = baseUrl + "PrintMarkSheet";
  // static const homeWorkStudent = baseUrl + "ConnStr";

  //-------NOTIFICATIONS-----------------------------------------------------------
  static const notificationApi = baseUrl + "Getalertnotifications";

  //-------TIME TABLE-----------------------------------------------------------
  static const timeTableApi = baseUrl + "loadTimeTable";
  static const addPeriodsTimeTableApi = baseUrl + "AddPeriod";

  //-------STUDENT REMARK-----------------------------------------------------------
  static const remarkForStudentsListApi = baseUrl + "getStudentRemarkMaster";
  static const searchStudentFromRecordsCommonApi =
      baseUrl + "GetStudentSearch4JqueryV1";
  static const saveStudentRemarkApi = baseUrl + "saveStudentGenRemark";
  static const studentRemarkListApi = baseUrl + "getStudentRemarks";
  static const deleteStudentRemarkApi = baseUrl + "deleteStudentRemark";
  static const addNewRemarkApi = baseUrl + "saveStudentGenRemarkMaster";

  //-------MEETING-----------------------------------------------------------
  static const fetchClientSecretIdApi = baseUrl + "getGoogleApiDetails";
  static const currentUserEmailForZoomApi =
      baseUrl + "GetMeetingsApiParaMeters";
  static const currentUserEmailForZoomAppManagersApi =
      baseUrl + "GetMeetingsApiParaMeterforAppManagers";
  static const meetingPlatformsApi = baseUrl + "GetMeetingPlateform";
  static const emailCheckScheduledMeetingApi = baseUrl + "";
  static const studentListMeetingApi = baseUrl + "getStudentListSubjectWise";
  static const subjectListMeetingApi = baseUrl + "GetTeacherSubjectNew";
  static const saveGoogleMeetScheduleMeetingApi = baseUrl + "SaveGoogleMeeting";
  static const saveZoomScheduleMeetingApi =
      baseUrl + "SaveZoomApiScheduleMeetingNew";
  static const scheduledMeetingListEmployeeApi =
      baseUrl + "GetMeetingDetailsNew";
  static const scheduledMeetingListAdminApi = baseUrl + "GetMeetingdetails";
  static const scheduleMeetingTodayListApi = baseUrl + "GetMeetingListnewToday";
  static const meetingDetailsAdminApi =
      baseUrl + "getMeetingDetailsForTeacher"; // class meeting detail teacher
  static const deleteScheduledMeetingEmployeeApi =
      baseUrl + "UpdateMeetingStatus";
  static const searchEmployeeFromRecordsCommonApi =
      baseUrl + "GetEmployeeSearch4JqueryV1";
  // static const schoolListMeetingApi = baseUrl + "getParams";
  static const groupWiseEmployeeMeetingApi = baseUrl + "getParams";
  static const departmentWiseEmployeeMeetingApi =
      baseUrl + "DepartmentwiseEmployee";
  static const meetingStatusListAdminApi = baseUrl + "GetMeetingSummary";
  static const saveGoogleMeetScheduleMeetingAdminApi =
      baseUrl + "SaveGoogleMeeting_Staff";
  // static const saveGoogleMeetScheduleMeetingAdminApi =
  //     baseUrl + "SaveForScheduleMeeting";
  static const saveZoomScheduleMeetingAdminApi =
      baseUrl + "SaveZoomApiScheduleMeeting_Staff";

  static const teachersListMeetingApi = baseUrl + "getTeacherList";
  static const teacherStatusListApi = baseUrl + "GetTeacherSummary";

  //-------MANAGE USERS-----------------------------------------------------------
  // static const searchStudentForTeacherApi = baseUrl + "GetStudentByEmpWise";
  static const studentDetailSearchApi = baseUrl + "GetUserDetail";
  static const updateStudentPasswordApi = baseUrl + "UpdateUserPassword";
  static const createUserStudentStatusApi = baseUrl + "CreateOnlineUser";
  static const sendStudentDetailsApi = baseUrl + "sendSingleUserDetails";
  static const updateStudentMobileNoApi = baseUrl + "UpdateGuardianMobileNoV1";
  static const updateStudentAccountStatusApi = baseUrl + "UpdateUserStatus";
  static const studentActiveDeactiveListAdminApi =
      baseUrl + "GetStudentStatusList";
  static const employeeDetailSearchApi = baseUrl + "";

  static const employeeStatusListApi = baseUrl + "LoadCreatedusers";
  static const createUserEmployeeStatusApi = baseUrl + "AddOnlineUser";
  static const deleteUserEmployeeStatusApi = baseUrl + "RemoveUserType";

  static const otpUserListApi = baseUrl + "GetLoginUserDetail";
  static const changeOtpUserLogsApi = baseUrl + "CaptureUserLogs";

  static const appUserListApi = baseUrl + "GETMOBILEUSER4AppSummary";
  static const appUserListForCordinatorApi =
      baseUrl + "GETMOBILEUSER4AppSummary4Coordinator";
  static const appUserDetailApi = baseUrl + "GETMOBILEUSER4AppDetail";
  static const downloadAppUserDataApi = baseUrl + "DownloadData";
  static const managerUSerSendSmsApi = baseUrl + "getData4SendSMSMobileUser";

  //-------EXAM ANALYSIS-----------------------------------------------------------
  static const yearSessionListExamAnalysisApi =
      baseUrl + "getStudentSessionAll";
  static const examsListExamAnalysisApi = baseUrl + "GetClassExams";
  static const examAnalysisLineChartApi = baseUrl + "GetStudentData";
  static const examAnalysisChartApi = baseUrl + "GetStudentDataExamWise";

  static const preClassExamAnalysisApi = baseUrl + "getPreClassId";
  static const subjectListExamAnalysisApi = baseUrl + "getExamClassSubject_v1";
  static const examAnalysisChartAdminApi =
      baseUrl + "GetSingleClassMarksData_v1";

  //TRANSPORT INFO
  static const schoolBusListApi = baseUrl + "GetSchoolBusList";
  static const schoolBusStopsApi = baseUrl + "GetBusStop";
  static const schoolBusInfoApi = baseUrl + "GetBusInfo";

  //-------ENQUIRY MANAGEMENT-----------------------------------------------------------
  static const dashboardEnquiryApi = baseUrl + "AllEnquiryInfo";
  static const viewEnquiryApi = baseUrl + "GetAllEnqueryBySearch";
  static const classListEnquiryApi = baseUrl + "fillclassonly";
  static const addNewEnquiryApi = baseUrl + "SaveEnquiry";
  static const feedbackEnquiryApi = baseUrl + "SaveFeedBack";
  static const enquiryCommentListApi = baseUrl + "BindEnquiryData";
  static const updateEnquiryStatusApi = baseUrl + "SaveEnquiryDeatilData";

  // TASK MANAGEMENT
  static const getEmployeeTaskManagement = baseUrl + "GetEmployee";
  static const saveTaskManagement = baseUrl + "SaveTaskDetials";
  static const getTaskDataTaskManagement = baseUrl + "GetTaskData";

  //-------PAYMENT GATEWAYS-----------------------------------------------------------

  //To Get Payment Gateway Type
  static const gatewayTypeApi = baseUrl + "getPaymentDetails";

  //To Get Payment Gateway Hash Code
  static const payUMoneyHashApi = baseUrl + "";
  static const ebsHashApi = baseUrl + "";
  static const payUBizHashApi = baseUrl + "getHInfoPYBZ";
  static const techProcessHashApi = baseUrl + "";
  static const ccAvenueHashApi = baseUrl + "";
  static const airPayHashApi = baseUrl + "";
  static const worldLineHashApi = baseUrl + "";

  //Urls used to catch payment status.
  static String get successUrl => "";
  static String get failureUrl => "";

  // Fee Balance Employee
  static const feeBalanceClassListEmployeeApi =
      baseUrl + "getClassesOfEmployee";

  static const feeBalanceMonthListEmployeeApi = baseUrl + "getFeeMonths";

  // Leave Employee
  static const studentLeaveEmployeeApi = baseUrl + "GetLeaveRequestsHistory";
  static const studentLeaveEmployeeHistoryApi = baseUrl + "GetLeaveRequests";
  static const studentLeaveEmployeeHistoryRejAcpApi =
      baseUrl + "ApproveOrRejectLeaveRequest";
  static const assignAdminApi = baseUrl + "getAdminEmployees";

  // Week Plan Employee
  static const studentLeaveSavePlannerEmployeeApi = baseUrl + "savePlanner";
  static const studentLeaveUpdatePlannerEmployeeApi = baseUrl + "getPlannerV1";

  static const studentInfoForSearchApi = baseUrl + "getStuInfoForSearch";
  static const employeeInfoForSearchApi = baseUrl + "getMeetingEmpProfilenew";

  //SUGGESTION
  static const getSuggestionComplainListApi =
      baseUrl + "getCompSuggsBetweenDateV2";

  static const replyToSuggestionApi = baseUrl + "replyCompOrSugg";

  static const inactiveCompOrSuggApi = baseUrl + "inactiveCompOrSugg";

  //EMPLOYEE ADMIN
  static const getLoadLastEmpNo = baseUrl + "LoadLastEmpNo";
  static const addNewEmployeeAdminApi = baseUrl + "AddNewEmployee";

  //Send SMS Admin
  static const getBusRoutesAdmin = baseUrl + "loadBusRoutes";
  static const getEmployeeAdmin = baseUrl + "loadGroupsnew";
  static const getHousesAdmin = baseUrl + "loadHouseGroup";
  static const getAddressAdmin = baseUrl + "loadAddressGroup";
  static const submitSmsAdmin = baseUrl + "sendSmsToOption";

  //Teacher Assign
  static const saveClassTeacherAdmin = baseUrl + "AssignClassTeacher";
  static const classForSubjectAdmin = baseUrl + "loadClass4SubjectAllote";
  static const getClassSectionAdmin = baseUrl + "getClassSection";
  static const alloteSubjectAdmin = baseUrl + "SubjectAlloteToTeacher";
  static const getAllottedSubjectAdmin = baseUrl + "loadAllottedSubjects";
  static const deleteAllottedSubjectAdmin = baseUrl + "RemoveAllottedSubjects";
  static const AssignPeriodAdmin = baseUrl + "AssignPeriod";
  static const getSelectClassTeacherDropdown =
      baseUrl + "GetselectClassTeacherDropdown";

  // Send SMS config
  static const getLoadUserTypeApi = baseUrl + "loadUserType";
  static const getSmsTypeSmsConfigApi = baseUrl + "getSmsType";
  static const getSmsTypeSmsDetailApi = baseUrl + "getSmsTypeDetail";
  static const saveSmstypeApi = baseUrl + "saveSmsType";

  //Student detail
  static const getStudentMonthlyAmountApi =
      baseUrl + "getStudentMonthlyAmountNew";

  //Meeting Config
  static const getUserDetailCredentialApi =
      baseUrl + "GetEmployeeOnlineClassCredentials";

  static const savePlatformApi = baseUrl + "SetPlateform";

  //Coordinator assign
  static const coordinatorListDetailApi = baseUrl + "GetCoordinatorDetails";
  static const deleteCoordinatorApi = baseUrl + "deleteCoordinator";
  static const getCoordinatorListApi = baseUrl + "GetCoordinatorList";
  static const getCoordinatorProfile = baseUrl + "getCoordinatorProfile";
  static const GetselectClassCoordinatorDropdownApi =
      baseUrl + "GetselectClassCoordinatorDropdown";
  static const assignClassCoordinatorApi = baseUrl + "AssignClassCoordinator";

  // POPup Config
  static const getPopupMessageListApi = baseUrl + "GetPopupMessageList";
  static const getPopupAlertListApi = baseUrl + "GetPopupAlertList";
  static const deleteMessagePopupApi = baseUrl + "UpdateMessageStatus";
  static const deleteAlertPopupApi = baseUrl + "UpdateAlertStatus";
  static const savePopupMessageApi = baseUrl + "SavePopupMessage";
  static const savePopupAlertApi = baseUrl + "SavePopupAlert";

  // Gate Pass
  static const sendingOtpGatePassApi = baseUrl + "searchNoDetails";
  static const gatePassMeetToApi = baseUrl + "getVisitorMeetTo";
  static const gatePassPurposeApi = baseUrl + "getVisitorPurpose";
  static const gatePassVerifyOtpApi = baseUrl + "verifyVisitorOtp";
  static const saveVisitorGatePassApi = baseUrl + "updateVisitorDetailV1";
  static const getVisitorListApi = baseUrl + "getVisitorListToday";
  static const markVisitorExitApi = baseUrl + "markVisitorExit";
  static const markGatePassExitApi = baseUrl + "markGatePassExit";
  static const verifyIdGatePass = baseUrl + "updateVisitorIdProofV1";
  static const getGatePassHistoryApi = baseUrl + "getGatePasssListToday";

  //Employee Calendar
  static const employeeCalendarAllDateApi =
      baseUrl + "GetEmployeeDetailsForCal";
  static const employeeCalendarLeaveBalanceApi = baseUrl + "LeaveBalance";
  static const saveLeaveEmployeeCal = baseUrl + "SaveLeaveRequest";
  static const getInOutTimeApi = baseUrl + "GetInOutTimeForCal";
  static const dropDownIndexProxyApply = baseUrl + "GetAttForCal";
  static const saveProxyRequestApi = baseUrl + "SaveProxyRequest";
  static const approveProxyListApi = baseUrl + "GetAttendanceRequestToApprove";
  static const approveProxyRequestApi = baseUrl + "ApproveRequest";
  static const approveLeaveListApi = baseUrl + "GetLeaveRequestToApprove";
  static const approveLeaveRequestApi = baseUrl + "ApproveLeaveRequest";

  // School Setting
  static const getSchoolSettingApi = baseUrl + "CheckSchoolSetting";
}

//Api Header Global Variable
final Map<String, String> headers = {
  "Accept": "application/json",
  "Content-Type": "application/x-www-form-urlencoded"
};

//Api Encoding Global Variable
final Encoding? encoding = Encoding.getByName("utf-8");

Future<Map<String, String>>? getHeader() async {
  final uid = await UserUtils.idFromCache();
  final token = await UserUtils.userTokenFromCache();
  final userData = await UserUtils.userTypeFromCache();
  return {
    // "Accept": "application/json",
    "Content-Type": "application/x-www-form-urlencoded",
    "HeaderToken":
        "$uid#$token#${userData!.ouserType}#${userData.stuEmpId}#${userData.schoolId}#${userData.organizationId}",
  };
}
