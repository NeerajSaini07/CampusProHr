import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:flutter/material.dart';

class HrEmployee extends StatefulWidget {
  static const routeName = '/Hr-Employee';
  @override
  _HrEmployeeState createState() => _HrEmployeeState();
}

class _HrEmployeeState extends State<HrEmployee> {
  TabController? tabController;
  int _currentIndex = 0;

  void tabIndexChange(int tabIndex) {
    setState(() {
      _currentIndex = tabIndex;
    });
  }

  //var currentIndex;
  @override
  void initState() {
    super.initState();
    // setState(() {
    //   currentIndex = 0;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, title: 'Services and Responsibilities'),
      body: DefaultTabController(
        initialIndex: _currentIndex,
        length: 2,
        child: Column(
          children: [
            buildTabBar(context),
            Expanded(
              child: TabBarView(
                //physics: NeverScrollableScrollPhysics(),
                children: [
                  buildDataList(),
                  buildDataList(),
                ],
              ),
            )
          ],
        ),
      ),
      // currentIndex == 0
      //     ? Column(
      //         children: [
      //           Text('First Index'),
      //         ],
      //       )
      //     : Column(
      //         children: [Text('Second Index')],
      //       ),
      // bottomNavigationBar: BottomAppBar(
      //   color: Colors.blue,
      //   child: IntrinsicHeight(
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceAround,
      //       children: [
      //         TextButton(
      //           // style: TextButton.styleFrom(
      //           //   textStyle: const TextStyle(
      //           //     fontSize: 15,
      //           //   ),
      //           //   primary: Colors.white,
      //           // ),
      //           style: ButtonStyle(
      //             overlayColor: MaterialStateProperty.all(Colors.transparent),
      //           ),
      //           onPressed: () {
      //             if (currentIndex != 0) {
      //               setState(() {
      //                 currentIndex = 0;
      //               });
      //             }
      //           },
      //           child: Text(
      //             'Services & Leave Rules ',
      //             style: TextStyle(
      //               color: Colors.white,
      //               fontSize: 17,
      //             ),
      //           ),
      //         ),
      //         VerticalDivider(
      //           thickness: 1,
      //         ),
      //         TextButton(
      //           // style: TextButton.styleFrom(
      //           //   backgroundColor: Colors.transparent,
      //           //   textStyle: TextStyle(
      //           //     fontSize: 15,
      //           //   ),
      //           //   primary: Colors.white,
      //           // ),
      //           style: ButtonStyle(
      //             overlayColor: MaterialStateProperty.all(Colors.transparent),
      //           ),
      //
      //           onPressed: () {
      //             if (currentIndex != 1) {
      //               setState(() {
      //                 currentIndex = 1;
      //               });
      //             }
      //           },
      //           child: Text(
      //             'Job Responsibilities',
      //             style: TextStyle(
      //               color: Colors.white,
      //               fontSize: 17,
      //             ),
      //           ),
      //         )
      //       ],
      //     ),
      //   ),
      // ),
    );
  }

  Container buildTabBar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 8.0),
      height: 40,
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor)),
      child: TabBar(
        unselectedLabelColor: Theme.of(context).primaryColor,
        labelColor: Colors.white,
        indicator: BoxDecoration(
          // gradient: customGradient,
          color: Theme.of(context).primaryColor,
        ),
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
              break;
            default:
              tabIndexChange(tabIndex);
              // getSample();
              break;
          }
        },
        tabs: [
          buildTabs(title: 'Services & Leave Rules ', index: 0),
          buildTabs(title: 'Job Responsibilities ', index: 1),
        ],
        controller: tabController,
      ),
    );
  }

  Tab buildTabs({String? title, int? index}) {
    return Tab(
      child: Text(title!),
    );
  }

  // Column getData1() {
  //   return Column(
  //     children: [
  //       Text(
  //         ('index 1'),
  //       )
  //     ],
  //   );
  // }
  //
  // Column getData2() {
  //   return Column(
  //     children: [
  //       Text(
  //         ('index 2'),
  //       )
  //     ],
  //   );
  // }

  Container buildDataList() {
    return Container(
      child: Center(
        child: Text(
          NO_RECORD_FOUND,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
