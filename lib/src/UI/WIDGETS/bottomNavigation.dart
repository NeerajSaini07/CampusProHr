import 'package:campus_pro/src/UI/PAGES/STAND_ALONE_PAGES/ENQUIRY_MANAGEMENT/dashboardEnquiry.dart';
import 'package:campus_pro/src/UI/PAGES/STAND_ALONE_PAGES/ENQUIRY_MANAGEMENT/feedbackEnquiry.dart';
import 'package:campus_pro/src/UI/PAGES/STAND_ALONE_PAGES/ENQUIRY_MANAGEMENT/todayFollowUpEnquiry.dart';
import 'package:campus_pro/src/UI/PAGES/STAND_ALONE_PAGES/ENQUIRY_MANAGEMENT/viewEnquiry.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:flutter/material.dart';

import '../../globalBlocProvidersFile.dart';

class BottomNavigation extends StatefulWidget {
  static const routeName = "bottom-navigation";
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;

  List<Widget> _page = [
    BlocProvider<DashboardEnquiryCubit>(
      create: (_) => DashboardEnquiryCubit(
          (DashboardEnquiryRepository(DashboardEnquiryApi()))),
      child: DashboardEnquiry(),
    ),
    BlocProvider<DashboardEnquiryCubit>(
      create: (_) => DashboardEnquiryCubit(
          (DashboardEnquiryRepository(DashboardEnquiryApi()))),
      child: TodayFollowUpEnquiry(),
    ),
    // TodayFollowUpEnquiry(),
    BlocProvider<ViewEnquiryCubit>(
      create: (_) => ViewEnquiryCubit(ViewEnquiryRepository(ViewEnquiryApi())),
      child: BlocProvider<AddNewEnquiryCubit>(
        create: (_) =>
            AddNewEnquiryCubit(AddNewEnquiryRepository(AddNewEnquiryApi())),
        child: ViewEnquiry(),
      ),
    ),
    BlocProvider<FeedbackEnquiryCubit>(
      create: (_) => FeedbackEnquiryCubit(
          (FeedbackEnquiryRepository(FeedbackEnquiryApi()))),
      child: FeedbackEnquiry(),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: DrawerWidget(),
      // appBar: mainAppBar(context,
      //     title: _currentIndex == 0
      //         ? "Home"
      //         : _currentIndex == 1
      //             ? "My Appointments"
      //             : _currentIndex == 2
      //                 ? "Search"
      //                 : _currentIndex == 3
      //                     ? "Profile"
      //                     : ""),
      appBar: commonAppBar(context, title: 'Enquiry Management'),
      body: _page[_currentIndex],
      bottomNavigationBar: _buildBottomNavigationBar(context),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   backgroundColor: Colors.white,
      //   child: Image.asset(
      //     AppImages.searchIcon,
      //     color: Theme.of(context).primaryColor,
      //   ),
      // ),
    );
  }

  double iconSize = 28;

  BottomNavigationBar _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: Theme.of(context).primaryColor,
      selectedLabelStyle: TextStyle(
        fontWeight: FontWeight.bold,
      ),
      // selectedfontSize: 12.0,
      unselectedItemColor: Color(0xff77838F),
      unselectedLabelStyle: TextStyle(
        fontWeight: FontWeight.bold,
      ),
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
        print("_currentIndex bottomBar : $_currentIndex");
      },
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          // label: 'Home',
          label: 'Dashboard',
          // textScaleFactor: 1.5,
          //   style: TextStyle(
          //       fontSize: 12.0,
          //       color: Colors.black,
          //       fontWeight: FontWeight.bold),
          // ),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.perm_phone_msg),
          // label: 'Matches',
          label: 'Follow Up',
          // textScaleFactor: 1.5,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.help_center),
          // label: 'Matches',
          label: 'Enquiry',
          // textScaleFactor: 1.5,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.feedback),
          // label: 'Search',
          label: 'Feedback',
          // textScaleFactor: 1.5,
        ),
      ],
    );
  }
}
