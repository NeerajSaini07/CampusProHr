import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/FEE_BALANCE_EMPLOYEE_CUBIT/fee_balance_employee_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/FEE_BALANCE_GET_CLASS_EMPLOYEE_CUBIT/fee_balance_get_class_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/FEE_BALANCE_GET_MONTH_EMPLOYEE_CUBIT/fee_balance_get_month_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/FEE_TYPE_CUBIT/fee_type_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/feeBalanceClassListEmployeeModel.dart';
import 'package:campus_pro/src/DATA/MODELS/feeBalanceEmployeeModel.dart';
import 'package:campus_pro/src/DATA/MODELS/feeBalanceMonthListEmployeeModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class FeeBalance extends StatefulWidget {
  static const routeName = "/fee-balance-employee";
  @override
  _FeeBalanceState createState() => _FeeBalanceState();
}

class _FeeBalanceState extends State<FeeBalance> {
  // _callNumber(String phoneNumber) async {
  //   String number = phoneNumber;
  //   await FlutterPhoneDirectCaller.callNumber(number);
  // }

  String? feeID = "";
  bool isLoader = false;
  String? classId;
  String? monthId;

  int totalBalance = 0;
  int gettingBalance = 0;

  List<FeeBalanceClassListEmployeeModel>? classItem;

  List<FeeBalanceMonthListEmployeeModel>? monthItem;

  FeeBalanceClassListEmployeeModel? selectedClass;

  FeeBalanceMonthListEmployeeModel? selectedMonth;

  bool isChecked = false;

  _launchPhoneURL(String phoneNumber) async {
    String url = 'tel:' + phoneNumber;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  getEmployeeMonth() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final getEmpMonthData = {
      "OUserId": uid!,
      "Token": token!,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "StuEmpId": userData.stuEmpId,
      "UserType": userData.ouserType,
    };
    print('get employee month $getEmpMonthData');
    context
        .read<FeeBalanceMonthListCubit>()
        .feeBalanceMonthListCubitCall(getEmpMonthData);
  }

