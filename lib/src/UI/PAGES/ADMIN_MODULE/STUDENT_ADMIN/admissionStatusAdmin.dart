import 'package:campus_pro/src/DATA/BLOC_CUBIT/ADMISSION_STATUS_CUBIT/admission_status_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/YEAR_SESSION_CUBIT/year_session_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/admissionStatusModel.dart';
import 'package:campus_pro/src/DATA/MODELS/yearSessionModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/WIDGETS/CHARTS/barPieCommonChart.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/drawerWidget.dart';
import 'package:campus_pro/src/UI/WIDGETS/noRecordFound.dart';
import 'package:campus_pro/src/UI/WIDGETS/sessionCreator.dart';
import 'package:campus_pro/src/UTILS/appImages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class AdmissionStatusAdmin extends StatefulWidget {
  static const routeName = "/admission-status-admin";
  @override
  _AdmissionStatusAdminState createState() => _AdmissionStatusAdminState();
}

class _AdmissionStatusAdminState extends State<AdmissionStatusAdmin> {
  List<CommonListGraph> scholarTodayAdmissionList = [];
  List<CommonListGraph> hostelerTodayAdmissionList = [];
  List<CommonListGraph> studentStrengthList = [];
  List<CommonListGraph> preStudentStrengthList = [];

  String? totalDayScholar = "0";
  String? totalHosteler = "0";

  YearSessionModel? selectedYear;
  List<YearSessionModel>? yearDropdown = [];

  @override
  void initState() {
    preStudentStrengthList = [];
    getSession();
    // getAdmissionStatusData();
    super.initState();
  }

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

