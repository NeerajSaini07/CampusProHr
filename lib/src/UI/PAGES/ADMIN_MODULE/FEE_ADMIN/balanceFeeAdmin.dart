import 'package:campus_pro/src/DATA/BLOC_CUBIT/BALANCE_FEE_ADMIN_CUBIT/balance_fee_admin_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/FEE_BALANCE_GET_MONTH_EMPLOYEE_CUBIT/fee_balance_get_month_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/FEE_HEAD_BALANCEE_FEE_CUBIT/fee_head_balance_fee_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/FEE_TYPE_CUBIT/fee_type_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/balanceFeeAdminModel.dart';
import 'package:campus_pro/src/DATA/MODELS/feeBalanceMonthListEmployeeModel.dart';
import 'package:campus_pro/src/DATA/MODELS/feeHeadBalanceFeeModel.dart';
import 'package:campus_pro/src/DATA/MODELS/feeTypeModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/drawerWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

class BalanceFeeAdmin extends StatefulWidget {
  static const routeName = "/balance-fee-admin";

  const BalanceFeeAdmin({Key? key}) : super(key: key);

  @override
  _BalanceFeeAdminState createState() => _BalanceFeeAdminState();
}

class _BalanceFeeAdminState extends State<BalanceFeeAdmin> {
  List<FeeHeadBalanceFeeModel> _selectedFeeHeadList =
      []; // Fee Head after Seletion
  List<FeeHeadBalanceFeeModel>? feeHeadListMulti = []; // Fee Head After API
  final _feeHeadSelectKey = GlobalKey<FormFieldState>();

  FeeTypeModel? selectedFeeCategory;
  List<FeeTypeModel> feeCategoryDropdown = [];

  FeeBalanceMonthListEmployeeModel? selectedMonth;
  List<FeeBalanceMonthListEmployeeModel> monthDropdown = [];

  List<BalanceFeeAdminModel>? balanceFeeList = [];

  final _filterKey = GlobalKey<FormState>();

  int? totalAmount = 0;

  bool showLoader = false;
  bool showFilters = true;

  @override
  void initState() {
    getFeeType();
    getEmployeeMonth();
    getFeeHead();
    super.initState();
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

  getFeeType() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final feeTypeData = {
      "OUserId": uid!,
      "Token": token!,
      "OrgId": userData!.organizationId!,
      "Schoolid": userData.schoolId!,
      "EmpStuId": userData.stuEmpId!,
      "UserType": userData.ouserType!,
      "ParamType": "Fee Category",
    };
    context.read<FeeTypeCubit>().feeTypeCubitCall(feeTypeData);
  }

