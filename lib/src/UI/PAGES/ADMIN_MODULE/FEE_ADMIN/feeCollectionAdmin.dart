import 'package:campus_pro/src/DATA/BLOC_CUBIT/MAIN_MODE_WISE_FEE_CUBIT/main_mode_wise_fee_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/PAY_MODE_WISE_FEE_CUBIT/pay_mode_wise_fee_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/YEAR_SESSION_CUBIT/year_session_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/mainModeWiseFeeModel.dart';
import 'package:campus_pro/src/DATA/MODELS/payModeWiseFeeModel.dart';
import 'package:campus_pro/src/DATA/MODELS/yearSessionModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/drawerWidget.dart';
import 'package:campus_pro/src/UI/WIDGETS/noRecordFound.dart';
import 'package:campus_pro/src/UI/WIDGETS/sessionCreator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class FeeCollectionAdmin extends StatefulWidget {
  static const routeName = "/fee-collection-admin";

  const FeeCollectionAdmin({Key? key}) : super(key: key);

  @override
  _FeeCollectionAdminState createState() => _FeeCollectionAdminState();
}

class _FeeCollectionAdminState extends State<FeeCollectionAdmin> {
  int totalCollection = 0;

  YearSessionModel? selectedYear;

  List<YearSessionModel>? yearDropdown = [];

  DateTime selectedFromDate = DateTime.now();
  DateTime selectedToDate = DateTime.now();

