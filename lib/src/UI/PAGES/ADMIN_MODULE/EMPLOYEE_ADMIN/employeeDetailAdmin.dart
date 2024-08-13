import 'package:campus_pro/src/DATA/BLOC_CUBIT/ATTENDANCE_OF_EMPLOYEE_ADMIN_CUBIT/attendance_of_employee_admin_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/FEE_TYPE_CUBIT/fee_type_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/attendanceOfEmployeeAdminModel.dart';
import 'package:campus_pro/src/DATA/MODELS/feeTypeModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class EmployeeDetail extends StatefulWidget {
  static const routeName = '/Employee-Detail';
  const EmployeeDetail({Key? key}) : super(key: key);

  @override
  _EmployeeDetailState createState() => _EmployeeDetailState();
}

class _EmployeeDetailState extends State<EmployeeDetail> {
  List<FeeTypeModel>? designationDropDown;
  FeeTypeModel? selectedDesignation;
  final key = GlobalKey<State<Tooltip>>();
  List<AttendanceOfEmployeeAdminModel>? attendanceList = [];
  List<AttendanceOfEmployeeAdminModel>? constAttList = [];

  // List listItem = [
  //   [
  //     'Naman ',
  //     '1234',
  //     'Engineer',
  //     '10 Aug 1990',
  //     'A+',
  //     'gurugram new delhi noida',
  //     '1231232312323',
  //     'namanhiakaakdjasd@gmail.com'
  //   ],
  //   [
  //     'Naman',
  //     '1234',
  //     'Engineer',
  //     '10 Aug 1990',
  //     'A+',
  //     'gurugram new delhi noida',
  //     '1231232312323',
  //     'namanhiakaakdjasd@gmail.com'
  //   ],
  //   [
  //     'Naman',
  //     '1234',
  //     'Engineer',
  //     '10 Aug 1990',
  //     'A',
  //     'gurugram new delhi noida [ldlqwekqwkleqjweqwelejqklwejqwklejqwlelqwejqklwejqwlke',
  //     '1231232312323',
  //     'namanhiakaakdjasd@gmail.com'
  //   ],
  //   [
  //     'Naman',
  //     '1234',
  //     'Engineer',
  //     '10 Aug 1990',
  //     'A',
  //     'janak puri gurugram new delhi noida',
  //     '1231232312323',
  //     'namanhiakaakdjasd@gmail.com'
  //   ]
  // ];

  DateTime selectedDate = DateTime.now();
  // final List<DropdownMenuItem<String>> items = item
  //     .map((String e) => DropdownMenuItem<String>(value: e, child: Text('$e')))
  //     .toList();

  _launchPhoneURL(String phoneNumber) async {
    String url = 'tel:' + phoneNumber;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  getEmployeeAttendance({String? date}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final attendanceData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId!,
      "AttDate": date.toString(),
      "empid": userData.stuEmpId,
      "usertype": userData.ouserType,
    };
    print("get attendance Employee = > $attendanceData");
    context
        .read<AttendanceOfEmployeeAdminCubit>()
        .attendanceOfEmployeeAdminCubitCall(attendanceData);
  }

  Future<void> _selectDate() async {
    setState(() {
      selectedDate = DateTime.now();
    });
    // final DateTime? picked = await showDatePicker(
    //   context: context,
    //   initialDate: DateTime.now(),
    //   firstDate: DateTime(1947),
    //   lastDate: DateTime(2101),
    // );
    // if (picked != null)
    //   setState(() {
    //     print(picked);
    //     selectedDate = picked;
    //     // getAttendance(
    //     //     date: DateFormat("yyyy-MM-dd").format(selectedDate).toString());
    //   });
  }

