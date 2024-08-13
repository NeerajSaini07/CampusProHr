import 'dart:async';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/CONSTANTS/themeData.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/saveLeaveEmployeeCal.dart';
import 'package:campus_pro/src/DATA/MODELS/LeaveBalanceEmpCalModal.dart'
    as leaveBal;
import 'package:campus_pro/src/DATA/API_SERVICES/leaveBalanceEmpCalApi.dart';
import 'package:campus_pro/src/DATA/MODELS/leaveBalanceEmpCalModal.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/PAGES/EMPLOYEE_MODULE/EMPLOYEE_CALENDAR/calendarEmployeeCalendar.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonSnackbar.dart';
import 'package:campus_pro/src/WIDGETS_STYLE/style_common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EmployeeLeaveCal extends StatefulWidget {
  static const routeName = "/employee-leave-cal";
  @override
  _EmployeeLeaveCalState createState() => _EmployeeLeaveCalState();
}

class _EmployeeLeaveCalState extends State<EmployeeLeaveCal> {
  // static const items = ["as", "asd"];
  // List<DropdownMenuItem<String>> dropDownItems = items
  //     .map((e) => DropdownMenuItem(
  //           child: Text("$e"),
  //           value: e,
  //         ))
  //     .toList();
  // String? selectedDropDownVal = "as";

  DateTime selectedFromDate = DateTime.now();
  DateTime selectedToDate = DateTime.now();

  TextEditingController descController = TextEditingController();

  int selectedIdLeave = 0;
  String selectedLeave = "";

  var _future;

  bool isSaving = false;

  @override
  void initState() {
    _future = LeaveBalanceEmpCalApi().getLeaveBalanceEmp();
    super.initState();
  }

