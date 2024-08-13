import 'package:campus_pro/src/DATA/API_SERVICES/approveProxyEmpListApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/approveProxyRequestApi.dart';
import 'package:campus_pro/src/DATA/MODELS/approveProxyEmpListModal.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonSnackbar.dart';
import 'package:campus_pro/src/WIDGETS_STYLE/style_common.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ApproveProxy extends StatefulWidget {
  static const routeName = "/Approve-Proxy";
  _ApproveProxyState createState() => _ApproveProxyState();
}

class _ApproveProxyState extends State<ApproveProxy> {
  DateTime? currentDate;
  // = DateTime.now();

  TextEditingController nameController = TextEditingController();

  //
  List<bool> checkBoxList = [];

  //
  List<TextEditingController> remarkList = [];

  //
  List<ApproveProxyEmpListModal> proxyList = [];

  //
  List<int> selectedIds = [];

  bool showLoadMore = true;

  //
  int olderListLength = 0;

  static const dropDownList = ["Pending", "Approved", "Rejected"];
  String? selectedStatus = "Pending";
  List<DropdownMenuItem<String>> dropDownMenuStatus = dropDownList
      .map((e) => DropdownMenuItem(
            child: Text("$e"),
            value: e,
          ))
      .toList();

  bool checkBoxValue = false;

  var listResponseFuture;

  getProxyList({String? empName, String? date, String? itemShow}) async {
    try {
      await ApproveProxyEmpListApi()
          .approveProxyEmpCalApi(
        status: selectedStatus == "Pending"
            ? "p"
            : selectedStatus == "Approved"
                ? "A"
                : "R",
        empName: empName != null ? empName : "",
        date: date != null ? date : "",
        itemsShow: itemShow,
      )
          .then((value) {
        setState(() {
          proxyList = value;
          proxyList.forEach((element) {
            checkBoxList.add(false);
          });
          proxyList.forEach((element) {
            remarkList.add(TextEditingController());
          });
          if (proxyList.length % 10 == 0 &&
              olderListLength != proxyList.length) {
            showLoadMore = true;
          } else {
            showLoadMore = false;
          }
        });
      });
    } catch (e) {
      setState(() {
        proxyList.length = 0;
        proxyList = [];
        showLoadMore = false;
      });
      throw e;
    }
  }

  @override
  void initState() {
    listResponseFuture = getProxyList();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, title: "Approve Proxy"),
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
                        listResponseFuture = getProxyList(
                          empName: nameController.text != ""
                              ? nameController.text
                              : "",
                          date: currentDate != null
                              ? DateFormat("dd-MMM-yyyy").format(currentDate!)
                              : "",
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
                          proxyList.forEach((element) {
                            selectedIds.add(element.prId!);
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
            : Container()
      ],
    );
  }

