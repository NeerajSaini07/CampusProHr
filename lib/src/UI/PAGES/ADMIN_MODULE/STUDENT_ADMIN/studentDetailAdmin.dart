import 'dart:convert';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/CONSTANTS/themeData.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/ATTENDANCE_GRAPH_CUBIT/attendance_graph_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/EXAM_MARKS_CHART_CUBIT/exam_marks_chart_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/EXAM_MARKS_CUBIT/exam_marks_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/EXAM_SELECTED_LIST_CUBIT/exam_selected_list_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/FEE_MONTHS_CUBIT/fee_months_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/FEE_RECEIPTS_CUBIT/fee_receipts_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/FEE_TYPE_CUBIT/fee_type_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/GET_STUDENT_AMOUNT_CUBIT/get_student_amount_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/PROFILE_STUDENT_CUBIT/profile_student_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/STUDENT_REMARK_LIST_CUBIT/student_remark_list_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/YEAR_SESSION_CUBIT/year_session_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/attendanceGraphModel.dart';
import 'package:campus_pro/src/DATA/MODELS/examMarksChartModel.dart';
import 'package:campus_pro/src/DATA/MODELS/examMarksModel.dart';
import 'package:campus_pro/src/DATA/MODELS/examSelectedListModel.dart';
import 'package:campus_pro/src/DATA/MODELS/feeDummyData.dart';
import 'package:campus_pro/src/DATA/MODELS/feeMonthsModel.dart';
import 'package:campus_pro/src/DATA/MODELS/feeReceiptsModel.dart';
import 'package:campus_pro/src/DATA/MODELS/feeTypeModel.dart';
import 'package:campus_pro/src/DATA/MODELS/profileStudentModel.dart';
import 'package:campus_pro/src/DATA/MODELS/searchStudentFromRecordsCommonModel.dart';
import 'package:campus_pro/src/DATA/MODELS/studentRemarkListModel.dart';
import 'package:campus_pro/src/DATA/MODELS/yearSessionModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/WIDGETS/CHARTS/attendanceBarChart.dart';
import 'package:campus_pro/src/UI/WIDGETS/CHARTS/examDetailChart.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/searchStudentFromRecordsCommon.dart';
import 'package:campus_pro/src/UTILS/appImages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// class StudentDetailAdmin extends StatefulWidget {
//   static const routeName = "/student-detail-admin";
//   @override
//   _StudentDetailAdminState createState() => _StudentDetailAdminState();
// }
//
// class _StudentDetailAdminState extends State<StudentDetailAdmin> {
//   TextEditingController searchController = TextEditingController();
//
//   YearSessionModel? selectedYearSession;
//   List<YearSessionModel>? yearSessionDropdown;
//   // String _selectedYear = "Select Year";
//   //
//   // List<String> dropDownYearList = ['Select Year', '2020 - 2021', '2019 - 2020'];
//
//   void getSession() async {
//     final uid = await UserUtils.idFromCache();
//     final token = await UserUtils.userTokenFromCache();
//     final userData = await UserUtils.userTypeFromCache();
//
//     final requestPayload = {
//       // "OUserId": uid!,
//       // "Token": token!,
//       // "OrgId": userData!.organizationId,
//       // "SchoolId": userData!.schoolId!,
//       "OUserId": uid,
//       "Token": token,
//       "EmpId": userData!.stuEmpId,
//       "OrgID": userData.organizationId,
//       "SchoolID": userData.schoolId,
//       "UserType": userData.ouserType,
//     };
//     print("Sending YearSession data => $requestPayload");
//     context.read<YearSessionCubit>().yearSessionCubitCall(requestPayload);
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     selectedYearSession = YearSessionModel(id: "", sessionFrom: "", status: "");
//     yearSessionDropdown = [];
//     getSession();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: DrawerWidget(),
//       appBar: commonAppBar(context, title: "Student Detail"),
//       body: Container(
//         color: Colors.white,
//         child: Column(
//           children: [
//             Image.asset(AppImages.stuSearchImage, height: 100),
//             buildTextField(),
//             // BlocConsumer<YearSessionCubit, YearSessionState>(
//             //   listener: (context, state) {
//             //     if (state is YearSessionLoadInProgress) {}
//             //     if (state is YearSessionLoadSuccess) {
//             //       setState(() {
//             //         selectedYearSession = state.yearSessionList[0];
//             //         yearSessionDropdown = state.yearSessionList;
//             //       });
//             //     }
//             //     if (state is YearSessionLoadFail) {
//             //       if (state.failReason == 'false') {
//             //         UserUtils.unauthorizedUser(context);
//             //       } else {
//             //         selectedYearSession =
//             //             YearSessionModel(id: "", sessionFrom: "", status: "");
//             //         yearSessionDropdown = [];
//             //       }
//             //     }
//             //   },
//             //   builder: (context, state) {
//             //     if (state is YearSessionLoadInProgress) {
//             //       return buildYearDropDown();
//             //     } else if (state is YearSessionLoadSuccess) {
//             //       return buildYearDropDown();
//             //     } else if (state is YearSessionLoadFail) {
//             //       return buildYearDropDown();
//             //     } else {
//             //       return Container();
//             //     }
//             //   },
//             // ),
//             //buildYearDropDown(),
//             buildSearchBtn(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Container buildYearDropDown() {
//     return Container(
//       color: Colors.white,
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           border: Border.all(color: Color(0xffECECEC)),
//         ),
//         child: DropdownButton<YearSessionModel>(
//           isDense: true,
//           value: selectedYearSession,
//           key: UniqueKey(),
//           isExpanded: true,
//           underline: Container(),
//           items: yearSessionDropdown!
//               .map((item) => DropdownMenuItem<YearSessionModel>(
//                   child: Text('${item.sessionFrom}'), value: item))
//               .toList(),
//           onChanged: (val) {
//             setState(() {
//               selectedYearSession = val!;
//               print("_selectedYear: $val");
//             });
//           },
//         ),
//       ),
//     );
//   }
//
//   Container buildTextField() {
//     return Container(
//       color: Colors.white,
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       child: TextFormField(
//         // obscureText: !obscureText ? false : true,
//         controller: searchController,
//         validator: FieldValidators.globalValidator,
//         autovalidateMode: AutovalidateMode.onUserInteraction,
//         style: TextStyle(color: Colors.black),
//         decoration: InputDecoration(
//           border: new OutlineInputBorder(
//             borderRadius: const BorderRadius.all(
//               const Radius.circular(18.0),
//             ),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(
//               color: Color(0xffECECEC),
//             ),
//             gapPadding: 0.0,
//           ),
//           disabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(
//               color: Theme.of(context).primaryColor,
//             ),
//           ),
//           errorBorder: OutlineInputBorder(
//             borderSide: BorderSide(
//               color: Color(0xffECECEC),
//             ),
//           ),
//           focusedErrorBorder: OutlineInputBorder(
//             borderSide: BorderSide(
//               color: Theme.of(context).primaryColor,
//             ),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(
//               color: Theme.of(context).primaryColor,
//             ),
//           ),
//           hintText: "Name/Mobile No/Adm. No",
//           hintStyle: TextStyle(color: Color(0xffA5A5A5)),
//           contentPadding:
//               const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
//           // suffixIcon: suffixIcon
//           //     ? InkWell(
//           //         onTap: () {
//           //           setState(() {
//           //             _showPassword = !_showPassword;
//           //           });
//           //         },
//           //         child: !_showPassword
//           //             ? Icon(Icons.remove_red_eye_outlined)
//           //             : Icon(Icons.remove_red_eye),
//           //       )
//           //     : null,
//         ),
//       ),
//     );
//   }
//
//   Container buildSearchBtn() {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
//       padding: EdgeInsets.all(8),
//       width: MediaQuery.of(context).size.width * 0.4,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10.0),
//         gradient: LinearGradient(
//             begin: Alignment.centerLeft,
//             end: Alignment.centerRight,
//             colors: [accentColor, primaryColor]),
//       ),
//       child: GestureDetector(
//         onTap: () {
//           Navigator.pushNamed(context, StudentDetailsAdmin.routeName);
//         },
//         child: Center(
//           child: Text(
//             "SEARCH",
//             style: TextStyle(
//               fontFamily: "BebasNeue-Regular",
//               color: Colors.white,
//               fontWeight: FontWeight.w600,
//               fontSize: 16,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class StudentDetailsAdmin extends StatefulWidget {
  static const routeName = "/student-detail-admin";

  @override
  _StudentDetailsAdminState createState() => _StudentDetailsAdminState();
}

