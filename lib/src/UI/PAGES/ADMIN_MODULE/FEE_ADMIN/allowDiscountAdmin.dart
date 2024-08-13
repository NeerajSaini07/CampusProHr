import 'dart:convert';

import 'package:campus_pro/src/DATA/BLOC_CUBIT/ALLOW_DISCOUNT_LIST_CUBIT/allow_discount_list_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/DISCOUNT_APPLY_AND_REJECT_CUBIT/discount_apply_and_reject_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/DISCOUNT_GIVE_ALLOW_DISCOUNT_CUBIT/discount_given_allow_discount_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/allowDiscountListModel.dart';
import 'package:campus_pro/src/DATA/MODELS/discountGivenAllowDiscountModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/drawerWidget.dart';
import 'package:campus_pro/src/UI/WIDGETS/noRecordFound.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AllowDiscountAdmin extends StatefulWidget {
  static const routeName = "/allow-discount-admin";

  const AllowDiscountAdmin({Key? key}) : super(key: key);

  @override
  _AllowDiscountAdminState createState() => _AllowDiscountAdminState();
}

class _AllowDiscountAdminState extends State<AllowDiscountAdmin> {
  bool showFilters = true;
  bool showLoader = false;
  bool showApplyRejectBtn = false;

  String? selectedDateType = "0";

  DateTime selectedFromDate = DateTime.now();
  DateTime selectedToDate = DateTime.now();

  DiscountGivenAllowDiscountModel? selectedGivenBy;
  List<DiscountGivenAllowDiscountModel> givenByDropdown = [];

  String? selectedDiscountType = "0";
  List<String> discountTypeDropdown = ["0", "1", "2"];

  List<AllowDiscountListModel>? allowDiscountList = [];

