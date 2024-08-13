import 'dart:math';

import 'package:campus_pro/src/DATA/BLOC_CUBIT/DASHBOARD_ENQUIRY_CUBIT/dashboard_enquiry_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/dashboardEnquiryModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/WIDGETS/CHARTS/barPieCommonChart.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardEnquiry extends StatefulWidget {
  const DashboardEnquiry({Key? key}) : super(key: key);

  @override
  _DashboardEnquiryState createState() => _DashboardEnquiryState();
}

class _DashboardEnquiryState extends State<DashboardEnquiry> {
  GetDashBoardDeatils? todayEnquiryPieChartData;
  List<WeekChartData>? weekBarChartData = [];
  List<MonthlyChartData>? monthlyBarChartData = [];
  List<HowPeopleReachus>? howPeopleReachusData = [];
  GetDashBoardDeatils? statusOfEnquiryData;

  List<CommonListGraph> enquiryList = [];
  List<CommonListGraph> weekDaysList = [];
  List<CommonListGraph> monthList = [];

  @override
  void initState() {
    getDashboardCharts();
    super.initState();
  }

  getDashboardCharts() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userType = await UserUtils.userTypeFromCache();
    final dashboardEnquiryData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userType!.organizationId,
      "Schoolid": userType.schoolId,
      "Flag": "All",
    };
    print("Sending DashboardEnquiry Data => $dashboardEnquiryData");
    context
        .read<DashboardEnquiryCubit>()
        .dashboardEnquiryCubitCall(dashboardEnquiryData);
  }

  setEnquiryListData() {
    enquiryList.add(
      CommonListGraph(
        title: "Email",
        value:
            double.parse(todayEnquiryPieChartData!.chart1Data!.split(',')[0]),
        color: Colors.red[200],
      ),
    );
    enquiryList.add(
      CommonListGraph(
        title: "Phone",
        value:
            double.parse(todayEnquiryPieChartData!.chart1Data!.split(',')[1]),
        color: Colors.blue[200],
      ),
    );
    enquiryList.add(
      CommonListGraph(
        title: "Visitors",
        value:
            double.parse(todayEnquiryPieChartData!.chart1Data!.split(',')[2]),
        color: Colors.orange[200],
      ),
    );
    enquiryList.add(
      CommonListGraph(
        title: "Online",
        value:
            double.parse(todayEnquiryPieChartData!.chart1Data!.split(',')[3]),
        color: Colors.green[200],
      ),
    );
    print("enquiryList : $enquiryList");
    setState(() {
      enquiryList = enquiryList;
    });
  }

  setMonthlyBarListData() {
    int length = monthlyBarChartData![0].monthName!.split(",").length;
    print('monthlyBarChartData length $length');
    for (int i = 0; i < length; i++) {
      monthList.add(
        CommonListGraph(
          title:
              monthlyBarChartData![0].monthName!.split(",")[i].substring(0, 3),
          value: double.parse(
              monthlyBarChartData![0].monthTotalEnquiry!.split(",")[i]),
          color: Colors.blue[200],
        ),
      );
    }
    // print("month list ${monthList}");
    setState(() {
      monthList = monthList;
    });
  }

  setWeekBarListData() {
    int length = weekBarChartData![0].dayName!.split(",").length;
    print('weekBarChartData length $length');
    for (int i = 0; i < length; i++) {
      weekDaysList.add(
        CommonListGraph(
          title: weekBarChartData![0].dayName!.split(",")[i],
          value: double.parse(weekBarChartData![0].totalEnquiry!.split(",")[i]),
          color: Colors.red[200],
        ),
      );
    }
    print('weekDaysList List : $weekDaysList');
    setState(() {
      weekDaysList = weekDaysList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocConsumer<DashboardEnquiryCubit, DashboardEnquiryState>(
        listener: (context, state) {
          if (state is DashboardEnquiryLoadFail) {
            if (state.failReason == "false") {
              UserUtils.unauthorizedUser(context);
            }
          }
          if (state is DashboardEnquiryLoadSuccess) {
            setState(() {
              final chartData = state.dashboardEnquiryData.data;
              todayEnquiryPieChartData = chartData!.getDashBoardDeatils![0];
              weekBarChartData = chartData.weekChartData;
              monthlyBarChartData = chartData.monthlyChartData;
              howPeopleReachusData = chartData.howPeopleReachus;
              statusOfEnquiryData = chartData.getDashBoardDeatils![0];
            });
            Future.delayed(Duration(seconds: 0)).then((value) {
              setEnquiryListData();
              setWeekBarListData();
              setMonthlyBarListData();
            });
          }
        },
        builder: (context, state) {
          if (state is DashboardEnquiryLoadInProgress) {
            // return Center(child: CircularProgressIndicator());
            return Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: LinearProgressIndicator());
          } else if (state is DashboardEnquiryLoadSuccess) {
            return buildDashboardEnquiryBody(context);
          } else if (state is DashboardEnquiryLoadFail) {
            return buildDashboardEnquiryBody(context);
          } else {
            // return Center(child: CircularProgressIndicator());
            return Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: LinearProgressIndicator());
          }
        },
      ),
    );
  }

  ListView buildDashboardEnquiryBody(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        enquiryList.length > 0
            ? BarPieCommonChart(
                subjectName: "",
                chartType: 'pie chart',
                graphTitle: "Today's Enquiry",
                commonDataList: enquiryList,
              )
            : Container(),
        SizedBox(height: 20.0),
        Divider(),
        weekDaysList.length > 0
            ? BarPieCommonChart(
                subjectName: "",
                chartType: 'bar chart',
                color: Colors.red[200],
                graphTitle: 'Last 7 Days Enquiry',
                commonDataList: weekDaysList,
              )
            : Container(),
        SizedBox(height: 20.0),
        Divider(),
        monthList.length > 0
            ? BarPieCommonChart(
                subjectName: "",
                chartType: 'bar chart',
                color: Colors.blue[200],
                graphTitle: 'Monthly Enquiry',
                commonDataList: monthList,
              )
            : Container(),
        SizedBox(height: 20.0),
        Divider(),
        SizedBox(height: 20.0),
        if (statusOfEnquiryData != null) buildEnquiryStats(statusOfEnquiryData),
        SizedBox(height: 20.0),
        buildReachUs(),
      ],
    );
  }

  // Expanded buildClass(BuildContext context) {
  //   return Expanded(
  //     child: Container(
  //       color: Colors.white,
  //       child: Column(
  //         children: [
  //           SizedBox(height: 20.0),
  //           buildEnquiryStats(),
  //           SizedBox(height: 20.0),
  //           buildReachUs(),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Container buildReachUs() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: "How People Reach Us",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Divider(),
          // Text("Through Friends"),
          // Text("Through Google Search"),
          ListView.builder(
            shrinkWrap: true,
            itemCount: howPeopleReachusData!.length,
            itemBuilder: (context, i) {
              return buildLinearBar(
                  title: howPeopleReachusData![i].referenceName,
                  value: "${howPeopleReachusData![i].totalSrch}%",
                  percent: 0.32,
                  //Random Colors Auto-generated
                  color: Colors
                          .primaries[Random().nextInt(Colors.primaries.length)]
                      [Random().nextInt(9) * 100]);
            },
          ),
          // buildLinearBar(
          //     title: "Facebook",
          //     value: "32%",
          //     percent: 0.32,
          //     color: Colors.blue[400]),
          // buildLinearBar(
          //     title: "Google",
          //     value: "53%",
          //     percent: 0.53,
          //     color: Colors.orange[400]),
          // buildLinearBar(
          //     title: "Friends",
          //     value: "16%",
          //     percent: 0.16,
          //     color: Colors.green[400]),
        ],
      ),
    );
  }

  Column buildLinearBar(
      {String? title, String? value, Color? color, double percent = 0.0}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title!),
            Text(value!, style: TextStyle(color: color)),
          ],
        ),
        LinearPercentIndicator(
          // width: MediaQuery.of(context).size.width - 50,
          animation: true,
          lineHeight: 18.0,
          animationDuration: 2500,
          percent: percent,
          // center: Text(value!),
          barRadius: Radius.circular(10),
          progressColor: color,
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Container buildEnquiryStats(GetDashBoardDeatils? enquiryData) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: "Status of Enquiry ",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(
                  text: "(TILL DATE)",
                  style: TextStyle(color: Colors.grey, fontSize: 20),
                ),
              ],
            ),
          ),
          Divider(),
          buildStatsRows(
              title: "Total Enquiry",
              percent: "${enquiryData!.totalEnquiry}",
              color: Theme.of(context).primaryColor,
              icon: Icons.query_stats),
          buildStatsRows(
              title: "Admitted",
              // percent: "asdas",
              percent:
                  "(${enquiryData.toatlFollowUpCount}) ${enquiryData.converted}%",
              color: Colors.green,
              icon: Icons.thumb_up),
          buildStatsRows(
              title: "Not Admitted",
              // percent: "sasdsa",
              percent: "(${enquiryData.closeCount}) ${enquiryData.closed}%",
              color: Colors.red,
              icon: Icons.thumb_down),
          buildStatsRows(
              title: "Follow Up",
              // percent: "asdsadas",
              percent:
                  "(${enquiryData.convertedCount}) ${enquiryData.totalFollowUp}%",
              color: Colors.orange,
              icon: Icons.query_stats),
          buildStatsRows(
              title: "Registered",
              percent:
                  "(${enquiryData.registeredCount}) ${enquiryData.registered}%",
              color: Colors.blueAccent,
              icon: Icons.stacked_bar_chart),
        ],
      ),
    );
  }

  Padding buildStatsRows(
      {Color? color, String? title, String? percent, IconData? icon}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: color),
              SizedBox(width: 8),
              Text(title!),
            ],
          ),
          Text(percent!, style: TextStyle(color: color)),
        ],
      ),
    );
  }
}

