import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/approveLeaveListApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/approveLeaveRequestApi.dart';
import 'package:campus_pro/src/DATA/MODELS/approveLeaveListModal.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonSnackbar.dart';
import 'package:campus_pro/src/WIDGETS_STYLE/style_common.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ApproveLeaveEmpCal extends StatefulWidget {
  static const routeName = "/ApproveLeaveEmpCal";
  ApproveLeaveEmpCalState createState() => ApproveLeaveEmpCalState();
}

class ApproveLeaveEmpCalState extends State<ApproveLeaveEmpCal> {
  DateTime? currentDate;
  //= DateTime.now();

  TextEditingController nameController = TextEditingController();

  List<bool> checkBoxList = [];

  List<TextEditingController> remarkList = [];

  static const dropDownList = ["Pending", "Approved", "Rejected"];
  String? selectedStatus = "Pending";
  List<DropdownMenuItem<String>> dropDownMenuStatus = dropDownList
      .map((e) => DropdownMenuItem(
            child: Text("$e"),
            value: e,
          ))
      .toList();

  bool checkBoxValue = false;

  List<ApproveLeaveListModal> leaveList = [];

  bool showLoadMore = true;

  List<int> selectedIds = [];

  var _futureApproveLeaveList;

  int olderListLength = 0;

  getLeaveList(
      {String? empName, String? date, String? itemShow, String? status}) async {
    try {
      await ApproveLeaveListApi()
          .getLeaveList(
              showTop: "10",
              createdDate: date,
              empName: empName,
              status: status != null ? status : "")
          .then((value) {
        setState(() {
          leaveList = value;

          leaveList.forEach((element) {
            checkBoxList.add(false);
          });

          leaveList.forEach((element) {
            remarkList.add(TextEditingController());
          });
          if (leaveList.length % 10 == 0 &&
              olderListLength != leaveList.length) {
            showLoadMore = true;
          } else {
            showLoadMore = false;
          }
        });
      });
    } catch (e) {
      print("error on leave list api $e");
      setState(() {
        leaveList.length = 0;
        leaveList = [];
        showLoadMore = false;
      });
      throw e;
    }
  }