  GestureDetector buildDateSelector({int? index, DateTime? selectedDate}) {
    return GestureDetector(
      onTap: () => _selectDate(context, index),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 0.4),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Text(
                DateFormat("dd-MMM-yyyy").format(selectedDate!),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Icon(Icons.today, color: Theme.of(context).primaryColor)
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, int? index) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: index == 0 ? selectedFromDate : selectedToDate,
      firstDate: DateTime(1947),
      lastDate: DateTime(2101),
      helpText: index == 0 ? "SELECT FROM DATE" : "SELECT TO DATE",
    );
    if (picked != null)
      setState(() {
        if (index == 0) {
          selectedFromDate = picked;
        } else {
          selectedToDate = picked;
        }
      });
  }

  @override
  void initState() {
    selectedGivenBy =
        DiscountGivenAllowDiscountModel(desigid: "0", name: "Select");
    getAllowDiscountList(0);
    getGivenByList();
    super.initState();
  }

  getAllowDiscountList(int? index) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final allowDiscountData = {
      'OUserId': uid,
      'Token': token,
      'OrgId': userData!.organizationId,
      'Schoolid': userData.schoolId,
      'UserID': userData.stuEmpId,
      'UserType': userData.ouserType,
      'SessionID': userData.currentSessionid,
      'FromDate': index == 1
          ? DateFormat("dd-MMM-yyyy").format(selectedFromDate).toString()
          : "",
      'ToDate': index == 1
          ? DateFormat("dd-MMM-yyyy").format(selectedToDate).toString()
          : "",
      'DiscountGevinByID':
          selectedGivenBy!.desigid != "" ? selectedGivenBy!.desigid : "0",
      'DiscountType': selectedDiscountType == "1"
          ? "Y"
          : selectedDiscountType == "2"
              ? "X"
              : selectedDiscountType,
      'DiscountType_index': selectedDiscountType,
      'DateTypeIndex': selectedDateType.toString(),
    };
    print("Sending AllowDiscountList Data => $allowDiscountData");
    context
        .read<AllowDiscountListCubit>()
        .allowDiscountListCubitCall(allowDiscountData);
  }

  getGivenByList() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final givenData = {
      'OUserId': uid,
      'Token': token,
      'OrgId': userData!.organizationId,
      'Schoolid': userData.schoolId,
      'UserID': userData.stuEmpId,
      'UserType': userData.ouserType,
      'SessionID': userData.currentSessionid,
    };
    print("Sending DiscountGivenAllowDiscount Data => $givenData");
    context
        .read<DiscountGivenAllowDiscountCubit>()
        .discountGivenAllowDiscountCubitCall(givenData);
  }

  changeStatus(String? status) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    List<Map<String, String>> jsonData = [];

    allowDiscountList!.forEach((element) {
      if (element.isChecked!) jsonData.add({"ReceiptNo": element.receiptno!});
    });

    final statusData = {
      'OUserId': uid,
      'Token': token,
      'OrgId': userData!.organizationId,
      'Schoolid': userData.schoolId,
      'SessionID': userData.currentSessionid,
      'UpdatedByID': userData.stuEmpId,
      'UserType': userData.ouserType,
      'AppStatus': status,
      'JsonData': jsonEncode(jsonData),
    };
    print("Sending DiscountApplyAndReject Data => $statusData");
    context
        .read<DiscountApplyAndRejectCubit>()
        .discountApplyAndRejectCubitCall(statusData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: commonAppBar(context, title: "Allow Discount"),
      body: MultiBlocListener(
        listeners: [
          BlocListener<DiscountApplyAndRejectCubit,
              DiscountApplyAndRejectState>(
            listener: (context, state) {
              if (state is DiscountApplyAndRejectLoadSuccess) {
                if (state.status == true) {
                  allowDiscountList = [];
                  getAllowDiscountList(0);
                }
              }
            },
          ),
          BlocListener<AllowDiscountListCubit, AllowDiscountListState>(
            listener: (context, state) {
              if (state is AllowDiscountListLoadSuccess) {
                setState(() {
                  allowDiscountList = state.allowDiscountList;
                  showLoader = false;
                  for (var i = 0; i < allowDiscountList!.length; i++) {
                    if (allowDiscountList![i].discountapplied!.toLowerCase() ==
                        "n") {
                      showApplyRejectBtn = true;
                      break;
                    }
                  }
                  // allowDiscountList!.forEach((element) {
                  //   if (element.discountapplied!.toLowerCase() == "n") {
                  //     showApplyRejectBtn = true;
                  //     // break;
                  //   }
                  // });
                });
              }
              if (state is AllowDiscountListLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                } else {
                  setState(() {
                    allowDiscountList = [];
                    showLoader = false;
                  });
                }
              }
            },
          ),
          BlocListener<DiscountGivenAllowDiscountCubit,
              DiscountGivenAllowDiscountState>(
            listener: (context, state) {
              if (state is DiscountGivenAllowDiscountLoadSuccess) {
                setState(() {
                  givenByDropdown = state.discountGivenAllowDiscount;
                  if (givenByDropdown.first.name != "Select") {
                    givenByDropdown.insert(
                        0,
                        DiscountGivenAllowDiscountModel(
                            desigid: "0", name: "Select"));
                  }
                });
                selectedGivenBy = givenByDropdown[0];
              }
              if (state is DiscountGivenAllowDiscountLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                } else {
                  setState(() {
                    givenByDropdown = [];
                  });
                }
              }
            },
          ),
        ],
        child: buildAllowDiscountBody(context),
      ),
    );
  }

  Widget buildAllowDiscountBody(BuildContext context) {
    return Column(
      children: [
        buildEnquiry(context),
        if (showLoader)
          LinearProgressIndicator()
        else
          Divider(color: Color(0xffECECEC), thickness: 6, height: 0),
        if (showFilters) buildTopFilter(context),
        SizedBox(height: 10.0),
        // if (showLoader) LinearProgressIndicator(),
        Expanded(
          child: Container(
            // color: Colors.white,
            child: Column(
              children: [
                // Container(
                //   // color: Colors.blue[200],
                //   padding: const EdgeInsets.symmetric(
                //       horizontal: 20.0, vertical: 8.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       buildHeading(title: "Classes"),
                //       buildHeading(title: "Balance"),
                //     ],
                //   ),
                // ),
                // Divider(thickness: 4),
                // SizedBox(height: 8),
                if (allowDiscountList!.isNotEmpty)
                  Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(),
                      itemCount: allowDiscountList!.length,
                      itemBuilder: (context, i) {
                        var item = allowDiscountList![i];
                        return Column(
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        // allowDiscountList![i].isExpand =
                                        //     !item.isExpand!;
                                        // print(
                                        //     "allowDiscountList![i].isExpand ${allowDiscountList![i].isExpand}");
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        // Icon(
                                        //     item.isExpand!
                                        //         ? Icons.remove
                                        //         : Icons.add,
                                        //     color:
                                        //         Theme.of(context).primaryColor),
                                        SizedBox(width: 10.0),
                                        buildLabels(
                                            "${item.admno!} ${item.stname!}"),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      buildLabels(item.spdiscnt.toString()),
                                      Container(
                                        // color: Colors.yellow,
                                        width: 35.0,
                                        height: 35.0,
                                        child: item.discountapplied!
                                                    .toLowerCase() ==
                                                "n"
                                            ? Checkbox(
                                                value: item.isChecked,
                                                onChanged: (val) {
                                                  setState(() {
                                                    allowDiscountList![i]
                                                        .isChecked = val;
                                                  });
                                                  print(
                                                      "allowDiscountList : $allowDiscountList");
                                                },
                                              )
                                            : Container(),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            //   if (item.isExpand!)
                            Container(
                              color: Colors.black12,
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  buildRows(title: "Date", value: item.feedate),
                                  buildRows(
                                      title: "F.Name", value: item.fathername),
                                  buildRows(
                                      title: "Rec. No.", value: item.receiptno),
                                  buildRows(
                                      title: "Receive Amt.",
                                      value: item.receiveamount),
                                  buildRows(
                                      title: "Remark", value: item.remarks),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  )
                else
                  Expanded(
                    child: Container(
                      child: noRecordFound(),
                    ),
                  ),
              ],
            ),
          ),
        ),
        if (allowDiscountList!.isNotEmpty && showApplyRejectBtn)
          buildBottomButtons(),
        // InkWell(
        //   onTap: () async {
        //     // final data = await showAdvanceFilters() as String;
        //     // if (data == "Y") getAllowDiscountList(1);
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

  Row buildRows({String? title, String? value}) {
    return Row(
      children: [
        Icon(Icons.add, color: Colors.transparent),
        SizedBox(width: 10.0),
        buildLabels("$title : $value"),
      ],
    );
  }

  Container buildTopFilter(BuildContext context) {
    return Container(
      color: Color(0xffECECEC),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // buildTopBar(context),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
          //   child: Divider(),
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: buildLabels("Date Type"),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    buildRadioText(
                        title: "Fee Date",
                        value: "0",
                        groupValue: selectedDateType),
                    buildRadioText(
                        title: "Approved Date",
                        value: "1",
                        groupValue: selectedDateType),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildLabels("From Date:"),
                      SizedBox(height: 8),
                      buildDateSelector(
                          index: 0, selectedDate: selectedFromDate),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildLabels("To Date:"),
                      SizedBox(height: 8),
                      buildDateSelector(index: 1, selectedDate: selectedToDate),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                buildGivenDropdown(),
                SizedBox(width: 10),
                buildTypeDropdown(),
              ],
            ),
          ),
          Center(child: buildSearchBtn()),
        ],
      ),
    );
  }

  Container buildSearchBtn() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Theme.of(context).primaryColor,
      ),
      child: InkWell(
        onTap: () async {
          getAllowDiscountList(1);
          setState(() {
            showFilters = false;
            showLoader = true;
            allowDiscountList = [];
          });
        },
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

  Row buildEnquiry(BuildContext context) {
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
      ],
    );
  }

  Container buildBottomButtons() {
    return Container(
      // padding: const EdgeInsets.all(8.0),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildButtons(
              title: "Approve",
              icon: Icons.clear,
              color: Colors.green,
              isBorder: true,
              onPressed: () => changeStatus("Y")),
          buildButtons(
              title: "Reject",
              icon: Icons.check,
              color: Colors.red,
              onPressed: () => changeStatus("X")),
        ],
      ),
    );
  }

  Expanded buildButtons(
      {String? title,
      IconData? icon,
      bool isBorder = false,
      Color? color,
      required void Function()? onPressed}) {
    return Expanded(
      flex: 1,
      child: Container(
        decoration: BoxDecoration(
          color: color!.withOpacity(0.7),
          border: isBorder
              ? Border(
                  left: BorderSide(width: 2, color: Color(0xffECECEC)),
                  right: BorderSide(width: 2, color: Color(0xffECECEC)),
                )
              : null,
        ),
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.transparent,
          ),
          // color: Colors.transparent,
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.white,
              ),
              Text(
                title!,
                textScaleFactor: 1.5,
                style: GoogleFonts.quicksand(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildHeading({String? title, Color? color}) {
    return Container(
      child: Text(
        title!,
        style: GoogleFonts.quicksand(
          color: color ?? Color(0xff777777),
          // color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Row buildRadioText(
      {String? title, required String value, required String? groupValue}) {
    return Row(
      children: [
        Radio(
          value: value,
          groupValue: groupValue,
          onChanged: (String? value) {
            setState(() {
              selectedDateType = value!;
            });
            print("selectedDateType : $selectedDateType");
          },
        ),
        Text(title!),
      ],
    );
  }

  Expanded buildGivenDropdown() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          buildLabels("Given BY"),
          SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButton<DiscountGivenAllowDiscountModel>(
              hint: Text("Select", style: GoogleFonts.quicksand(fontSize: 12)),
              isDense: true,
              value: selectedGivenBy,
              key: UniqueKey(),
              isExpanded: true,
              underline: Container(),
              items: givenByDropdown
                  .map((item) =>
                      DropdownMenuItem<DiscountGivenAllowDiscountModel>(
                        child: Text(item.name!,
                            style: GoogleFonts.quicksand(fontSize: 12)),
                        value: item,
                      ))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  selectedGivenBy = val;
                  print("selectedGivenBy: $selectedGivenBy");
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Expanded buildTypeDropdown() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          buildLabels("Discount Type"),
          SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButton<String>(
              hint: Text("Select"),
              isDense: true,
              value: selectedDiscountType,
              key: UniqueKey(),
              isExpanded: true,
              underline: Container(),
              items: discountTypeDropdown
                  .map((item) => DropdownMenuItem<String>(
                      child: Text(
                          item == "1"
                              ? "Approved"
                              : item == "2"
                                  ? "Rejected"
                                  : "Select",
                          style: GoogleFonts.quicksand(fontSize: 12)),
                      value: item))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  selectedDiscountType = val;
                  print("selectedDiscountType: $selectedDiscountType");
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Text buildLabels(String label) {
    return Text(
      label,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        // color: Theme.of(context).primaryColor,
        color: Color(0xff313131),
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Padding buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Advance Filters",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 18)),
          // Text("Reset",
          //     style: TextStyle(
          //         // fontWeight: FontWeight.bold,
          //         color: Theme.of(context).accentColor)),
        ],
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
}

// class AdvanceFilters extends StatefulWidget {
//   @override
//   _AdvanceFiltersState createState() => _AdvanceFiltersState();
// }

// class _AdvanceFiltersState extends State<AdvanceFilters> {
//   final _filterKey = GlobalKey<FormState>();

//   GestureDetector buildDateSelector({int? index, DateTime? selectedDate}) {
//     return GestureDetector(
//       onTap: () => _selectDate(context, index),
//       child: Container(
//         width: MediaQuery.of(context).size.width,
//         padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//         decoration: BoxDecoration(
//           border: Border.all(color: Color(0xffECECEC)),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Container(
//               // width: MediaQuery.of(context).size.width / 4,
//               child: Text(
//                 DateFormat("dd-MMM-yyyy").format(selectedDate!),
//                 overflow: TextOverflow.visible,
//                 maxLines: 1,
//               ),
//             ),
//             Icon(Icons.today, color: Theme.of(context).primaryColor)
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> _selectDate(BuildContext context, int? index) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: index == 0 ? selectedFromDate : selectedToDate,
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2101),
//       helpText: index == 0 ? "SELECT FROM DATE" : "SELECT TO DATE",
//     );
//     if (picked != null)
//       setState(() {
//         if (index == 0) {
//           selectedFromDate = picked;
//         } else {
//           selectedToDate = picked;
//         }
//       });
//   }

//   getSearchData() async {}

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _filterKey,
//       child: Column(
//         children: [
//           buildTopBar(context),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Divider(),
//           ),
//           buildLabels("Date Type"),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     buildRadioText(
//                         title: "Fee Date",
//                         value: "0",
//                         groupValue: selectedDateType),
//                     buildRadioText(
//                         title: "Approved Date",
//                         value: "1",
//                         groupValue: selectedDateType),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       buildLabels("From Date:"),
//                       SizedBox(height: 8),
//                       buildDateSelector(
//                           index: 0, selectedDate: selectedFromDate),
//                     ],
//                   ),
//                 ),
//                 SizedBox(width: 10),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       buildLabels("To Date:"),
//                       SizedBox(height: 8),
//                       buildDateSelector(index: 1, selectedDate: selectedToDate),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Row(
//               children: [
//                 buildGivenDropdown(),
//                 SizedBox(width: 10),
//                 buildTypeDropdown(),
//               ],
//             ),
//           ),
//           buildSearchButton(),
//         ],
//       ),
//     );
//   }

//   Container buildSearchButton() {
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10.0),
//         gradient: LinearGradient(
//             begin: Alignment.centerLeft,
//             end: Alignment.centerRight,
//             colors: [accentColor, primaryColor]),
//       ),
//       child: FlatButton(
//         onPressed: () {
//           Navigator.pop(context, "Y");
//         },
//         child: Text(
//           "Search",
//           style: GoogleFonts.quicksand(color: Colors.white),
//         ),
//       ),
//     );
//   }

//   Row buildRadioText(
//       {String? title, required String value, required String? groupValue}) {
//     return Row(
//       children: [
//         Radio(
//           value: value,
//           groupValue: groupValue,
//           onChanged: (String? value) {
//             setState(() {
//               selectedDateType = value!;
//             });
//             print("selectedDateType : $selectedDateType");
//           },
//         ),
//         Text(title!),
//       ],
//     );
//   }

//   Expanded buildGivenDropdown() {
//     return Expanded(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(height: 8),
//           buildLabels("Given BY"),
//           SizedBox(height: 8),
//           Container(
//             padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//             decoration: BoxDecoration(
//               border: Border.all(color: Color(0xffECECEC)),
//               // borderRadius: BorderRadius.circular(4),
//             ),
//             child: DropdownButton<DiscountGivenAllowDiscountModel>(
//               hint: Text("Select"),
//               isDense: true,
//               value: selectedGivenBy,
//               key: UniqueKey(),
//               isExpanded: true,
//               underline: Container(),
//               items: givenByDropdown
//                   .map((item) =>
//                       DropdownMenuItem<DiscountGivenAllowDiscountModel>(
//                         child: Text(item.name!,
//                             style: GoogleFonts.quicksand(fontSize: 12)),
//                         value: item,
//                       ))
//                   .toList(),
//               onChanged: (val) {
//                 setState(() {
//                   selectedGivenBy = val;
//                   print("selectedGivenBy: $selectedGivenBy");
//                 });
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Expanded buildTypeDropdown() {
//     return Expanded(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(height: 8),
//           buildLabels("Discount Type"),
//           SizedBox(height: 8),
//           Container(
//             padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//             decoration: BoxDecoration(
//               border: Border.all(color: Color(0xffECECEC)),
//               // borderRadius: BorderRadius.circular(4),
//             ),
//             child: DropdownButton<String>(
//               hint: Text("Select"),
//               isDense: true,
//               value: selectedDiscountType,
//               key: UniqueKey(),
//               isExpanded: true,
//               underline: Container(),
//               items: discountTypeDropdown
//                   .map((item) => DropdownMenuItem<String>(
//                       child: Text(
//                           item == "1"
//                               ? "Approved"
//                               : item == "2"
//                                   ? "Rejected"
//                                   : "Select",
//                           style: GoogleFonts.quicksand(fontSize: 12)),
//                       value: item))
//                   .toList(),
//               onChanged: (val) {
//                 setState(() {
//                   selectedDiscountType = val;
//                   print("selectedDiscountType: $selectedDiscountType");
//                 });
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Padding buildLabels(String label) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8.0),
//       child: Text(
//         label,
//         style: TextStyle(
//           // color: Theme.of(context).primaryColor,
//           color: Color(0xff313131),
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
//               style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                   fontSize: 18)),
//           // Text("Reset",
//           //     style: TextStyle(
//           //         // fontWeight: FontWeight.bold,
//           //         color: Theme.of(context).accentColor)),
//         ],
//       ),
//     );
//   }
// }
