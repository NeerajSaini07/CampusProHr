import 'dart:core';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/APPLY_FOR_LEAVE_CUBIT/apply_for_leave_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/ASSIGN_ADMIN_CUBIT/assign_admin_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/ASSIGN_TEACHER_CUBIT/assign_teacher_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/ATTENDANCE_GRAPH_CUBIT/attendance_graph_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/LEAVE_REQUEST_CUBIT/leave_request_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/leaveRequestModel.dart';
import 'package:campus_pro/src/DATA/MODELS/userTypeModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/WIDGETS/CHARTS/attendanceBarChart.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/drawerWidget.dart';
import 'package:campus_pro/src/UI/WIDGETS/toast.dart';
import 'package:campus_pro/src/UTILS/fieldValidators.dart';
import 'package:campus_pro/src/WIDGETS_STYLE/style_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../DATA/API_SERVICES/applyForLeaveApi.dart';
import '../../../DATA/API_SERVICES/assignAdminApi.dart';
import '../../../DATA/API_SERVICES/assignTeacherApi.dart';
import '../../../DATA/REPOSITORIES/applyForLeaveRepository.dart';
import '../../../DATA/REPOSITORIES/assignAdminRepository.dart';
import '../../../DATA/REPOSITORIES/assignTeacherRepository.dart';

class AttendanceStudent extends StatefulWidget {
  static const routeName = "/attendance-student";
  @override
  _AttendanceStudentState createState() => _AttendanceStudentState();
}

class _AttendanceStudentState extends State<AttendanceStudent> {
  final _leaveFormKey = GlobalKey<FormState>();

  TextEditingController descriptionController = TextEditingController();
  TabController? tabController;

  var scrollController = ScrollController();

  bool showLoader = false;

  int _currentIndex = 0;

  String? _selectedLeave = 's';

  List<String> leaveTypeDropdown = ['s', 'u'];

  UserTypeModel? userTypeData;

  void tabIndexChange(int tabIndex) {
    setState(() {
      _currentIndex = tabIndex;
    });
  }

  DateTime selectedFromDate = DateTime.now();
  DateTime selectedToDate = DateTime.now().add((Duration(days: 1)));