  @override
  void initState() {
    _futureApproveLeaveList = getLeaveList(itemShow: "10", status: "p");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, title: "Approve Leave"),
      body: buildBody(context),
      bottomNavigationBar: buildBottomNavBar(context),
    );
  }

  Column buildBody(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Employee Name:",
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.42,
                    height: MediaQuery.of(context).size.height * 0.05,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffECECEC)),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        suffixIcon: Icon(
                          Icons.search,
                          size: 20,
                          color: Theme.of(context).primaryColor,
                        ),
                        contentPadding: EdgeInsets.only(
                          left: 2,
                          bottom: 2,
                        ),
                        hintText: 'Name',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Attendance Date:"),
                  SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      showDate();
                    },
                    child: internalTextForDateTime(
                      context,
                      selectedDate: currentDate == null
                          ? ""
                          : DateFormat("dd-MMM-yyyy").format(currentDate!),
                      width: MediaQuery.of(context).size.width * 0.42,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Status"),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.42,
                    height: MediaQuery.of(context).size.height * 0.05,
                    padding: EdgeInsets.only(left: 8, right: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Color(0xffECECEC)),
                    ),
                    child: DropdownButton<String>(
                      items: dropDownMenuStatus,
                      value: selectedStatus,
                      isExpanded: true,
                      underline: Container(),
                      onChanged: (String? val) {
                        setState(() {
                          selectedStatus = val;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 50,
              ),
              Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _futureApproveLeaveList = getLeaveList(
                          empName: nameController.text,
                          date: currentDate == null
                              ? ""
                              : DateFormat("dd-MMM-yyyy").format(currentDate!),
                          status: selectedStatus == "Pending"
                              ? "p"
                              : selectedStatus == "Approved"
                                  ? "A"
                                  : "R",
                        );
                      });
                    },
                    child: Text(
                      "Search",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Divider(
          thickness: 1,
          color: Theme.of(context).primaryColor,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.04,
          decoration: BoxDecoration(
            border: Border.all(
              color: Color(0xffECECEC),
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Container(),
              ),
              Text(
                "All",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              selectedStatus == "Pending"
                  ? Checkbox(
                      onChanged: (val) {
                        setState(() {
                          checkBoxValue = val!;
                        });
                        var checkList = checkBoxList;
                        checkBoxList = [];
                        if (checkBoxValue == true) {
                          for (int i = 0; i < checkList.length; i++) {
                            setState(() {
                              checkBoxList.add(true);
                            });
                          }
                          selectedIds = [];
                          leaveList.forEach((element) {
                            selectedIds.add(element.leaveRequestId!);
                          });
                        } else {
                          for (int i = 0; i < checkList.length; i++) {
                            setState(() {
                              checkBoxList.add(false);
                            });
                          }
                          selectedIds = [];
                        }
                        print(selectedIds);
                      },
                      value: checkBoxValue,
                    )
                  : Container()
            ],
          ),
        ),
        buildFutureBuilder(),
        // buildProxyApproveList(),
        showLoadMore
            ? Container(
                margin: EdgeInsets.only(right: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(),
                    ),
                    loadMoreButton(),
                  ],
                ),
              )
            : Container(),
      ],
    );
  }

  FutureBuilder<Object> buildFutureBuilder() {
    return FutureBuilder(
      future: _futureApproveLeaveList,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                "${snapshot.error}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }
          return buildLeaveEmpList();
        }
        return Container();
      },
    );
  }

  Expanded buildLeaveEmpList() {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => Divider(
          thickness: 1,
        ),
        itemCount: leaveList.length,
        itemBuilder: (context, index) {
          var item = leaveList[index];
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: Color(0xffECECEC),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        "${item.name}",
                        style: TextStyle(),
                      ),
                    ),
                    Text(
                      "${item.fromDate}=>${item.toDate}",
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${item.leaveDate}",
                          style: TextStyle(
                            fontSize: 11,
                          ),
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.purpleAccent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "${item.leaveName.toString()}",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 4, vertical: 2),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: item.leaveStatus!
                                            .toLowerCase()
                                            .toString() ==
                                        "pending"
                                    ? Colors.lightBlueAccent
                                    : item.leaveStatus!
                                                .toLowerCase()
                                                .toString() ==
                                            "rejected"
                                        ? Colors.redAccent
                                        : Colors.green),
                            child: Text(
                              "${item.leaveStatus}",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            )),
                        selectedStatus == "Pending"
                            ? SizedBox(
                                height: 28,
                                width: 28,
                                child: Checkbox(
                                    value: checkBoxList[index],
                                    onChanged: (val) {
                                      setState(() {
                                        checkBoxList[index] = val!;
                                      });
                                      if (val == true) {
                                        selectedIds.add(item.leaveRequestId!);
                                      } else {
                                        selectedIds.remove(item.leaveRequestId);
                                      }
                                      print(item.leaveRequestId);
                                      print(selectedIds);
                                    }),
                              )
                            : Container()
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text("Description:${item.description}"),
                    ),
                    selectedStatus == "Pending"
                        ? Container(
                            width: MediaQuery.of(context).size.width * 0.45,
                            height: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                width: 0.3,
                                color: Color(0xffFFB6B3B3),
                              ),
                            ),
                            child: TextFormField(
                              controller: remarkList[index],
                              decoration: InputDecoration(
                                hintText: "Remark",
                                hintStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                ),
                                contentPadding:
                                    EdgeInsets.only(bottom: 13, left: 2),
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                              ),
                            ),
                          )
                        : Flexible(
                            child: Text("Remark:${item.remark}"),
                          ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Container buildBottomNavBar(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.07,
      decoration: BoxDecoration(
        color: Color(0xffFFF5ECEC),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Row(
        mainAxisAlignment: selectedStatus != "Pending"
            ? MainAxisAlignment.center
            : MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Color(0xffc9302c),
              ),
              padding: MaterialStateProperty.all(EdgeInsets.zero),
            ),
            onPressed: () {
              setState(() {
                nameController.text = "";
                currentDate = null;
                selectedStatus = dropDownList[0];
              });
            },
            child: Text(
              "Reset",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ),
          selectedStatus == "Pending"
              ? ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                  ),
                  onPressed: () async {
                    var remarks = [];
                    remarkList.forEach((element) {
                      // if (element.text != "") {
                      //   remarks.add(element.text);
                      //   print(element.text);
                      // }
                      remarks.add(element.text);
                    });

                    if (selectedIds.length > 0) {
                      try {
                        var results = [];

                        for (int i = 0; i < selectedIds.length; i++) {
                          var result = await ApproveLeaveRequestApi()
                              .approveLeaveRequest(
                                  ids: selectedIds[i].toString(),
                                  remarks: remarks[i],
                                  flag: "A");
                          results.add(result["Data"][0]["Status"].toString());
                        }

                        if (results[0] == "1") {
                          ScaffoldMessenger.of(context).showSnackBar(
                              commonSnackBar(title: "Leave Approved"));
                          setState(() {
                            selectedIds = [];
                            remarkList = [];
                            checkBoxList = [];
                          });
                          setState(() {
                            _futureApproveLeaveList =
                                getLeaveList(itemShow: "10", status: "p");
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              commonSnackBar(title: "$SOMETHING_WENT_WRONG"));
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            commonSnackBar(title: "$SOMETHING_WENT_WRONG"));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        commonSnackBar(
                          title: "Please Select Atleast One Request",
                        ),
                      );
                    }
                  },
                  child: Text(
                    "Approve",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                )
              : Container(),
          selectedStatus == "Pending"
              ? ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Color(0xffef4e53),
                    ),
                  ),
                  onPressed: () async {
                    var remarks = [];
                    remarkList.forEach((element) {
                      // if (element.text != "") {
                      //   remarks.add(element.text);
                      //   print(element.text);
                      // }
                      remarks.add(element.text);
                    });

                    if (selectedIds.length > 0) {
                      try {
                        var results = [];

                        for (int i = 0; i < selectedIds.length; i++) {
                          var result = await ApproveLeaveRequestApi()
                              .approveLeaveRequest(
                                  ids: selectedIds[i].toString(),
                                  remarks: remarks[i],
                                  flag: "R");
                          results.add(result["Data"][0]["Status"].toString());
                        }

                        if (results[0] == "1") {
                          ScaffoldMessenger.of(context).showSnackBar(
                              commonSnackBar(title: "Leave Rejected"));

                          setState(() {
                            _futureApproveLeaveList =
                                getLeaveList(itemShow: "10", status: "p");
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              commonSnackBar(title: "$SOMETHING_WENT_WRONG"));
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            commonSnackBar(title: "$SOMETHING_WENT_WRONG"));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        commonSnackBar(
                          title: "Please Select Atleast One Request",
                        ),
                      );
                    }
                  },
                  child: Text(
                    "Reject",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }

  Widget loadMoreButton() {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          Color(0xff178ed7),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(19),
          ),
        ),
      ),
      onPressed: () {
        olderListLength = leaveList.length + 10;
        _futureApproveLeaveList = getLeaveList(
          itemShow: olderListLength.toString(),
          status: selectedStatus == "Pending"
              ? "p"
              : selectedStatus == "Approved"
                  ? "A"
                  : "P",
          date: currentDate == null
              ? ""
              : DateFormat("dd-MMM-yyyy").format(currentDate!),
        );
      },
      child: Text("Load More"),
    );
  }

  showDate() async {
    DateTime? date = await showDatePicker(
        context: context,
        initialDate: currentDate == null ? DateTime.now() : currentDate!,
        firstDate: DateTime(1946),
        lastDate: DateTime(2040));

    if (date != null) {
      setState(() {
        currentDate = date;
      });
    }
  }
}

// ending data for approve leave leave list api {OUserId: 10317863,
// Token: 6E511475-D601-41CA-9BEF-100041F336EB, OrgId: 9998,
// Schoolid: 1, flag: S, EmpID: 407, Status: , EmpName: , CreatedDate: , ShowTop: 10, UserType: M
