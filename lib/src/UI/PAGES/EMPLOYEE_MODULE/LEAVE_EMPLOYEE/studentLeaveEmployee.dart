import 'package:campus_pro/src/DATA/BLOC_CUBIT/STUDENT_LEAVE_EMPLOYEE_CUBIT/student_leave_employee_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/studentLeaveEmployeeModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/WIDGETS_STYLE/style_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';

class StudentLeaveEmployee extends StatefulWidget {
  static const routeName = "/student-leave-employee";
  @override
  _StudentLeaveEmployeeState createState() => _StudentLeaveEmployeeState();
}

DateTime selectedFromDate = DateTime.now();
DateTime selectedToDate = DateTime.now().add(
  (Duration(days: 1)),
);

class _StudentLeaveEmployeeState extends State<StudentLeaveEmployee> {
  getStudentLeaves(String? onLoad) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final LeaveData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId!,
      "RequesterType": "S",
      "LeaveRequestDate": DateFormat("dd MMM yyyy").format(selectedFromDate),
      "ToDate": DateFormat("dd MMM yyyy").format(selectedToDate),
    };
    print("sending student Data $LeaveData");
    context
        .read<StudentLeaveEmployeeCubit>()
        .studentLeaveEmployeeCubitCall(LeaveData);
  }

  _launchPhoneURL(String phoneNumber) async {
    String url = 'tel:' + phoneNumber;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _selectDate(BuildContext context, {int? index}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedFromDate,
      firstDate: DateTime(1990),
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
    super.initState();
    getStudentLeaves("1");
  }

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 1)).then((value) {
      getStudentLeaves("1");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: commonAppBar(context, title: 'Student Leaves History'),
        body: RefreshIndicator(
          onRefresh: _refresh,
          child: BlocConsumer<StudentLeaveEmployeeCubit, LeaveEmployeeState>(
            listener: (context, state) {
              if (state is LeaveEmployeeLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                }
              }
            },
            builder: (context, state) {
              if (state is LeaveEmployeeLoadInProgress) {
                return Center(child: CircularProgressIndicator());
                //return Container();
              } else if (state is LeaveEmployeeLoadSuccess) {
                return buildBody(context, LeaveList: state.LeaveList);
              } else if (state is LeaveEmployeeLoadFail) {
                return buildBody(context, error: state.failReason);
              } else {
                return Center(
                  //child: CircularProgressIndicator(),
                  child: Container(),
                );
              }
            },
          ),
        )
        //buildBody(context),
        );
  }

  Column buildBody(BuildContext context,
      {List<StudentLeaveEmployeeModel>? LeaveList, String? error}) {
    return Column(
      children: [
        buildTopDatePicker(),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.025,
        ),
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.3,
            height: MediaQuery.of(context).size.height * 0.05,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: InkWell(
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () {
                print('test');
                getStudentLeaves("1");
              },
              child: Center(
                child: Text(
                  'Get Details',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.width * 0.07,
        ),
        if (LeaveList == null || LeaveList.isEmpty)
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon(
                //   Icons.table_chart_outlined,
                //   color: Colors.grey,
                //   size: 80,
                // ),
                Text(
                  error!,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          )
        else
          buildLeaveList(context, LeaveList: LeaveList),
      ],
    );
  }

  Container buildTopDatePicker() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildLabels("Start Date"),
                SizedBox(height: 8),
                buildDateSelector(
                  index: 0,
                  selectedDate:
                      DateFormat("dd MMM yyyy").format(selectedFromDate),
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
                  selectedDate:
                      DateFormat("dd MMM yyyy").format(selectedToDate),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Expanded buildLeaveList(context,
      {List<StudentLeaveEmployeeModel>? LeaveList}) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(
          height: 3,
        ),
        itemCount: LeaveList!.length,
        itemBuilder: (context, index) {
          var item = LeaveList[index];
          return Container(
            //padding: const EdgeInsets.symmetric(vertical: 0.0),
            margin: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 6),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xffDBDBDB)),
            ),
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item.name!,
                    //leaveRequestList[0],
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _launchPhoneURL(item.requestorPhone!);
                    },
                    icon: Icon(
                      Icons.phone,
                      color: Theme.of(context).primaryColor,
                      size: 20,
                    ),
                  )
                ],
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildText(
                          title: "${item.fromDate!} "
                              "- ${item.toDate!}"),
                      buildText(title: "Leave Type : ${item.leaveDayType}"),
                    ],
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                        color: item.leaveStatus!.toLowerCase() == 'accepted'
                            ? Colors.green[800]
                            : item.leaveStatus!.toLowerCase() == 'pending'
                                ? Color.fromRGBO(250, 196, 47, 1.0)
                                : Colors.red,
                        borderRadius: BorderRadius.circular(4.0)),
                    child: Row(
                      children: [
                        Icon(
                          item.leaveStatus!.toLowerCase() == 'accepted'
                              ? Icons.check
                              : item.leaveStatus!.toLowerCase() == 'pending'
                                  ? Icons.pending
                                  : Icons.close,
                          color: Colors.white,
                          size: 16,
                        ),
                        SizedBox(width: 4),
                        Text(
                          item.leaveStatus!,
                          textScaleFactor: 1.5,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
          //return buildMyCard(context, leaveRequestList: item);
        },
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
      //         width: MediaQuery.of(context).size.width / 4,
      //         child: Text(
      //           selectedDate!,
      //           overflow: TextOverflow.visible,
      //           maxLines: 1,
      //         ),
      //       ),
      //       Icon(Icons.today, color: Theme.of(context).primaryColor)
      //     ],
      //   ),
      // ),
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

  // Container buildMyCard(BuildContext context, {leaveRequestList}) {
  //   return Container(
  //     //padding: const EdgeInsets.symmetric(vertical: 0.0),
  //     margin: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 6),
  //     decoration: BoxDecoration(
  //       border: Border.all(color: Color(0xffDBDBDB)),
  //     ),
  //     child: ListTile(
  //       title: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //       Text(leaveRequestList
  //       //leaveRequestList[0],
  //       style: TextStyle(
  //       color: Colors.black,
  //         fontWeight: FontWeight.bold,
  //       ),
  //     ),
  //     IconButton(
  //       onPressed: () {
  //         _launchPhoneURL(leaveRequestList[5]);
  //       },
  //       icon: Icon(
  //         Icons.phone,
  //         color: Theme.of(context).primaryColor,
  //         size: 20,
  //       ),
  //     )
  //     ],
  //   ),
  //   subtitle: Row(
  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //   children: [
  //   Column(
  //   crossAxisAlignment: CrossAxisAlignment.start,
  //   children: [
  //   buildText(
  //   title: "${leaveRequestList[1]} "
  //   "- ${leaveRequestList[2]!}"),
  //   buildText(title: "Allowed for : ${leaveRequestList[3]}"),
  //   ],
  //   ),
  //   Container(
  //   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
  //   decoration: BoxDecoration(
  //   color: leaveRequestList[4] == 'accepted'
  //   ? Colors.green[800]
  //       : leaveRequestList[4] == 'pending'
  //   ? Color.fromRGBO(250, 196, 47, 1.0)
  //       : Colors.red,
  //   borderRadius: BorderRadius.circular(4.0)),
  //   child: Row(
  //   children: [
  //   Icon(
  //   leaveRequestList[4] == 'accepted'
  //   ? Icons.check
  //       : leaveRequestList[4] == 'pending'
  //   ? Icons.pending
  //       : Icons.close,
  //   color: Colors.white,
  //   size: 16,
  //   ),
  //   SizedBox(width: 4),
  //   Text(
  //   leaveRequestList[4],
  //   textScaleFactor: 1.5,
  //   style: TextStyle(
  //   color: Colors.white,
  //   fontWeight: FontWeight.w600,
  //   fontSize: 10),
  //   ),
  //   ],
  //   ),
  //   ),
  //   ],
  //   ),
  //   ),
  //   );
  // }

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
