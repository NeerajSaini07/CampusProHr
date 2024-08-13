import 'package:campus_pro/src/DATA/BLOC_CUBIT/DAY_CLOSING_DATA_CUBIT/day_closing_data_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/dayClosingDataModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/drawerWidget.dart';
import 'package:campus_pro/src/UI/WIDGETS/noRecordFound.dart';
import 'package:campus_pro/src/WIDGETS_STYLE/style_common.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DayClosingAdmin extends StatefulWidget {
  static const routeName = "/day-closing-admin";

  const DayClosingAdmin({Key? key}) : super(key: key);

  @override
  _DayClosingAdminState createState() => _DayClosingAdminState();
}

class _DayClosingAdminState extends State<DayClosingAdmin> {
  InkWell buildDateSelector() {
    return InkWell(
      onTap: () => _selectDate(context),
      child: internalTextForDateTime(
        context,
        selectedDate: DateFormat("dd-MMM-yyyy").format(selectedDate),
        width: 160,
      ),
      // Container(
      //   padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      //   decoration: BoxDecoration(
      //     border: Border.all(color: Color(0xffECECEC)),
      //   ),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       Container(
      //         child: Text(
      //           DateFormat("dd-MMM-yyyy").format(selectedDate),
      //           overflow: TextOverflow.visible,
      //           maxLines: 1,
      //         ),
      //       ),
      //       SizedBox(
      //         width: 20,
      //       ),
      //       Icon(Icons.today, color: Theme.of(context).primaryColor)
      //     ],
      //   ),
      // ),
    );
  }

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
      helpText: "SELECT DATE",
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  void initState() {
    getDayClosingData();
    super.initState();
  }