class _StudentDetailsAdminState extends State<StudentDetailsAdmin> {
  String _selectedMonth = "Apr";

  List<String> dropDownMonthList = ['Apr', 'May', 'June'];

  var scrollController = ScrollController();

  TabController? tabController;
  int _currentIndex = 0;

  void tabIndexChange(int tabIndex) {
    setState(() {
      _currentIndex = tabIndex;
    });
  }

  List<Map<String, dynamic>> jsonMonthData = [];

  //year dropdown
  YearSessionModel? selectedYearSession;
  List<YearSessionModel>? yearSessionDropdown;

  //search employee
  List<ProfileStudentModel>? selectedStudent = [];

  //student account
  FeeTypeModel? selectedFeeType;
  List<FeeTypeModel>? feeTypeDropdown;
  String? amount = "0";

  FeeMonthsModel? selectedMonth;
  List<FeeMonthsModel>? monthDropdown;

  //fee recipient
  List<FeeReceiptsModel> feeRecipientList = [];

  //student remark
  List<StudentRemarkListModel>? studentRemarksList = [];

  //detail
  // DetailModel? detailsEmp;

  //exam detail
  ExamSelectedListModel? selectedExam;
  List<ExamSelectedListModel>? examDropdown;
  List<ExamMarksModel> getStudentMarksForSingleExamList = [];
  List<ExamMarksChartModel> getStudentMarksVsHighestMarks = [];

  //student graph
  List<AttendanceGraphModel> graphList = [];

