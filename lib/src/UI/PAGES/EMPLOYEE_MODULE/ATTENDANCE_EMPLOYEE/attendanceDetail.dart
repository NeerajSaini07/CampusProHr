import 'package:campus_pro/src/DATA/BLOC_CUBIT/ATTENDANCE_DETAIL_CUBIT/attendance_detail_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/MARK_ATTENDANCE_PERIOD_EMPLOYEE_CUBIT/mark_attendance_employee_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/attendanceDetailModel.dart';
import 'package:campus_pro/src/DATA/MODELS/markAttendacePeriodsEmployeeModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AttendanceDetail extends StatefulWidget {
  final classId;
  final classSection;
  final date;
  static const routeName = 'attendance-detail';
  const AttendanceDetail({this.classId, this.classSection, this.date});

  @override
  _AttendanceDetailState createState() => _AttendanceDetailState();
}

class _AttendanceDetailState extends State<AttendanceDetail> {
  MarkAttendacePeriodsEmployeeModel? selectedPeriod;
  List<MarkAttendacePeriodsEmployeeModel>? periodItem;
  String? periodId;

  List<AttendanceDetailModel>? studentList;
  _launchPhoneURL(String phoneNumber) async {
    String url = 'tel:' + phoneNumber;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  getEmployeePeriod({String? classid}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final getEmpPeriodData = {
      "OUserId": uid!,
      "Token": token!,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "SessionId": userData.currentSessionid,
      "EmpID": userData.stuEmpId,
      "ClassIds": classid.toString(),
      'UserType': userData.ouserType,
    };

    print('Get Employee Periods $getEmpPeriodData');

    context
        .read<MarkAttendancePeriodsEmployeeCubit>()
        .markAttendancePeriodsEmployeeCubitCall(getEmpPeriodData, 0);
  }

  getPeriodStudentList({
    String? classid,
    String? periodid,
    String? date,
  }) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final getEmpPeriodData = {
      "OUserId": uid!,
      "Token": token!,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "SessionId": userData.currentSessionid,
      "ClassId": classid.toString(),
      "Date": date.toString(),
      "PeriodId": periodid.toString(),
    };
    print('Get attendance Detail $getEmpPeriodData');
    context
        .read<AttendanceDetailCubit>()
        .attendanceDetailCubitCall(getEmpPeriodData);
  }

