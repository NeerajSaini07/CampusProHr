import 'package:campus_pro/src/DATA/BLOC_CUBIT/BILLS_LIST_BILL_APPROVE_CUBIT/bills_list_bill_approve_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/BILL_DETAILS_BILL_APPROVE_CUBIT/bill_details_bill_approve_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/PARTY_TYPE_BILL_APPROVE_CUBIT/party_type_bill_approve_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/billDetailsBillApproveModel.dart';
import 'package:campus_pro/src/DATA/MODELS/billsListBillApproveModel.dart';
import 'package:campus_pro/src/DATA/MODELS/partyTypeBillApproveModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/drawerWidget.dart';
import 'package:campus_pro/src/UI/WIDGETS/noRecordFound.dart';
import 'package:campus_pro/src/UTILS/fieldValidators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../globalBlocProvidersFile.dart';

class BillApproveAdmin extends StatefulWidget {
  static const routeName = "/bill-approve-admin";

  const BillApproveAdmin({Key? key}) : super(key: key);

  @override
  _BillApproveAdminState createState() => _BillApproveAdminState();
}

class _BillApproveAdminState extends State<BillApproveAdmin> {
  PartyTypeBillApproveModel? _selectedParty;
  List<PartyTypeBillApproveModel>? partyDropdown = [];

  List<BillsListBillApproveModel> billList = [];

  @override
  void initState() {
    getPartyDropdownData();
    super.initState();
  }

  getPartyDropdownData() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final partyData = {
      'OUserId': uid,
      'Token': token,
      'OrgId': userData!.organizationId,
      'Schoolid': userData.schoolId,
      'EmpId': userData.stuEmpId,
      'UserType': userData.ouserType
    };
    print("Sending PartyTypeBillApprove Data => $partyData");
    context
        .read<PartyTypeBillApproveCubit>()
        .partyTypeBillApproveCubitCall(partyData);
  }

  getBillsListData() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final billsData = {
      'OUserId': uid,
      'Token': token,
      'Organization': userData!.organizationId,
      'SchoolId': userData.schoolId,
      'SessionID': userData.currentSessionid,
      'PartyID': _selectedParty!.id,
      'BillNo': "0",
      'EmpId': userData.stuEmpId,
      'UserType': userData.ouserType,
    };
    print("Sending BillsListBillApprove Data => $billsData");
    context
        .read<BillsListBillApproveCubit>()
        .billsListBillApproveCubitCall(billsData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: commonAppBar(context, title: "Bill Approve"),
      body: MultiBlocListener(
        listeners: [
          BlocListener<PartyTypeBillApproveCubit, PartyTypeBillApproveState>(
            listener: (context, state) {
              if (state is PartyTypeBillApproveLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                } else {
                  setState(() {
                    partyDropdown = [];
                    _selectedParty = null;
                  });
                }
              }
              if (state is PartyTypeBillApproveLoadSuccess) {
                setState(() {
                  state.partyTypeBillApprove.insert(
                    0,
                    PartyTypeBillApproveModel(id: "-1", name: "Select Party"),
                  );
                  partyDropdown = state.partyTypeBillApprove;
                  _selectedParty = state.partyTypeBillApprove[0];
                });
                getBillsListData();
              }
            },
          ),
        ],
        child: Column(
          children: [
            buildPartyDown(context),
            BlocConsumer<BillsListBillApproveCubit, BillsListBillApproveState>(
              listener: (context, state) {
                if (state is BillsListBillApproveLoadSuccess) {
                  setState(() {
                    billList = state.billsListBillApprove;
                  });
                }
                if (state is BillsListBillApproveLoadFail) {
                  if (state.failReason == "false") {
                    UserUtils.unauthorizedUser(context);
                  } else {}
                }
              },
              builder: (context, state) {
                if (state is BillsListBillApproveLoadInProgress) {
                  // return CircularProgressIndicator();
                  return LinearProgressIndicator();
                } else if (state is BillsListBillApproveLoadSuccess) {
                  return buildBillApproveBody(context, billList);
                } else if (state is BillsListBillApproveLoadFail) {
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

  buildBillApproveBody(
      BuildContext context, List<BillsListBillApproveModel>? billsList) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, i) => Divider(),
        shrinkWrap: true,
        itemCount: billsList!.length,
        itemBuilder: (context, i) {
          var item = billsList[i];
          return buildEntries(context, item);
        },
      ),
    );
  }

  ListTile buildEntries(BuildContext context, BillsListBillApproveModel item) {
    return ListTile(
      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
      title: Text(
        "Bill No : ${item.billNo!}",
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
      ),
      subtitle: Text(
        item.billDate!,
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: Colors.grey, fontSize: 12),
      ),
      trailing: Column(
        children: [
          Text(
            item.billTotal!,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      BlocProvider<BillDetailsBillApproveCubit>(
                    create: (_) => BillDetailsBillApproveCubit(
                        BillDetailsBillApproveRepository(
                            BillDetailsBillApproveApi())),
                    child: BillDetails(bill: item, partyId: _selectedParty!.id),
                  ),
                ),
              );
            },
            child: Text(
              "view",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontSize: 16,
                    // fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Container buildPartyDown(BuildContext context) {
    return Container(
      // color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          // color: Colors.white,
          border: Border.all(color: Color(0xffECECEC)),
        ),
        child: DropdownButton<PartyTypeBillApproveModel>(
          isDense: true,
          value: _selectedParty,
          key: UniqueKey(),
          isExpanded: true,
          underline: Container(),
          items: partyDropdown!
              .map((item) => DropdownMenuItem<PartyTypeBillApproveModel>(
                    child: Text(item.name!),
                    value: item,
                  ))
              .toList(),
          onChanged: (val) {
            setState(() {
              _selectedParty = val!;
              print("_selectedParty: $val");
              getBillsListData();
            });
          },
        ),
      ),
    );
  }
}