  getDayClosingData() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final closingData = {
      'OUserId': uid,
      'Token': token,
      'OrgId': userData!.organizationId,
      'Schoolid': userData.schoolId,
      'Date': DateFormat("dd-MMM-yyyy").format(selectedDate),
      'EmpId': userData.stuEmpId,
      'UserType': userData.ouserType
    };
    print("Sending DayClosingAdmin data => $closingData");
    context.read<DayClosingDataCubit>().dayClosingDataCubitCall(closingData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: commonAppBar(context, title: "Day Closing"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildTopDateFilter(context),
            BlocConsumer<DayClosingDataCubit, DayClosingDataState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is DayClosingDataLoadInProgress) {
                  // return CircularProgressIndicator();
                  return LinearProgressIndicator();
                } else if (state is DayClosingDataLoadSuccess) {
                  return buildDayClosingBody(context, state.dayClosingData);
                } else if (state is DayClosingDataLoadFail) {
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

  Column buildDayClosingBody(
      BuildContext context, DayClosingDataModel? dayClosingData) {
    return Column(
      children: [
        Container(
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
                  "Receivings",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              buildEntries(context,
                  title: "Last Closing Date",
                  date: dayClosingData!.lASTCLOSEINGDATE,
                  amount: ''),
              buildEntries(context,
                  title: "Cash Opening",
                  date: dayClosingData.lASTCLOSEINGDATE,
                  amount: dayClosingData.cLOSEINGAMOUNT.toString()),
              buildEntries(context,
                  title: "By Cash",
                  date: dayClosingData.lASTCLOSEINGDATE,
                  amount: dayClosingData.bYCASH.toString()),
              buildEntries(context,
                  title: "By Cheque",
                  date: dayClosingData.lASTCLOSEINGDATE,
                  amount: dayClosingData.bYCHEQUE.toString()),
              buildEntries(context,
                  title: "By Online",
                  date: dayClosingData.lASTCLOSEINGDATE,
                  amount: dayClosingData.bYONLINE.toString()),
              buildEntries(context,
                  title: "By Swipe Machine",
                  date: dayClosingData.lASTCLOSEINGDATE,
                  amount: dayClosingData.sWIPEMACHINE.toString()),
              buildEntries(context,
                  title: "PayTM/GPay",
                  date: dayClosingData.lASTCLOSEINGDATE,
                  amount: dayClosingData.bYPAYTM.toString()),
              buildEntries(context,
                  title: "Tentative Fee",
                  date: dayClosingData.lASTCLOSEINGDATE,
                  amount: dayClosingData.tENTATIVEFEE.toString()),
              buildEntries(context,
                  title: "Other Fee",
                  date: dayClosingData.lASTCLOSEINGDATE,
                  amount: dayClosingData.oTHERFEE.toString()),
              buildEntries(context,
                  title: "Receive",
                  date: dayClosingData.lASTCLOSEINGDATE,
                  amount: dayClosingData.rECEIVEAMOUNT.toString()),
              buildEntries(context,
                  title: "Pocket Money Deposit",
                  date: dayClosingData.lASTCLOSEINGDATE,
                  amount: ""),
              buildEntries(context,
                  title: "Special Fee",
                  date: dayClosingData.lASTCLOSEINGDATE,
                  amount:
                      dayClosingData.cLASSWISESPECIALFEECOLLECTION.toString()),

              /// Doubt
              buildEntries(context,
                  title: "Prospectus Amount",
                  date: dayClosingData.lASTCLOSEINGDATE,
                  amount: dayClosingData.pROSSELLAMOUNT.toString()),
              // cash opening + tentative fee + by cash + receive + pocket money deposit + other fee + prospectus amount + special fee
              buildEntries(
                context,
                title: "Total Receiving",
                date: dayClosingData.lASTCLOSEINGDATE,
                amount: (dayClosingData.cLOSEINGAMOUNT! +
                        dayClosingData.tENTATIVEFEE! +
                        dayClosingData.bYCASH! +
                        dayClosingData.rECEIVEAMOUNT! +
                        dayClosingData.oTHERFEE! +
                        dayClosingData.pROSSELLAMOUNT! +
                        dayClosingData.cLASSWISESPECIALFEECOLLECTION! -
                        dayClosingData.pAYMENTBYCHEQUE! -
                        dayClosingData.bANKDEPOSIT! -
                        dayClosingData.pOCKETMONEYWITHDRAWCASH!)
                    .toString(),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.all(8.0),
          // padding: const EdgeInsets.all(14.0),
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
                  "Payments",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              buildEntries(context,
                  title: "Pocket Money Withdraw",
                  date: dayClosingData.lASTCLOSEINGDATE,
                  amount: dayClosingData.pOCKETMONEYWITHDRAWCASH.toString()),
              buildEntries(context,
                  title: "Payment By Cash",
                  date: dayClosingData.lASTCLOSEINGDATE,
                  amount: dayClosingData.pAYMENTBYCASH.toString()),
              buildEntries(context,
                  title: "Payment By Cheque",
                  date: dayClosingData.lASTCLOSEINGDATE,
                  amount: dayClosingData.pAYMENTBYCHEQUE.toString()),
              buildEntries(context,
                  title: "Bank Deposit",
                  date: dayClosingData.lASTCLOSEINGDATE,
                  amount: dayClosingData.bANKDEPOSIT.toString()),
              //pay by cheque + hand over amount + bank deposit +
              buildEntries(context,
                  title: "Total Payments",
                  date: dayClosingData.lASTCLOSEINGDATE,
                  amount: (dayClosingData.pOCKETMONEYWITHDRAWCASH! +
                          dayClosingData.pAYMENTBYCASH!.toDouble() +
                          dayClosingData.pAYMENTBYCHEQUE!.toDouble() +
                          dayClosingData.bANKDEPOSIT!.toDouble())
                      .toString()),

              /// Doubt
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.all(8.0),
          // padding: const EdgeInsets.all(14.0),
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
                  "Hand Over",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              buildEntries(context,
                  title: "Hand Over To",
                  date: dayClosingData.lASTCLOSEINGDATE,
                  amount: ""),

              /// Doubt
              buildEntries(context,
                  title: "Hand Over Amount",
                  date: dayClosingData.lASTCLOSEINGDATE,
                  amount: ""),

              /// Doubt
              // opening bal + tentative + fee collection + receive + deposited + other fee + propectus + special fee - payment - handoveramount - bank deposit - withdraw
              buildEntries(
                context,
                title: "Closing Balance",
                date: dayClosingData.lASTCLOSEINGDATE,
                amount: (dayClosingData.cLOSEINGAMOUNT! +
                        dayClosingData.tENTATIVEFEE! +
                        dayClosingData.bYCASH! +
                        dayClosingData.rECEIVEAMOUNT! +
                        dayClosingData.oTHERFEE! +
                        dayClosingData.pROSSELLAMOUNT! +
                        dayClosingData.cLASSWISESPECIALFEECOLLECTION! -
                        dayClosingData.pAYMENTBYCHEQUE! -
                        dayClosingData.bANKDEPOSIT! -
                        dayClosingData.pOCKETMONEYWITHDRAWCASH!)
                    .toString(),
              ),

              /// Doubt
              buildEntries(context,
                  title: "Remarks",
                  date: dayClosingData.lASTCLOSEINGDATE,
                  amount: ""),

              /// Doubt
            ],
          ),
        ),
      ],
    );
  }

  ListTile buildEntries(BuildContext context,
      {String? title, String? date, String? amount}) {
    return ListTile(
      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
      title: Text(
        title!,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
      ),
      subtitle: Text(
        date!,
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: Colors.grey, fontSize: 12),
      ),
      trailing: Text(
        "$amount",
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: amount!.contains("-")
                  ? Colors.red
                  : amount == "0"
                      ? Colors.black
                      : Colors.green,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  Container buildTopDateFilter(BuildContext context) {
    return Container(
      // color: Colors.white,
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          buildDateSelector(),
          SizedBox(width: 30.0),
          InkWell(
            onTap: () => getDayClosingData(),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Theme.of(context).primaryColor,
              ),
              child: Text(
                "Show",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
