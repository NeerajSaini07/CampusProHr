import 'package:campus_pro/src/DATA/BLOC_CUBIT/STUDENT_HISTORY_REJACPT_EMPLOYEE_CUBIT/student_leave_pending_reject_accept_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/STUDENT_LEAVE_EMPLOYEE_HISTORY_CUBIT/student_history_employee_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/studentLeaveEmployeeHistoryModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/PAGES/EMPLOYEE_MODULE/LEAVE_EMPLOYEE/studentLeaveEmployee.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentLeave extends StatefulWidget {
  static const routeName = "/student-leave-employee-pending";
  @override
  _StudentLeaveState createState() => _StudentLeaveState();
}

class _StudentLeaveState extends State<StudentLeave> {
  String? requestorId;
  String? toDate;
  String? fromDate;

  DateTime date = DateTime.now();

  _launchPhoneURL(String phoneNumber) async {
    String url = 'tel:' + phoneNumber;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  acceptRejectLeave(
      {String? acpRej, String? todate, String? fromdate, String? reqId}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final data = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId!,
      "ToApprOrRej": acpRej.toString(),
      "ToDate": todate.toString(),
      "FromDate": fromdate.toString(),
      "RequestorId": reqId.toString(),
      "RequestorType": "S",
    };
    print("Reject Accept sending = > $data");

    context
        .read<StudentLeavePendingRejectAcceptCubit>()
        .studentLeavePendingRejectAcceptCall(data);
  }

  getStudentLeaves() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final leaveData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId!,
      "SessionId": userData.currentSessionid!,
      "Id": userData.stuEmpId,
      "ForAdmin": "2",
      "Date": DateFormat("dd MMM yyyy").format(date),
      "Status": "N",
      "Month": DateTime.now().month.toString(),
      "year": DateTime.now().year.toString(),
      "UserType": userData.ouserType,
    };
    print("Getting Leave history sending = > $leaveData");
    context
        .read<StudentHistoryLeaveEmployeeCubit>()
        .studentHistoryEmployeeCubitCall(leaveData);
  }

  @override
  void initState() {
    super.initState();
    date = DateTime.now();
    getStudentLeaves();
  }

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 1)).then((value) {
      date = DateTime.now();
      getStudentLeaves();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, title: 'Student Leaves Requests'),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: MultiBlocListener(
          listeners: [
            BlocListener<StudentLeavePendingRejectAcceptCubit,
                StudentLeavePendingRejectAcceptState>(
              listener: (context, state) {
                if (state is StudentLeavePendingRejectAcceptLoadSuccess) {
                  getStudentLeaves();
                }
                if (state is StudentLeavePendingRejectAcceptLoadFail) {
                  if (state.failReason == "false") {
                    UserUtils.unauthorizedUser(context);
                  }
                }
              },
            )
          ],
          child: SingleChildScrollView(
            child: BlocConsumer<StudentHistoryLeaveEmployeeCubit,
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
                  // return Center(child: CircularProgressIndicator());
                  return Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: LinearProgressIndicator());
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
          ),
        ),
      ),
      //buildBody(context),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushNamed(context, StudentLeaveEmployee.routeName);
          },
          label: Text(
            'History',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          backgroundColor: Theme.of(context).primaryColor),
    );
  }

  Column buildBody(BuildContext context,
      {List<StudentLeaveEmployeeHistoryModel>? LeaveList, String? error}) {
    return Column(
      children: [
        if (LeaveList == null || LeaveList.isEmpty)
          Column(
            children: [
              Center(
                child: Text(
                  error!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          )
        else
          buildLeaveList(context, LeaveList: LeaveList),
      ],
    );
  }

  ListView buildLeaveList(context,
      {List<StudentLeaveEmployeeHistoryModel>? LeaveList}) {
    return ListView.separated(
      separatorBuilder: (context, index) => SizedBox(height: 10),
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: LeaveList!.length,
      //itemCount: item.length,
      itemBuilder: (context, index) {
        var item = LeaveList[index];
        return Container(
            padding: EdgeInsets.only(left: 8, right: 8, top: 3, bottom: 3),
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xffDBDBDB)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      //item[index][0],
                      item.name.toString(),
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w900),
                    ),
                    Row(
                      children: [
                        Text(
                          item.fromDate.toString(),
                          style: TextStyle(fontSize: 15),
                        ),
                        // Text(
                        //   '  TO  ',
                        //   style: TextStyle(fontSize: 12),
                        // )
                        Icon(
                          Icons.arrow_forward_sharp,
                          size: 18,
                        ),
                        Text(
                          item.toDate.toString(),
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ],
                ),
                // SizedBox(
                //   height: MediaQuery.of(context).size.height * 0.01,
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Leave Type : ',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          item.leavetype.toString(),
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.red),
                        ),
                      ],
                    ),
                    IconButton(
                      constraints: BoxConstraints(),
                      onPressed: () {
                        _launchPhoneURL(item.requestorPhone.toString());
                      },
                      icon: Icon(
                        Icons.phone,
                        color: Theme.of(context).primaryColor,
                        size: 25,
                      ),
                    )
                    // Text(
                    //   item[index][4],
                    //   style: TextStyle(fontSize: 16),
                    // ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.16,
                      height: MediaQuery.of(context).size.height * 0.04,
                      margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.green[800],
                        border: Border.all(width: 0.3),
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: InkWell(
                        onTap: () {
                          // setState(() {
                          //   requestorId = item.requestorId.toString();
                          //   fromDate = item.fromDate;
                          //   toDate = item.toDate;
                          // });
                          // print(toDate);
                          // print(fromDate);
                          acceptRejectLeave(
                            acpRej: "1",
                            todate: item.toDate,
                            fromdate: item.fromDate,
                            reqId: item.requestorId,
                          );
                          //Future.delayed(Duration(seconds: 2));
                        },
                        child: Center(
                          child: Text(
                            'Accept',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.16,
                      height: MediaQuery.of(context).size.height * 0.04,
                      margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        border: Border.all(width: 0.3),
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            requestorId = item.requestorId.toString();
                            fromDate = item.fromDate;
                            toDate = item.toDate;
                          });
                          acceptRejectLeave(
                            acpRej: "0",
                            todate: toDate,
                            fromdate: fromDate,
                            reqId: requestorId,
                          );
                          //getStudentLeaves();
                        },
                        child: Center(
                            child: Text(
                          'Reject',
                          style: TextStyle(color: Colors.white),
                        )),
                      ),
                    ),
                  ],
                )
              ],
            ));
        //return buildMyCard(context, leaveRequestList: item);
      },
    );
  }

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
      textScaleFactor: 1.2,
      style: TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