  getFeeType() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final feeTypeData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId!,
      "Schoolid": userData.schoolId!,
      "EmpStuId": userData.stuEmpId!,
      "UserType": userData.ouserType!,
      "ParamType": "Designation",
    };
    print('feeType Data $feeTypeData');
    context.read<FeeTypeCubit>().feeTypeCubitCall(feeTypeData);
  }

  @override
  void initState() {
    super.initState();
    selectedDesignation = FeeTypeModel(iD: "", paramname: "");
    designationDropDown = [];
    getFeeType();
    _selectDate();
    getEmployeeAttendance(date: DateFormat('dd-MMM-yyyy').format(selectedDate));
  }

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 1)).then((value) {
      getFeeType();
      _selectDate();
      getEmployeeAttendance(
          date: DateFormat('dd-MMM-yyyy').format(selectedDate));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee Detail'),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 10.0,
            ),
            child: IconButton(
              icon: Icon(Icons.help_outline),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Center(
                          child: Text(
                        "Note",
                        style: TextStyle(
                            fontSize: 20,
                            decoration: TextDecoration.underline,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                        textScaleFactor: 1.0,
                      )),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "~ Tap or hold to see more details.",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.red,
                                fontWeight: FontWeight.w600),
                            textScaleFactor: 1.0,
                          ),
                          Text(
                            "~ Long tap to see details for 5 seconds.",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.red,
                                fontWeight: FontWeight.w600),
                            textScaleFactor: 1.0,
                          ),
                          Text(
                            "~ Single tap to see details for long.",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.red,
                                fontWeight: FontWeight.w600),
                            textScaleFactor: 1.0,
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    BlocConsumer<FeeTypeCubit, FeeTypeState>(
                      listener: (context, state) {
                        if (state is FeeTypeLoadSuccess) {
                          setState(() {
                            selectedDesignation =
                                FeeTypeModel(iD: "", paramname: "All");
                            print(selectedDesignation);
                            designationDropDown!.add(selectedDesignation!);
                            state.feeTypes.forEach((element) {
                              designationDropDown!.add(element);
                            });
                          });
                        }
                        if (state is FeeTypeLoadFail) {
                          if (state.failReason == "false") {
                            UserUtils.unauthorizedUser(context);
                          } else {
                            setState(() {
                              selectedDesignation =
                                  FeeTypeModel(iD: "", paramname: "");
                              designationDropDown = [];
                            });
                          }
                        }
                      },
                      builder: (context, state) {
                        if (state is FeeTypeLoadInProgress) {
                          return buildDesignationDropDown();
                        } else if (state is FeeTypeLoadSuccess) {
                          return buildDesignationDropDown();
                        } else {
                          return Container();
                        }
                      },
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.02,
                    ),
                    // Flexible(
                    //   child: Text(
                    //     '              Note  \nTap or Hold to See More Detail.',
                    //     style: TextStyle(
                    //         fontSize: 14,
                    //         color: Colors.red,
                    //         fontWeight: FontWeight.w600),
                    //     // TextStyle(
                    //     //     fontSize: 15, fontWeight: FontWeight.w600),
                    //   ),
                    // ),
                  ],
                )
              ],
            ),
            //buildDesignationDropDown(),
            Divider(
              thickness: 5,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.005,
            ),
            BlocConsumer<AttendanceOfEmployeeAdminCubit,
                AttendanceOfEmployeeAdminState>(
              listener: (context, state) {
                if (state is AttendanceOfEmployeeAdminLoadSuccess) {
                  setState(() {
                    attendanceList = state.AttendanceList;
                    constAttList = state.AttendanceList;
                  });
                }
                if (state is AttendanceOfEmployeeAdminLoadFail) {
                  if (state.failReason == 'false') {
                    UserUtils.unauthorizedUser(context);
                  }
                }
              },
              builder: (context, state) {
                if (state is AttendanceOfEmployeeAdminLoadInProgress) {
                  // return Center(child: CircularProgressIndicator());
                  return Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: LinearProgressIndicator());
                } else if (state is AttendanceOfEmployeeAdminLoadSuccess) {
                  return checkDesignationList(desList: attendanceList);
                } else if (state is AttendanceOfEmployeeAdminLoadFail) {
                  return checkDesignationList(error: state.failReason);
                } else {
                  return Container();
                }
              },
            ),
            //buildDesignationList()
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            )
          ],
        ),
      ),
    );
  }

  Expanded checkDesignationList(
      {List<AttendanceOfEmployeeAdminModel>? desList, String? error}) {
    if (desList == null || desList.isEmpty) {
      return Expanded(
        child: Center(
          child: Text('$error'),
        ),
      );
    } else {
      return buildDesignationList(designationList: desList);
    }
  }

  Expanded buildDesignationList(
      {List<AttendanceOfEmployeeAdminModel>? designationList}) {
    return Expanded(
        child: CupertinoScrollbar(
      child: ListView.separated(
        shrinkWrap: true,
        separatorBuilder: (context, index) => SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        //itemCount: listItem.length,
        itemCount: designationList!.length,
        itemBuilder: (context, index) {
          final key = GlobalKey<State<Tooltip>>();
          // print(listItem.length);
          var item = designationList[index];
          return Tooltip(
            key: key,
            waitDuration: Duration(milliseconds: 1),
            showDuration: Duration(seconds: 3),
            padding: EdgeInsets.all(5),
            height: 35,
            textStyle: TextStyle(
                fontSize: 15, color: Colors.black, fontWeight: FontWeight.w600),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.cyan.shade100,
            ),
            message:
                //'My Account',
                '● Name : ${item.name.toString()}\n'
                '● Blood Group : ${item.bloodGroup.toString()}\n'
                '● Address : ${item.prsAddr.toString()}\n'
                '● Email : ${item.emailID.toString()}\n'
                '● Designation : ${item.desigName.toString()}\n'
                '● DOB : ${item.dateOfBirth.toString()}',
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                final dynamic tooltip = key.currentState;
                tooltip?.ensureTooltipVisible();
              },
              child: Container(
                margin: EdgeInsets.only(left: 12, right: 12, top: 2, bottom: 2),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(border: Border.all(width: 0.2)),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: Row(
                        children: [
                          item.empno != ""
                              ? Text(
                                  '(${item.empno}) ',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                )
                              : Container(),
                          Expanded(
                            child: Text(
                              item.name!.toUpperCase(),
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blue),
                            ),
                          ),
                          item.bloodGroup != ""
                              ? Text(
                                  ' (${item.bloodGroup}) ',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                )
                              : Container()
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.004,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Designation : ${item.desigName.toString()}',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                          // Expanded(
                          //   child: Text(
                          //     'Note : Tap or Hold to See More Detail',
                          //     style: TextStyle(
                          //         fontSize: 14,
                          //         color: Colors.red,
                          //         fontWeight: FontWeight.w600),
                          //     // TextStyle(
                          //     //     fontSize: 15, fontWeight: FontWeight.w600),
                          //   ),
                          // ),
                          item.mobileNo != ""
                              ? GestureDetector(
                                  onTap: () {
                                    _launchPhoneURL(item.mobileNo.toString());
                                  },
                                  child: Icon(
                                    Icons.phone,
                                    size: 24,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                )
                              : Container()
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    ));
  }

  Container buildDesignationDropDown() {
    return Container(
      margin: EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 10),
      width: MediaQuery.of(context).size.width * 0.5,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Designation',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xffECECEC)),
              borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButton<FeeTypeModel>(
              isDense: true,
              value: selectedDesignation,
              key: UniqueKey(),
              isExpanded: true,
              underline: Container(),
              items: designationDropDown!
                  .map((e) => DropdownMenuItem<FeeTypeModel>(
                        child: Text('${e.paramname}'),
                        value: e,
                      ))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  selectedDesignation = val;
                  attendanceList = constAttList;
                });

                List<AttendanceOfEmployeeAdminModel>? localList = [];

                if (selectedDesignation!.paramname!.toLowerCase() ==
                    'accountant') {
                  attendanceList!.forEach((element) {
                    if (element.desigName != "") {
                      if (element.desigName!.toLowerCase() == 'accountant') {
                        setState(() {
                          localList.add(element);
                        });
                      }
                    }
                  });
                }
                if (selectedDesignation!.paramname!.toLowerCase() ==
                    'teaching staff') {
                  attendanceList!.forEach((element) {
                    if (element.desigName != "") {
                      if (element.desigName!.toLowerCase() ==
                          'teaching staff') {
                        print(element.desigName);
                        setState(() {
                          localList.add(element);
                        });
                      }
                    }
                  });
                }
                if (selectedDesignation!.paramname!.toLowerCase() ==
                    'non-teaching') {
                  attendanceList!.forEach((element) {
                    if (element.desigName != "") {
                      if (element.desigName!.toLowerCase() == 'non-teaching') {
                        setState(() {
                          localList.add(element);
                        });
                      }
                    }
                  });
                }
                if (selectedDesignation!.paramname!.toLowerCase() ==
                    'pgt teacher') {
                  attendanceList!.forEach((element) {
                    if (element.desigName != "") {
                      if (element.desigName!.toLowerCase() == 'pgt teacher') {
                        setState(() {
                          localList.add(element);
                        });
                      }
                    }
                  });
                }
                if (selectedDesignation!.paramname!.toLowerCase() == 'driver') {
                  attendanceList!.forEach((element) {
                    if (element.desigName != "") {
                      if (element.desigName!.toLowerCase() == 'driver') {
                        setState(() {
                          localList.add(element);
                        });
                      }
                    }
                  });
                }
                if (selectedDesignation!.paramname!.toLowerCase() ==
                    'conducter') {
                  attendanceList!.forEach((element) {
                    if (element.desigName != "") {
                      if (element.desigName!.toLowerCase() == 'conducter') {
                        setState(() {
                          localList.add(element);
                        });
                      }
                    }
                  });
                }
                if (selectedDesignation!.paramname!.toLowerCase() ==
                    'principal') {
                  attendanceList!.forEach((element) {
                    if (element.desigName != "") {
                      if (element.desigName!.toLowerCase() == 'principal') {
                        setState(() {
                          localList.add(element);
                        });
                      }
                    }
                  });
                }
                if (selectedDesignation!.paramname!.toLowerCase() == 'all') {
                  attendanceList!.forEach((element) {
                    setState(() {
                      localList.add(element);
                    });
                  });
                }
                setState(() {
                  attendanceList = localList;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DetailScreen extends StatefulWidget {
  final selImg;

  DetailScreen({
    this.selImg,
  });

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Hero(
          tag: 'detailHero',
          child: Text('test'),
        ),
      ),
    );
  }
}
