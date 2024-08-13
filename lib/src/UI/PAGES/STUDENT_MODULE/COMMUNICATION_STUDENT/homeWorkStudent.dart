import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/allMonthHwForCalApi.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/HOME_WORK_STUDENT_ON_LOAD_CUBIT/home_work_student_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/homeWorkStudentModel.dart';
import 'package:campus_pro/src/DATA/MODELS/userTypeModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/PAGES/STAND_ALONE_PAGES/chatRoomCommon.dart';
import 'package:campus_pro/src/UI/PAGES/STUDENT_MODULE/monthPickerDialog.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/fileDownloader.dart';
import 'package:campus_pro/src/UTILS/appImages.dart';
import 'package:campus_pro/src/WIDGETS_STYLE/style_common.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:table_calendar/table_calendar.dart';

class HomeWorkStudent extends StatefulWidget {
  static const routeName = "/homework-student";
  @override
  _HomeWorkStudentState createState() => _HomeWorkStudentState();
}

class _HomeWorkStudentState extends State<HomeWorkStudent>
    with TickerProviderStateMixin {
  DateTime selectedDate = DateTime.now();

  // CalendarController? _calendarController;
  AnimationController? _animationController;
  DateTime current = DateTime.now();
  UserTypeModel? userData;

  @override
  void initState() {
    getHomework();
    // _calendarController = CalendarController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _animationController!.forward();
    allMonthHw();
    super.initState();
  }

  allMonthHw() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final stuInfo = await UserUtils.stuInfoDataFromCache();

    final data = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "StuEmpId": userData.stuEmpId,
      "UserType": userData.ouserType,
      "Year": current.year.toString(),
      "Month": current.month.toString(),
      "ClassId": stuInfo!.classId,
      "SectionId": stuInfo.classSectionId,
      "StreamId": stuInfo.streamId,
      "YearId": stuInfo.yearId,
    };

    print("sending data for all month for cal $data");

    // List<AllMonthHwForCalModal> response =
    try {
      await AllMonthHwForCalApi().hwList(data).then((value) {
        setState(() {
          // eventss = {
          //   DateTime(2021, 12, 14): ["Holiday"]
          // };
          eventss = {};
          value.forEach((element) {
            print(element.date);
            eventss.addAll({
              DateTime.parse(
                  "${element.date!.split("-")[0]}-${element.date!.split("-")[2]}-${element.date!.split("-")[1]}"): [
                element.id.toString()
              ]
            });
          });
          print('events $eventss');
          eventss = eventss;
        });
        // buildTableCalendar(context);
      });
    } catch (e) {}
  }

  getHomework({DateTime? date}) async {
    if (date != null) {
      selectedDate = date;
    }
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    userData = await UserUtils.userTypeFromCache();
    final homeworkData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "SchoolId": userData!.schoolId!,
      "SessionId": userData!.currentSessionid!,
      "StuEmpId": userData!.stuEmpId,
      "OUserType": userData!.ouserType,
      "From": DateFormat("dd MMM yyyy").format(selectedDate),
      "To": DateFormat("dd MMM yyyy").format(selectedDate),
      "OnLoad": "0",
    };
    print("homeworkData sending = > $homeworkData");
    context.read<HomeWorkStudentCubit>().homeWorkStudentCubitCall(homeworkData);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      helpText: "SELECT DATE",
    );
    if (picked != null)
      setState(() {
        selectedDate = picked;
      });
  }

  _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000)).then((value) {
      getHomework();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, title: "Homework"),
      body: Column(
        children: [
          //Todo:Add Calender
          // buildTopDateFilter(context),
          // buildTableCalendar(context),
          Divider(
            thickness: 1,
            color: Theme.of(context).primaryColor,
          ),
          BlocConsumer<HomeWorkStudentCubit, HomeWorkStudentState>(
            listener: (context, state) {
              if (state is HomeWorkStudentLoadSuccess) {
                print('events2 $eventss');
                eventss = eventss;

                if (eventss.length > 0) {
                  // buildTableCalendar(context);
                }
              }
              if (state is HomeWorkStudentLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                }
              }
            },
            builder: (context, state) {
              if (state is HomeWorkStudentLoadInProgress) {
                // return Center(child: CircularProgressIndicator());
                return Center(child: LinearProgressIndicator());
              } else if (state is HomeWorkStudentLoadSuccess) {
                return buildHomeWorkBody(context,
                    homeWorkList: state.homeWorkList);
              } else if (state is HomeWorkStudentLoadFail) {
                return Center(
                  child: Text(
                    NO_RECORD_FOUND,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }

  Map<DateTime, List> eventss = {
    // DateTime(2022, 1, 14): ["Holiday"]
  };

  // TableCalendar buildTableCalendar(BuildContext context) {
  //   return TableCalendar(
  //     calendarController: _calendarController,
  //     events: eventss,
  //     //     {
  //     //   DateTime.parse("2022-02-01"): ["Holiday"],
  //     //   DateTime(2022, 1, 8): ["Holiday"],
  //     //   DateTime(2022, 1, 16): ["Holiday"],
  //     //   DateTime(2022, 1, 17): ["Holiday"],
  //     // },
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
  //         centerHeaderTitle: true,
  //         formatButtonVisible: false,
  //         titleTextStyle: GoogleFonts.quicksand(
  //           fontSize: 24.0,
  //           fontWeight: FontWeight.bold,
  //           color: Color(0xff3A3A3A),
  //         )),
  //     onDaySelected: (date, events, _) => getHomework(date: date),
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
  //         // getCurrentMonthEvents();
  //       });
  //     },
  //   );
  // }

  // void _onVisibleDaysChanged(
  //     DateTime first, DateTime last, CalendarFormat format) async {
  //   // Add Api For month events
  //   print(first);
  //   print(last);
  //   getHomework(date: first);
  //   final uid = await UserUtils.idFromCache();
  //   final token = await UserUtils.userTokenFromCache();
  //   final userData = await UserUtils.userTypeFromCache();
  //   final stuInfo = await UserUtils.stuInfoDataFromCache();
  //   final data = {
  //     "OUserId": uid,
  //     "Token": token,
  //     "OrgId": userData!.organizationId,
  //     "Schoolid": userData.schoolId,
  //     "StuEmpId": userData.stuEmpId,
  //     "UserType": userData.ouserType,
  //     "Year": first.year.toString(),
  //     "Month": first.month.toString(),
  //     "ClassId": stuInfo!.classId,
  //     "SectionId": stuInfo.classSectionId,
  //     "StreamId": stuInfo.streamId,
  //     "YearId": stuInfo.yearId,
  //   };
  //
  //   print("sending data for all month for cal $data");
  //
  //   // List<AllMonthHwForCalModal> response =
  //   try {
  //     await AllMonthHwForCalApi().hwList(data).then((value) {
  //       setState(() {
  //         current = first;
  //         // eventss = {
  //         //   DateTime(2021, 12, 14): ["Holiday"]
  //         // };
  //         eventss = {};
  //         value.forEach((element) {
  //           print(element.date);
  //           eventss.addAll({
  //             DateTime.parse(
  //                 "${element.date!.split("-")[0]}-${element.date!.split("-")[2]}-${element.date!.split("-")[1]}"): [
  //               element.id.toString()
  //             ]
  //           });
  //         });
  //         print('events $eventss');
  //         eventss = eventss;
  //       });
  //       buildTableCalendar(context);
  //     });
  //   } catch (e) {}
  //
  //   // setState(() {
  //   //   current = first;
  //   //   // eventss = {
  //   //   //   DateTime(2021, 12, 14): ["Holiday"]
  //   //   // };
  //   //   response.forEach((element) {
  //   //     print(element.date);
  //   //     eventss.addAll({
  //   //       DateTime.parse(element.date!): ["HomeWork"]
  //   //     });
  //   //   });
  //   //   print('events $eventss');
  //   //    buildTableCalendar(context);
  //   // });
  //
  //   print('CALLBACK: _onVisibleDaysChanged first ${first.toIso8601String()}');
  // }

  Widget buildHomeWorkBody(BuildContext context,
      {List<HomeWorkStudentModel>? homeWorkList}) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () => _onRefresh(),
        child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) =>
              const SizedBox(height: 10.0),
          physics: AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: homeWorkList!.length,
          itemBuilder: (context, i) {
            var item = homeWorkList[i];
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xffDBDBDB)),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: [
                  ListTile(
                    title: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (item.subjectName != "" &&
                                  item.subjectName != null)
                                Text(
                                  "${item.subjectName}",
                                  style: commonStyleForText,
                                  // style: TextStyle(fontSize: 16),
                                ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${item.name}",
                                    style: commonStyleForText,
                                    // style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    "${item.attDate}",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Divider(color: Color(0xffDBDBDB), height: 10.0),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildText(title: item.homeworkMsg),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(color: Color(0xffDBDBDB), height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (item.homeworkURL != "")
                        FileDownload(
                          fileName: item.homeworkURL!.split("/").last,
                          fileUrl: userData!.baseDomainURL! + item.homeworkURL!,
                          downloadWidget: Row(
                            children: [
                              Image.asset(
                                getDownloadImage(
                                    item.homeworkURL!.split(".").last),
                                width: 28,
                                color: Theme.of(context).primaryColor,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "Download",
                                style: commonStyleForText,
                              ),
                            ],
                          ),
                        ),
                      InkWell(
                        onTap: () {
                          final chatData = ChatRoomCommonModel(
                            appbarTitle: item.name,
                            iD: item.iD,
                            stuEmpId: "",
                            classId: "",
                            screenType: "homework",
                          );
                          Navigator.pushNamed(context, ChatRoomCommon.routeName,
                              arguments: chatData);
                        },
                        child: Row(
                          children: [
                            Icon(Icons.chat_bubble_outline,
                                color: Theme.of(context).primaryColor),
                            SizedBox(width: 10),
                            Text("Comments", style: commonStyleForText),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

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

  Flexible buildText({String? title}) {
    return Flexible(
      child: Text("$title", style: commonStyleForText),
    );
  }

  InkWell buildDateSelector({String? selectedDate}) {
    return InkWell(
      onTap: () => _selectDate(context),
      child: internalTextForDateTime(context, selectedDate: selectedDate),
    );
  }

  Container buildTopDateFilter(BuildContext context) {
    return Container(
      // color: Colors.white,
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.4,
            child: buildDateSelector(
              selectedDate: DateFormat("dd MMM yyyy").format(selectedDate),
            ),
          ),
          //Expanded(child: Container()),
          SizedBox(width: 30.0),
          PhysicalModel(
            elevation: 10,
            color: Colors.transparent,
            child: InkWell(
              onTap: () => getHomework(),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Theme.of(context).primaryColor,
                ),
                child: Text(
                  "Show",
                  //textScaleFactor: 1.1,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
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

  String getDownloadImage(String? extention) {
    switch (extention) {
      case "jpg":
        return AppImages.jpgImage;
      case "jpeg":
        return AppImages.jpegImage;
      case "pdf":
        return AppImages.pdfImage;
      default:
        return AppImages.downloadImage;
    }
  }
}