  getAdmissionStatusData() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final statusData = {
      'OUserId': uid,
      'Token': token,
      'OrgId': userData!.organizationId,
      'Schoolid': userData.schoolId,
      'SessionId': selectedYear!.id,
      'EmpId': userData.stuEmpId,
      'UserType': userData.ouserType,
    };
    print("Sending AdmissionStatus Data => $statusData");
    context.read<AdmissionStatusCubit>().admissionStatusCubitCall(statusData);
  }

  setStudentStrengthData(AdmissionStatusModel? status) {
    setState(() {
      int length = 9;
      // int length = examAnalysisChartData![0].marks!.split(",").length;
      print('examAnalysisList length $length');

      List<CommonListGraph> studentStrengthChartData = [];

      studentStrengthChartData.add(CommonListGraph(
          iD: 0,
          title: "Day Scholar",
          value: double.parse(status!.lbltotalstudent!)));
      studentStrengthChartData.add(CommonListGraph(
          iD: 0,
          title: "Hosteler",
          value: double.parse(status.lbltotalhostel!)));
      studentStrengthChartData.add(CommonListGraph(
          iD: 0,
          title: "All",
          value: double.parse(status.txtalldayscholarhostalr!)));

      studentStrengthChartData.add(CommonListGraph(
          iD: 1,
          title: "Day Scholar",
          value: double.parse(status.lblnewadsession!)));
      studentStrengthChartData.add(CommonListGraph(
          iD: 1,
          title: "Hosteler",
          value: double.parse(status.lblnewhsession!)));
      studentStrengthChartData.add(CommonListGraph(
          iD: 1,
          title: "All",
          value: double.parse(status.txtalldayschoarhostalrnew!)));

      studentStrengthChartData.add(CommonListGraph(
          iD: 2,
          title: "Day Scholar",
          value: double.parse(status.lblreaddsession!)));
      studentStrengthChartData.add(CommonListGraph(
          iD: 2,
          title: "Hosteler",
          value: double.parse(status.lblrehsession!)));
      studentStrengthChartData.add(CommonListGraph(
          iD: 2,
          title: "All",
          value: double.parse(status.txtalldayschoarhostalrold!)));

      studentStrengthList = [];

      for (int i = 0; i < length; i++) {
        studentStrengthList.add(
          CommonListGraph(
            iD: studentStrengthChartData[i].iD,
            title: studentStrengthChartData[i].title,
            value: studentStrengthChartData[i].value,
            color: Colors.blue,
          ),
        );
      }
      print('studentStrengthList Final List => $studentStrengthList');
    });
  }

  setPreStudentStrengthData(AdmissionStatusModel? status) {
    setState(() {
      int length = 9;
      // int length = examAnalysisChartData![0].marks!.split(",").length;
      print('examAnalysisList length $length');

      List<CommonListGraph> studentStrengthChartData = [];

      studentStrengthChartData.add(CommonListGraph(
          iD: 0,
          title: "Day Scholar",
          value: double.parse(status!.lblpreyeartotal!)));
      studentStrengthChartData.add(CommonListGraph(
          iD: 0,
          title: "Hosteler",
          value: double.parse(status.lblpreyearhosteler!)));
      studentStrengthChartData.add(CommonListGraph(
          iD: 0,
          title: "All",
          value: double.parse(status.txttotalpreyearhosteler!)));

      studentStrengthChartData.add(CommonListGraph(
          iD: 1,
          title: "Day Scholar",
          value: double.parse(status.lblpreyearnew!)));
      studentStrengthChartData.add(CommonListGraph(
          iD: 1,
          title: "Hosteler",
          value: double.parse(status.lblpreyearhostelernew!)));
      studentStrengthChartData.add(CommonListGraph(
          iD: 1,
          title: "All",
          value: double.parse(status.txttotalpreyearhostelernew!)));

      studentStrengthChartData.add(CommonListGraph(
          iD: 2,
          title: "Day Scholar",
          value: double.parse(status.lblpreyearold!)));
      studentStrengthChartData.add(CommonListGraph(
          iD: 2,
          title: "Hosteler",
          value: double.parse(status.lblpreyearhostelerold!)));
      studentStrengthChartData.add(CommonListGraph(
          iD: 2,
          title: "All",
          value: double.parse(status.txttotalpreyearhostelerold!)));

      preStudentStrengthList = [];

      for (int i = 0; i < length; i++) {
        preStudentStrengthList.add(
          CommonListGraph(
            iD: studentStrengthChartData[i].iD,
            title: studentStrengthChartData[i].title,
            value: studentStrengthChartData[i].value,
            color: Colors.blue,
          ),
        );
      }
      print('studentStrengthList Final List => $studentStrengthList');
    });
  }

  setTodayAdmissionData(AdmissionStatusModel? status) {
    setState(() {
      int length = 9;
      // int length = examAnalysisChartData![0].marks!.split(",").length;
      print('examAnalysisList length $length');

      List<CommonListGraph> studentStrengthChartData = [];

      studentStrengthChartData.add(CommonListGraph(
          iD: 0,
          title: "Day Scholar",
          value: double.parse(status!.txttotaloldtoday!)));
      studentStrengthChartData.add(CommonListGraph(
          iD: 0,
          title: "Hosteler",
          value: double.parse(status.txttotaloldtoday!)));
      studentStrengthChartData.add(CommonListGraph(
          iD: 0, title: "All", value: double.parse(status.txttotaloldtoday!)));

      studentStrengthChartData.add(CommonListGraph(
          iD: 1,
          title: "Day Scholar",
          value: double.parse(status.txttotaloldtoday!)));
      studentStrengthChartData.add(CommonListGraph(
          iD: 1,
          title: "Hosteler",
          value: double.parse(status.txttotaloldtoday!)));
      studentStrengthChartData.add(CommonListGraph(
          iD: 1, title: "All", value: double.parse(status.txttotaloldtoday!)));

      for (int i = 0; i < 3; i++) {
        scholarTodayAdmissionList.add(
          CommonListGraph(
            iD: studentStrengthChartData[i].iD,
            title: studentStrengthChartData[i].title,
            value: studentStrengthChartData[i].value,
            color: Colors.blue,
          ),
        );
      }
      for (int i = 3; i < 6; i++) {
        hostelerTodayAdmissionList.add(
          CommonListGraph(
            iD: studentStrengthChartData[i].iD,
            title: studentStrengthChartData[i].title,
            value: studentStrengthChartData[i].value,
            color: Colors.blue,
          ),
        );
      }
      print('studentStrengthList Final List => $studentStrengthList');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: commonAppBar(context, title: "Admission Status"),
      body: MultiBlocListener(
        listeners: [
          BlocListener<YearSessionCubit, YearSessionState>(
            listener: (context, state) {
              if (state is YearSessionLoadSuccess) {
                final session = getCustomYear();
                setState(() {
                  yearDropdown = state.yearSessionList;
                  Future.delayed(Duration(microseconds: 300));
                  setState(() {
                    yearDropdown = state.yearSessionList;
                    final index = yearDropdown!.indexWhere(
                        (element) => element.sessionFrom == session);
                    selectedYear = yearDropdown![index];
                    print("yearDropdown![index] : ${yearDropdown![index]}");
                  });
                });
                getAdmissionStatusData();
              }
              if (state is YearSessionLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                } else {
                  setState(() {
                    yearDropdown = [];
                    selectedYear = null;
                  });
                }
              }
            },
          ),
        ],
        child: BlocConsumer<AdmissionStatusCubit, AdmissionStatusState>(
          listener: (context, state) {
            if (state is AdmissionStatusLoadSuccess) {
              setState(() {
                totalDayScholar = state.admissionStatus.lbloldpending;
                totalHosteler = state.admissionStatus.lbloldpendinghos;
              });
              setTodayAdmissionData(state.admissionStatus);
              setStudentStrengthData(state.admissionStatus);
              setPreStudentStrengthData(state.admissionStatus);
            }
          },
          builder: (context, state) {
            if (state is AdmissionStatusLoadInProgress) {
              // return Center(child: CircularProgressIndicator());
              return Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: LinearProgressIndicator());
            } else if (state is AdmissionStatusLoadSuccess) {
              return buildAdmissionBody(context);
            } else if (state is AdmissionStatusLoadFail) {
              return noRecordFound();
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Column buildAdmissionBody(BuildContext context) {
    return Column(
      children: [
        buildYearSessionDropdown(),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildChartColorLabel("Total", Colors.blue.withOpacity(0.5)),
              buildChartColorLabel("New", Colors.green.withOpacity(0.5)),
              buildChartColorLabel("Old", Colors.deepOrange.withOpacity(0.5)),
            ],
          ),
        ),
        Expanded(
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.only(bottom: 12.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width,
                          color: Colors.blue.withOpacity(0.06),
                          child: Text(
                            "Today's Admission",
                            // "Today's Online Classes",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            BarPieCommonChart(
                              width: MediaQuery.of(context).size.width / 2.5,
                              height: MediaQuery.of(context).size.width / 2.5,
                              subjectName: "",
                              chartType: 'label pie chart',
                              // color: Colors.red[200],
                              graphTitle: 'Day Scholar',
                              commonDataList: scholarTodayAdmissionList,
                            ),
                            BarPieCommonChart(
                              width: MediaQuery.of(context).size.width / 2.5,
                              height: MediaQuery.of(context).size.width / 2.5,
                              subjectName: "",
                              chartType: 'label pie chart',
                              // color: Colors.red[200],
                              graphTitle: 'Hosteler',
                              commonDataList: hostelerTodayAdmissionList,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.only(bottom: 12.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width,
                          color: Colors.blue.withOpacity(0.06),
                          child: Text(
                            "Pending Readmissions",
                            // "Today's Online Classes",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            buildReadmission(
                                title: "Day Scholar",
                                value: totalDayScholar,
                                index: 0),
                            buildReadmission(
                                title: "Hosteler",
                                value: totalHosteler,
                                index: 1),
                          ],
                        )
                        // BarPieCommonChart(
                        //   subjectName: "",
                        //   chartType: 'label pie chart',
                        //   // color: Colors.red[200],
                        //   graphTitle: 'Day Scholar',
                        //   commonDataList: studentStrengthList,
                        // ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.only(bottom: 12.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width,
                          color: Colors.blue.withOpacity(0.06),
                          child: Text(
                            "Student Strength",
                            // "Today's Online Classes",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                        ),
                        studentStrengthList.length > 0
                            ? BarPieCommonChart(
                                subjectName: "Day Scholar,Hosteler,All",
                                chartType: 'bar chart admission',
                                // color: Colors.red[200],
                                // graphTitle: 'Last 7 Days Enquiry',
                                commonDataList: studentStrengthList,
                              )
                            : Container()
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.only(bottom: 12.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width,
                          color: Colors.blue.withOpacity(0.06),
                          child: Text(
                            "Pre Year Student Strength",
                            // "Today's Online Classes",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                        ),
                        preStudentStrengthList.length > 0
                            ? BarPieCommonChart(
                                subjectName: "Day Scholar,Hosteler,All",
                                chartType: 'bar chart admission',
                                // color: Colors.red[200],
                                // graphTitle: 'Last 7 Days Enquiry',
                                commonDataList: preStudentStrengthList,
                              )
                            : Container()
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Container buildYearSessionDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          // buildLabels("Session"),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
              // borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButton<YearSessionModel>(
              isDense: true,
              value: selectedYear,
              key: UniqueKey(),
              isExpanded: true,
              underline: Container(),
              items: yearDropdown!
                  .map((item) => DropdownMenuItem<YearSessionModel>(
                      child: Text(item.sessionFrom!,
                          style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold)),
                      value: item))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  selectedYear = val;
                  print("selectedYear: $val");
                  getAdmissionStatusData();
                });
                // getExamSelected();
              },
            ),
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }

  Row buildChartColorLabel(String? label, Color? color) {
    return Row(
      children: [
        Container(
          height: 20,
          width: 20,
          color: color,
        ),
        SizedBox(width: 8),
        Text(
          label!,
          textScaleFactor: 1.0,
          style: GoogleFonts.quicksand(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ],
    );
  }

  Expanded buildReadmission({String? title, String? value, int? index}) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            right: index == 0
                ? BorderSide(width: 1, color: Colors.black12)
                : BorderSide.none,
            left: index == 1
                ? BorderSide(width: 1, color: Colors.black12)
                : BorderSide.none,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppImages.lineChartImage,
              width: 40,
              color: index == 0 ? Colors.blue : Colors.purple,
            ),
            Text(
              value!,
              textScaleFactor: 1.0,
              style: GoogleFonts.quicksand(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            Text(title!,
                textScaleFactor: 1.0,
                style: GoogleFonts.quicksand(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                )),
          ],
        ),
      ),
    );
  }
}
