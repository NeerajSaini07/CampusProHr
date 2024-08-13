import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/FEE_COLLECTIONS_CLASS_WISE_CUBIT/fee_collections_class_wise_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/feeCollectionsClassWiseModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/drawerWidget.dart';
import 'package:campus_pro/src/UI/WIDGETS/noRecordFound.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class FeeCollectionClassWiseAdmin extends StatefulWidget {
  static const routeName = "/fee-collection-class-wise-admin";

  const FeeCollectionClassWiseAdmin({Key? key}) : super(key: key);

  @override
  _FeeCollectionClassWiseAdminState createState() =>
      _FeeCollectionClassWiseAdminState();
}

class _FeeCollectionClassWiseAdminState
    extends State<FeeCollectionClassWiseAdmin> {
  TextEditingController filterController = TextEditingController();

  List<FeeCollectionsClassWiseModel> feeCollectionsList = [];
  List<FeeCollectionsClassWiseModel> feeCollectionsFilterList = [];

  int totalCollection = 0;

  DateTime? selectedMonth;

  List<DateTime> monthDropdown = [];

  @override
  void initState() {
    createMonthDropdown();
    super.initState();
  }

  createMonthDropdown() {
    setState(() {
      final todayDate = DateTime.now();
      if (todayDate.month != 1 &&
          todayDate.month != 2 &&
          todayDate.month != 3) {
        for (var i = 4; i <= 12; i++)
          monthDropdown.add(DateTime(todayDate.year, i, 1));
        for (var i = 1; i < 4; i++)
          monthDropdown.add(DateTime(todayDate.year + 1, i, 1));
        print("Condition 1 : $monthDropdown");
      } else {
        for (var i = 4; i <= 12; i++)
          monthDropdown.add(DateTime(todayDate.year - 1, i, 1));
        for (var i = 1; i < 4; i++)
          monthDropdown.add(DateTime(todayDate.year, i, 1));
        print("Condition 2 : $monthDropdown");
      }
      selectedMonth = monthDropdown
          .where((element) =>
              element.month == DateTime.now().month &&
              element.year == DateTime.now().year)
          .toList()
          .first;
      getFeeCollectionData();
    });
  }

  getFeeCollectionData() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final classWiseData = {
      'OUserId': uid,
      'Token': token,
      'OrgId': userData!.organizationId,
      'Schoolid': userData.schoolId,
      'SessionId': userData.currentSessionid,
      'EmpId': userData.stuEmpId,
      'UserType': userData.ouserType,
      // 'MonthId': "01-Apr-2021",
      'MonthId': DateFormat("dd-MMM-yyyy").format(selectedMonth!).toString(),
    };
    print("Sending DayClosingAdmin data => $classWiseData");
    context
        .read<FeeCollectionsClassWiseCubit>()
        .feeCollectionsClassWiseCubitCall(classWiseData);
  }

  @override
  void dispose() {
    filterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: commonAppBar(context, title: "Fee Collection Class Wise"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildYearDropDown(context),
            buildTotalFeeCollection(context),
            BlocConsumer<FeeCollectionsClassWiseCubit,
                FeeCollectionsClassWiseState>(
              listener: (context, state) {
                if (state is FeeCollectionsClassWiseLoadFail) {
                  if (state.failReason == "false") {
                    UserUtils.unauthorizedUser(context);
                  } else {
                    setState(() {
                      totalCollection = 0;
                    });
                  }
                }
                if (state is FeeCollectionsClassWiseLoadSuccess) {
                  setState(() {
                    feeCollectionsList = state.feeCollectionsClassWise;
                    totalCollection = 0;
                    feeCollectionsList.forEach((element) {
                      totalCollection =
                          totalCollection + int.tryParse(element.collection!)!;
                    });
                    feeCollectionsFilterList = feeCollectionsList;
                  });
                }
              },
              builder: (context, state) {
                if (state is FeeCollectionsClassWiseLoadInProgress) {
                  // return CircularProgressIndicator();
                  return LinearProgressIndicator();
                } else if (state is FeeCollectionsClassWiseLoadSuccess) {
                  return buildCollectionBody(context);
                } else if (state is FeeCollectionsClassWiseLoadFail) {
                  return noRecordFound();
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Column buildCollectionBody(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 8),
        buildTextField(),
        SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildHeading(title: "Classes"),
              buildHeading(title: "Collections"),
            ],
          ),
        ),
        Divider(thickness: 4),
        SizedBox(height: 8),
        ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (BuildContext context, int index) => Divider(),
          itemCount: feeCollectionsFilterList.length,
          itemBuilder: (context, i) {
            var item = feeCollectionsFilterList[i];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildLabels(label: item.className),
                  buildLabels(label: item.collection),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Container buildTotalFeeCollection(BuildContext context) {
    return Container(
      // width: MediaQuery.of(context).size.width,
      // height: 140,
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: totalCollection.toString().contains("-")
            ? Colors.red[400]
            : Color(0xff2ab57d),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Total Fee Collection",
            style: GoogleFonts.quicksand(
                fontWeight: FontWeight.bold, color: Colors.white70),
          ),
          Text(
            "$RUPEES $totalCollection",
            style: GoogleFonts.quicksand(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white70),
          ),
          // Expanded(
          //   flex: 1,
          //   child: Container(
          //     height: 140,
          //     child: Center(
          //       child: Text(
          //         "$RUPEES",
          //         style: GoogleFonts.quicksand(
          //             fontSize: 60,
          //             fontWeight: FontWeight.bold,
          //             color: Colors.white70),
          //       ),
          //     ),
          //   ),
          // ),
          // Expanded(
          //   flex: 2,
          //   child: Container(
          //     height: 140,
          //     // color: Colors.red,
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //       children: [
          //         Text(
          //           "$totalCollection",
          //           style: GoogleFonts.quicksand(
          //               fontSize: 32,
          //               fontWeight: FontWeight.bold,
          //               color: Colors.white70),
          //         ),
          //         Text(
          //           "Total Fee Collection",
          //           style: GoogleFonts.quicksand(
          //               fontWeight: FontWeight.bold, color: Colors.white70),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Container buildYearDropDown(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Color(0xffECECEC)),
        ),
        child: DropdownButton<DateTime>(
          hint: Text("Select"),
          isDense: true,
          value: selectedMonth,
          key: UniqueKey(),
          isExpanded: true,
          underline: Container(),
          items: monthDropdown
              .map((item) => DropdownMenuItem<DateTime>(
                  child: Text("${DateFormat("MMM yyyy").format(item)}"),
                  value: item))
              .toList(),
          onChanged: (val) {
            setState(() {
              selectedMonth = val!;
              print("selectedMonth: $val");
              getFeeCollectionData();
            });
            getFeeCollectionData();
          },
        ),
      ),
    );
  }

  Container buildTextField() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        controller: filterController,
        style: GoogleFonts.quicksand(color: Colors.black),
        decoration: InputDecoration(
          border: new OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(18.0),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xffECECEC),
            ),
            gapPadding: 0.0,
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xffECECEC),
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
            ),
          ),
          hintText: "Filter Class...",
          hintStyle: GoogleFonts.quicksand(color: Color(0xffA5A5A5)),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
        ),
        onChanged: (val) {
          setState(() {
            if (filterController.text != "") {
              feeCollectionsFilterList = [];
              feeCollectionsList.forEach((element) {
                if (element.className!
                        .toLowerCase()
                        .contains(val.toLowerCase()) ||
                    element.collection!
                        .toLowerCase()
                        .contains(val.toLowerCase()))
                  feeCollectionsFilterList.add(element);
              });
            } else {
              feeCollectionsFilterList = [];
              feeCollectionsFilterList = feeCollectionsList;
            }
          });
        },
      ),
    );
  }

  Widget buildLabels({String? label}) {
    return Text(
      label!,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: Color(0xffFF54AEF6),
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
    );
  }

  Container buildHeading({String? title}) {
    return Container(
      child: Text(
        title!,
        style: TextStyle(
          color: Color(0xff777777),
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    );
  }
}

class MonthModel {
  String? month = '';
  String? value = '';

  MonthModel({this.month, this.value});

  @override
  String toString() {
    return "{month: $month, value: $value}";
  }
}
