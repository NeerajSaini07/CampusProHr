import 'package:campus_pro/src/CONSTANTS/themeData.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/drawerWidget.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class EnquiryManagement extends StatefulWidget {
  static const routeName = "/enquiry-management";
  final String? userType;

  const EnquiryManagement({Key? key, this.userType}) : super(key: key);
  @override
  _EnquiryManagementState createState() => _EnquiryManagementState();
}

class _EnquiryManagementState extends State<EnquiryManagement> {
  TabController? tabController;

  var scrollController = ScrollController();

  int _currentIndex = 0;

  void tabIndexChange(int tabIndex) {
    setState(() {
      _currentIndex = tabIndex;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: commonAppBar(context, title: "Enquiry Management"),
      // bottomNavigationBar: BottomNavigation(),
      body: DefaultTabController(
        initialIndex: _currentIndex,
        length: 3,
        child: Column(
          children: [
            // SizedBox(height: 20),
            buildTabBar(context),
            Expanded(
              child: TabBarView(
                // physics: NeverScrollableScrollPhysics(),
                children: [
                  buildClass(context),
                  buildClass(context),
                  buildClass(context),
                ],
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigation(),
    );
  }

  Expanded buildClass(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(height: 20.0),
            buildEnquiryStats(),
            SizedBox(height: 20.0),
            buildReachUs(),
          ],
        ),
      ),
    );
  }

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
          buildLinearBar(
              title: "Facebook",
              value: "32%",
              percent: 0.32,
              color: Colors.blue[400]),
          buildLinearBar(
              title: "Google",
              value: "53%",
              percent: 0.53,
              color: Colors.orange[400]),
          buildLinearBar(
              title: "Friends",
              value: "16%",
              percent: 0.16,
              color: Colors.green[400]),
        ],
      ),
    );
  }

  Column buildLinearBar(
      {String? title, String? value, Color? color, double percent = 0.0}) {
    return Column(
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
          linearStrokeCap: LinearStrokeCap.roundAll,
          progressColor: color,
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Container buildEnquiryStats() {
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
              percent: "19%",
              color: Theme.of(context).primaryColor,
              icon: Icons.query_stats),
          buildStatsRows(
              title: "Admitted",
              percent: "(14) 21%",
              color: Colors.green,
              icon: Icons.thumb_up),
          buildStatsRows(
              title: "Not Admitted",
              percent: "(1) 5%",
              color: Colors.red,
              icon: Icons.thumb_down),
          buildStatsRows(
              title: "Follow Up",
              percent: "(4) 74%",
              color: Colors.orange,
              icon: Icons.query_stats),
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

  Container buildTabBar(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Container(
        margin: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
        // decoration: BoxDecoration(
        color: Colors.white,
        //     border: Border.all(color: Theme.of(context).primaryColor)),
        child: TabBar(
          unselectedLabelColor: Theme.of(context).primaryColor,
          labelColor: Colors.white,
          indicator: BoxDecoration(
            gradient: customGradient,
            borderRadius: BorderRadius.circular(40.0),
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
              default:
                tabIndexChange(tabIndex);
                // getSample();
                break;
            }
          },
          tabs: [
            buildTabs(title: 'Dashboard', index: _currentIndex),
            buildTabs(title: 'View Enquiry', index: _currentIndex),
            buildTabs(title: 'Feedback', index: _currentIndex),
          ],
          controller: tabController,
        ),
      ),
    );
  }

  Tab buildTabs({String? title, int? index}) {
    return Tab(
      child: Text(title ?? ""),
    );
  }
}