///

class BillDetails extends StatefulWidget {
  final BillsListBillApproveModel? bill;
  final String? partyId;
  const BillDetails({Key? key, this.bill, this.partyId}) : super(key: key);

  @override
  _BillDetailsState createState() => _BillDetailsState();
}

class _BillDetailsState extends State<BillDetails> {
  TextEditingController amountController = TextEditingController();
  TextEditingController remarkController = TextEditingController();

  bool _selectedBill = false;

  BillDetailsBillApproveModel? billDetail;

  @override
  void initState() {
    billDetail = BillDetailsBillApproveModel(
        billNo: "", billTotal: "", billType: "", isFinalize: "");
    getBillDetailData();
    super.initState();
  }

  getBillDetailData() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final billsData = {
      'OUserId': uid,
      'Token': token,
      'Organization': userData!.organizationId,
      'SchoolId': userData.schoolId,
      'SessionID': userData.currentSessionid,
      'PartyID': widget.partyId,
      'BillNo': widget.bill!.billId,
      'EmpId': userData.stuEmpId,
      'UserType': userData.ouserType,
    };
    print("Sending BillDetailsBillApprove Data => $billsData");
    context
        .read<BillDetailsBillApproveCubit>()
        .billDetailsBillApproveCubitCall(billsData);
  }

  @override
  void dispose() {
    amountController.dispose();
    remarkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, title: "Purchase Detail"),
      body: MultiBlocListener(
        listeners: [
          BlocListener<BillDetailsBillApproveCubit,
              BillDetailsBillApproveState>(
            listener: (context, state) {
              if (state is BillDetailsBillApproveLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                }
              }
              if (state is BillDetailsBillApproveLoadSuccess) {
                setState(() {
                  billDetail = state.billDetailsBillApprove;
                });
              }
            },
          ),
        ],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildLabels("Total Amt"),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xffECECEC),
                            ),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Text(
                            billDetail!.billTotal!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildLabels("To be Approve"),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xffECECEC)),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Text(
                            billDetail!.billTotal!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildLabels("Approve Amount"),
                  buildTextField(
                    controller: amountController,
                    validator: FieldValidators.globalValidator,
                  ),
                ],
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildLabels("Remark"),
                  buildTextField(
                    controller: remarkController,
                    validator: (_) {},
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: _selectedBill,
                    onChanged: (val) {
                      setState(() {
                        _selectedBill = !_selectedBill;
                      });
                    },
                  ),
                  Text("Finalise Bill"),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              buildButton(),
            ],
          ),
        ),
      ),
    );
  }

  Container buildButton() {
    return Container(
      // width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.all(
          Radius.circular(30.0),
        ),
      ),
      child: TextButton(
        onPressed: () async {},
        child: Text(
          "Approve",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Padding buildLabels(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        label,
        style: TextStyle(
          // color: Theme.of(context).primaryColor,
          color: Color(0xff3A3A3A),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Container buildTextField(
      {String? Function(String?)? validator,
      @required TextEditingController? controller}) {
    return Container(
      child: TextFormField(
        controller: controller,
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: TextStyle(color: Colors.black),
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
          hintText: "type here",
          hintStyle: TextStyle(color: Color(0xffA5A5A5)),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
        ),
      ),
    );
  }
}