  void getSession() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final requestPayload = {
      "OUserId": uid,
      "Token": token,
      "EmpId": userData!.stuEmpId,
      "OrgID": userData.organizationId,
      "SchoolID": userData.schoolId,
      "UserType": userData.ouserType,
    };
    print("Sending YearSession data => $requestPayload");
    context.read<YearSessionCubit>().yearSessionCubitCall(requestPayload);
  }

  getFeeType() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final feeTypeData = {
      "OUserId": uid!,
      "Token": token!,
      "OrgId": userData!.organizationId!,
      "Schoolid": userData.schoolId!,
      "EmpStuId": userData.stuEmpId!,
      "UserType": userData.ouserType!,
      "ParamType": "Fee Category",
    };
    context.read<FeeTypeCubit>().feeTypeCubitCall(feeTypeData);
  }

  getFeeReceiptsTransactions({String? empId}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final receiptsTransactionData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId!,
      "SessionId": userData.currentSessionid!,
      "StudentId": empId,
      "StuEmpId": userData.stuEmpId,
      "UserType": userData.ouserType,
    };

    print("Sending getFeeReceipts data => $receiptsTransactionData");

    context
        .read<FeeReceiptsCubit>()
        .feeReceiptsCubitCall(receiptsTransactionData);
  }

  getSelectedUserRemark({String? empId}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final studentData = {
      'OUserId': uid!,
      'Token': token!,
      'OrgId': userData!.organizationId!,
      'SchoolId': userData.schoolId!,
      'SessionId': userData.currentSessionid!,
      'StuEmpType': 's',
      'StuEmpId': userData.stuEmpId!,
      'StuID': empId.toString(),
      'UserType': userData.ouserType!,
    };

    context
        .read<StudentRemarkListCubit>()
        .studentRemarkListCubitCall(studentData);
  }

  void getExamSelected({String? empId}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final requestPayload = {
      "OUserId": uid!,
      "Token": token!,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId!,
      "StudentId": empId,
      "SessionId": userData.currentSessionid,
      'StuEmpId': userData.stuEmpId,
      'UserType': userData.ouserType!,
    };
    print("Sending ExamSelectedList data => $requestPayload");
    context
        .read<ExamSelectedListCubit>()
        .examSelectedListCubitCall(requestPayload);
  }

  getMonthsFromApi({String? catId, String? empId}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final monthsData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId!,
      "SessionId": userData.currentSessionid!,
      "StudentId": empId,
      "FeecatId": catId,
      'StuEmpId': userData.stuEmpId,
      'UserType': userData.ouserType!,
    };
    print("Sending monthsData data => $monthsData");
    context.read<FeeMonthsCubit>().feeMonthsCubitCall(monthsData);
  }

  getMonthlyAmount(
      {String? catId, String? empId, FeeMonthsModel? feeMonths}) async {
    setState(() => jsonMonthData = []);
    for (int i = 0; i < monthDropdown!.length; i++) {
      final jsonData = {
        "FeeMonthId": monthDropdown![i].feeMonthId,
        "isBalance": monthDropdown![i].isBalance,
        "FeeType": monthDropdown![i].feeType
      };
      jsonMonthData.add(jsonData);
      if (monthDropdown![i] == feeMonths) break;
    }

    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final sendingDataForAmount = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "SessionId": userData.currentSessionid,
      "EmpId": userData.stuEmpId,
      "UserType": userData.ouserType,
      "StudentId": empId,
      "FeecatId": catId,
      "JsonMonths": jsonEncode(jsonMonthData),
      //     :[{"FeeMonthId":"1","isBalance":"N","FeeType":"H"},
      //   {"FeeMonthId":"2","isBalance":"N","FeeType":"H"},
      //   {"FeeMonthId":"3","isBalance":"N","FeeType":"H"},{"FeeMonthId":"4","isBalance":"N","FeeType":"H"},
      //   {"FeeMonthId":"5","isBalance":"N","FeeType":"H"}
      // ,{"FeeMonthId":"6","isBalance":"N","FeeType":"H"},
      //   {"FeeMonthId":"7","isBalance":"N","FeeType":"M"}]
    };

    print("sending data for get student amount $sendingDataForAmount");

    context
        .read<GetStudentAmountCubit>()
        .getStudentAmountCubitCall(sendingDataForAmount);
  }

  getAttendanceGraph({String? empId}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final attendanceData = {
      'OUserId': uid!,
      'Token': token!,
      'OrgId': userData!.organizationId!,
      'Schoolid': userData.schoolId!,
      'SessionId': userData.currentSessionid!,
      'StudentId': empId,
      'StuEmpId': userData.stuEmpId,
      'UserType': userData.ouserType!,
    };
    print("Sending getAttendanceGraph Data => $attendanceData");
    context
        .read<AttendanceGraphCubit>()
        .attendanceGraphCubitCall(attendanceData);
  }

  void getExamMarks({String? examID, String? empId}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final requestPayload = {
      "OUserId": uid!,
      "Token": token!,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId!,
      "SessionId": userData.currentSessionid,
      "StudentId": empId,
      "ExamID": examID,
      'StuEmpId': userData.stuEmpId,
      'UserType': userData.ouserType!,
    };
    print("Sending ExamMarks data => $requestPayload");
    context.read<ExamMarksCubit>().examMarksCubitCall(requestPayload);
  }

  void getMarksGraph({String? examID, String? empId}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final requestPayload = {
      "OUserId": uid!,
      "Token": token!,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId!,
      "SessionId": userData.currentSessionid,
      "StudentId": empId,
      "ExamId": examID,
      'StuEmpId': userData.stuEmpId,
      'UserType': userData.ouserType!,
    };
    print("Sending ExamMarksGraph data => $requestPayload");
    context.read<ExamMarksChartCubit>().examMarksChartCubitCall(requestPayload);
  }

  @override
  void initState() {
    super.initState();
    selectedYearSession = YearSessionModel(id: "", sessionFrom: "", status: "");
    yearSessionDropdown = [];
    selectedFeeType = FeeTypeModel(iD: "", paramname: "");
    feeTypeDropdown = [];
    selectedStudent = [];
    feeRecipientList = [];
    studentRemarksList = [];
    selectedExam =
        ExamSelectedListModel(exam: "", examID: "", displayOrder: "");
    examDropdown = [];
    selectedMonth = FeeMonthsModel(
        feeMonthId: "", feeMonthName: "", isBalance: "", feeType: "");
    monthDropdown = [];
    graphList = [];
    getStudentMarksForSingleExamList = [];
    getStudentMarksVsHighestMarks = [];
    getSession();
    getFeeType();
  }

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 1)).then((value) {
      selectedYearSession =
          YearSessionModel(id: "", sessionFrom: "", status: "");
      yearSessionDropdown = [];
      selectedFeeType = FeeTypeModel(iD: "", paramname: "");
      feeTypeDropdown = [];
      selectedStudent = [];
      feeRecipientList = [];
      studentRemarksList = [];
      selectedExam =
          ExamSelectedListModel(exam: "", examID: "", displayOrder: "");
      examDropdown = [];
      selectedMonth = FeeMonthsModel(
          feeMonthId: "", feeMonthName: "", isBalance: "", feeType: "");
      monthDropdown = [];
      graphList = [];
      getStudentMarksForSingleExamList = [];
      getStudentMarksVsHighestMarks = [];
      getSession();
      getFeeType();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, title: "Student Detail"),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: MultiBlocListener(
          listeners: [
            BlocListener<ProfileStudentCubit, ProfileStudentState>(
              listener: (context, state) {
                if (state is ProfileStudentLoadFail) {
                  if (state.failReason == "false") {
                    UserUtils.unauthorizedUser(context);
                  } else {
                    setState(() {
                      selectedStudent = [];
                    });
                  }
                }
                if (state is ProfileStudentLoadSuccess) {
                  setState(() {
                    selectedStudent = state.profileData;
                    getFeeReceiptsTransactions(
                        empId: selectedStudent![0].studentid);

                    getSelectedUserRemark(empId: selectedStudent![0].studentid);
                    getExamSelected(empId: selectedStudent![0].studentid);
                    getMonthsFromApi(
                        catId: selectedFeeType!.iD,
                        empId: selectedStudent![0].studentid);
                    getAttendanceGraph(empId: selectedStudent![0].studentid);
                  });
                  // setState(() {
                  //   periodListForTeacherAssign = [];
                  //   totalPeriodsSelection = [];
                  //   collectionOfSelectedPeriodList = [];
                  // });
                  // getSelectedClass(empid: empId.toString());
                  // getAllottedSubjectList(empid: empId.toString());
                }
              },
            ),
            BlocListener<FeeTypeCubit, FeeTypeState>(
              listener: (context, state) {
                if (state is FeeTypeLoadSuccess) {
                  setState(() {
                    selectedFeeType = state.feeTypes[0];
                    feeTypeDropdown = state.feeTypes;
                  });
                }
                if (state is FeeTypeLoadFail) {
                  if (state.failReason == 'false') {
                    UserUtils.unauthorizedUser(context);
                  } else {
                    selectedFeeType = FeeTypeModel(iD: "", paramname: "");
                    feeTypeDropdown = [];
                  }
                }
              },
            ),
            BlocListener<FeeReceiptsCubit, FeeReceiptsState>(
                listener: (context, state) {
              if (state is FeeReceiptsLoadSuccess) {
                setState(() {
                  feeRecipientList = state.receiptsList;
                });
              }
              if (state is FeeReceiptsLoadFail) {
                if (state.failReason == 'false') {
                  UserUtils.unauthorizedUser(context);
                } else {}
              }
            }),
            BlocListener<StudentRemarkListCubit, StudentRemarkListState>(
                listener: (context, state) {
              if (state is StudentRemarkListLoadFail) {
                if (state.failReason == 'false') {
                  UserUtils.unauthorizedUser(context);
                } else {
                  setState(() {
                    studentRemarksList = [];
                  });
                }
              }

              if (state is StudentRemarkListLoadSuccess) {
                setState(() {
                  studentRemarksList = state.studentRemarksList;
                });
              }
            }),
            BlocListener<ExamSelectedListCubit, ExamSelectedListState>(
                listener: (context, state) {
              if (state is ExamSelectedListLoadSuccess) {
                setState(() {
                  selectedExam = state.marksList[0];
                  examDropdown = state.marksList;
                });

                getExamMarks(
                    empId: selectedStudent![0].studentid,
                    examID: selectedExam!.examID);
                getMarksGraph(
                    empId: selectedStudent![0].studentid,
                    examID: selectedExam!.examID);
              }
              if (state is ExamSelectedListLoadFail) {
                if (state.failreason == 'false') {
                  UserUtils.unauthorizedUser(context);
                } else {
                  selectedExam = ExamSelectedListModel(
                      exam: "", examID: "", displayOrder: "");
                  examDropdown = [];

                  //
                  setState(() {
                    getStudentMarksForSingleExamList = [];
                    getStudentMarksVsHighestMarks = [];
                  });
                }
              }
            }),
            BlocListener<FeeMonthsCubit, FeeMonthsState>(
                listener: (context, state) {
              if (state is FeeMonthsLoadSuccess) {
                setState(() {
                  selectedMonth = state.feeMonths[0];
                  monthDropdown = state.feeMonths;
                });
                getMonthlyAmount(
                    catId: selectedFeeType!.iD,
                    empId: selectedStudent![0].studentid,
                    feeMonths: selectedMonth);
              }
              if (state is FeeMonthsLoadFail) {
                if (state.failReason == 'false') {
                  UserUtils.unauthorizedUser(context);
                } else {
                  setState(() {
                    selectedMonth = FeeMonthsModel(
                        feeMonthId: "",
                        feeMonthName: "",
                        isBalance: "",
                        feeType: "");
                    monthDropdown = [];
                    amount = "0";
                  });
                }
              }
            }),
            BlocListener<GetStudentAmountCubit, GetStudentAmountState>(
                listener: (context, state) {
              if (state is GetStudentAmountLoadSuccess) {
                setState(() {
                  amount = state.amount;
                });
              }
              if (state is GetStudentAmountLoadFail) {
                if (state.failReason == 'false') {
                  UserUtils.unauthorizedUser(context);
                } else {
                  amount = "0";
                }
              }
            }),
            BlocListener<AttendanceGraphCubit, AttendanceGraphState>(
                listener: (context, state) {
              if (state is AttendanceGraphLoadSuccess) {
                setState(() {
                  graphList = state.attendanceList;
                });
              }
              if (state is AttendanceGraphLoadFail) {
                if (state.failReason == 'false') {
                  UserUtils.unauthorizedUser(context);
                } else {
                  graphList = [];
                }
              }
            }),
            BlocListener<ExamMarksCubit, ExamMarksState>(
                listener: (context, state) {
              if (state is ExamMarksLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                }
              }
              if (state is ExamMarksLoadSuccess) {
                setState(() {
                  getStudentMarksForSingleExamList = state.marksList;
                });
              }
            }),
            BlocListener<ExamMarksChartCubit, ExamMarksChartState>(
                listener: (context, state) {
              if (state is ExamMarksChartLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                }
              }
              if (state is ExamMarksChartLoadSuccess) {
                setState(() {
                  getStudentMarksVsHighestMarks = state.chartList;
                });
              }
            }),
          ],
          child: NestedScrollView(
            controller: scrollController,
            physics: ScrollPhysics(parent: PageScrollPhysics()),
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate([
                    BlocConsumer<YearSessionCubit, YearSessionState>(
                      listener: (context, state) {
                        if (state is YearSessionLoadInProgress) {}
                        if (state is YearSessionLoadSuccess) {
                          setState(() {
                            //selectedYearSession = state.yearSessionList[0];
                            selectedYearSession = state.yearSessionList[2];
                            yearSessionDropdown = state.yearSessionList;
                          });
                        }
                        if (state is YearSessionLoadFail) {
                          if (state.failReason == 'false') {
                            UserUtils.unauthorizedUser(context);
                          } else {
                            selectedYearSession = YearSessionModel(
                                id: "", sessionFrom: "", status: "");
                            yearSessionDropdown = [];
                          }
                        }
                      },
                      builder: (context, state) {
                        if (state is YearSessionLoadInProgress) {
                          return buildYearDropDown();
                        } else if (state is YearSessionLoadSuccess) {
                          return buildYearDropDown();
                        } else if (state is YearSessionLoadFail) {
                          return buildYearDropDown();
                        } else {
                          return Container();
                        }
                      },
                    ),
                    //search
                    GestureDetector(
                      // onTap: () => Navigator.pushNamed(
                      //     context, SearchEmployeeFromRecordsCommon.routeName),
                      onTap: () async {
                        final employeeData = await Navigator.pushNamed(context,
                                SearchStudentFromRecordsCommon.routeName)
                            as SearchStudentFromRecordsCommonModel;
                        //print(employeeData.studentid);
                        if (employeeData.studentid != "") {
                          final uid = await UserUtils.idFromCache();
                          final token = await UserUtils.userTokenFromCache();
                          final userData = await UserUtils.userTypeFromCache();
                          final data = {
                            'OUserId': uid,
                            'Token': token,
                            'OrgId': userData!.organizationId,
                            'Schoolid': userData.schoolId,
                            'SessionId': selectedYearSession!.id,
                            'StudentId': employeeData.studentid,
                          };
                          context
                              .read<ProfileStudentCubit>()
                              .profileStudentCubitCall(data);
                        }
                      },
                      child: Container(
                        // height: 40,
                        width: MediaQuery.of(context).size.width,
                        margin:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12),
                        ),
                        child: Text("Search Student here..."),
                      ),
                    ),
                    if (selectedStudent!.length > 0)
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        child: Text(
                            "● ${selectedStudent![0].stName} - ${selectedStudent![0].mobileNo!}",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).primaryColor)),
                      ),
                    // buildYearDropDown(),
                    // Container(height: 300, color: Colors.blue),
                    SizedBox(
                      height: 3,
                    ),
                    Icon(
                      Icons.swipe,
                      color: Colors.red,
                    )
                  ]),
                ),
              ];
            },
            body: DefaultTabController(
              initialIndex: _currentIndex,
              length: 6,
              child: Column(
                children: [
                  buildTabBar(context),
                  Expanded(
                    child: TabBarView(
                      // physics: NeverScrollableScrollPhysics(),
                      children: [
                        buildStudentProfile(context),
                        buildExamDetail(context),
                        buildStudentAccount(context),
                        buildFeeReceipts(),
                        buildAttendanceGraph(context),
                        buildStudentRemark(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container buildYearDropDown() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Color(0xffECECEC)),
        ),
        child: DropdownButton<YearSessionModel>(
          isDense: true,
          value: selectedYearSession,
          key: UniqueKey(),
          isExpanded: true,
          underline: Container(),
          items: yearSessionDropdown!
              .map((item) => DropdownMenuItem<YearSessionModel>(
                  child: Text('${item.sessionFrom}'), value: item))
              .toList(),
          onChanged: (val) {
            setState(() {
              selectedYearSession = val!;
              print("_selectedYear: $val");
            });
          },
        ),
      ),
    );
  }

  Container buildTabBar(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Container(
        margin: const EdgeInsets.only(
          left: 15.0,
          right: 15.0,
          top: 8.0,
          bottom: 8.0,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Theme.of(context).primaryColor,
          ),
        ),
        child: TabBar(
          isScrollable: true,
          unselectedLabelColor: Theme.of(context).primaryColor,
          labelColor: Colors.white,
          indicator: BoxDecoration(
            gradient: customGradient,
            // color: Theme.of(context).primaryColor,
          ),
          // isScrollable: true,
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
                // getReports();
                break;
              case 2:
                tabIndexChange(tabIndex);
                // getReports();
                break;
              case 3:
                tabIndexChange(tabIndex);
                // getReports();
                break;

              case 4:
                tabIndexChange(tabIndex);
                break;

              case 5:
                tabIndexChange(tabIndex);
                break;
              default:
                tabIndexChange(tabIndex);
                // getSample();
                break;
            }
          },
          tabs: [
            buildTabs(title: 'Student Profile', index: _currentIndex),
            buildTabs(title: 'Exam Detail', index: _currentIndex),
            buildTabs(title: 'Student Account', index: _currentIndex),
            buildTabs(title: 'Fee Receipts', index: _currentIndex),
            buildTabs(title: 'Attendance Graph', index: _currentIndex),
            buildTabs(title: 'Student Remark', index: _currentIndex)
          ],
          controller: tabController,
        ),
      ),
    );
  }

  Tab buildTabs({String? title, int? index}) {
    return Tab(
      child: Text(title!),
    );
  }

  Container buildStudentProfile(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Center(
                child: Text(
                  "Student Profile",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                    border: Border.all(width: 1.0),
                    borderRadius: BorderRadius.zero),
                child: selectedStudent!.length > 0
                    ? Image.network(
                        "${selectedStudent![0].studentImage!.replaceAll("~/", "")}",
                        errorBuilder: (context, error, stackTrace) {
                        return Image.asset(AppImages.dummyImage);
                      })
                    : Container(),
              ),
            ),
            buildRow(
                title: "Adm No. :",
                value: selectedStudent!.length > 0
                    ? selectedStudent![0].admNo
                    : ""),
            buildRow(
                title: "Name :",
                value: selectedStudent!.length > 0
                    ? selectedStudent![0].stName
                    : ""),
            buildRow(
                title: "Father's Name :",
                value: selectedStudent!.length > 0
                    ? selectedStudent![0].fatherName
                    : ""),
            buildRow(
                title: "Mother's Name :",
                value: selectedStudent!.length > 0
                    ? selectedStudent![0].motherName
                    : ""),
            buildRow(
                title: "Class :",
                value: selectedStudent!.length > 0
                    ? selectedStudent![0].className
                    : ""),
            buildRow(
                title: "Gender :",
                value: selectedStudent!.length > 0
                    ? selectedStudent![0].gender
                    : ""),
            buildRow(
                title: "D.O.B. :",
                value: selectedStudent!.length > 0
                    ? selectedStudent![0].dobNew
                    : ""),
            buildRow(
                title: "Mobile No :",
                value: selectedStudent!.length > 0
                    ? selectedStudent![0].mobileNo
                    : ""),
            buildRow(
                title: "Guardian's Mobile :",
                value: selectedStudent!.length > 0
                    ? selectedStudent![0].guardianMobileNo
                    : ""),
            buildRow(
                title: "Email-Id :",
                value: selectedStudent!.length > 0
                    ? selectedStudent![0].email
                    : ""),
            buildRow(
                title: "Category :",
                value: selectedStudent!.length > 0
                    ? selectedStudent![0].category
                    : ""),
            buildRow(
                title: "Nationality :",
                value: selectedStudent!.length > 0
                    ? selectedStudent![0].nationality
                    : ""),
            buildRow(
                title: "Religion :",
                value: selectedStudent!.length > 0
                    ? selectedStudent![0].religion
                    : ""),
            buildRow(
                title: "Blood Group :",
                value: selectedStudent!.length > 0
                    ? selectedStudent![0].bloodGroup
                    : ""),
            Center(
              child: Text(
                "Present Address",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                    ),
              ),
            ),
            buildRow(
                title: "Address :",
                value: selectedStudent!.length > 0
                    ? selectedStudent![0].prsntAddress
                    : ""),
            buildRow(
                title: "Area / Village :",
                value: selectedStudent!.length > 0
                    ? selectedStudent![0].village
                    : ""),
            buildRow(
                title: "Post Office :",
                value:
                    selectedStudent!.length > 0 ? selectedStudent![0].pO : ""),
            buildRow(
                title: "City :",
                value: selectedStudent!.length > 0
                    ? selectedStudent![0].pCity
                    : ""),
            buildRow(
                title: "State :",
                value: selectedStudent!.length > 0
                    ? selectedStudent![0].pState
                    : ""),
            buildRow(
                title: "Pin Code :",
                value: selectedStudent!.length > 0
                    ? selectedStudent![0].permanentPin
                    : ""),
          ],
        ),
      ),
    );
  }

  Container buildFeeReceipts() {
    return Container(
      child: feeRecipientList.length > 0
          ? ListView.builder(
              itemCount: feeRecipientList.length,
              itemBuilder: (context, index) {
                var item = feeRecipientList[index];
                return Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 5,
                  ),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 0.1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Rec No: ${item.receiptNo}',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total: ${item.feeTotal}',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            'Rec.Amt: ${item.receiveAmount}',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.green,
                            ),
                          ),
                          // Text(
                          //   'Bal: ${item.balanceAmt}',
                          //   style: TextStyle(
                          //     fontSize: 15,
                          //     fontWeight: FontWeight.w600,
                          //     color: Colors.red,
                          //   ),
                          // ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Sp.Dis : ${item.spDiscnt}',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            '${item.newFeeDate}',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            )
          : Center(
              child: Container(
                child: Text(
                  'NO Data',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
    );
  }

  Container buildStudentRemark() {
    return Container(
      child: studentRemarksList!.length > 0
          ? ListView.builder(
              itemCount: studentRemarksList!.length,
              itemBuilder: (context, index) {
                var item = studentRemarksList![index];
                return Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 5,
                  ),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 0.1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Remark: ${item.remark}',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              'EName: ${item.empName}',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Text(
                            '${item.addedOnDate}',
                            style: TextStyle(
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            )
          : Center(
              child: Container(
                child: Text(
                  'NO Data',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
    );
  }

  Container buildExamDetail(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildExamDropDown(),
            getStudentMarksForSingleExamList.length > 0
                ? buildExamMarksTable(context,
                    marksList: getStudentMarksForSingleExamList)
                : Container(),
            getStudentMarksVsHighestMarks.length > 0
                ? ExamDetailChart(examMarksChart: getStudentMarksVsHighestMarks)
                : Container(),
          ],
        ),
      ),
    );
  }

  Container buildExamMarksTable(BuildContext context,
      {List<ExamMarksModel>? marksList}) {
    return Container(
      child: marksList!.isEmpty
          ? Center(child: Text(NO_RECORD_FOUND))
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "${selectedExam!.exam} Result [${selectedYearSession!.sessionFrom}]",
                    // textScaleFactor: 1.5,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Table(
                    columnWidths: {
                      0: FlexColumnWidth(MediaQuery.of(context).size.width / 2),
                      1: FlexColumnWidth(
                          (MediaQuery.of(context).size.width / 2) / 2),
                      2: FlexColumnWidth(
                          (MediaQuery.of(context).size.width / 2) / 2),
                    },
                    // textDirection: TextDirection.rtl,
                    // defaultVerticalAlignment: TableCellVerticalAlignment.top,
                    // border: TableBorder.all(width: 2.0, color: Colors.red),
                    children: [
                      for (int i = 0; i < marksList.length; ++i)
                        buildTableRows(
                          subjectName: marksList[i].subjectName,
                          maxMarks: marksList[i].maxmarks,
                          studentMarks: marksList[i].total,
                          grade: marksList[i].grades,
                        ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  TableRow buildTableRows(
      {String? subjectName,
      String? maxMarks,
      String? studentMarks,
      String? grade}) {
    return TableRow(
      decoration: BoxDecoration(
          // color: Colors.blue,
          ),
      children: [
        buildTableRowText(
            title: subjectName,
            color: Colors.transparent,
            alignment: Alignment.centerLeft),
        buildTableRowText(
            title: maxMarks,
            color: Colors.blue[50],
            fontWeight: FontWeight.w600,
            alignment: Alignment.center),
        buildTableRowText(
            title: "$studentMarks - $grade",
            color: Colors.green[100],
            fontWeight: FontWeight.w700,
            alignment: Alignment.center),
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
              // textScaleFactor: 1.5,
              style: TextStyle(fontWeight: fontWeight ?? FontWeight.normal)),
        ),
      );

  Container buildStudentAccount(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [buildFeeTypeDropDown(), buildMonthDropdown()],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              border: Border.all(
                width: 0.1,
              ),
            ),
            padding: EdgeInsets.all(8),
            child: Text(
              'Amount : $amount',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 20,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Expanded buildReceipts(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10.0),
        color: Colors.white,
        child: ListView.builder(
          physics: AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: feeReceiptList.length,
          itemBuilder: (context, i) {
            var item = feeReceiptList[i];
            return Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xffDBDBDB)),
              ),
              child: Column(
                children: [
                  buildRow(title: "Receipt No.", value: item.receiptNo),
                  Divider(color: Color(0xffDBDBDB), height: 20),
                  buildRow(title: "Month", value: "October"),
                  Divider(color: Colors.white, height: 10),
                  buildRow(title: "Payment Date", value: item.date),
                  Divider(color: Color(0xffDBDBDB), height: 20),
                  buildRow(title: "Total Amount", value: item.amount),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Container buildAttendanceGraph(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            graphList.length > 0
                ? AttendanceBarChart(attendanceChart: graphList)
                : Center(
                    child: Text(
                      "Attendance Graph",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Container buildExamDropDown() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Color(0xffECECEC)),
        ),
        child: DropdownButton<ExamSelectedListModel>(
          isDense: true,
          value: selectedExam,
          key: UniqueKey(),
          isExpanded: true,
          underline: Container(),
          items: examDropdown!
              .map((item) => DropdownMenuItem<ExamSelectedListModel>(
                  child: Text('${item.exam}'), value: item))
              .toList(),
          onChanged: (val) {
            setState(() {
              selectedExam = val!;
              print("_selectedExam: $val");
            });
          },
        ),
      ),
    );
  }

  Expanded buildFeeTypeDropDown() {
    return Expanded(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Color(0xffECECEC)),
          ),
          child: DropdownButton<FeeTypeModel>(
            isDense: true,
            value: selectedFeeType,
            key: UniqueKey(),
            isExpanded: true,
            underline: Container(),
            items: feeTypeDropdown!
                .map((item) => DropdownMenuItem<FeeTypeModel>(
                    child: Text('${item.paramname}'), value: item))
                .toList(),
            onChanged: (val) {
              setState(() {
                selectedFeeType = val!;
                print("_selectedExam: $val");
              });
              getMonthsFromApi(
                  catId: selectedFeeType!.iD,
                  empId: selectedStudent![0].studentid);
            },
          ),
        ),
      ),
    );
  }

  Expanded buildMonthDropdown() {
    return Expanded(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Color(0xffECECEC)),
          ),
          child: DropdownButton<FeeMonthsModel>(
            isDense: true,
            value: selectedMonth,
            key: UniqueKey(),
            isExpanded: true,
            underline: Container(),
            items: monthDropdown!
                .map((item) => DropdownMenuItem<FeeMonthsModel>(
                    child: Text('${item.feeMonthName}'), value: item))
                .toList(),
            onChanged: (val) {
              setState(() {
                selectedMonth = val;
                print("_selectedFeeType: $val");
              });
              getMonthlyAmount(
                  catId: selectedFeeType!.iD,
                  empId: selectedStudent![0].studentid,
                  feeMonths: selectedMonth);
            },
          ),
        ),
      ),
    );
  }

  // Container buildYearDropDown() {
  //   return Container(
  //     color: Colors.white,
  //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  //     child: Container(
  //       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         border: Border.all(color: Color(0xffECECEC)),
  //       ),
  //       child: DropdownButton<String>(
  //         isDense: true,
  //         value: _selectedYear,
  //         key: UniqueKey(),
  //         isExpanded: true,
  //         underline: Container(),
  //         items: dropDownYearList
  //             .map((item) =>
  //                 DropdownMenuItem<String>(child: Text(item), value: item))
  //             .toList(),
  //         onChanged: (val) {
  //           setState(() {
  //             _selectedYear = val!;
  //             print("_selectedYear: $val");
  //           });
  //         },
  //       ),
  //     ),
  //   );
  // }

  Padding buildRow({String? title, String? value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title!,
            style: TextStyle(
                color: Color(0xff777777), fontWeight: FontWeight.w600),
          ),
          Text(
            value!,
            style: TextStyle(
                color: Color(0xff3A3A3A), fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

// class DetailModel{
//   String? admNo="";
//   String? name="";
//   String? classs="";
//   String? gender="";
//   String? dob="";
//   String? fName="";
//   String? mName="";
//   String? mobileNo="";
//   String? guardianNo="";
//   String? emailId="";
//   String? category="";
//   String? nationality="";
//   String? religion="";
//   String? bloodGroup="";
//   String? address="";
//   String? village="";
//   String? postOffice="";
//   String? city="";
//   String? state="";
//   String? pinCode="";
//
//   DetailModel({this.state,this.admNo,this.gender,this.address,this.bloodGroup,this.category,this.city,this.classs,this.dob,this.emailId,this.fName,this.guardianNo,this.mName,this.mobileNo,this.name,this.nationality,this.pinCode,this.postOffice,this.religion,this.village});
//
//   DetailModel.fromJson(Map<String,dynamic> json){
//     this.name=json[''];
//   }
//
// }
