import 'package:campus_pro/src/DATA/BLOC_CUBIT/STUDENT_HISTORY_REJACPT_EMPLOYEE_CUBIT/student_leave_pending_reject_accept_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/STUDENT_LEAVE_EMPLOYEE_HISTORY_CUBIT/student_history_employee_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/studentLeaveEmployeeHistoryModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class LeaveApplicationAdmin extends StatefulWidget {
  static const routeName = '/Leave-Application-Admin';
  const LeaveApplicationAdmin({Key? key}) : super(key: key);

  @override
  _LeaveApplicationAdminState createState() => _LeaveApplicationAdminState();
}

class _LeaveApplicationAdminState extends State<LeaveApplicationAdmin> {
  static const item = <String>[
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  String? selectedMonth = DateFormat.MMMM().format(DateTime.now());
  static const item1 = <String>[
    '2017',
    '2018',
    '2019',
    '2020',
    '2021',
    '2022',
    '2023',
  ];
  // String? selectedYear = '2021';
  static const item2 = <String>['Approved', 'Rejected', 'Pending'];
  String? selectedStatus = 'Approved';

  String? selectedYear;
  // List classListItem = [
  //   [
  //     'name',
  //     'type',
  //     '1231231232',
  //     'status',
  //     'fromDate',
  //     'ToDate',
  //     'I am not feeling good today because having cold.'
  //   ],
  //   ['name', 'type', '1231231232', 'status', 'fromDate', 'ToDate', 'desc'],
  //   ['name', 'type', '1231231232', 'status', 'fromDate', 'ToDate', 'desc'],
  //   ['name', 'type', '1231231232', 'status', 'fromDate', 'ToDate', 'desc'],
  // ];

  DateTime date = DateTime.now();
  _launchPhoneURL(String phoneNumber) async {
    String url = 'tel:' + phoneNumber;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  final List<DropdownMenuItem<String>> monthItem = item
      .map(
          (String e) => DropdownMenuItem<String>(value: e, child: Text('${e}')))
      .toList();

  final List<DropdownMenuItem<String>> yearItem = item1
      .map(
          (String e) => DropdownMenuItem<String>(value: e, child: Text('${e}')))
      .toList();

  final List<DropdownMenuItem<String>> statusItem = item2
      .map(
          (String e) => DropdownMenuItem<String>(value: e, child: Text('${e}')))
      .toList();

  getStudentLeaves({String? month}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final LeaveData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId!,
      "SessionId": userData.currentSessionid!,
      "Id": userData.stuEmpId,
      "ForAdmin": "1",
      "Date": DateFormat("dd MMM yyyy").format(date),
      "Status": selectedStatus == 'Approved'
          ? 'A'
          : selectedStatus == 'Rejected'
              ? 'R'
              : 'N',
      "Month": month,
      "year": selectedYear,
      "UserType": userData.ouserType,
    };
    print("Getting Leave history sending = > $LeaveData");
    context
        .read<StudentHistoryLeaveEmployeeCubit>()
        .studentHistoryEmployeeCubitCall(LeaveData);
  }

  acceptRejectLeave(
      {String? acpRej, String? todate, String? fromdate, String? reqId}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final Data = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId!,
      "ToApprOrRej": acpRej.toString(),
      "ToDate": todate.toString(),
      "FromDate": fromdate.toString(),
      "RequestorId": reqId.toString(),
      "RequestorType": "E",
    };
    print("Reject Accept data sending = > $Data");

    context
        .read<StudentLeavePendingRejectAcceptCubit>()
        .studentLeavePendingRejectAcceptCall(Data);
  }

