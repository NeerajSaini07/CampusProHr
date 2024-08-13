import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/CONSTANTS/themeData.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/CALENDER_STUDENT_CUBIT/calender_student_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/calenderStudentModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/PAGES/STUDENT_MODULE/monthPickerDialog.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/drawerWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
// import 'package:table_calendar/table_calendar.dart';

class CalendarStudent extends StatefulWidget {
  static const routeName = "/calender-student";
  @override
  _CalendarStudentState createState() => _CalendarStudentState();
}

class _CalendarStudentState extends State<CalendarStudent>
    with TickerProviderStateMixin {
  PageController? calPageController;
  // CalendarController? _calendarController;
  // Map<DateTime, List>? _events;
  Map<DateTime, List<dynamic>>? _events;
  List<dynamic>? _selectedEvents;
  Iterable<CalenderStudentModel>? _samemontheventsFilter = [];
  List<CalenderStudentModel>? samemonthevents = [];
  // List<CalenderStudentModel>? _samemonthevents = <CalenderStudentModel>[];
  AnimationController? _animationController;
  DateTime current = DateTime.now();

  bool showCalender = false;

  _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000)).then((value) {
      Navigator.pop(context);
      Navigator.pushNamed(context, CalendarStudent.routeName);
    });
  }

  @override
  void initState() {
    _events = {};
    _selectedEvents = [];
    // _calendarController = CalendarController();
    calPageController = PageController();
    getCalenderEvents();
    super.initState();
  }

  getCalenderEvents() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userType = await UserUtils.userTypeFromCache();
    // Pass dynamic SessionId
    final data = {
      'OUserId': uid, //'10263727',
      'Token': token,
      'OrgId': userType!.organizationId,
      'Schoolid': userType.schoolId,
      'SessionId': '6',
      // 'SessionId': userType.currentSessionid,
    };

    // // getSameMonthAppointments();
    context.read<CalenderStudentCubit>().calenderStudentCubitCall(data);

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _animationController!.forward();
  }

  @override
  void dispose() {
    // _calendarController!.dispose();
    super.dispose();
  }

  // void _onVisibleDaysChanged(
  //     DateTime first, DateTime last, CalendarFormat format) {
  //   setState(() {
  //     current = first;
  //     getCurrentMonthEvents();
  //   });
  //
  //   print('CALLBACK: _onVisibleDaysChanged first ${first.toIso8601String()}');
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: commonAppBar(context, title: 'Calendar'),
      floatingActionButton: current.month != DateTime.now().month
          ? FloatingActionButton(
              onPressed: () {
                // _calendarController!.setFocusedDay(DateTime.now());
              },
              backgroundColor: Theme.of(context).primaryColor,
              child: Icon(Icons.calendar_today))
          : null,
      body: RefreshIndicator(
        onRefresh: () => _onRefresh(),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: SizedBox.fromSize(
            size: MediaQuery.of(context).size,
            child: Column(
              children: [
                // if (showCalender) _buildTableCalendarWithBuilders(),
                Divider(
                  thickness: 2.0,
                  color: accentColor,
                ),
                BlocConsumer<CalenderStudentCubit, CalenderStudentState>(
                  listener: (context, state) {
                    if (state is CalenderStudentLoadFail) {
                      if (state.failReason == "false") {
                        UserUtils.unauthorizedUser(context);
                      } else {
                        setState(() => showCalender = !showCalender);
                      }
                    }
                    if (state is CalenderStudentLoadSuccess) {
                      _animationController = AnimationController(
                        vsync: this,
                        duration: const Duration(milliseconds: 100),
                      );
                      _animationController!.forward();
                      setState(() {
                        showCalender = !showCalender;
                        samemonthevents = state.calenderList;
                        getCurrentMonthEvents();
                      });
                      samemonthevents!.forEach((element) {
                        _events!.addAll({
                          DateTime.parse(element.start!): [element.title]
                        });
                      });
                    }
                  },
                  builder: (context, state) {
                    if (state is CalenderStudentLoadInProgress) {
                      return LinearProgressIndicator();
                    } else if (state is CalenderStudentLoadSuccess) {
                      return Expanded(child: _buildsameMonthEventList(context));
                    } else if (state is CalenderStudentLoadFail) {
                      return Text(state.failReason);
                    } else {
                      return Container();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getCurrentMonthEvents() {
    print('DATE EDIT = ' +
        "${DateTime.parse(samemonthevents![0].start! + 'T' + samemonthevents![0].eventStartDate!.split(' ')[1].split(' ')[0] + '.000Z')}");
    _samemontheventsFilter = samemonthevents!.where(
      (element) =>
          DateTime.parse(element.start! +
                      'T' +
                      element.eventStartDate!.split(' ')[1].split(' ')[0] +
                      '.000Z')
                  .year ==
              current.year &&
          DateTime.parse(element.start! +
                      'T' +
                      element.eventStartDate!.split(' ')[1].split(' ')[0] +
                      '.000Z')
                  .month ==
              current.month,
    );
    print('_samemontheventsFilter length = ${_samemontheventsFilter!.length}');
  }

  getOnDaySelectedEvents(DateTime date) {
    setState(() {
      print('DATE EDIT onDaySelected = ' +
          "${DateTime.parse(samemonthevents![0].start! + 'T' + samemonthevents![0].eventStartDate!.split(' ')[1].split(' ')[0] + '.000Z')}");
      _samemontheventsFilter = samemonthevents!.where(
        (element) =>
            DateTime.parse(element.start! +
                        'T' +
                        element.eventStartDate!.split(' ')[1].split(' ')[0] +
                        '.000Z')
                    .year ==
                date.year &&
            DateTime.parse(element.start! +
                        'T' +
                        element.eventStartDate!.split(' ')[1].split(' ')[0] +
                        '.000Z')
                    .month ==
                date.month &&
            DateTime.parse(element.start! +
                        'T' +
                        element.eventStartDate!.split(' ')[1].split(' ')[0] +
                        '.000Z')
                    .day ==
                date.day,
      );
      print(
          '_samemontheventsFilter on selected date length = ${_samemontheventsFilter!.length}');
    });
  }

  // More advanced TableCalendar configuration (using Builders & Styles)
  // Widget _buildTableCalendarWithBuilders() {
  //   return TableCalendar(
  //     calendarController:_calendarController!,
  //     events: _events!,
  //     //holidays: _holidays,
  //     initialCalendarFormat: CalendarFormat.month,
  //     formatAnimation: FormatAnimation.slide,
  //     startingDayOfWeek: StartingDayOfWeek.sunday,
  //     availableGestures: AvailableGestures.all,
  //     availableCalendarFormats: const {CalendarFormat.month: ''},
  //     calendarStyle: CalendarStyle(
  //       outsideDaysVisible: false,
  //       weekendStyle: GoogleFonts.quicksand(
  //         fontSize: 18.0,
  //         fontWeight: FontWeight.bold,
  //         color: Colors.red,
  //       ),
  //       weekdayStyle: GoogleFonts.quicksand(
  //         fontSize: 18.0,
  //         fontWeight: FontWeight.bold,
  //         color: Colors.black,
  //       ),
  //       // weekendStyle: TextStyle().copyWith(color: Colors.blue[800]),
  //       holidayStyle: GoogleFonts.quicksand(
  //         fontSize: 18.0,
  //         fontWeight: FontWeight.bold,
  //         color: Colors.red,
  //       ),
  //     ),
  //     daysOfWeekStyle: DaysOfWeekStyle(
  //       weekendStyle: GoogleFonts.quicksand(
  //         fontSize: 18.0,
  //         fontWeight: FontWeight.bold,
  //         color: Colors.red,
  //       ),
  //       weekdayStyle: GoogleFonts.quicksand(
  //         fontSize: 18.0,
  //         fontWeight: FontWeight.bold,
  //         color: Colors.black,
  //       ),
  //     ),
  //     headerStyle: HeaderStyle(
  //       centerHeaderTitle: true,
  //       formatButtonVisible: false,
  //       titleTextStyle: GoogleFonts.quicksand(
  //         fontSize: 24.0,
  //         fontWeight: FontWeight.bold,
  //         color: Color(0xff3A3A3A),
  //       ),
  //     ),
  //     onDaySelected: (date, events, _) => getOnDaySelectedEvents(date),
  //     builders: CalendarBuilders(
  //       selectedDayBuilder: (context, date, _) {
  //         return FadeTransition(
  //           opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController!),
  //           child: Container(
  //             margin: const EdgeInsets.all(8.0),
  //             alignment: Alignment.center,
  //             decoration: BoxDecoration(
  //                 color: Theme.of(context).primaryColor,
  //                 borderRadius: BorderRadius.circular(12.0),
  //                 border: Border.all(color: Theme.of(context).primaryColor)),
  //             child: Text(
  //               '${date.day}',
  //               style: TextStyle().copyWith(
  //                   // fontSize: 20.0,
  //                   color: Colors.white,
  //                   fontWeight: FontWeight.bold),
  //             ),
  //           ),
  //         );
  //       },
  //       todayDayBuilder: (context, date, _) {
  //         return Container(
  //           margin: const EdgeInsets.all(8.0),
  //           alignment: Alignment.center,
  //           decoration: BoxDecoration(
  //               // color: Theme.of(context).primaryColor,
  //               borderRadius: BorderRadius.circular(12.0),
  //               border: Border.all(
  //                   width: 2, color: Theme.of(context).primaryColor)),
  //           child: Text('${date.day}',
  //               style: TextStyle(
  //                   color: Theme.of(context).primaryColor,
  //                   fontWeight: FontWeight.bold,
  //                   fontSize: 16)),
  //         );
  //       },
  //       markersBuilder: (context, date, events, holidays) {
  //         final children = <Widget>[];
  //
  //         if (events.isNotEmpty) {
  //           children.add(
  //             Positioned(
  //               child: _buildEventsMarker(date, events),
  //             ),
  //           );
  //         }
  //         if (holidays.isNotEmpty) {
  //           children.add(
  //             Positioned(
  //               right: -2,
  //               top: -2,
  //               child: _buildHolidaysMarker(),
  //             ),
  //           );
  //         }
  //         return children;
  //       },
  //     ),
  //     onVisibleDaysChanged: _onVisibleDaysChanged,
  //     onHeaderTapped: (_) {
  //       print("onHeaderTapped");
  //       showMonthPicker(
  //               context: context,
  //               firstDate: DateTime(DateTime.now().year - 10, 5),
  //               lastDate: DateTime(DateTime.now().year + 1, 9),
  //               initialDate: current)
  //           .then((date) {
  //         setState(() => current = date!);
  //         _calendarController!.setFocusedDay(current);
  //         getCurrentMonthEvents();
  //       });
  //     },
  //   );
  // }

  // DateTime selectedDate = DateTime.now();

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.all(8.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Color(0xffffb703),
        // border: Border.all(width: 2, color: Colors.blue[300]!),
      ),
      child: Center(
          child: Text(
        "${date.day}",
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
      )),
    );
  }

  Widget _buildHolidaysMarker() {
    return Icon(
      Icons.add_box,
      size: 20.0,
      color: Colors.blueGrey[800],
    );
  }

  Widget _buildsameMonthEventList(BuildContext context) {
    return Scaffold(
      body: (_samemontheventsFilter!.length == 0)
          ? Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(top: 60),
              child: Text(
                "No Events in this Month",
                textAlign: TextAlign.center,
                style: commonStyleForText.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          : ListView(
              children: _samemontheventsFilter!
                  .map(
                    (event) => Container(
                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xffE1E3E8)),
                      ),
                      child: (event is CalenderStudentModel)
                          ? ListTile(
                              title: Text(
                                event.title!,
                                textScaleFactor: 1.0,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    DateFormat('dd MMMM yyyy').format(
                                        DateTime.parse(event.start! +
                                            'T' +
                                            event.eventStartDate!
                                                .split(' ')[1]
                                                .split(' ')[0] +
                                            '.000Z')),
                                    //textScaleFactor: 1.0,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    DateFormat('EEEE').format(DateTime.parse(
                                        event.start! +
                                            'T' +
                                            event.eventStartDate!
                                                .split(' ')[1]
                                                .split(' ')[0] +
                                            '.000Z')),
                                    // textScaleFactor: 1.0,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () {
                                // setState(() {});
                              },
                            )
                          : null,
                    ),
                  )
                  .toList()),
    );
  }
}