  @override
  void initState() {
    super.initState();
    selectedPeriod = MarkAttendacePeriodsEmployeeModel(
        periodid: "", periodname: "", periodtype: "", durationmin: "");
    periodItem = [];
    getEmployeePeriod(classid: widget.classId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, title: 'Student Attendance'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // buildPeriodDropDown(),
          Row(
            children: [
              BlocConsumer<MarkAttendancePeriodsEmployeeCubit,
                  MarkAttendanceEmployeeState>(
                listener: (context, state) {
                  if (state is MarkAttendanceEmployeeLoadSuccess) {
                    setState(() {
                      //Todo
                      var selectPeriod = MarkAttendacePeriodsEmployeeModel(
                          periodid: "",
                          periodname: "All",
                          periodtype: "",
                          durationmin: "");
                      state.periodList.add(selectPeriod);
                      selectedPeriod = selectPeriod;
                      //Todo
                      periodItem = state.periodList;
                      //selectedPeriod = state.periodList[0];
                      periodId = state.periodList[0].periodid;
                    });
                    getPeriodStudentList(
                        classid: widget.classId,
                        periodid: '0',
                        date: widget.date);
                  }
                  if (state is MarkAttendanceEmployeeLoadFail) {
                    if (state.failReason == "false") {
                      UserUtils.unauthorizedUser(context);
                    }
                    setState(() {
                      selectedPeriod = MarkAttendacePeriodsEmployeeModel(
                          periodid: "",
                          periodname: "",
                          periodtype: "",
                          durationmin: "");
                      periodItem = [];
                    });
                  }
                },
                builder: (context, state) {
                  if (state is MarkAttendanceEmployeeLoadInProgress) {
                    //return CircularProgressIndicator();
                    return buildPeriodDropDown();
                  } else if (state is MarkAttendanceEmployeeLoadSuccess) {
                    return buildPeriodDropDown();
                  }
                  // else if (state is MarkAttendanceEmployeeLoadFail) {
                  //   return buildPeriodDropDown();
                  //}
                  else {
                    return Container();
                  }
                },
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.1,
              ),
              Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.055,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.02,
                    width: MediaQuery.of(context).size.width * 0.13,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        // status == ''
                        //     ? Colors.white
                        //     : status == 'Y'
                        //     ? Colors.green
                        //     : status == 'N'
                        //     ? Colors.red
                        //     : Colors.orange,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black)),
                    child: Text(
                      '',
                    ),
                  ),
                  Text('Present')
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.055,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.02,
                    width: MediaQuery.of(context).size.width * 0.13,
                    decoration: BoxDecoration(
                        color: Colors.orange,
                        // status == ''
                        //     ? Colors.white
                        //     : status == 'Y'
                        //     ? Colors.green
                        //     : status == 'N'
                        //     ? Colors.red
                        //     : Colors.orange,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black)),
                    child: Text(
                      '',
                    ),
                  ),
                  Text('Leave')
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.055,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.02,
                    width: MediaQuery.of(context).size.width * 0.13,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        // status == ''
                        //     ? Colors.white
                        //     : status == 'Y'
                        //     ? Colors.green
                        //     : status == 'N'
                        //     ? Colors.red
                        //     : Colors.orange,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black)),
                    child: Text(
                      '',
                    ),
                  ),
                  Text('Absent')
                ],
              ),
            ],
          ),
          Divider(
            thickness: 4,
          ),
          Center(
            child: Container(
              child: Text(
                'Class/Section :- ${widget.classSection.toString()}',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
            ),
          ),
          Divider(
            thickness: 4,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          BlocConsumer<AttendanceDetailCubit, AttendanceDetailState>(
            listener: (context, state) {
              if (state is AttendanceDetailLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                }
              }
              if (state is AttendanceDetailLoadSuccess) {
                studentList = state.attendanceDetailList;
              }
            },
            builder: (context, state) {
              if (state is AttendanceDetailLoadInProgress) {
                // return Center(child: CircularProgressIndicator());
                return LinearProgressIndicator();
              } else if (state is AttendanceDetailLoadSuccess) {
                return checkStudentList(stuList: studentList);
              } else if (state is AttendanceDetailLoadFail) {
                return checkStudentList(error: state.failReason);
              } else {
                return Container();
              }
            },
          ),
          //Expanded(child: buildPeriodList()),
        ],
      ),
    );
  }

  Expanded checkStudentList(
      {List<AttendanceDetailModel>? stuList, String? error}) {
    if (stuList == null || stuList.isEmpty || stuList.length == 0) {
      if (error != null) {
        return Expanded(
          child: Center(
            child: Text(
              "$error",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      } else {
        return Expanded(
          child: Center(
            child: Text("Wait"),
          ),
        );
      }
    } else {
      return buildPeriodList(stuList: stuList);
    }
  }

  Expanded buildPeriodList({List<AttendanceDetailModel>? stuList}) {
    return Expanded(
      child: ListView.separated(
        shrinkWrap: true,
        separatorBuilder: (context, index) => SizedBox(
          height: 10,
        ),
        itemCount: stuList!.length,
        itemBuilder: (context, index) {
          var item = stuList[index];
          print(item.status2);
          return Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              border: Border.all(width: 0.2),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            '${item.onlyAdmNo}',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w900),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.02,
                          ),
                          Flexible(
                            child: Text(
                              '${item.onlyName!.toUpperCase()}',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.01,
                          ),
                          Flexible(
                            child: Text(
                              '(${item.fatherName!.toUpperCase()})',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),
                    item.guardianMobileNo != ''
                        ? IconButton(
                            padding: EdgeInsets.all(0),
                            constraints: BoxConstraints(),
                            //splashColor: Colors.transparent,
                            onPressed: () {
                              _launchPhoneURL(
                                  item.guardianMobileNo!.toString());
                            },
                            icon: Icon(
                              Icons.phone,
                              size: 18,
                              color: Theme.of(context).primaryColor,
                            ),
                          )
                        : IconButton(
                            padding: EdgeInsets.all(0),
                            constraints: BoxConstraints(),
                            //splashColor: Colors.transparent,
                            onPressed: () {
                              //_launchPhoneURL(item.guardianMobileNo!.toString());
                            },
                            icon: Icon(
                              Icons.phone,
                              size: 18,
                              color: Theme.of(context).primaryColor,
                            ),
                          )
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildStatusColor(context,
                        status: item.status1, date: item.status1Date),
                    buildStatusColor(context,
                        status: item.status2, date: item.status2Date),
                    buildStatusColor(context,
                        status: item.status3, date: item.status3Date),
                    buildStatusColor(context,
                        status: item.status4, date: item.status4Date),
                    buildStatusColor(context,
                        status: item.status5, date: item.status5Date),
                    buildStatusColor(context,
                        status: item.status6, date: item.status6Date),
                    buildStatusColor(context,
                        status: item.status7, date: item.status7Date),
                    // buildStatusColor(context, item[3]),
                    // buildStatusColor(context, item[4] != '' ? item[4] : ''),
                    // buildStatusColor(context, item[5]),
                    // buildStatusColor(context, item[3]),
                    // buildStatusColor(context, item[3]),
                    // buildStatusColor(context, item[3]),
                    // buildStatusColor(context, item[3]),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Column buildStatusColor(BuildContext context,
      {String? status, String? date}) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.02,
          width: MediaQuery.of(context).size.width * 0.13,
          decoration: BoxDecoration(
              color: status == ''
                  ? Colors.white
                  : status == 'Y'
                      ? Colors.green
                      : status == 'N'
                          ? Colors.red
                          : Colors.orange,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black)),
          child: Text(
            '',
          ),
        ),
        Text(
          '${date}',
          style: TextStyle(fontSize: 11),
        ),
      ],
    );
  }

  Container buildPeriodDropDown() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 13, horizontal: 13),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Period :',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.35,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xffECECEC)),
              // borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButton<MarkAttendacePeriodsEmployeeModel>(
              isDense: true,
              value: selectedPeriod,
              key: UniqueKey(),
              isExpanded: true,
              underline: Container(),
              items: periodItem!
                  .map((itm) =>
                      DropdownMenuItem<MarkAttendacePeriodsEmployeeModel>(
                          value: itm,
                          child: Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text(
                              itm.periodname!,
                              style: TextStyle(
                                  fontSize: 15.0, fontWeight: FontWeight.w300),
                            ),
                          )))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  selectedPeriod = val;
                });
                setState(() {
                  if (val!.periodname == 'All') {
                    periodId = '0';
                  } else {
                    periodId = val.periodid;
                  }
                });
                getPeriodStudentList(
                    classid: widget.classId,
                    periodid: periodId,
                    date: widget.date);
              },
            ),
          ),
        ],
      ),
    );
  }
}