  @override
  void initState() {
    super.initState();
    print(selectedMonth);
    date = DateTime.now();
    getStudentLeaves(
        month: selectedMonth == 'January'
            ? '1'
            : selectedMonth == 'February'
                ? '2'
                : selectedMonth == 'March'
                    ? '3'
                    : selectedMonth == 'April'
                        ? '4'
                        : selectedMonth == 'May'
                            ? '5'
                            : selectedMonth == 'June'
                                ? '6'
                                : selectedMonth == 'July'
                                    ? '7'
                                    : selectedMonth == 'August'
                                        ? '8'
                                        : selectedMonth == 'September'
                                            ? '9'
                                            : selectedMonth == 'October'
                                                ? '10'
                                                : selectedMonth == 'November'
                                                    ? '11'
                                                    : '12');
    selectedYear = DateFormat("yyyy").format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, title: 'Leave Apps'),
      body: MultiBlocListener(
        listeners: [
          BlocListener<StudentLeavePendingRejectAcceptCubit,
              StudentLeavePendingRejectAcceptState>(listener: (context, state) {
            if (state is StudentLeavePendingRejectAcceptLoadSuccess) {
              getStudentLeaves(
                  month: selectedMonth == 'January'
                      ? '1'
                      : selectedMonth == 'February'
                          ? '2'
                          : selectedMonth == 'March'
                              ? '3'
                              : selectedMonth == 'April'
                                  ? '4'
                                  : selectedMonth == 'May'
                                      ? '5'
                                      : selectedMonth == 'June'
                                          ? '6'
                                          : selectedMonth == 'July'
                                              ? '7'
                                              : selectedMonth == 'August'
                                                  ? '8'
                                                  : selectedMonth == 'September'
                                                      ? '9'
                                                      : selectedMonth ==
                                                              'October'
                                                          ? '10'
                                                          : selectedMonth ==
                                                                  'November'
                                                              ? '11'
                                                              : '12');
            }
            if (state is StudentLeavePendingRejectAcceptLoadFail) {
              if (state.failReason == "false") {
                UserUtils.unauthorizedUser(context);
              }
            }
          })
        ],
        child: Column(
          children: [
            Row(
              children: [
                buildMonthDropDown(),
                buildYearDropDown(),
              ],
            ),
            // SizedBox(
            //   height: MediaQuery.of(context).size.height * 0.01,
            // ),
            Row(
              children: [
                buildStatusDropDown(),
                Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                    InkWell(
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                      onTap: () {
                        getStudentLeaves(
                            month: selectedMonth == 'January'
                                ? '1'
                                : selectedMonth == 'February'
                                    ? '2'
                                    : selectedMonth == 'March'
                                        ? '3'
                                        : selectedMonth == 'April'
                                            ? '4'
                                            : selectedMonth == 'May'
                                                ? '5'
                                                : selectedMonth == 'June'
                                                    ? '6'
                                                    : selectedMonth == 'July'
                                                        ? '7'
                                                        : selectedMonth ==
                                                                'August'
                                                            ? '8'
                                                            : selectedMonth ==
                                                                    'September'
                                                                ? '9'
                                                                : selectedMonth ==
                                                                        'October'
                                                                    ? '10'
                                                                    : selectedMonth ==
                                                                            'November'
                                                                        ? '11'
                                                                        : '12');
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            left: 20, right: 10, top: 8, bottom: 10),
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.height * 0.05,
                        decoration: BoxDecoration(
                            border: Border(),
                            borderRadius: BorderRadius.circular(20),
                            color: Theme.of(context).primaryColor),
                        child: Center(
                          child: Text(
                            'Search',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Divider(
              thickness: 5,
            ),
            BlocConsumer<StudentHistoryLeaveEmployeeCubit,
                StudentHistoryEmployeeState>(
              listener: (context, state) {
                if (state is StudentHistoryEmployeeLoadInProgress) {}
                if (state is StudentHistoryEmployeeLoadFail) {
                  if (state.failReason == "false") {
                    UserUtils.unauthorizedUser(context);
                  }
                }
              },
              builder: (context, state) {
                if (state is StudentHistoryEmployeeLoadInProgress) {
                  return Container(
                      height: 10,
                      width: 10,
                      child: Center(child: CircularProgressIndicator()));
                } else if (state is StudentHistoryEmployeeLoadSuccess) {
                  return buildBody(context, LeaveList: state.LeaveList);
                } else if (state is StudentHistoryEmployeeLoadFail) {
                  return buildBody(context, error: state.failReason);
                } else {
                  return Center(
                    //child: CircularProgressIndicator(),
                    child: Container(),
                  );
                }
              },
            ),
            //buildLeaveApplication()
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Expanded buildBody(BuildContext context,
      {List<StudentLeaveEmployeeHistoryModel>? LeaveList, String? error}) {
    return Expanded(
      child: LeaveList == null || LeaveList.isEmpty
          ? Center(
              child: Text(
                error!,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            )
          : buildLeaveApplication(LeaveList: LeaveList),
    );
  }

  ListView buildLeaveApplication(
      {List<StudentLeaveEmployeeHistoryModel>? LeaveList}) {
    return ListView.separated(
      separatorBuilder: (context, index) => SizedBox(
        height: 10,
      ),
      itemCount: LeaveList!.length,
      itemBuilder: (context, index) {
        final key = GlobalKey<State<Tooltip>>();
        var item = LeaveList[index];
        return Container(
          margin: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 2),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(border: Border.all(width: 0.1)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item.name!.toUpperCase(),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    item.status.toString(),
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: item.status.toString() == 'Pending'
                            ? Colors.orange
                            : item.status.toString() == 'Approved'
                                ? Colors.green
                                : Colors.red),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'Description : ',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      Tooltip(
                          key: key,
                          waitDuration: Duration(milliseconds: 1),
                          showDuration: Duration(seconds: 3),
                          padding: EdgeInsets.all(5),
                          height: 35,
                          textStyle: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.cyan.shade100),
                          message: '${item.leaveDescription.toString()}',
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              final dynamic tooltip = key.currentState;
                              tooltip?.ensureTooltipVisible();
                            },
                            child: Icon(
                              Icons.description,
                              color: Theme.of(context).primaryColor,
                            ),
                          )),
                    ],
                  ),
                  Text(
                    item.leavetype.toString(),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  // Text(
                  //   itm[6],
                  //   style: TextStyle(
                  //     fontWeight: FontWeight.w600,
                  //     fontSize: 15,
                  //   ),
                  // ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.date_range,
                        size: 17,
                        color: Theme.of(context).primaryColor,
                      ),
                      Text(' ${item.fromDate}',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 12)),
                      // Text(' => '),
                      Icon(
                        Icons.arrow_right,
                        size: 20,
                      ),
                      Text(item.toDate.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 12)),
                    ],
                  ),
                  item.requestorPhone != ""
                      ? GestureDetector(
                          onTap: () {
                            _launchPhoneURL(item.requestorPhone.toString());
                          },
                          child: Icon(
                            Icons.phone,
                            size: 24,
                            color: Theme.of(context).primaryColor,
                          ),
                        )
                      : Container()
                ],
              ),
              item.status == "Pending"
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            acceptRejectLeave(
                              acpRej: "1",
                              todate: item.toDate,
                              fromdate: item.fromDate,
                              reqId: item.requestorId,
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(width: 0.1),
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(13)),
                            padding: EdgeInsets.all(8),
                            child: Text(
                              'Accept',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            acceptRejectLeave(
                              acpRej: "0",
                              todate: item.toDate,
                              fromdate: item.fromDate,
                              reqId: item.requestorId,
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                border: Border.all(width: 0.1),
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(13)),
                            child: Text(
                              'Reject',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container()
            ],
          ),
        );
      },
    );
  }

  Container buildMonthDropDown() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 10, top: 8, bottom: 10),
      width: MediaQuery.of(context).size.width * 0.4,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Month',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xffECECEC)),
              borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButton(
              isDense: true,
              value: selectedMonth,
              key: UniqueKey(),
              isExpanded: true,
              underline: Container(),
              items: monthItem,
              onChanged: (String? val) {
                setState(() {
                  selectedMonth = val;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Container buildYearDropDown() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 10, top: 8, bottom: 10),
      width: MediaQuery.of(context).size.width * 0.4,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Year',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xffECECEC)),
              borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButton(
              isDense: true,
              value: selectedYear,
              key: UniqueKey(),
              isExpanded: true,
              underline: Container(),
              items: yearItem,
              onChanged: (String? val) {
                setState(() {
                  selectedYear = val;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Container buildStatusDropDown() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 10, top: 8, bottom: 10),
      width: MediaQuery.of(context).size.width * 0.4,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Status',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xffECECEC)),
              borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButton(
              isDense: true,
              value: selectedStatus,
              key: UniqueKey(),
              isExpanded: true,
              underline: Container(),
              items: statusItem,
              onChanged: (String? val) {
                setState(() {
                  selectedStatus = val;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