  Future<void> _selectDate(BuildContext context, {int? index}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: index == 0 ? selectedFromDate : selectedToDate,
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
      helpText: index == 0 ? "SELECT FROM DATE" : "SELECT TO DATE",
    );
    if (picked != null)
      setState(() {
        if (index == 0) {
          selectedFromDate = picked;
        } else {
          selectedToDate = picked;
        }
        getFeeCollectionData();
      });
  }

  @override
  void initState() {
    selectedYear = YearSessionModel(id: "", sessionFrom: "", status: "");
    // getFeeCollectionData();
    getYearSession();
    super.initState();
  }

  void getYearSession() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final requestPayload = {
      "OUserId": uid,
      "Token": token,
      "EmpId": userData!.stuEmpId,
      "OrgID": userData.organizationId,
      "SchoolID": userData.schoolId,
      "UserType": userData.ouserType,
    };
    print("Sending YearSession data => $requestPayload");
    context.read<YearSessionCubit>().yearSessionCubitCall(requestPayload);
  }

  getFeeCollectionData() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final collectionData = {
      'OUserId': uid,
      'Token': token,
      'OrgId': userData!.organizationId,
      'Schoolid': userData.schoolId,
      'SessionID': selectedYear!.id,
      'EmpId': userData.stuEmpId,
      'UserType': userData.ouserType,
      'FromDate': DateFormat("dd-MMM-yyyy").format(selectedFromDate),
      'TillDate': DateFormat("dd-MMM-yyyy").format(selectedToDate),
    };
    print("Sending MainAndPayModeWiseFee data => $collectionData");
    context
        .read<MainModeWiseFeeCubit>()
        .mainModeWiseFeeCubitCall(collectionData);
    context.read<PayModeWiseFeeCubit>().payModeWiseFeeCubitCall(collectionData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: commonAppBar(context, title: "Fee Collection"),
      body: MultiBlocListener(
        listeners: [
          BlocListener<YearSessionCubit, YearSessionState>(
            listener: (context, state) {
              if (state is YearSessionLoadSuccess) {
                final session = getCustomYear();
                Future.delayed(Duration(microseconds: 300));
                print("yearDropdown![ created : $session");
                setState(() {
                  yearDropdown = state.yearSessionList;
                  final index = yearDropdown!
                      .indexWhere((element) => element.sessionFrom == session);
                  selectedYear = yearDropdown![index];
                  print("yearDropdown![index] : ${yearDropdown![index]}");
                });
                getFeeCollectionData();
              }
              if (state is YearSessionLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                } else {
                  setState(() {
                    yearDropdown = [];
                    selectedYear =
                        YearSessionModel(id: "", sessionFrom: "", status: "");
                  });
                }
              }
            },
          ),
        ],
        child: Column(
          children: [
            // buildYearSessionDropdown(context),
            Divider(color: Color(0xffECECEC), thickness: 2, height: 0),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  buildYearSessionDropdown(),
                  buildDatePicker(
                      title: "From", date: selectedFromDate, index: 0),
                  buildDatePicker(title: "To", date: selectedToDate, index: 1),
                ],
              ),
            ),
            Divider(color: Color(0xffECECEC), thickness: 2, height: 0),
            // SizedBox(height: 10.0),
            Expanded(
              child: Container(
                child: ListView(
                  children: [
                    BlocConsumer<PayModeWiseFeeCubit, PayModeWiseFeeState>(
                      listener: (context, state) {
                        if (state is PayModeWiseFeeLoadFail) {
                          if (state.failReason == "false") {
                            UserUtils.unauthorizedUser(context);
                          } else {
                            setState(() {
                              totalCollection = 0;
                            });
                          }
                        }
                        if (state is PayModeWiseFeeLoadSuccess) {
                          // setState(() {
                          //   state.mainModeWiseFee.forEach((element) {
                          //     totalCollection =
                          //         totalCollection + int.tryParse(element.amount!)!;
                          //   });
                          // });
                        }
                      },
                      builder: (context, state) {
                        if (state is PayModeWiseFeeLoadInProgress) {
                          return LinearProgressIndicator();
                        } else if (state is PayModeWiseFeeLoadSuccess) {
                          return buildPayModeCollectionBody(
                              context, state.payModeWiseFeeList);
                        } else if (state is PayModeWiseFeeLoadFail) {
                          return noRecordFound();
                        } else {
                          return Container();
                        }
                      },
                    ),
                    BlocConsumer<MainModeWiseFeeCubit, MainModeWiseFeeState>(
                      listener: (context, state) {
                        if (state is MainModeWiseFeeLoadFail) {
                          if (state.failReason == "false") {
                            UserUtils.unauthorizedUser(context);
                          } else {
                            setState(() {
                              totalCollection = 0;
                            });
                          }
                        }
                        if (state is MainModeWiseFeeLoadSuccess) {
                          setState(() {
                            totalCollection = 0;
                            state.mainModeWiseFee.forEach((element) {
                              totalCollection = totalCollection +
                                  int.tryParse(element.amount!)!;
                            });
                          });
                        }
                      },
                      builder: (context, state) {
                        if (state is MainModeWiseFeeLoadInProgress) {
                          // return LinearProgressIndicator();
                          return Container();
                        } else if (state is MainModeWiseFeeLoadSuccess) {
                          return buildMainModeCollectionBody(
                              context, state.mainModeWiseFee);
                        } else if (state is MainModeWiseFeeLoadFail) {
                          return noRecordFound();
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Flexible buildYearSessionDropdown() {
    return Flexible(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            buildLabels("Session"),
            Container(
              child: DropdownButton<YearSessionModel>(
                isDense: true,
                value: selectedYear,
                key: UniqueKey(),
                isExpanded: true,
                underline: Container(),
                items: yearDropdown!
                    .map((item) => DropdownMenuItem<YearSessionModel>(
                        child: Text(item.sessionFrom!,
                            style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold)),
                        value: item))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    selectedYear = val;
                    print("selectedYear: $val");
                    getFeeCollectionData();
                  });
                },
              ),
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Flexible buildDatePicker({String? title, DateTime? date, int? index}) {
    return Flexible(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(width: 2, color: Color(0xffECECEC)),
            // right: BorderSide(width: 2, color: Color(0xffECECEC)),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            buildLabels(title!),
            InkWell(
              onTap: () => _selectDate(context, index: index),
              child: Container(
                child: Text(
                  DateFormat("dd-MMM-yyyy").format(date!),
                  style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Container buildPayModeCollectionBody(
      context, PayModeWiseFeeModel payModeWiseFeeList) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            color: Colors.blue.withOpacity(0.06),
            child: Text(
              "Pay Mode Wise",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Total: ",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                Text(
                  payModeWiseFeeList.total!,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[400]),
                ),
              ],
            ),
          ),
          buildEntries(context, title: "Cash", amount: payModeWiseFeeList.cash),
          SizedBox(
            height: 15,
          ),
          buildEntries(context,
              title: "Cheque", amount: payModeWiseFeeList.cheque),
          SizedBox(
            height: 15,
          ),
          buildEntries(context,
              title: "Online", amount: payModeWiseFeeList.online),
          SizedBox(
            height: 15,
          ),
          buildEntries(context,
              title: "Swipe Machine", amount: payModeWiseFeeList.swipeMachine),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  Widget buildMainModeCollectionBody(
      context, List<MainModeWiseFeeModel> mainModeWiseFeeList) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(8.0),
      ),
      // child: ListView.builder(
      //   physics: NeverScrollableScrollPhysics(),
      //   shrinkWrap: true,
      //   // separatorBuilder: (BuildContext context, int index) => Divider(),
      //   itemCount: mainModeWiseFeeList.length,
      //   itemBuilder: (context, i) {
      //     var item = mainModeWiseFeeList[i];
      //     return buildEntries(context,
      //         title: item.feeHead, amount: item.amount);
      //   },
      // ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            color: Colors.blue.withOpacity(0.06),
            child: Text(
              "Main Category Breakup Head Wise",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.w600, fontSize: 18),
            ),
          ),
          Container(
            // color: Colors.red[400],
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Total: ",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                Text(
                  totalCollection.toString(),
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
              ],
            ),
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            // separatorBuilder: (BuildContext context, int index) => Divider(),
            itemCount: mainModeWiseFeeList.length,
            itemBuilder: (context, i) {
              var item = mainModeWiseFeeList[i];
              return Column(
                children: [
                  buildEntries(context,
                      title: item.feeHead, amount: item.amount),
                  SizedBox(
                    height: 15,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget buildEntries(BuildContext context, {String? title, String? amount}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title!,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          Text(
            "$amount",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
    //   ListTile(
    //   title: Text(
    //     title!,
    //     style: Theme.of(context)
    //         .textTheme
    //         .headline6!
    //         .copyWith(fontWeight: FontWeight.w600, fontSize: 16),
    //   ),
    //   trailing: Text(
    //     "$amount",
    //     style: Theme.of(context).textTheme.headline6!.copyWith(
    //           fontSize: 16,
    //           fontWeight: FontWeight.bold,
    //         ),
    //   ),
    // );
  }

  Padding buildLabels(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0.0),
      child: Text(
        label,
        style: TextStyle(
          // color: Theme.of(context).primaryColor,
          color: Color(0xff313131),
        ),
      ),
    );
  }
}