  @override
  void dispose() {
    descController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, title: "Apply Leave"),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder(
                // future: LeaveBalanceEmpCalApi().getLeaveBalanceEmp(),
                future: _future,
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    if (snapshot.error == "false") {
                      UserUtils.unauthorizedUser(context);
                    }
                    print("error on leave balance api ${snapshot.error}");
                    return Container();
                  } else {
                    if (!snapshot.hasData) {
                      return Container();
                    } else {
                      print("this is snapshot ${snapshot.data["Data"]}");

                      List<LeaveBalanceEmpCalModal> leaveTypes =
                          (snapshot.data["Data"] as List)
                              .map((e) => LeaveBalanceEmpCalModal.fromJson(e))
                              .toList();
                      // return Column(
                      //   children: [
                      //     for (int i = 0; i < leaveTypes.length; i++)
                      //       buildLeaveButton(
                      //           name: "${leaveTypes[i].leaveName}",
                      //           dayLeft:
                      //               int.parse(leaveTypes[i].totalBalance!)),
                      //   ],
                      // );
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemCount: leaveTypes.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 1 / .3,
                          crossAxisCount: 2,
                          crossAxisSpacing: 0.0,
                          mainAxisSpacing: 0.0,
                        ),
                        itemBuilder: (context, index) {
                          var item = leaveTypes[index];
                          return buildLeaveButton(
                            name: "${item.leaveName}",
                            dayLeft: int.parse(item.totalBalance!),
                            leaveId: int.parse(item.leaveID!),
                            monthlyLimit: item.monthlyLimit,
                          );
                        },
                      );
                    }
                  }
                }),
            SizedBox(
              height: 10,
            ),
            // buildDropdownButton(),
            // SizedBox(
            //   height: 10,
            // ),
            buildBothDatePicker(context),
            SizedBox(
              height: 10,
            ),
            buildTextField(),
            SizedBox(
              height: 20,
            ),
            buildSaveButton(),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLeaveButton(
      {String? name, int? dayLeft, int? leaveId, String? monthlyLimit}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    30.0,
                  ),
                ),
              ),
              backgroundColor: name == selectedLeave
                  ? MaterialStateProperty.all(Colors.blue)
                  : MaterialStateProperty.all(accentColor),
              // int.parse(monthlyLimit!) != 0
              //     ? name == selectedLeave
              //         ? MaterialStateProperty.all(Colors.blue)
              //         : MaterialStateProperty.all(Theme.of(context).accentColor)
              //     : MaterialStateProperty.all(Colors.red),
            ),
            onPressed: () {
              if (int.parse(monthlyLimit!) != 0) {
                setState(() {
                  selectedIdLeave = leaveId!;
                  selectedLeave = name!;
                });
              } else {
                // ScaffoldMessenger.of(context).showSnackBar(
                //     commonSnackBar(title: "You Reached Your Monthly Limit."));
                setState(() {
                  selectedIdLeave = leaveId!;
                  selectedLeave = name!;
                });
              }
            },
            child: Container(
              constraints: BoxConstraints(
                minWidth: 130,
                maxHeight: 40,
              ),
              child: Center(
                  child: Text(
                '${name!.replaceAll("Leave", "")} : $dayLeft',
                style: TextStyle(
                  fontSize: 16,
                ),
              )),
            ),
          ),
          // SizedBox(
          //   width: 5,
          // ),
          // Text(
          //   "$name : $dayLeft",
          //   style: TextStyle(
          //     fontWeight: FontWeight.w600,
          //     fontSize: 14,
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget buildSaveButton() {
    return isSaving == false
        ? Center(
            child: TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(
                        vertical: 6,
                        horizontal: 40,
                      ),
                    )),
                onPressed: () async {
                  if (descController.text != "" && selectedIdLeave != 0) {
                    try {
                      setState(() {
                        isSaving = true;
                      });
                      await SaveLeaveEmployeeCal()
                          .saveLeaveEmployeeCal(
                              fromDate: DateFormat("dd-MMM-yyyy")
                                  .format(selectedFromDate),
                              toDate: DateFormat("dd-MMM-yyyy")
                                  .format(selectedToDate),
                              desc: descController.text,
                              leaveId: selectedIdLeave.toString())
                          .then((value) {
                        print("value $value");
                        if (int.parse(value["Data"][0]["Status"]) == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              commonSnackBar(
                                  title: "${value["Data"][0]["Message"]}"));
                        }
                        if (int.parse(value["Data"][0]["Status"]) == 1) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              commonSnackBar(
                                  title: "${value["Data"][0]["Message"]}"));
                          Navigator.pushReplacementNamed(
                              context, EmployeeCalendar.routeName);
                        }
                        if (int.parse(value["Data"][0]["Status"]) == 2) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              commonSnackBar(
                                  title: "${value["Data"][0]["Message"]}"));
                        }
                      });
                    } catch (e) {
                      print("error $e");
                      ScaffoldMessenger.of(context).showSnackBar(
                          commonSnackBar(title: "$SOMETHING_WENT_WRONG"));
                    }
                    setState(() {
                      isSaving = false;
                    });
                  } else {
                    if (selectedIdLeave == 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        commonSnackBar(title: "Please Select Leave Type"),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        commonSnackBar(title: "Please Type Description"),
                      );
                    }
                  }
                },
                child: Text(
                  "Save",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: 16,
                  ),
                )),
          )
        : Center(child: CircularProgressIndicator());
  }

  Widget buildTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 20),
          child: Text(
            "Description",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(width: 0.1),
          ),
          child: TextFormField(
            controller: descController,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 4),
                border: OutlineInputBorder(borderSide: BorderSide.none)),
          ),
        ),
      ],
    );
  }

  Padding buildBothDatePicker(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 18, right: 18),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'From Date',
                  // style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                buildDateSelector(
                  index: 0,
                  selectedDate:
                      DateFormat("dd MMM yyyy").format(selectedFromDate),
                ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.05,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'To Date',
                  // style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
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

  // Widget buildDropdownButton() {
  //   return IgnorePointer(
  //     child: Container(
  //       margin: EdgeInsets.only(left: 17),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(
  //             "Leave Type",
  //             style: TextStyle(
  //               fontSize: 15,
  //               fontWeight: FontWeight.w600,
  //             ),
  //           ),
  //           SizedBox(
  //             height: 5,
  //           ),
  //           Container(
  //             padding: EdgeInsets.symmetric(horizontal: 4),
  //             decoration: BoxDecoration(
  //               border: Border.all(color: Color(0xffECECEC)),
  //               borderRadius: BorderRadius.circular(10.0),
  //             ),
  //             width: MediaQuery.of(context).size.width * 0.42,
  //             height: 40,
  //             child: DropdownButton<String>(
  //               isExpanded: true,
  //               underline: Container(),
  //               value: selectedDropDownVal,
  //               items: dropDownItems,
  //               onChanged: (e) {
  //                 setState(() {
  //                   selectedDropDownVal = e;
  //                 });
  //               },
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Future<void> _selectDate(BuildContext context, {int? index}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedFromDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      helpText: index == 0 ? "SELECT FROM DATE" : "SELECT TO DATE",
    );
    if (picked != null)
      setState(() {
        print(int.parse(DateFormat("MM").format(picked)));
        if (index == 0) {
          if (picked.year == selectedFromDate.year) {
            if (picked.month == selectedFromDate.month ||
                int.parse(DateFormat("MM").format(picked)) >
                    int.parse(DateFormat("MM").format(selectedFromDate))) {
              if (picked.isBefore(selectedToDate) || picked == selectedToDate) {
                selectedFromDate = picked;
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  commonSnackBar(
                    title: "start date always less then end date",
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                commonSnackBar(
                  title: "Can Not Apply Leave For Older Month",
                  duration: Duration(
                    seconds: 2,
                  ),
                ),
              );
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              commonSnackBar(
                title: "Can Apply Leave For this year Only",
                duration: Duration(
                  seconds: 2,
                ),
              ),
            );
          }
        } else {
          if (picked.year == selectedFromDate.year) {
            if (picked.month == selectedFromDate.month ||
                int.parse(DateFormat("MM").format(picked)) >
                    int.parse(DateFormat("MM").format(selectedFromDate))) {
              if (picked.isAfter(selectedFromDate) ||
                  picked == selectedFromDate) {
                selectedToDate = picked;
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  commonSnackBar(
                    title: "End date always greater then start date",
                    duration: Duration(
                      seconds: 2,
                    ),
                  ),
                );
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                commonSnackBar(
                  title: "Can Not Apply Leave For Older Month",
                  duration: Duration(
                    seconds: 2,
                  ),
                ),
              );
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              commonSnackBar(
                title: "Can Apply Leave For this year Only",
                duration: Duration(
                  seconds: 2,
                ),
              ),
            );
          }
        }
      });
  }

  InkWell buildDateSelector({String? selectedDate, int? index}) {
    return InkWell(
      onTap: () => _selectDate(context, index: index),
      child: internalTextForDateTime(context, selectedDate: selectedDate),
    );
  }
}