// class CalendarStudent extends StatefulWidget {
//   static const routeName = "/calender-student";
//   @override
//   _DynamicEventState createState() => _DynamicEventState();
// }

// class _DynamicEventState extends State<CalendarStudent> {
//   CalendarController? _controller;
//   Map<DateTime, List<dynamic>>? _events;
//   List<dynamic>? _selectedEvents;
//   TextEditingController? _eventController;
//   SharedPreferences? prefs;

//   @override
//   void initState() {
//     super.initState();
//     _controller = CalendarController();
//     _eventController = TextEditingController();
//     _events = {};
//     _selectedEvents = [];
//     prefsData();
//   }

//   prefsData() async {
//     prefs = await SharedPreferences.getInstance();
//     setState(() {
//       _events = Map<DateTime, List<dynamic>>.from(
//           decodeMap(json.decode(prefs!.getString("events") ?? "{}")));
//     });
//   }

//   Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map) {
//     Map<String, dynamic> newMap = {};
//     map.forEach((key, value) {
//       newMap[key.toString()] = map[key];
//     });
//     return newMap;
//   }

//   Map<DateTime, dynamic> decodeMap(Map<String, dynamic> map) {
//     Map<DateTime, dynamic> newMap = {};
//     map.forEach((key, value) {
//       newMap[DateTime.parse(key)] = map[key];
//     });
//     return newMap;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: DrawerWidget(),
//       appBar: commonAppBar(context, title: "Calender"),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             calender(context),
//             SizedBox(height: 10),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 10),
//               child: Text(
//                 "List of Holiday",
//                 textScaleFactor: 1.4,
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//             ),
//             buildExamDateSheet(context),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget calender(BuildContext context) {
//     return TableCalendar(
//       availableGestures: AvailableGestures.none,
//       startDay: DateTime(2000, 1, 1),
//       // rowHeight: 36,
//       daysOfWeekStyle: DaysOfWeekStyle(
//         weekendStyle:
//             TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//       ),
//       initialCalendarFormat: CalendarFormat.month,
//       calendarStyle: CalendarStyle(
//         todayColor: Colors.orange,
//         selectedColor: Theme.of(context).primaryColor,
//         // weekdayStyle: TextStyle(fontWeight: FontWeight.bold),
//       ),
//       headerStyle: HeaderStyle(
//         centerHeaderTitle: true,
//         formatButtonVisible: false,
//         titleTextStyle: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 16,
//             color: Color(0xff313131)),
//         leftChevronIcon: Icon(
//           Icons.arrow_back_ios,
//         ),
//         rightChevronIcon: Icon(
//           Icons.arrow_forward_ios,
//         ),
//       ),
//       onVisibleDaysChanged: (first, last, CalendarFormat date) {
//         print(first);
//         print(last);
//         print(date);
//         print(DateFormat.LLLL().format(first));
//         print(DateFormat.LLLL().format(last));
//         // you could write those values into a variable here
//         // maybe call setState if that variable is part of your state
//       },
//       startingDayOfWeek: StartingDayOfWeek.monday,
//       onDaySelected: (date, events, _) {
//         setState(() {});
//       },
//       builders: CalendarBuilders(
//         dowWeekdayBuilder: (context, day) => Container(
//           decoration: BoxDecoration(
//               // border: Border(
//               //   top: BorderSide(width: 2.0, color: Colors.amber),
//               //   bottom: BorderSide(width: 2.0, color: Colors.amber),
//               // ),
//               ),
//           alignment: Alignment.center,
//           child: Text(
//             day.toString(),
//             style: TextStyle(
//               // fontWeight: FontWeight.bold,
//               color: Colors.black,
//             ),
//           ),
//         ),
//         // dowWeekdayBuilder: (context, day) => Container(
//         //   color: Colors.amber,
//         //   // decoration: BoxDecoration(
//         //   //   border: Border(
//         //   //     top: BorderSide(width: 2.0, color: Colors.amber),
//         //   //     bottom: BorderSide(width: 2.0, color: Colors.amber),
//         //   //   ),
//         //   // ),
//         //   alignment: Alignment.center,
//         //   child: Padding(
//         //     padding: const EdgeInsets.symmetric(vertical: 4),
//         //     child: Text(
//         //       day.toString(),
//         //       style:
//         //           TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//         //     ),
//         //   ),
//         // ),
//         selectedDayBuilder: (context, date, events) => Container(
//           margin: EdgeInsets.all(10),
//           alignment: Alignment.center,
//           height: 10,
//           width: 10,
//           decoration: BoxDecoration(
//             // border: Border.all(),
//             borderRadius: BorderRadius.circular(80.0),
//             color: Theme.of(context).primaryColor,
//           ),
//           child: Text(
//             date.day.toString(),
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           ),
//         ),
//         outsideDayBuilder: (context, date, events) => Container(
//           alignment: Alignment.center,
//           child: Text(
//             date.day.toString(),
//             style: TextStyle(
//               // fontWeight: FontWeight.bold,
//               color: Colors.grey[400],
//             ),
//           ),
//         ),
//         // unavailableDayBuilder: ,
//         weekendDayBuilder: (context, date, events) => Container(
//           alignment: Alignment.center,
//           child: Text(
//             date.day.toString(),
//             style: TextStyle(
//                 // color: Colors.red,
//                 // fontWeight: FontWeight.bold,
//                 ),
//           ),
//         ),
//         todayDayBuilder: (context, date, events) => Container(
//           margin: EdgeInsets.all(10),
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//             border: Border.all(),
//             borderRadius: BorderRadius.circular(80),
//             color: Colors.transparent,
//           ),
//           child: Text(
//             date.day.toString(),
//             style: TextStyle(
//                 // fontWeight: FontWeight.bold,
//                 ),
//           ),
//         ),
//       ),
//       calendarController: _controller,
//     );
//   }