// final List<CommonListGraph> enquiryList = [
//     CommonListGraph(title: 'Email', value: 5, color: Colors.red[200]),
//     CommonListGraph(title: 'Phone', value: 6, color: Colors.blue[200]),
//     CommonListGraph(title: 'Visitors', value: 0, color: Colors.orange[200]),
//     CommonListGraph(title: 'Online', value: 9, color: Colors.green[200]),
//   ];

//   final List<CommonListGraph> weekDaysList = [
//     CommonListGraph(title: 'Mon', value: 5, color: Colors.red[200]),
//     CommonListGraph(title: 'Sun', value: 6, color: Colors.red[200]),
//     CommonListGraph(title: 'Sat', value: 9, color: Colors.red[200]),
//     CommonListGraph(title: 'Fri', value: 4, color: Colors.red[200]),
//     CommonListGraph(title: 'Thu', value: 6, color: Colors.red[200]),
//     CommonListGraph(title: 'Wed', value: 0, color: Colors.red[200]),
//     CommonListGraph(title: 'Tue', value: 2, color: Colors.red[200]),
//   ];

//   final List<CommonListGraph> monthList = [
//     CommonListGraph(title: 'Jan', value: 5, color: Colors.blue[200]),
//     CommonListGraph(title: 'Feb', value: 6, color: Colors.blue[200]),
//     CommonListGraph(title: 'Mar', value: 0, color: Colors.blue[200]),
//     CommonListGraph(title: 'Apr', value: 9, color: Colors.blue[200]),
//     CommonListGraph(title: 'May', value: 6, color: Colors.blue[200]),
//     CommonListGraph(title: 'Jun', value: 4, color: Colors.blue[200]),
//     CommonListGraph(title: 'Jul', value: 2, color: Colors.blue[200]),
//   ];