  getFeeHead() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final feeHeadData = {
      'OUserId': uid,
      'Token': token,
      'OrganizationId': userData!.organizationId,
      'SchoolId': userData.schoolId,
      'EmpId': userData.stuEmpId,
      'UserType': userData.ouserType
    };
    print("Sending FeeHeadBalanceFee Data => $feeHeadData");
    context
        .read<FeeHeadBalanceFeeCubit>()
        .feeHeadBalanceFeeCubitCall(feeHeadData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: commonAppBar(context, title: "Balance Fee"),
      body: MultiBlocListener(
        listeners: [
          BlocListener<FeeBalanceMonthListCubit, FeeBalanceGetMonthState>(
            listener: (context, state) {
              if (state is MonthListEmployeeLoadSuccess) {
                setState(() {
                  monthDropdown = state.monthList;
                });
              }
              if (state is MonthListEmployeeLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                } else {
                  setState(() {
                    monthDropdown = [];
                  });
                }
              }
            },
          ),
          BlocListener<FeeTypeCubit, FeeTypeState>(
            listener: (context, state) {
              if (state is FeeTypeLoadSuccess) {
                setState(() {
                  feeCategoryDropdown = state.feeTypes;
                });
              }
              if (state is FeeTypeLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                } else {
                  setState(() {
                    feeCategoryDropdown = [];
                  });
                }
              }
            },
          ),
          BlocListener<FeeHeadBalanceFeeCubit, FeeHeadBalanceFeeState>(
            listener: (context, state) {
              if (state is FeeHeadBalanceFeeLoadSuccess) {
                setState(() {
                  feeHeadListMulti = state.feeHeads;
                });
              }
              if (state is FeeHeadBalanceFeeLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                } else {
                  setState(() {
                    feeHeadListMulti = [];
                  });
                }
              }
            },
          ),
          BlocListener<BalanceFeeAdminCubit, BalanceFeeAdminState>(
            listener: (context, state) {
              if (state is BalanceFeeAdminLoadInProgress) {
                showLoader = true;
                balanceFeeList = [];
                totalAmount = 0;
              }
              if (state is BalanceFeeAdminLoadSuccess) {
                setState(() {
                  showLoader = false;
                  balanceFeeList = state.balanceFeeAdmin;
                  balanceFeeList!.forEach((element) {
                    totalAmount =
                        totalAmount! + int.tryParse(element.balanceAmt!)!;
                  });
                });
              }
              if (state is BalanceFeeAdminLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                } else {
                  setState(() {
                    showLoader = false;
                    balanceFeeList = [];
                    totalAmount = 0;
                  });
                }
              }
            },
          ),
        ],
        child: buildBalanceFeeBody(context),
      ),
    );
  }

  Widget buildBalanceFeeBody(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        buildAddEnquiry(context),
        if (showFilters) buildTopFilter(context),
        if (showLoader) LinearProgressIndicator(),
        Expanded(
          child: Container(
            // color: Colors.white,
            child: ListView(shrinkWrap: true, children: [
              Column(
                children: [
                  Container(
                    // color: Colors.blue[200],
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildHeading(title: "Classes"),
                        buildHeading(title: "Balance"),
                      ],
                    ),
                  ),
                  Divider(thickness: 4),
                  SizedBox(height: 8),
                  ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(),
                    itemCount: balanceFeeList!.length,
                    itemBuilder: (context, i) {
                      var item = balanceFeeList![i];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildLabels(label: item.className),
                            buildLabels(label: item.balanceAmt),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ]),
          ),
        ),
        Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildHeading(
                  title: "Total Balance",
                  color: Theme.of(context).primaryColor),
              buildHeading(
                  title: totalAmount.toString(),
                  color: Theme.of(context).primaryColor),
            ],
          ),
        ),
        // InkWell(
        //   onTap: () {
        //     showAdvanceFilters();
        //   },
        //   child: Container(
        //     color: Colors.white,
        //     width: MediaQuery.of(context).size.width,
        //     padding: const EdgeInsets.symmetric(vertical: 12.0),
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         Text("Advance Filter",
        //             style: GoogleFonts.quicksand(fontWeight: FontWeight.bold)),
        //         SizedBox(width: 8),
        //         Icon(Icons.filter_list),
        //       ],
        //     ),
        //   ),
        // ),
      ],
    );
  }

  Row buildAddEnquiry(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            setState(() => showFilters = !showFilters);
          },
          child: Container(
            padding: const EdgeInsets.all(8.0),
            // color: Theme.of(context).primaryColor,
            child: Row(
              children: [
                Icon(Icons.sort),
                Text("Filters",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ),
        // InkWell(
        //   onTap: () {
        //     // Navigator.pushNamed(context, AddNewEnquiry.routeName);
        //     // _drawerKey.currentState!.openEndDrawer();
        //   },
        //   child: Container(
        //     padding: const EdgeInsets.all(8.0),
        //     // color: Theme.of(context).primaryColor,
        //     child: Row(
        //       children: [
        //         Icon(Icons.add, color: Theme.of(context).primaryColor),
        //         Text("New Enquiry",
        //             style: TextStyle(
        //                 color: Theme.of(context).primaryColor,
        //                 fontWeight: FontWeight.bold)),
        //       ],
        //     ),
        //   ),
        // ),
      ],
    );
  }

  Container buildTopFilter(BuildContext context) {
    return Container(
      color: Color(0xffECECEC),
      // child: AdvanceFilters(),
      child: Form(
        key: _filterKey,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    buildFeeDropdown(),
                    SizedBox(width: 20),
                    buildMonthDropdown(),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: buildFeeHeadMultiSelect(context),
              ),
              // SizedBox(height: 20),
              buildSearchButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLabels({String? label}) {
    return Text(
      label!,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.quicksand(
        fontSize: 16,
        color: Color(0xff313131),
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Container buildHeading({String? title, Color? color}) {
    return Container(
      child: Text(
        title!,
        style: GoogleFonts.quicksand(
          color: color ?? Color(0xff777777),
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // showAdvanceFilters() {
  //   showModalBottomSheet<void>(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AdvanceFilters();
  //     },
  //   );
  // }

  Widget buildFeeHeadMultiSelect(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildLabels(label: "Fee Head"),
        Container(
          alignment: Alignment.center,
          // padding: EdgeInsets.symmetric(horizontal: 10),
          child: MultiSelectBottomSheetField<FeeHeadBalanceFeeModel>(
            autovalidateMode: AutovalidateMode.disabled,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
            ),
            key: _feeHeadSelectKey,
            initialValue: _selectedFeeHeadList,
            initialChildSize: 0.7,
            maxChildSize: 0.95,
            searchIcon: Icon(Icons.ac_unit),
            title: Text("Fee Head",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 18)),
            buttonText: Text(
              _selectedFeeHeadList.length > 0
                  ? "${_selectedFeeHeadList.length} Fee Head selected"
                  : "None selected",
            ),
            // items: _items,
            items: feeHeadListMulti!
                .map((feeHeadList) =>
                    MultiSelectItem(feeHeadList, feeHeadList.feeName!))
                .toList(),
            searchable: false,
            validator: (values) {
              if (values == null || values.isEmpty) {
                return "Required";
              }
              // List<String> names = values.map((e) => e.name!).toList();
              // if (names.contains("Frog")) {
              //   return "Frogs are weird!";
              // }
              return null;
            },
            onConfirm: (values) {
              setState(() {
                _selectedFeeHeadList = values;
              });
              _feeHeadSelectKey.currentState!.validate();
              // getSubjectList(_selectedClassList);
              // getStudentsList(_selectedClassList);
              // getTodayList(_selectedClassList);
            },
            chipDisplay: MultiSelectChipDisplay.none(),
            // chipDisplay: MultiSelectChipDisplay(
            //   shape: RoundedRectangleBorder(),
            //   textStyle: TextStyle(
            //       fontWeight: FontWeight.w900,
            //       color: Theme.of(context).primaryColor),
            //   // chipColor: Colors.grey,
            //   // onTap: (item) {
            //   //   setState(() {
            //   //     _selectedClassList.remove(item);
            //   //   });
            //   //   _classSelectKey.currentState!.validate();
            //   // },
            // ),
          ),
        ),
      ],
    );
  }

  Widget buildSearchButton() {
    return InkWell(
      onTap: () async {
        getSearchData();
        setState(() => showFilters = !showFilters);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: Theme.of(context).primaryColor,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.search, color: Colors.white),
            SizedBox(width: 4),
            Text(
              "Search",
              style: TextStyle(
                  fontFamily: "BebasNeue-Regular", color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Expanded buildFeeDropdown() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          buildLabels(label: "Fee Category"),
          SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButton<FeeTypeModel>(
              hint: Text("Select"),
              isDense: true,
              value: selectedFeeCategory,
              key: UniqueKey(),
              isExpanded: true,
              underline: Container(),
              items: feeCategoryDropdown
                  .map((item) => DropdownMenuItem<FeeTypeModel>(
                      child: Text(item.paramname!,
                          style: GoogleFonts.quicksand(fontSize: 12)),
                      value: item))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  selectedFeeCategory = val;
                  print("selectedFeeCategory: $selectedFeeCategory");
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Expanded buildMonthDropdown() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          buildLabels(label: "Up to Month"),
          SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButton<FeeBalanceMonthListEmployeeModel>(
              hint: Text("Select"),
              isDense: true,
              value: selectedMonth,
              key: UniqueKey(),
              isExpanded: true,
              underline: Container(),
              items: monthDropdown
                  .map((item) =>
                      DropdownMenuItem<FeeBalanceMonthListEmployeeModel>(
                          child: Text(item.monthName!,
                              style: GoogleFonts.quicksand(fontSize: 12)),
                          value: item))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  selectedMonth = val;
                  print("selectedMonth: $selectedMonth");
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  getSearchData() async {
    List<String> selectedHeadIds = [];

    _selectedFeeHeadList.forEach((element) {
      selectedHeadIds.add(element.feeDetailID!);
    });

    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final searchData = {
      'OUserId': uid,
      'Token': token,
      'OrganizationId': userData!.organizationId,
      'SchoolId': userData.schoolId,
      'EmpID': userData.stuEmpId,
      'UserType': userData.ouserType,
      'SessionId': userData.currentSessionid,
      'FeeCatId': selectedFeeCategory!.iD,
      'TillMonthId': selectedMonth!.monthID,
      'FeeHeadID': selectedHeadIds.join(","),
    };
    print("Sending BalanceFeeAdmin Data => $searchData");
    context.read<BalanceFeeAdminCubit>().balanceFeeAdminCubitCall(searchData);
  }

  // Text buildLabels({String? label, Color? color}) {
  //   return Text(
  //     label!,
  //     style: TextStyle(
  //       color: color ?? Color(0xff313131),
  //       fontWeight: FontWeight.bold,
  //     ),
  //   );
  // }
}

// class AdvanceFilters extends StatefulWidget {
//   @override
//   _AdvanceFiltersState createState() => _AdvanceFiltersState();
// }

// class _AdvanceFiltersState extends State<AdvanceFilters> {
//   final _filterKey = GlobalKey<FormState>();

//   @override
//   void initState() {
//     super.initState();
//   }

//   getSearchData() async {
//     List<String> selectedHeadIds = [];

//     _selectedFeeHeadList.forEach((element) {
//       selectedHeadIds.add(element.feeDetailID!);
//     });

//     final uid = await UserUtils.idFromCache();
//     final token = await UserUtils.userTokenFromCache();
//     final userData = await UserUtils.userTypeFromCache();
//     final searchData = {
//       'OUserId': uid,
//       'Token': token,
//       'OrganizationId': userData!.organizationId,
//       'SchoolId': userData.schoolId,
//       'EmpID': userData.stuEmpId,
//       'UserType': userData.ouserType,
//       'SessionId': userData.currentSessionid,
//       'FeeCatId': selectedFeeCategory!.iD,
//       'TillMonthId': selectedMonth!.monthID,
//       'FeeHeadID': selectedHeadIds.join(","),
//     };
//     print("Sending BalanceFeeAdmin Data => $searchData");
//     context.read<BalanceFeeAdminCubit>().balanceFeeAdminCubitCall(searchData);
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _filterKey,
//       child: Container(
//         width: MediaQuery.of(context).size.width,
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Row(
//                 children: [
//                   buildFeeDropdown(),
//                   SizedBox(width: 20),
//                   // buildMonthDropdown(),
//                 ],
//               ),
//             ),
//             // SizedBox(height: 20),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: buildFeeHeadMultiSelect(context),
//             ),
//             // SizedBox(height: 20),
//             buildSearchButton(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildFeeHeadMultiSelect(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         buildLabels(label: "Fee Head"),
//         Container(
//           alignment: Alignment.center,
//           // padding: EdgeInsets.symmetric(horizontal: 10),
//           child: MultiSelectBottomSheetField<FeeHeadBalanceFeeModel>(
//             autovalidateMode: AutovalidateMode.disabled,
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.black12),
//             ),
//             key: _feeHeadSelectKey,
//             initialValue: _selectedFeeHeadList,
//             initialChildSize: 0.7,
//             maxChildSize: 0.95,
//             searchIcon: Icon(Icons.ac_unit),
//             title: Text("Fee Head",
//                 style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                     fontSize: 18)),
//             buttonText: Text(
//               _selectedFeeHeadList.length > 0
//                   ? "${_selectedFeeHeadList.length} Fee Head selected"
//                   : "None selected",
//             ),
//             // items: _items,
//             items: feeHeadListMulti!
//                 .map((feeHeadList) =>
//                     MultiSelectItem(feeHeadList, feeHeadList.feeName!))
//                 .toList(),
//             searchable: false,
//             validator: (values) {
//               if (values == null || values.isEmpty) {
//                 return "Required";
//               }
//               // List<String> names = values.map((e) => e.name!).toList();
//               // if (names.contains("Frog")) {
//               //   return "Frogs are weird!";
//               // }
//               return null;
//             },
//             onConfirm: (values) {
//               setState(() {
//                 _selectedFeeHeadList = values;
//               });
//               _feeHeadSelectKey.currentState!.validate();
//               // getSubjectList(_selectedClassList);
//               // getStudentsList(_selectedClassList);
//               // getTodayList(_selectedClassList);
//             },
//             chipDisplay: MultiSelectChipDisplay(
//               shape: RoundedRectangleBorder(),
//               textStyle: TextStyle(
//                   fontWeight: FontWeight.w900,
//                   color: Theme.of(context).primaryColor),
//               // chipColor: Colors.grey,
//               // onTap: (item) {
//               //   setState(() {
//               //     _selectedClassList.remove(item);
//               //   });
//               //   _classSelectKey.currentState!.validate();
//               // },
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Container buildSearchButton() {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
//       padding: const EdgeInsets.all(8.0),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(4.0),
//         color: Theme.of(context).primaryColor,
//       ),
//       child: InkWell(
//         onTap: () async {
//           getSearchData();
//           // setState(() => showFilters = !showFilters);
//         },
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(Icons.search, color: Colors.white),
//             SizedBox(width: 4),
//             Text(
//               "Search",
//               style: TextStyle(
//                   fontFamily: "BebasNeue-Regular", color: Colors.white),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Expanded buildFeeDropdown() {
//     return Expanded(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(height: 8),
//           buildLabels(label: "Fee Category"),
//           SizedBox(height: 8),
//           Container(
//             padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.black12),
//               // borderRadius: BorderRadius.circular(4),
//             ),
//             child: DropdownButton<FeeTypeModel>(
//               hint: Text("Select"),
//               isDense: true,
//               value: selectedFeeCategory,
//               key: UniqueKey(),
//               isExpanded: true,
//               underline: Container(),
//               items: feeCategoryDropdown
//                   .map((item) => DropdownMenuItem<FeeTypeModel>(
//                       child: Text(item.paramname!,
//                           style: GoogleFonts.quicksand(fontSize: 12)),
//                       value: item))
//                   .toList(),
//               onChanged: (val) {
//                 setState(() {
//                   selectedFeeCategory = val;
//                   print("selectedFeeCategory: $selectedFeeCategory");
//                 });
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Expanded buildMonthDropdown() {
//     return Expanded(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(height: 8),
//           buildLabels(label: "Up to Month"),
//           SizedBox(height: 8),
//           Container(
//             padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.black12),
//               // borderRadius: BorderRadius.circular(4),
//             ),
//             child: DropdownButton<FeeBalanceMonthListEmployeeModel>(
//               hint: Text("Select"),
//               isDense: true,
//               value: selectedMonth,
//               key: UniqueKey(),
//               isExpanded: true,
//               underline: Container(),
//               items: monthDropdown
//                   .map((item) =>
//                       DropdownMenuItem<FeeBalanceMonthListEmployeeModel>(
//                           child: Text(item.monthName!,
//                               style: GoogleFonts.quicksand(fontSize: 12)),
//                           value: item))
//                   .toList(),
//               onChanged: (val) {
//                 setState(() {
//                   selectedMonth = val;
//                   print("selectedMonth: $selectedMonth");
//                 });
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Text buildLabels({String? label, Color? color}) {
//     return Text(
//       label!,
//       style: TextStyle(
//         color: color ?? Color(0xff313131),
//         fontWeight: FontWeight.bold,
//       ),
//     );
//   }

//   Container buildTextField({
//     String? Function(String?)? validator,
//     @required TextEditingController? controller,
//   }) {
//     return Container(
//       child: TextFormField(
//         // obscureText: !obscureText ? false : true,
//         controller: controller,
//         validator: validator,
//         autovalidateMode: AutovalidateMode.onUserInteraction,
//         style: GoogleFonts.quicksand(color: Colors.black),
//         decoration: InputDecoration(
//           border: new OutlineInputBorder(
//             borderRadius: const BorderRadius.all(
//               const Radius.circular(18.0),
//             ),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(
//               color: Color(0xffECECEC),
//             ),
//             gapPadding: 0.0,
//           ),
//           disabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(
//               color: Theme.of(context).primaryColor,
//             ),
//           ),
//           errorBorder: OutlineInputBorder(
//             borderSide: BorderSide(
//               color: Color(0xffECECEC),
//             ),
//           ),
//           focusedErrorBorder: OutlineInputBorder(
//             borderSide: BorderSide(
//               color: Theme.of(context).primaryColor,
//             ),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(
//               color: Theme.of(context).primaryColor,
//             ),
//           ),
//           hintText: "type here",
//           hintStyle: GoogleFonts.quicksand(color: Color(0xffA5A5A5)),
//           contentPadding:
//               const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
//           // suffixIcon: suffixIcon
//           //     ? InkWell(
//           //         onTap: () {
//           //           setState(() {
//           //             _showPassword = !_showPassword;
//           //           });
//           //         },
//           //         child: !_showPassword
//           //             ? Icon(Icons.remove_red_eye_outlined)
//           //             : Icon(Icons.remove_red_eye),
//           //       )
//           //     : null,
//         ),
//       ),
//     );
//   }

//   Padding buildTopBar(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text("Advance Filters",
//               style: GoogleFonts.quicksand(
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                   fontSize: 18)),
//           // Text("Reset",
//           //     style: GoogleFonts.quicksand(
//           //         // fontWeight: FontWeight.bold,
//           //         color: Theme.of(context).accentColor)),
//         ],
//       ),
//     );
//   }
// }