//   Widget buildExamDateSheet(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(10.0),
//       child: ListView.separated(
//         physics: AlwaysScrollableScrollPhysics(),
//         separatorBuilder: (context, index) => SizedBox(height: 10.0),
//         shrinkWrap: true,
//         itemCount: 2,
//         itemBuilder: (BuildContext context, int i) {
//           return Container(
//             // padding: const EdgeInsets.all(4.0),
//             decoration: BoxDecoration(
//               border: Border.all(color: Color(0xffE1E3E8)),
//             ),
//             child: ListTile(
//               title: Text(
//                 "Diwali",
//                 textScaleFactor: 1.2,
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               subtitle: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text("14 November",
//                       textScaleFactor: 1.0,
//                       style: TextStyle(color: Colors.grey)),
//                   Text("Saturday",
//                       textScaleFactor: 1.0,
//                       style: TextStyle(color: Colors.grey)),
//                 ],
//               ),
//             ),
//             // child: Row(
//             //   crossAxisAlignment: CrossAxisAlignment.start,
//             //   mainAxisAlignment: MainAxisAlignment.start,
//             //   children: [
//             //     Container(
//             //       // width: MediaQuery.of(context).size.width / 2.9,
//             //       margin: const EdgeInsets.symmetric(vertical: 4.0),
//             //       decoration: BoxDecoration(
//             //         border: Border.all(color: Color(0xffE1E3E8)),
//             //       ),
//             //       child: Column(
//             //         children: [
//             //           Container(
//             //             color: Theme.of(context).primaryColor,
//             //             padding: const EdgeInsets.symmetric(horizontal: 8),
//             //             child: Text("item.examDate",
//             //                 textScaleFactor: 1.2,
//             //                 style: TextStyle(color: Colors.white)),
//             //           ),
//             //           Container(
//             //             padding: const EdgeInsets.symmetric(vertical: 2),
//             //             child: Text("item.examDate",
//             //                 textScaleFactor: 1.5,
//             //                 style: TextStyle(
//             //                     color: Colors.black,
//             //                     fontWeight: FontWeight.bold)),
//             //           ),
//             //         ],
//             //       ),
//             //       // child: Row(
//             //       //   children: [
//             //       //     buildTiming(
//             //       //         color: Theme.of(context).primaryColor,
//             //       //         title: item.timing!.split("-")[0]),
//             //       //     buildTiming(
//             //       //         color: Colors.blue[800],
//             //       //         title: item.timing!.split("-")[0]),
//             //       //   ],
//             //       // ),
//             //     ),
//             //     SizedBox(width: 10),
//             //     Expanded(
//             //       child: Container(
//             //         // width: MediaQuery.of(context).size.width / 1.8,
//             //         child: Column(
//             //           crossAxisAlignment: CrossAxisAlignment.start,
//             //           mainAxisAlignment: MainAxisAlignment.start,
//             //           children: [
//             //             Text(
//             //               "item.subjectHead",
//             //               textScaleFactor: 1.5,
//             //               style: TextStyle(fontWeight: FontWeight.bold),
//             //             ),
//             //             Row(
//             //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             //               children: [
//             //                 Row(
//             //                   children: [
//             //                     Icon(Icons.watch_later_outlined,
//             //                         size: 18, color: Colors.grey),
//             //                     SizedBox(width: 8),
//             //                     Text("item.timing",
//             //                         textScaleFactor: 1.2,
//             //                         style: TextStyle(color: Colors.grey)),
//             //                   ],
//             //                 ),
//             //                 Text("item.shift",
//             //                     textScaleFactor: 1.2,
//             //                     style: TextStyle(color: Colors.green)),
//             //               ],
//             //             ),
//             //           ],
//             //         ),
//             //       ),
//             //     ),
//             //   ],
//             // ),
//           );
//         },
//       ),
//     );
//   }
// }