  FutureBuilder<Object> buildFutureBuilder() {
    return FutureBuilder(
      // future: getProxyList(),
      future: listResponseFuture,
      builder: (BuildContext context, snapshot) {
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
          return buildProxyApproveList();
        }
        return Container();
      },
    );
  }

  Expanded buildProxyApproveList() {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => Divider(
          thickness: 1,
        ),
        itemCount: proxyList.length,
        itemBuilder: (context, index) {
          var item = proxyList[index];
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
                      "${item.checkInTime}=>${item.checkOutTime}",
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
                          "${item.attDate}",
                          style: TextStyle(
                            fontSize: 11,
                          ),
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                          decoration: BoxDecoration(
                            color: item.attendanceFor!.toLowerCase() ==
                                    "full day"
                                ? Colors.green
                                : item.attendanceFor!.toLowerCase() == "quarter"
                                    ? Colors.lightBlueAccent
                                    : item.attendanceFor!.toLowerCase() ==
                                            "absent"
                                        ? Colors.redAccent
                                        : item.attendanceFor!.toLowerCase() ==
                                                "fourth-half"
                                            ? Colors.purpleAccent
                                            : Colors.orange,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "${item.attendanceFor}",
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
                                color:
                                    item.proxyStatus!.toLowerCase() == "pending"
                                        ? Colors.lightBlueAccent
                                        : item.proxyStatus!.toLowerCase() ==
                                                "rejected"
                                            ? Colors.redAccent
                                            : Colors.green),
                            child: Text(
                              "${item.proxyStatus}",
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
                                        selectedIds.add(item.prId!);
                                      } else {
                                        selectedIds.remove(item.prId);
                                      }
                                      print(item.prId);
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
                      child: Text("Reason:${item.reasons}"),
                    ),
                    // Text("${item.remark}"),
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
                            child: Text("Remark :${item.remark}"),
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

  Widget loadMoreButton() {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Color(0xff178ed7)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(19),
          ),
        ),
      ),
      onPressed: () {
        olderListLength = proxyList.length + 10;
        listResponseFuture = getProxyList(itemShow: olderListLength.toString());
      },
      child: Text("Load More"),
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
        mainAxisAlignment: selectedStatus == "Pending"
            ? MainAxisAlignment.spaceEvenly
            : MainAxisAlignment.center,
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
                // currentDate = DateTime.now();
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
                    try {
                      if (selectedIds.length > 0) {
                        var remarks = [];
                        remarkList.forEach((element) {
                          // if (element.text != "") {
                          //   remarks.add(element.text);
                          // }
                          remarks.add(element.text);
                        });

                        var results = [];

                        for (int i = 0; i < selectedIds.length; i++) {
                          var result = await ApproveProxyRequestApi()
                              .approveProxyRequestApi(
                                  status: "A",
                                  id: selectedIds[i].toString(),
                                  // remark: remarkList.join(","));
                                  // remark: remarks.join(","));
                                  remark: remarks[i]);
                          results.add(result["Data"][0]["Status"]);
                        }

                        // var result =
                        //     await ApproveProxyRequestApi().approveProxyRequestApi(
                        //         status: "A",
                        //         id: selectedIds.join(","),
                        //         // remark: remarkList.join(","));
                        //         remark: remarks.join(","));

                        // if (result["Data"][0]["Status"] == 1) {
                        if (results[0] == 1) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            commonSnackBar(title: "Proxy Approved "),
                          );
                          setState(() {
                            listResponseFuture = getProxyList(itemShow: "10");
                          });
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          commonSnackBar(
                              title: "Please Select Atleast One Request"),
                        );
                      }
                    }

                    ///
                    catch (e) {
                      print("error on on approved proxy api $e");
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
                    try {
                      if (selectedIds.length > 0) {
                        var remarks = [];
                        remarkList.forEach((element) {
                          // if (element.text != "") {
                          //   remarks.add(element.text);
                          // }
                          remarks.add(element.text);
                        });

                        var results = [];

                        for (int i = 0; i < selectedIds.length; i++) {
                          var result = await ApproveProxyRequestApi()
                              .approveProxyRequestApi(
                                  status: "A",
                                  id: selectedIds[i].toString(),
                                  // remark: remarkList.join(","));
                                  // remark: remarks.join(","));
                                  remark: remarks[i]);
                          results.add(result["Data"][0]["Status"]);
                        }

                        //
                        //
                        // var result =
                        //     await ApproveProxyRequestApi().approveProxyRequestApi(
                        //         status: "R",
                        //         id: selectedIds.join(","),
                        //         // remark: remarkList.join(","));
                        //         remark: remarks.join(","));

                        if (results[0] == 1) {
                          setState(() {
                            listResponseFuture = getProxyList(itemShow: "10");
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            commonSnackBar(title: "Proxy Rejected"),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          commonSnackBar(
                              title: "Please Select Atleast One Request"),
                        );
                      }
                    } catch (e) {
                      print("error on on approved proxy api $e");
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