  Future<void> _selectDate(BuildContext context, {int? index}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedFromDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      helpText: index == 0 ? "SELECT FROM DATE" : "SELECT TO DATE",
    );
    if (picked != null) {
      if (index == 0) {
        setState(() => selectedFromDate = picked);
        print('selectedFromDate $selectedFromDate');
      } else {
        setState(() => selectedToDate = picked);
        print('selectedToDate $selectedToDate');
      }
    }
  }

  // sendLeaveDataToApi({String? empID, String? empMobileNo}) async {
  //   if (empID != null && empMobileNo != null) {
  //     final uid = await UserUtils.idFromCache();
  //     final token = await UserUtils.userTokenFromCache();
  //     final userData = await UserUtils.userTypeFromCache();
  //     final leaveData = {
  //       'OUserId': uid,
  //       'Token': token,
  //       'OrgId': userData!.organizationId,
  //       'Schoolid': userData.schoolId,
  //       'SessionId': userData.currentSessionid,
  //       'RequesterId': userData.stuEmpId,
  //       'RequestorPhone': empMobileNo,
  //       'LeaveType': _selectedLeave,
  //       'LeaveDesscription': descriptionController.text,
  //       'FromDate': DateFormat("dd MMM yyyy").format(selectedFromDate),
  //       'ToDate': DateFormat("dd MMM yyyy").format(selectedToDate),
  //       'RequestorType': 'S',
  //       'DestinationId': empID,
  //     };
  //     print("Sending Apply For Leave Data => $leaveData");
  //     context.read<ApplyForLeaveCubit>().applyForLeaveCubitCall(leaveData);
  //   } else {
  //     toastFailedNotification(
  //         "You don't have any assign teacher for apply leave.");
  //   }
  // }

  getUserTypeData() async {
    userTypeData = await UserUtils.userTypeFromCache();
  }

  @override
  void initState() {
    getLeaveRequest();
    super.initState();
  }

  String? userType = "";

  getAttendanceGraph() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    setState(() => userType = userData!.ouserType);
    final attendanceData = {
      'OUserId': uid!,
      'Token': token!,
      'OrgId': userData!.organizationId!,
      'Schoolid': userData.schoolId!,
      'SessionId': userData.currentSessionid!,
      'StudentId': userData.stuEmpId!,
      'StuEmpId': userData.stuEmpId!,
      'UserType': userData.ouserType!,
    };
    print("Sending getAttendanceGraph Data => $attendanceData");
    context
        .read<AttendanceGraphCubit>()
        .attendanceGraphCubitCall(attendanceData);
  }

  getLeaveRequest() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final leaveRequestData = {
      'OUserId': uid,
      'Token': token,
      'OrgId': userData!.organizationId,
      'Schoolid': userData.schoolId,
      'SessionId': userData.currentSessionid,
      'RequesterId': userData.stuEmpId,
      'RequestorType': userData.ouserType,
    };
    print("Sending leaveRequestData Data => $leaveRequestData");
    context.read<LeaveRequestCubit>().leaveRequestCubitCall(leaveRequestData);
    if (userData.ouserType!.toLowerCase() == 's') getAttendanceGraph();
  }

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000)).then((value) async {
      getLeaveRequest();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: commonAppBar(context, title: "Attendance"),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: userTypeData == null
          ? Container()
          : userTypeData!.ouserType!.toLowerCase() == "f"
              ? FloatingActionButton(
                  backgroundColor: Colors.grey,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider<AssignAdminCubit>(
                          create: (_) => AssignAdminCubit(
                              AssignAdminRepository(AssignAdminApi())),
                          child: BlocProvider<AssignTeacherCubit>(
                            create: (_) => AssignTeacherCubit(
                                AssignTeacherRepository(AssignTeacherApi())),
                            child: BlocProvider<ApplyForLeaveCubit>(
                              create: (_) => ApplyForLeaveCubit(
                                  ApplyForLeaveRepository(ApplyForLeaveApi())),
                              child: ApplyForLeave(),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  child: Icon(Icons.add),
                )
              : Container(),
      body: RefreshIndicator(
        onRefresh: () => _onRefresh(),
        child: MultiBlocListener(
          listeners: [
            BlocListener<ApplyForLeaveCubit, ApplyForLeaveState>(
              listener: (context, state) {
                if (state is ApplyForLeaveLoadSuccess) {
                  getLeaveRequest();
                }
                if (state is ApplyForLeaveLoadFail) {
                  if (state.failReason == "false") {
                    UserUtils.unauthorizedUser(context);
                  }
                }
              },
            ),
          ],
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // AttendanceBarChart(),
                if (userType!.toLowerCase() == 's')
                  BlocConsumer<AttendanceGraphCubit, AttendanceGraphState>(
                    listener: (context, state) {
                      if (state is AttendanceGraphLoadFail) {
                        if (state.failReason == "false") {
                          UserUtils.unauthorizedUser(context);
                        }
                      }
                    },
                    builder: (context, state) {
                      if (state is AttendanceGraphLoadInProgress) {
                        return LinearProgressIndicator();
                      } else if (state is AttendanceGraphLoadSuccess) {
                        return AttendanceBarChart(
                            attendanceChart: state.attendanceList);
                      } else if (state is AttendanceGraphLoadFail) {
                        return Container();
                      } else {
                        return LinearProgressIndicator();
                      }
                    },
                  ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      'Requests',
                      // style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                ),
                BlocConsumer<LeaveRequestCubit, LeaveRequestState>(
                  listener: (context, state) {
                    if (state is LeaveRequestLoadFail) {
                      if (state.failReason == "false") {
                        UserUtils.unauthorizedUser(context);
                      }
                    }
                  },
                  builder: (context, state) {
                    if (state is LeaveRequestLoadInProgress) {
                      // return Center(child: CircularProgressIndicator());
                      return Center(child: LinearProgressIndicator());
                    } else if (state is LeaveRequestLoadSuccess) {
                      return buildLeaveRequests(context,
                          leaveRequestList: state.leaveRequestList);
                    } else if (state is LeaveRequestLoadFail) {
                      return Center(
                          child: Text(
                        state.failReason,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ));
                    } else {
                      // return Center(child: CircularProgressIndicator());
                      return Center(child: LinearProgressIndicator());
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      // body: MultiBlocListener(

      //   child: NestedScrollView(
      //     controller: scrollController,
      //     physics: ScrollPhysics(parent: PageScrollPhysics()),
      //     headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
      //       return <Widget>[
      //         SliverList(
      //           delegate: SliverChildListDelegate([AttendanceBarChart()]),
      //         ),
      //       ];
      //     },
      //     body: DefaultTabController(
      //       initialIndex: _currentIndex,
      //       length: 2,
      //       child: Column(
      //         children: [
      //           // SizedBox(height: 20),
      //           buildTabBar(context),
      //           Expanded(
      //             child: TabBarView(
      //               // physics: NeverScrollableScrollPhysics(),
      //               children: [

      //                 // buildLeaveRequests(context, leaveRequestList: []),
      //                 buildApplyForLeave(context),
      //               ],
      //             ),
      //           ),
      //           // buildLeaveForm(context),
      //           // buildLeaveStatus(context),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }

  Container buildTabBar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
      child: TabBar(
        unselectedLabelColor: Colors.black,
        indicatorSize: TabBarIndicatorSize.label,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
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
            default:
              tabIndexChange(tabIndex);
              // getSample();
              break;
          }
        },
        tabs: [
          buildTabs(title: 'Leave Requests', index: 0),
          buildTabs(title: 'Apply For Leave', index: 1),
        ],
        controller: tabController,
      ),
    );
  }

  Tab buildTabs({String? title, int? index}) {
    return Tab(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: _currentIndex == index
              ? Theme.of(context).primaryColor
              : Color(0xffECECEC),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(title!),
        ),
      ),
    );
  }

  Container buildLeaveRequests(BuildContext context,
      {List<LeaveRequestModel>? leaveRequestList}) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: leaveRequestList!.isNotEmpty
          ? ListView.separated(
              separatorBuilder: (context, index) => SizedBox(height: 10),
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: leaveRequestList.length,
              itemBuilder: (context, i) {
                var item = leaveRequestList[i];
                return buildMyCard(context, leaveRequestList: item);
              },
            )
          : Center(child: Text(NO_RECORD_FOUND)),
    );
  }

  Container buildMyCard(BuildContext context,
      {LeaveRequestModel? leaveRequestList}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xffDBDBDB)),
      ),
      child: ListTile(
        title: Text(
          "${leaveRequestList!.leaveType!}",
          style: commonStyleForText.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildText(
                      title:
                          "${leaveRequestList.fromDate!} - ${leaveRequestList.toDate!}"),
                  buildText(
                      title: "Allowed for : ${leaveRequestList.allowedFor}"),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              constraints: BoxConstraints(minWidth: 100),
              decoration: BoxDecoration(
                color: leaveRequestList.leaveStatus!.toLowerCase() == 'accepted'
                    ? Colors.green[800]
                    : leaveRequestList.leaveStatus!.toLowerCase() == 'pending'
                        ? Color.fromRGBO(250, 196, 47, 1.0)
                        : Colors.red,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Row(
                children: [
                  Icon(
                    leaveRequestList.leaveStatus!.toLowerCase() == 'accepted'
                        ? Icons.check
                        : leaveRequestList.leaveStatus!.toLowerCase() ==
                                'pending'
                            ? Icons.pending
                            : Icons.close,
                    color: Colors.white,
                    size: 16,
                  ),
                  SizedBox(width: 4),
                  Text(
                    leaveRequestList.leaveStatus!,
                    // textScaleFactor: 1.5,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  InkWell buildDateSelector({String? selectedDate, int? index}) {
    return InkWell(
      onTap: () => _selectDate(context, index: index),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xffECECEC)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              // width: MediaQuery.of(context).size.width / 4,
              child: Text(
                selectedDate!,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            Icon(Icons.today, color: Theme.of(context).primaryColor)
          ],
        ),
      ),
    );
  }

  Container buildTextField() {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: TextFormField(
        maxLines: 8,
        maxLength: 100,
        controller: descriptionController,
        validator: FieldValidators.globalValidator,
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
          hintText: "type here...",
          hintStyle: TextStyle(color: Color(0xff77838F)),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16),
        ),
      ),
    );
  }

  // Container buildApplyBtn() {
  //   return Container(
  //     margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(10.0),
  //       gradient: LinearGradient(
  //           begin: Alignment.centerLeft,
  //           end: Alignment.centerRight,
  //           colors: [accentColor, primaryColor]),
  //     ),
  //     child: FlatButton(
  //       onPressed: () async {
  //         if (_leaveFormKey.currentState!.validate()) {
  //           setState(() => showLoader = !showLoader);
  //           final uid = await UserUtils.idFromCache();
  //           final token = await UserUtils.userTokenFromCache();
  //           final userData = await UserUtils.userTypeFromCache();
  //           print("userData!.ouserType : ${userData!.ouserType}");
  //           if (userData.ouserType!.toLowerCase() == 's') {
  //             final checkTeacher = {
  //               'OUserId': uid,
  //               'Token': token,
  //               'OrgId': userData.organizationId,
  //               'Schoolid': userData.schoolId,
  //               'SessionId': userData.currentSessionid,
  //               'StudentId': userData.stuEmpId,
  //             };

  //             print("Sending assignTeacher Data => $checkTeacher");

  //             context
  //                 .read<AssignTeacherCubit>()
  //                 .assignTeacherCubitCall(checkTeacher);
  //           } else {
  //             final checkAdmin = {
  //               'OUserId': uid,
  //               'Token': token,
  //               'OrgId': userData.organizationId,
  //               'Schoolid': userData.schoolId,
  //               'EmpId': userData.stuEmpId,
  //               'UserType': userData.ouserType,
  //             };

  //             print("Sending assignAdmin Data => $checkAdmin");

  //             context.read<AssignAdminCubit>().assignAdminCubitCall(checkAdmin);
  //           }
  //         }
  //       },
  //       child: Text(
  //         "Apply For Leave",
  //         style:
  //             TextStyle(fontFamily: "BebasNeue-Regular", color: Colors.white),
  //       ),
  //     ),
  //   );
  // }

  Text buildLabels(String label) {
    return Text(
      label,
      style: TextStyle(
        // color: Theme.of(context).primaryColor,
        color: Color(0xff3A3A3A),
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Text buildText({String? title}) {
    return Text(
      title!,
      style: TextStyle(
        color: Colors.grey,
        fontSize: 14.0,
      ),
    );
  }
}

class ApplyForLeave extends StatefulWidget {
  const ApplyForLeave({Key? key}) : super(key: key);

  @override
  _ApplyForLeaveState createState() => _ApplyForLeaveState();
}

class _ApplyForLeaveState extends State<ApplyForLeave> {
  final _leaveFormKey = GlobalKey<FormState>();

  TextEditingController descriptionController = TextEditingController();

  bool showLoader = false;

  String? _selectedLeave = 's';

  List<String> leaveTypeDropdown = ['s', 'u'];

  DateTime selectedFromDate = DateTime.now();
  DateTime selectedToDate = DateTime.now().add((Duration(days: 1)));

  String? userId;

  Future<void> _selectDate(BuildContext context, {int? index}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedFromDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      helpText: index == 0 ? "SELECT FROM DATE" : "SELECT TO DATE",
    );
    if (picked != null)
      setState(() {
        if (index == 0) {
          selectedFromDate = picked;
        } else {
          selectedToDate = picked;
        }
      });
  }

  @override
  void initState() {
    dataFromCache();
    super.initState();
  }

  dataFromCache() async {
    final data = await UserUtils.userTypeFromCache();
    setState(() {
      userId = data!.stuEmpId;
    });
  }

  sendLeaveDataToApi({String? empID, String? empMobileNo, String? type}) async {
    if (empID != null && empMobileNo != null) {
      final uid = await UserUtils.idFromCache();
      final token = await UserUtils.userTokenFromCache();
      final userData = await UserUtils.userTypeFromCache();
      final leaveData = {
        'OUserId': uid,
        'Token': token,
        'OrgId': userData!.organizationId,
        'Schoolid': userData.schoolId,
        'SessionId': userData.currentSessionid,
        'RequesterId': userData.stuEmpId,
        'RequestorPhone': empMobileNo,
        'LeaveType': _selectedLeave,
        'LeaveDesscription': descriptionController.text,
        'FromDate': DateFormat("dd MMM yyyy").format(selectedFromDate),
        'ToDate': DateFormat("dd MMM yyyy").format(selectedToDate),
        'RequestorType': type,
        'DestinationId': empID,
      };
      print("Sending Apply For Leave Data => $leaveData");
      context.read<ApplyForLeaveCubit>().applyForLeaveCubitCall(leaveData);
    } else {
      toastFailedNotification(
          "You don't have any assign teacher for apply leave.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, title: "Apply For Leave"),
      body: MultiBlocListener(
        listeners: [
          BlocListener<ApplyForLeaveCubit, ApplyForLeaveState>(
            listener: (context, state) {
              if (state is ApplyForLeaveLoadSuccess) {
                setState(() {
                  _selectedLeave = 's';
                  selectedFromDate = DateTime.now();
                  selectedToDate = DateTime.now().add((Duration(days: 1)));
                  descriptionController.clear();
                  showLoader = !showLoader;
                });
                toast(state.status);
                Navigator.pop(context);
              }
              if (state is ApplyForLeaveLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                } else {
                  setState(() => showLoader = !showLoader);
                  toast(state.failReason);
                }
              }
            },
          ),
          BlocListener<AssignTeacherCubit, AssignTeacherState>(
            listener: (context, state) {
              if (state is AssignTeacherLoadSuccess) {
                sendLeaveDataToApi(
                    empID: state.teacherList[0].empID,
                    empMobileNo: state.teacherList[0].mobileNo,
                    type: "S");
              }
              if (state is AssignTeacherLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                } else {
                  setState(() => showLoader = !false);
                  toast(state.failReason);
                }
              }
            },
          ),
          BlocListener<AssignAdminCubit, AssignAdminState>(
            listener: (context, state) {
              if (state is AssignAdminLoadSuccess) {
                final admin = state.assignAdminList
                    .where((element) => element.empId == userId)
                    .toList();
                print("admin.length => ${admin.length} --- $userId");
                if (admin.length > 0)
                  sendLeaveDataToApi(
                      empID: admin[0].empId,
                      empMobileNo: admin[0].mobileNo,
                      type: "E");
                else {
                  toastAlertNotification("Admin not assigned!");
                  setState(() {
                    showLoader = false;
                  });
                }
              }
              if (state is AssignAdminLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                } else {
                  setState(() => showLoader = false);
                  toast(state.failReason);
                }
              }
            },
          ),
        ],
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _leaveFormKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // shrinkWrap: true,
                // physics: NeverScrollableScrollPhysics(),
                children: [
                  buildLabels("Leave Type"),
                  SizedBox(height: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffECECEC)),
                      // borderRadius: BorderRadius.circular(4),
                    ),
                    child: DropdownButton<String>(
                      isDense: true,
                      value: _selectedLeave,
                      key: UniqueKey(),
                      isExpanded: true,
                      underline: Container(),
                      items: leaveTypeDropdown
                          .map((item) => DropdownMenuItem<String>(
                              child:
                                  Text(item == 's' ? 'Sick Leave' : 'Urgent'),
                              value: item))
                          .toList(),
                      onChanged: (val) {
                        setState(() {
                          _selectedLeave = val;
                          print("_selectedLeave: $val");
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildLabels("Start Date"),
                            SizedBox(height: 8),
                            buildDateSelector(
                              index: 0,
                              selectedDate: DateFormat("dd MMM yyyy")
                                  .format(selectedFromDate),
                            )
                          ],
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildLabels("End Date"),
                            SizedBox(height: 8),
                            buildDateSelector(
                              index: 1,
                              selectedDate: DateFormat("dd MMM yyyy")
                                  .format(selectedToDate),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  buildLabels("Description"),
                  buildTextField(),
                  if (showLoader)
                    // Center(child: CircularProgressIndicator())
                    Center(child: LinearProgressIndicator())
                  else
                    Center(child: buildApplyBtn()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  InkWell buildDateSelector({String? selectedDate, int? index}) {
    return InkWell(
      onTap: () => _selectDate(context, index: index),
      child: internalTextForDateTime(context, selectedDate: selectedDate),
      // Container(
      //   width: MediaQuery.of(context).size.width,
      //   padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      //   decoration: BoxDecoration(
      //     border: Border.all(color: Color(0xffECECEC)),
      //   ),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       Container(
      //         // width: MediaQuery.of(context).size.width / 4,
      //         child: Text(
      //           selectedDate!,
      //           overflow: TextOverflow.ellipsis,
      //           maxLines: 1,
      //         ),
      //       ),
      //       Icon(Icons.today, color: Theme.of(context).primaryColor)
      //     ],
      //   ),
      // ),
    );
  }

  Container buildTextField() {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: TextFormField(
        maxLines: 8,
        maxLength: 100,
        controller: descriptionController,
        validator: FieldValidators.globalValidator,
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
          hintText: "type here...",
          hintStyle: TextStyle(color: Color(0xff77838F)),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16),
        ),
      ),
    );
  }

  Container buildApplyBtn() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Theme.of(context).primaryColor,
      ),
      child: TextButton(
        onPressed: () async {
          if (_leaveFormKey.currentState!.validate()) {
            setState(() => showLoader = true);
            final uid = await UserUtils.idFromCache();
            final token = await UserUtils.userTokenFromCache();
            final userData = await UserUtils.userTypeFromCache();
            print("userData!.ouserType : ${userData!.ouserType}");
            if (userData.ouserType!.toLowerCase() == 's') {
              final checkTeacher = {
                'OUserId': uid,
                'Token': token,
                'OrgId': userData.organizationId,
                'Schoolid': userData.schoolId,
                'SessionId': userData.currentSessionid,
                'StudentId': userData.stuEmpId,
              };

              print("Sending assignTeacher Data => $checkTeacher");

              context
                  .read<AssignTeacherCubit>()
                  .assignTeacherCubitCall(checkTeacher);
            } else {
              final checkAdmin = {
                'OUserId': uid,
                'Token': token,
                'OrgId': userData.organizationId,
                'Schoolid': userData.schoolId,
                'EmpId': userData.stuEmpId,
                'UserType': userData.ouserType,
              };

              print("Sending assignAdmin Data => $checkAdmin");

              context.read<AssignAdminCubit>().assignAdminCubitCall(checkAdmin);
            }
          }
        },
        child: Text(
          "Apply For Leave",
          style:
              TextStyle(fontFamily: "BebasNeue-Regular", color: Colors.white),
        ),
      ),
    );
  }

  Text buildLabels(String label) {
    return Text(
      label,
      style: TextStyle(fontSize: 16),
    );
  }
}