  getEmployeeClass() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final getEmpClassData = {
      "OUserId": uid!,
      "Token": token!,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "SessionId": userData.currentSessionid,
      "EmpId": userData.stuEmpId,
    };
    print('Get Emp class $getEmpClassData');
    context
        .read<FeeBalanceClassListEmployeeCubit>()
        .feeBalanceClassListEmployeeCubitCall(getEmpClassData);
  }

  getBalanceList({
    String? classid,
    String? feeid,
    String? monthid,
  }) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final getFeeList = {
      "OUserId": uid!,
      "Token": token!,
      "OrgId": userData!.organizationId,
      "SchoolID": userData.schoolId,
      "SessionID": userData.currentSessionid,
      "ClassId": classid.toString(),
      "FeeId": feeid.toString(),
      "MonthId": monthid.toString(),
      "chkDefOnly": "1",
      "chkAdvPaid": "0",
      "chkOnlyAdv": "0",
      "chkIncludeDischarge": "0",
      "ClassGroupID": "0",
      "SortOn": "1",
    };
    print('fee List $getFeeList');
    context
        .read<FeeBalanceEmployeeCubit>()
        .feeBalanceEmployeeCubitCall(getFeeList);
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
      "ParamType": "Fee Category",
    };
    print('feeType Data $feeTypeData');
    context.read<FeeTypeCubit>().feeTypeCubitCall(feeTypeData);
  }

  @override
  void initState() {
    super.initState();
    isChecked = false;
    selectedClass = FeeBalanceClassListEmployeeModel(
        classId: "", className: "", allowSendHomework: "");
    classItem = [];
    selectedMonth =
        FeeBalanceMonthListEmployeeModel(monthID: "", monthName: "");
    monthItem = [];
    getFeeType();
    getEmployeeClass();
    getEmployeeMonth();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _refresh() async {
    Future.delayed(Duration(seconds: 1)).then((value) {
      isChecked = false;
      selectedClass = FeeBalanceClassListEmployeeModel(
          classId: "", className: "", allowSendHomework: "");
      classItem = [];
      selectedMonth =
          FeeBalanceMonthListEmployeeModel(monthID: "", monthName: "");
      monthItem = [];
      getFeeType();
      getEmployeeClass();
      getEmployeeMonth();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, title: 'Balance Detail'),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: MultiBlocListener(
          listeners: [
            BlocListener<FeeTypeCubit, FeeTypeState>(
              listener: (context, state) {
                if (state is FeeTypeLoadSuccess) {
                  setState(() {
                    feeID = state.feeTypes[0].iD;
                  });
                }
                if (state is FeeTypeLoadFail) {
                  if (state.failReason == "false") {
                    UserUtils.unauthorizedUser(context);
                  }
                }
              },
            )
          ],
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(12),
                child: Row(
                  children: [
                    BlocConsumer<FeeBalanceClassListEmployeeCubit,
                        FeeBalanceClassListEmployeeState>(
                      listener: (context, state) {
                        if (state is ClassListEmployeeLoadSuccess) {
                          setState(() {
                            state.classList.forEach((element) {
                              if (element.isClassTeacher == "Y") {
                                classItem!.add(element);
                              }
                            });
                            classId = classItem![0].classId;
                            selectedClass = classItem![0];
                            // classId = state.classList[0].classId;
                            // print(state.classList[1].classId);
                            // //classId = state.classList[0].iD!.split('#')[0];
                            // selectedClass = state.classList[0];
                            // classItem = state.classList;
                          });
                        }
                        if (state is ClassListEmployeeLoadFail) {
                          if (state.failReason == "false") {
                            UserUtils.unauthorizedUser(context);
                          }
                          setState(() {
                            selectedClass = FeeBalanceClassListEmployeeModel(
                                classId: "",
                                className: "",
                                allowSendHomework: "");
                            classItem = [];
                          });
                        }
                      },
                      builder: (context, state) {
                        if (state is ClassListEmployeeLoadInProgress) {
                          return buildClassDropDown();
                          //return CircularProgressIndicator();
                        } else if (state is ClassListEmployeeLoadSuccess) {
                          return buildClassDropDown();
                        }
                        // else if (state is ClassListEmployeeLoadFail) {
                        //   return buildClassDropDown();
                        // }
                        else {
                          return Container();
                        }
                      },
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.040,
                    ),
                    BlocConsumer<FeeBalanceMonthListCubit,
                        FeeBalanceGetMonthState>(
                      listener: (context, state) {
                        if (state is MonthListEmployeeLoadSuccess) {
                          setState(() {
                            monthId = state.monthList[0].monthID;
                            selectedMonth = state.monthList[0];
                            monthItem = state.monthList;
                            gettingBalance = 0;
                          });
                          // getBalanceList(
                          //     classid: classId.replaceAll("#", ","),
                          //     monthid: monthId,
                          //     feeid: feeID);
                        }
                        if (state is MonthListEmployeeLoadFail) {
                          if (state.failReason == "false") {
                            UserUtils.unauthorizedUser(context);
                          }
                          setState(() {
                            selectedMonth = FeeBalanceMonthListEmployeeModel(
                              monthID: "",
                              monthName: "",
                            );
                            monthItem = [];
                          });
                        }
                      },
                      builder: (context, state) {
                        if (state is MonthListEmployeeLoadInProgress) {
                          //return CircularProgressIndicator();
                          return buildMonthDropDown();
                        } else if (state is MonthListEmployeeLoadSuccess) {
                          return buildMonthDropDown();
                        }
                        // else if (state is MonthListEmployeeLoadFail) {
                        //   return buildMonthDropDown();
                        // }
                        else {
                          return Container();
                        }
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              isLoader == false
                  ? PhysicalModel(
                      color: Colors.transparent,
                      shadowColor: Colors.transparent,
                      elevation: 10,
                      child: Container(
                        height: MediaQuery.of(context).size.width * 0.09,
                        width: MediaQuery.of(context).size.width * 0.3,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: InkWell(
                          hoverColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: () async {
                            setState(() {
                              totalBalance = 0;
                              isChecked = true;
                            });
                            await getBalanceList(
                              classid: classId!.replaceAll("#", ","),
                              monthid: monthId,
                              feeid: feeID,
                            );
                          },
                          child: Center(
                            child: Text(
                              'View',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    )
                  // : CircularProgressIndicator(),
                  : LinearProgressIndicator(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Divider(
                thickness: 2.0,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.00,
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin:
                        EdgeInsets.only(left: 8, right: 6, top: 6, bottom: 4),
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: Center(
                      child: Text(
                        'Details',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.only(left: 7, right: 0, top: 6, bottom: 4),
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    //width: MediaQuery.of(context).size.width / 2,
                    child: Center(
                        child: Row(
                      children: [
                        RichText(
                            text: TextSpan(
                          text: 'Total Balance : ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        )),
                        // Text(
                        //   'Total Balance : ',
                        //   style: TextStyle(color: Colors.black, fontSize: 16),
                        // ),
                        // Text(
                        //   '₹ $totalBalance',
                        //   style: TextStyle(
                        //       color: Colors.red,
                        //       fontSize: 16,
                        //       fontWeight: FontWeight.bold),
                        // ),
                        RichText(
                            text: TextSpan(
                          text: '₹ $totalBalance',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        )),
                      ],
                    )),
                  ),
                ],
              ),
              Divider(
                thickness: 1.0,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              isChecked == true
                  ? BlocConsumer<FeeBalanceEmployeeCubit,
                      FeeBalanceEmployeeState>(
                      listener: (context, state) {
                        if (state is FeeBalanceEmployeeLoadSuccess)
                          state.feeList.forEach((element) {
                            setState(() {
                              totalBalance = totalBalance +
                                  int.tryParse(element.balAmount!)!;
                            });
                          });
                        if (state is FeeBalanceEmployeeLoadFail) {
                          if (state.failReason == "false") {
                            UserUtils.unauthorizedUser(context);
                          }
                        }
                      },
                      builder: (context, state) {
                        if (state is FeeBalanceEmployeeLoadInProgress) {
                          // return Container(
                          //     height: 10,
                          //     width: 10,
                          //     child: CircularProgressIndicator());
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 0),
                            child: LinearProgressIndicator(),
                          );
                        } else if (state is FeeBalanceEmployeeLoadSuccess) {
                          return feeListCheck(feeList: state.feeList);
                        } else if (state is FeeBalanceEmployeeLoadFail) {
                          return feeListCheck(error: state.failReason);
                        } else {
                          return Container();
                        }
                      },
                    )
                  : Container()
              //buildFeeList(),
            ],
          ),
        ),
      ),
    );
  }

  Expanded feeListCheck(
      {List<FeeBalanceEmployeeModel>? feeList, String? error}) {
    if (feeList == null || feeList.isEmpty) {
      if (error != null) {
        return Expanded(
            child: Text(
          '$error',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0),
        ));
      } else {
        return Expanded(
          child: Text(
            '$NO_RECORD_FOUND',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0),
          ),
        );
      }
    } else {
      return buildFeeList(feeList: feeList);
    }
  }

  Expanded buildFeeList({List<FeeBalanceEmployeeModel>? feeList}) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(
          height: 3,
        ),
        itemCount: feeList!.length,
        itemBuilder: (context, index) {
          var item = feeList[index];
          // gettingBalance += int.parse(item.balAmount!);
          return Container(
            margin: EdgeInsets.only(left: 8, right: 8, top: 6, bottom: 4),
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
                border: Border.all(width: 0.2),
                borderRadius: BorderRadius.circular(3),
                color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        //' ${items[index][0][0]} - ${items[index][0][1]}',
                        '${item.admNo} - ${item.studentName}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                    ),
                    Row(
                      children: [
                        Text(
                          'Bal :',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.red,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          ' ₹ ${item.balAmount}',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                item.guardianMobileNo != null
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height * 0.00,
                      )
                    : SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Flexible(
                                child: Text(
                                  'Father Name :',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                              ),
                              Text(
                                '  ${item.fatherName}',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        item.guardianMobileNo != null
                            ? IconButton(
                                constraints: BoxConstraints(),
                                onPressed: () {
                                  //_callNumber(items[index][2][0]);
                                  _launchPhoneURL(item.guardianMobileNo!);
                                },
                                icon: Icon(
                                  Icons.phone,
                                  size: 20,
                                  color: Theme.of(context).primaryColor,
                                  //color: Colors.cyanAccent[400],
                                ),
                              )
                            : Container()
                      ],
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Expanded buildClassDropDown() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Class',
            style: Theme.of(context).textTheme.titleLarge,
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
            child: DropdownButton<FeeBalanceClassListEmployeeModel>(
              isDense: true,
              value: selectedClass,
              key: UniqueKey(),
              isExpanded: true,
              underline: Container(),
              items: classItem!
                  .map(
                    (value) =>
                        DropdownMenuItem<FeeBalanceClassListEmployeeModel>(
                      child: Text(value.className.toString()),
                      value: value,
                    ),
                  )
                  .toList(),
              onChanged: (val) {
                setState(
                  () {
                    selectedClass = val;
                    //classId = dropDownClassValue!.iD!.split('#')[0];
                    classId = selectedClass!.classId;
                  },
                );
                print(classId);
              },
            ),
          ),
        ],
      ),
    );
  }

  Expanded buildMonthDropDown() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Month',
            style: Theme.of(context).textTheme.titleLarge,
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
            child: DropdownButton<FeeBalanceMonthListEmployeeModel>(
              isDense: true,
              value: selectedMonth,
              key: UniqueKey(),
              isExpanded: true,
              underline: Container(),
              items: monthItem!
                  .map(
                    (value) =>
                        DropdownMenuItem<FeeBalanceMonthListEmployeeModel>(
                      child: Text(value.monthName.toString()),
                      value: value,
                    ),
                  )
                  .toList(),
              onChanged: (val) {
                setState(
                  () {
                    selectedMonth = val;
                    monthId = selectedMonth!.monthID;
                    gettingBalance = 0;
                  },
                );
                // getBalanceList(
                //     classid: classId.replaceAll("#", ","),
                //     monthid: monthId,
                //     feeid: feeID);
                print(monthId);
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Container(
//   width: MediaQuery.of(context).size.width,
//   child: Row(
//     mainAxisAlignment: MainAxisAlignment.spaceAround,
//     children: [
//       Text(
//         'Student Details',
//         style: TextStyle(),
//       ),
//       Text(
//         'Balance :- $totalBalance',
//         style: TextStyle(),
//       ),
//       Text(
//         'Mobile Number',
//         style: TextStyle(),
//       )
//     ],
//   ),
// ),

// Flexible(
//   child: Text(
//     '  ${items[index][0][2]}',
//     style: TextStyle(
//         fontSize: 15, color: Colors.black),
//   ),
// ),
// SizedBox(
//   width: MediaQuery.of(context).size.width * 0.2,
// ),

// SizedBox(
//   height: MediaQuery.of(context).size.height * 0.005,
// ),
// Row(
//   crossAxisAlignment: CrossAxisAlignment.baseline,
//   textBaseline: TextBaseline.alphabetic,
//   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   children: [
//     Text(
//       'Admission No : ',
//       style: TextStyle(
//           fontSize: 15, color: Colors.black),
//     ),
//     SizedBox(
//       width: MediaQuery.of(context).size.width * 0.1,
//     ),
//     Text(
//       ' ${items[index][0][0]} ',
//       style: TextStyle(
//           fontSize: 16, color: Colors.black),
//     ),
//   ],
// )

//   Container(
//   margin: EdgeInsets.only(left: 8, right: 8, top: 6, bottom: 4),
//   padding: EdgeInsets.all(6),
//   decoration: BoxDecoration(
//       border: Border.all(width: 0.2),
//       borderRadius: BorderRadius.circular(13),
//       //color: Colors.black54
//       color: Colors.blueGrey
//       //color: Colors.black,
//       ),
//   child: Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Container(
//         padding: EdgeInsets.only(left: 5, right: 5),
//         decoration: BoxDecoration(
//             border: Border.all(width: 0.2),
//             borderRadius: BorderRadius.circular(13),
//             //    color: Colors.grey[400],
//             color: Colors.white),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               'Name : ${items[index][0][1]}',
//               style: TextStyle(
//                 fontSize: 15,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(
//               width: MediaQuery.of(context).size.width * 0.1,
//             ),
//             Row(
//               children: [
//                 Text(
//                   'Balance :',
//                   style: TextStyle(
//                       color: Colors.red,
//                       fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   ' ₹ ${items[index][1][0]}',
//                   style: TextStyle(
//                       fontSize: 15,
//                       fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//       SizedBox(
//         height: MediaQuery.of(context).size.width * 0.01,
//       ),
//       Container(
//         padding: EdgeInsets.only(
//             left: 5, right: 5, top: 5, bottom: 5),
//         decoration: BoxDecoration(
//           border: Border.all(width: 0.2),
//           borderRadius: BorderRadius.circular(13),
//           color: Colors.white,
//         ),
//         child: Column(
//           children: [
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.baseline,
//               textBaseline: TextBaseline.alphabetic,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Admission No : ',
//                   style: TextStyle(
//                       fontSize: 15, color: Colors.black),
//                 ),
//                 SizedBox(
//                   width:
//                       MediaQuery.of(context).size.width * 0.1,
//                 ),
//                 Text(
//                   ' ${items[index][0][0]} ',
//                   style: TextStyle(
//                       fontSize: 16, color: Colors.black),
//                 ),
//               ],
//             ),
//             SizedBox(
//               height:
//                   MediaQuery.of(context).size.height * 0.005,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.baseline,
//               textBaseline: TextBaseline.alphabetic,
//               children: [
//                 Flexible(
//                   child: Text(
//                     'Father Name :',
//                     style: TextStyle(
//                         fontSize: 15, color: Colors.black),
//                   ),
//                 ),
//                 Flexible(
//                   child: Text(
//                     '  ${items[index][0][2]}',
//                     style: TextStyle(
//                         fontSize: 15, color: Colors.black),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(
//               height:
//                   MediaQuery.of(context).size.height * 0.005,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 Icon(
//                   Icons.phone,
//                   size: 20,
//                   //color: Colors.lightBlueAccent[700],
//                   color: Colors.cyanAccent[400],
//                 ),
//                 SizedBox(
//                   width:
//                       MediaQuery.of(context).size.width * 0.01,
//                 ),
//                 // Text(
//                 //   'Phone Number : ',
//                 //   style: TextStyle(
//                 //       fontSize: 15, color: Colors.white),
//                 // ),
//                 Text(
//                   '${items[index][2][0]}',
//                   style: TextStyle(
//                       fontSize: 16, color: Colors.black),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       )
//     ],
//   ),
// );

// SizedBox(
//   height: MediaQuery.of(context).size.height * 0.005,
// ),
// Row(
//   mainAxisAlignment: MainAxisAlignment.start,
//   children: [
//     Icon(
//       Icons.phone,
//       size: 20,
//       color: Theme.of(context).primaryColor,
//       //color: Colors.cyanAccent[400],
//     ),
//     SizedBox(
//       width: MediaQuery.of(context).size.width * 0.01,
//     ),
//     // Text(
//     //   'Phone Number : ',
//     //   style: TextStyle(
//     //       fontSize: 15, color: Colors.white),
//     // ),
//     Text(
//       '${items[index][2][0]}',
//       style: TextStyle(
//           fontSize: 16, color: Colors.black),
//     ),
//   ],
// ),
