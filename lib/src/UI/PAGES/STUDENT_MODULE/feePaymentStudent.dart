import 'dart:convert';

import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/PAYMENT_GATEWAY_API/paymentScreen.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/FEE_MONTHS_CUBIT/fee_months_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/FEE_RECEIPTS_CUBIT/fee_receipts_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/FEE_REMARK_CUBIT/fee_remark_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/FEE_TRANSACTION_HISTORY_CUBIT/fee_transaction_history_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/FEE_TYPE_CUBIT/fee_type_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/FEE_TYPE_SETTING_CUBIT/fee_type_setting_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/GATEWAY_TYPE_CUBIT/gateway_type_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/PAY_U_BIZ_HASH_CUBIT/pay_u_biz_hash_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/STUDENT_FEE_FINE_CUBIT/student_fee_fine_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/STUDENT_FEE_RECEIPT_CUBIT/student_fee_receipt_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/STUDENT_INFO_CUBIT/student_info_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/TERMS_CONDITIONS_SETTING_CUBIT/terms_conditions_setting_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/PAYMENT_GATEWAY_MODELS/gatewayTypeModel.dart';
import 'package:campus_pro/src/DATA/MODELS/feeMonthsModel.dart';
import 'package:campus_pro/src/DATA/MODELS/feeReceiptsModel.dart';
import 'package:campus_pro/src/DATA/MODELS/feeTransactionHistoryModel.dart';
import 'package:campus_pro/src/DATA/MODELS/feeTypeModel.dart';
import 'package:campus_pro/src/DATA/MODELS/studentFeeReceiptModel.dart';
import 'package:campus_pro/src/DATA/MODELS/studentInfoModel.dart';
import 'package:campus_pro/src/DATA/MODELS/userTypeModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/PAGES/STUDENT_MODULE/payByChequeStudent.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/noRecordFound.dart';
import 'package:campus_pro/src/UI/WIDGETS/toast.dart';
import 'package:campus_pro/src/UTILS/paymentGatewayMethods.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';


int totalAmount = 0;
int totalFine = 0;

List<StudentFeeReceiptModel>? feeDetailsList = [];

class FeePaymentStudent extends StatefulWidget {
  static const routeName = "/fee-payment-student";
  @override
  _FeePaymentStudentState createState() => _FeePaymentStudentState();
}

class _FeePaymentStudentState extends State<FeePaymentStudent> {
  final GlobalKey dropdownKey = GlobalKey();

  List<GatewayTypeModel>? gatewayData;

  List<Map<String, dynamic>> jsonMonthData = [];

  bool paymentLoader = false;

  bool showFineWidget = false;

  String? editTotalAmount;

  String? _showReceipts = 'false';

  // int totalAmount = 0;
  // int totalFine = 0;

  String? feeCatId;

  String? uid;

  String? token;

  bool showPayButton = false;
  bool selectedCheckBox = false;

  bool showFeeTypeDropdown = true;
  String termsConditionsSettingValue = "";

  FeeTypeModel? selectedFeeType;
  List<FeeTypeModel>? feeTypeDropdown;

  FeeMonthsModel? selectedMonth;
  List<FeeMonthsModel>? monthDropdown;

  UserTypeModel? userData;

  StudentInfoModel? stuInfo;

  var scrollController = ScrollController();

  TextEditingController totalAmountController = TextEditingController();

  TabController? tabController;
  int _currentIndex = 0;

  void tabIndexChange(int tabIndex) {
    setState(() {
      _currentIndex = tabIndex;
    });
  }

  @override
  void initState() {
    selectedFeeType = FeeTypeModel(iD: "", paramname: "");
    feeTypeDropdown = [];
    selectedMonth = FeeMonthsModel(
        feeMonthId: "", feeMonthName: "", feeType: "", isBalance: "");
    monthDropdown = [];
    getDataFromCache();
    super.initState();
  }

  getDataFromCache() async {
    uid = await UserUtils.idFromCache();
    token = await UserUtils.userTokenFromCache();
    userData = await UserUtils.userTypeFromCache();
    stuInfo = await UserUtils.stuInfoDataFromCache();
    final appConfig = await UserUtils.appConfigFromCache();
    setState(() => _showReceipts = appConfig!.showFeeReceipt!.toLowerCase());
    final editAmount = await UserUtils.appConfigFromCache();
    setState(() {
      editTotalAmount = editAmount!.editAmount;
    });
    getFeeType();
    getFeeReceiptsTransactions();
    feeTypeSettingFromApi();
    termsConditionsSettingFromApi();
  }

  getFeeType() {
    final feeTypeData = {
      "OUserId": uid!,
      "Token": token!,
      "OrgId": userData!.organizationId!,
      "Schoolid": userData!.schoolId!,
      "EmpStuId": userData!.stuEmpId!,
      "UserType": userData!.ouserType!,
      "ParamType": "Fee Category",
    };
    context.read<FeeTypeCubit>().feeTypeCubitCall(feeTypeData);
  }

  getFeeReceiptsTransactions() {
    final receiptsTransactionData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData!.schoolId!,
      "SessionId": userData!.currentSessionid!,
      "StudentId": userData!.stuEmpId,
      "StuEmpId": userData!.stuEmpId,
      "UserType": userData!.ouserType,
    };
    print("Sending getFeeReceipts data => $receiptsTransactionData");
    if (_showReceipts == 'true')
      context
          .read<FeeReceiptsCubit>()
          .feeReceiptsCubitCall(receiptsTransactionData);
    context
        .read<FeeTransactionHistoryCubit>()
        .feeTransactionHistoryCubitCall(receiptsTransactionData);
  }

  getMonthsFromApi() {
    final monthsData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData!.schoolId!,
      "SessionId": userData!.currentSessionid!,
      "StudentId": userData!.stuEmpId,
      "StuEmpId": userData!.stuEmpId,
      "FeecatId": feeCatId,
      "UserType": userData!.ouserType,
    };
    print("Sending monthsData data => $monthsData");
    context.read<FeeMonthsCubit>().feeMonthsCubitCall(monthsData);
  }

  termsConditionsSettingFromApi() async {
    final data = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData!.schoolId!,
      "StuEmpId": userData!.stuEmpId,
      "UserType": userData!.ouserType,
    };
    print("Sending TermsConditionsSetting data => $data");
    context
        .read<TermsConditionsSettingCubit>()
        .termsConditionsSettingCubitCall(data);
  }

  feeTypeSettingFromApi() async {
    final data = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "SchoolID": userData!.schoolId!,
      "StuEmpId": userData!.stuEmpId,
      "UserType": userData!.ouserType,
    };
    print("Sending FeeTypeSetting data => $data");
    context.read<FeeTypeSettingCubit>().feeTypeSettingCubitCall(data);
  }

  getRemarksFromApi() async {
    final remarkData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "SchoolId": userData!.schoolId!,
      "SessionId": userData!.currentSessionid!,
      "InvoiceOrReceipt": "R",
      "FeeCat": feeCatId,
      "FeeReceiptType": "M",
      "StudentId": userData!.stuEmpId,
      "classid": "204", //stuInfo!.classId,
      "StuType": "All",
    };
    print("Sending remarkData data => $remarkData");
    context.read<FeeRemarkCubit>().feeRemarkCubitCall(remarkData);
  }

  getStudentFeeReceiptFromApi(FeeMonthsModel feeMonths) async {
    setState(() => jsonMonthData = []);
    for (int i = 0; i < monthDropdown!.length; i++) {
      final jsonData = {
        "FeeMonthId": monthDropdown![i].feeMonthId,
        "isBalance": monthDropdown![i].isBalance,
        "FeeType": monthDropdown![i].feeType
      };
      jsonMonthData.add(jsonData);
      if (monthDropdown![i] == feeMonths) break;
    }

    // final jsonData = {
    //   "FeeMonthId": feeMonths.feeMonthId,
    //   "isBalance": feeMonths.isBalance,
    //   "FeeType": feeMonths.feeType
    // };

    final receiptData = {
      "UserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData!.schoolId!,
      "SessionId": userData!.currentSessionid!,
      "FeecatId": feeCatId,
      "StuEmpId": userData!.stuEmpId,
      "JsonMonths": jsonEncode(jsonMonthData),
      "UserType": userData!.ouserType,
    };
    print("Sending receiptData & fineData data => $receiptData");
    context
        .read<StudentFeeReceiptCubit>()
        .studentFeeReceiptCubitCall(receiptData);
    context.read<StudentFeeFineCubit>().studentFeeFineCubitCall(receiptData);
  }

  selectPaymentGateway() {
    final type = gatewayData![0].gatewayType;
    switch (type) {
      case 'payu':
        print("{$type Found}");
        break;
      case 'ebs':
        print("{$type Found}");
        break;
      case 'payubiz':
        print("{$type Found}");
        // getPayUBizMainHashFromApi();
        // PaymentGatewayMethods.getPayUBizMainHashFromApi(context);
        break;
      case 'techprocess':
        print("{$type Found}");
        break;
      case 'ccavenue':
        print("{$type Found}");
        PaymentGatewayMethods.sendAirPayData(context,
            gatewayData: gatewayData,
            // amount: feeDetailsList![widget.currentIndex!].amountPaid,
            amount: editTotalAmount!.toLowerCase() == 'true'
                ? totalAmountController.text
                : totalAmount.toString(),
            stuInfo: stuInfo);
        break;
      case 'airpay':
        print("{$type Found}");
        PaymentGatewayMethods.sendAirPayData(context,
            gatewayData: gatewayData,
            // amount: feeDetailsList![widget.currentIndex!].amountPaid,
            amount: editTotalAmount!.toLowerCase() == 'true'
                ? totalAmountController.text
                : totalAmount.toString(),
            stuInfo: stuInfo);
        break;
      case 'worldline':
        print("{$type Found}");
        break;
      default:
        print("UnKnown Found");
        break;
    }
  }

  @override
  void dispose() {
    totalAmountController.dispose();
    super.dispose();
  }

  _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000)).then((value) {
      setState(() {
        selectedFeeType = FeeTypeModel(iD: "", paramname: "");
        feeTypeDropdown = [];
        selectedMonth = FeeMonthsModel(
            feeMonthId: "", feeMonthName: "", feeType: "", isBalance: "");
        monthDropdown = [];
        getDataFromCache();
      });
    });
  }

  goToPaymentGateway(String gatewayUrl) async {
    bool status = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => PaymentScreen(gatewayUrl: gatewayUrl)),
    );
    if (status) {
      _onRefresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: DrawerWidget(),
      resizeToAvoidBottomInset: true,
      appBar: commonAppBar(
        context,
        title: "Fee Payment",
        // leadingIcon: InkResponse(
        //   onTap: () {},
        //   child: Icon(
        //     Icons.arrow_back,
        //   ),
        // ),
      ),
      body: RefreshIndicator(
        onRefresh: () => _onRefresh(),
        child: MultiBlocListener(
          listeners: [
            BlocListener<GatewayTypeCubit, GatewayTypeState>(
              listener: (context, state) {
                if (state is GatewayTypeLoadFail) {
                  if (state.failReason == "false") {
                    UserUtils.unauthorizedUser(context);
                  }
                }
                if (state is GatewayTypeLoadSuccess) {
                  goToPaymentGateway(state.gatewayUrl);
                  // setState(() {
                  //   gatewayData = state.gatewayData;
                  // });
                  // selectPaymentGateway();
                }
              },
            ),
            BlocListener<PayUBizHashCubit, PayUBizHashState>(
              listener: (context, state) {
                if (state is PayUBizHashLoadFail) {
                  if (state.failReason == "false") {
                    UserUtils.unauthorizedUser(context);
                  }
                }
                if (state is PayUBizHashLoadSuccess) {
                  PaymentGatewayMethods.sendPayUBizData(
                    context,
                    gatewayData: gatewayData,
                    amount: totalAmount.toString(),
                    payUBizData: state.payUBizData,
                    // stuInfo: stuInfo,
                  );
                }
              },
            ),
            BlocListener<StudentInfoCubit, StudentInfoState>(
              listener: (context, state) {
                if (state is StudentInfoLoadFail) {
                  if (state.failReason == "false") {
                    UserUtils.unauthorizedUser(context);
                  }
                }
                if (state is StudentInfoLoadSuccess) {
                  setState(() {
                    stuInfo = state.studentInfoData;
                  });
                }
              },
            ),
            BlocListener<FeeTypeSettingCubit, FeeTypeSettingState>(
              listener: (context, state) {
                if (state is FeeTypeSettingLoadFail) {
                  if (state.failReason == "false") {
                    UserUtils.unauthorizedUser(context);
                  }
                }
                if (state is FeeTypeSettingLoadSuccess) {
                  setState(() {
                    if (state.feeTypeSettings == "1") {
                      showFeeTypeDropdown = false;
                    }
                  });
                }
              },
            ),
            BlocListener<TermsConditionsSettingCubit,
                TermsConditionsSettingState>(
              listener: (context, state) {
                if (state is TermsConditionsSettingLoadFail) {
                  if (state.failReason == "false") {
                    UserUtils.unauthorizedUser(context);
                  }
                }
                if (state is TermsConditionsSettingLoadSuccess) {
                  setState(() {
                    if (state.setting != "") {
                      termsConditionsSettingValue = state.setting;
                      print(
                          "termsConditionsSettingValue is not empty : $termsConditionsSettingValue");
                    } else {
                      termsConditionsSettingValue = "";
                      print("termsConditionsSettingValue is empty");
                    }
                  });
                }
              },
            ),
            BlocListener<FeeMonthsCubit, FeeMonthsState>(
              listener: (context, state) {
                if (state is FeeMonthsLoadInProgress) {
                  setState(() {
                    totalAmount = 0;
                    totalAmountController.text = "";
                    totalFine = 0;
                  });
                }
                if (state is FeeMonthsLoadSuccess) {
                  setState(() {
                    selectedMonth = state.feeMonths[0];
                    monthDropdown = state.feeMonths;
                  });
                  // getRemarksFromApi();
                  getStudentFeeReceiptFromApi(state.feeMonths[0]);
                  if (monthDropdown == []) {
                    setState(() {
                      showFineWidget = false;
                    });
                  }
                }
                if (state is FeeMonthsLoadFail) {
                  if (state.failReason == "false") {
                    UserUtils.unauthorizedUser(context);
                  } else {
                    getStudentFeeReceiptFromApi(FeeMonthsModel(
                        feeMonthId: "",
                        feeMonthName: "",
                        feeType: "",
                        isBalance: ""));
                    if (monthDropdown == []) {
                      setState(() {
                        showFineWidget = false;
                      });
                    }
                  }
                }
              },
            ),
            BlocListener<FeeTypeCubit, FeeTypeState>(
              listener: (context, state) {
                if (state is FeeTypeLoadInProgress) {
                  setState(() {
                    totalAmount = 0;
                    totalAmountController.text = "";
                    totalFine = 0;
                  });
                }
                if (state is FeeTypeLoadSuccess) {
                  setState(() {
                    feeCatId = state.feeTypes[0].iD;
                    selectedFeeType = state.feeTypes[0];
                    feeTypeDropdown = state.feeTypes;
                  });
                  getMonthsFromApi();
                  if (feeTypeDropdown! == []) {
                    setState(() {
                      showFineWidget = false;
                    });
                  }
                  // getRemarksFromApi();
                }
                if (state is FeeTypeLoadFail) {
                  if (state.failReason == "false") {
                    UserUtils.unauthorizedUser(context);
                  } else {
                    setState(() {
                      selectedFeeType = FeeTypeModel(iD: "", paramname: "");
                      feeTypeDropdown = [];
                    });
                    if (feeTypeDropdown == []) {
                      setState(() {
                        showFineWidget = false;
                      });
                    }
                  }
                }
              },
            ),
          ],
          child: NestedScrollView(
            controller: scrollController,
            physics: ScrollPhysics(parent: PageScrollPhysics()),
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate([
                    Row(
                      children: [
                        if (showFeeTypeDropdown) buildFeeTypeDropdown(context),
                        buildMonthDropdown(context),
                      ],
                    ),
                    SizedBox(height: 10),
                    Divider(color: Color(0xffECECEC), thickness: 6),
                    BlocConsumer<StudentFeeReceiptCubit,
                        StudentFeeReceiptState>(
                      listener: (context, state) {
                        if (state is StudentFeeReceiptLoadFail) {
                          if (state.failReason == "false") {
                            UserUtils.unauthorizedUser(context);
                          } else {
                            setState(() {
                              showFineWidget = false;
                            });
                          }
                        }
                        if (state is StudentFeeReceiptLoadSuccess) {
                          if (state.feeDetails.isNotEmpty) {
                            setState(() {
                              totalAmount = 0;
                              totalAmountController.text = "";
                              feeDetailsList = state.feeDetails;
                              feeDetailsList!.forEach((element) {
                                totalAmount = totalAmount +
                                    int.tryParse(element.amountPaid!)!;
                              });
                              totalAmountController.text =
                                  totalAmount.toString();
                              showFineWidget = true;
                            });
                            print("totalAmount before fine : $totalAmount");
                          }
                        }
                      },
                      builder: (context, state) {
                        if (state is StudentFeeReceiptLoadInProgress) {
                          print("StudentFeeReceiptLoadInProgress Screen");
                          return Center(child: Text('Calculating...'));
                        } else if (state is StudentFeeReceiptLoadSuccess) {
                          print("StudentFeeReceiptLoadSuccess Screen");
                          return buildFeeDescription(context,
                              feeDetails: state.feeDetails);
                        } else if (state is StudentFeeReceiptLoadFail) {
                          print("StudentFeeReceiptLoadFail Screen");
                          return Center(child: Text(state.failReason));
                        } else {
                          return Center(child: Text('Please wait...'));
                        }
                      },
                    ),
                    BlocConsumer<StudentFeeFineCubit, StudentFeeFineState>(
                      listener: (context, state) {
                        if (state is StudentFeeFineLoadSuccess) {
                          if (state.studentFine.isNotEmpty) {
                            setState(() {
                              totalFine = 0;
                              totalFine = totalFine +
                                  double.parse(state.studentFine).toInt();
                              totalAmountController.text =
                                  (totalAmount + totalFine).toString();
                              // totalAmount = totalAmount +
                              //     double.parse(state.studentFine).toInt();
                              print("totalFine after API : $totalFine");
                              print(
                                  "totalAmount after fine : ${totalAmount + totalFine}");
                              showPayButton = true;
                            });
                          }
                        }
                        if (state is StudentFeeFineLoadFail) {
                          if (state.failReason == "false") {
                            UserUtils.unauthorizedUser(context);
                          } else {
                            setState(() {
                              showPayButton = false;
                            });
                          }
                        }
                      },
                      builder: (context, state) {
                        if (state is StudentFeeFineLoadInProgress) {
                          return Container();
                        } else if (state is StudentFeeFineLoadSuccess) {
                          return buildFineWidget(context);
                        } else if (state is StudentFeeFineLoadFail) {
                          return buildFineWidget(context);
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ]),
                ),
              ];
            },
            body: _showReceipts == 'true'
                ? DefaultTabController(
                    initialIndex: _currentIndex,
                    length: 2,
                    child: buildTabBarBody(context),
                  )
                : buildTabBarBody(context),
          ),
        ),
      ),
    );
  }

  Column buildTabBarBody(BuildContext context) {
    return Column(
      children: [
        Divider(color: Color(0xffECECEC), thickness: 6),
        if (_showReceipts == 'true')
          buildTabBar(context)
        else
          Container(
            margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 8.0),
            height: 40,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            alignment: Alignment.center,
            child: Text(
              'Transaction History',
              style: TextStyle(color: Colors.white),
            ),
          ),
        if (_showReceipts == 'true')
          Expanded(
            child: TabBarView(
              // physics: NeverScrollableScrollPhysics(),
              children: [
                BlocConsumer<FeeReceiptsCubit, FeeReceiptsState>(
                  listener: (context, state) {
                    if (state is FeeReceiptsLoadFail) {
                      if (state.failReason == "false") {
                        UserUtils.unauthorizedUser(context);
                      }
                    }
                  },
                  builder: (context, state) {
                    if (state is FeeReceiptsLoadInProgress) {
                      // return Center(child: CircularProgressIndicator());
                      return Center(child: LinearProgressIndicator());
                    } else if (state is FeeReceiptsLoadSuccess) {
                      return buildFeeReceipts(context,
                          receiptsList: state.receiptsList);
                    } else if (state is FeeReceiptsLoadFail) {
                      return Center(child: Text(NO_RECORD_FOUND));
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
                BlocConsumer<FeeTransactionHistoryCubit,
                    FeeTransactionHistoryState>(
                  listener: (context, state) {
                    if (state is FeeTransactionHistoryLoadFail) {
                      if (state.failReason == "false") {
                        UserUtils.unauthorizedUser(context);
                      }
                    }
                  },
                  builder: (context, state) {
                    if (state is FeeTransactionHistoryLoadInProgress) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is FeeTransactionHistoryLoadSuccess) {
                      return buildTransactionHistory(context,
                          transactionlist: state.transactionlist);
                    } else if (state is FeeTransactionHistoryLoadFail) {
                      return Center(
                          child: Text(
                        state.failReason,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ));
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ],
            ),
          )
        else
          Expanded(
            child: BlocConsumer<FeeTransactionHistoryCubit,
                FeeTransactionHistoryState>(
              listener: (context, state) {
                if (state is FeeTransactionHistoryLoadFail) {
                  if (state.failReason == "false") {
                    UserUtils.unauthorizedUser(context);
                  }
                }
              },
              builder: (context, state) {
                if (state is FeeTransactionHistoryLoadInProgress) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is FeeTransactionHistoryLoadSuccess) {
                  return buildTransactionHistory(context,
                      transactionlist: state.transactionlist);
                } else if (state is FeeTransactionHistoryLoadFail) {
                  return Center(child: Text(state.failReason));
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
      ],
    );
  }

  Expanded buildFeeTypeDropdown(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            buildLabels('Fee Type :'),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xffECECEC)),
                // borderRadius: BorderRadius.circular(4),
              ),
              child: DropdownButton<FeeTypeModel>(
                onTap: () => FocusScope.of(context).unfocus(),
                isDense: true,
                value: selectedFeeType!,
                key: dropdownKey,
                // key: UniqueKey(),
                isExpanded: true,
                underline: Container(),
                items: feeTypeDropdown!
                    .map((item) => DropdownMenuItem<FeeTypeModel>(
                        child: Text(
                          item.paramname!,
                          // style: Theme.of(context).textTheme.headline6,
                        ),
                        value: item))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    selectedFeeType = val;
                    print("selectedFeeType ID: ${val!.iD}");
                    print("selectedFeeType Param: ${val.paramname}");
                    feeCatId = selectedFeeType!.iD;
                    showFineWidget = false;
                  });
                  getMonthsFromApi();
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Expanded buildMonthDropdown(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            buildLabels('Month :'),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xffECECEC)),
                // borderRadius: BorderRadius.circular(4),
              ),
              child: DropdownButton<FeeMonthsModel>(
                onTap: () => FocusScope.of(context).unfocus(),
                isDense: true,
                value: selectedMonth!,
                key: UniqueKey(),
                isExpanded: true,
                underline: Container(),
                items: monthDropdown!
                    .map((item) => DropdownMenuItem<FeeMonthsModel>(
                        child: Text(
                          item.feeMonthName!,
                          // style: Theme.of(context).textTheme.headline6,
                        ),
                        value: item))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    selectedMonth = val!;
                    print("selectedMonth: $val");
                  });
                  getStudentFeeReceiptFromApi(val!);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding buildLabels(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        label,
        // style: Theme.of(context).textTheme.headline6,
        // style: TextStyle(
        //   // color: Theme.of(context).primaryColor,
        //   color: Color(0xff313131),
        // ),
      ),
    );
  }

  Column buildFeeDescription(BuildContext context,
      {List<StudentFeeReceiptModel>? feeDetails}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Table(
            columnWidths: {
              0: FlexColumnWidth(MediaQuery.of(context).size.width / 2),
              1: FlexColumnWidth((MediaQuery.of(context).size.width / 2) / 2),
              2: FlexColumnWidth((MediaQuery.of(context).size.width / 2) / 2),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            // textDirection: TextDirection.rtl,
            // defaultVerticalAlignment: TableCellVerticalAlignment.top,
            // border: TableBorder.all(width: 2.0, color: Colors.red),
            children: [
              TableRow(
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                ),
                children: [
                  buildTableRowText(
                      title: "FeeName",
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[50],
                      alignment: Alignment.centerLeft),
                  buildTableRowText(
                      title: "Amt Due",
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[50],
                      alignment: Alignment.centerRight),
                  buildTableRowText(
                      title: "Paid Amt",
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[50],
                      alignment: Alignment.centerRight),
                ],
              ),
              for (int i = 0; i < feeDetailsList!.length; ++i)
                buildTableRows(
                  feeName: feeDetailsList![i].feeName,
                  amountDue: feeDetailsList![i].amountPayable,
                  paidAmount: feeDetailsList![i].amountPaid,
                  editCell: feeDetailsList![i].isMandatory,
                  currentIndex: i,
                  feeDetails: feeDetailsList,
                ),
            ],
          ),
        ),
      ],
    );
  }

  Column buildFineWidget(
    BuildContext context, {
    int? currentIndex = -1,
    List<StudentFeeReceiptModel>? feeDetails,
  }) {
    return showFineWidget
        ? Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Table(
                  columnWidths: {
                    0: FlexColumnWidth(MediaQuery.of(context).size.width / 2),
                    1: FlexColumnWidth(
                        (MediaQuery.of(context).size.width / 2) / 2),
                    2: FlexColumnWidth(
                        (MediaQuery.of(context).size.width / 2) / 2),
                  },
                  // textDirection: TextDirection.rtl,
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  // border: TableBorder.all(width: 2.0, color: Colors.red,style: TextStyle()),
                  children: [
                    buildTableRows(
                      feeName: "Fine",
                      amountDue: totalFine.toString(),
                      paidAmount: totalFine.toString(),
                      editCell: '1',
                    ),
                    TableRow(
                      decoration: BoxDecoration(color: Colors.green[100]),
                      children: [
                        buildTableRowText(
                            title: "",
                            fontWeight: FontWeight.bold,
                            color: Colors.green[100],
                            alignment: Alignment.centerLeft),
                        buildTableRowText(
                            title: "Total:",
                            fontWeight: FontWeight.bold,
                            color: Colors.green[100],
                            alignment: Alignment.centerRight),
                        if (editTotalAmount!.toLowerCase() == 'true')
                          buildTotalAmountTextField(context)
                        // FeePaymentTextField(
                        //   paidAmount:
                        //       userData!.fillFeeAmount!.toUpperCase() == "N"
                        //           ? ""
                        //           : '${totalAmount + totalFine}',
                        //   currentIndex: currentIndex,
                        //   feeDetails: [],
                        // )
                        else
                          buildTableRowText(
                              title: '${totalAmount + totalFine}',
                              fontWeight: FontWeight.bold,
                              color: Colors.green[100],
                              alignment: Alignment.centerRight),
                      ],
                    ),
                    // TableRow(
                    //   children: [
                    //     buildTableRowText(
                    //         title: "",
                    //         fontWeight: FontWeight.bold,
                    //         color: Colors.green[100],
                    //         alignment: Alignment.centerLeft),
                    //     buildTableRowText(
                    //         title: "Total:",
                    //         fontWeight: FontWeight.bold,
                    //         color: Colors.green[100],
                    //         alignment: Alignment.center),
                    //     Container(
                    //       child: TextFormField(
                    //         // obscureText: !obscureText ? false : true,
                    //         // controller: controller,
                    //         // validator: validator,
                    //         // keyboardType: keyboardType,
                    //         // autovalidateMode: AutovalidateMode.onUserInteraction,
                    //         style: TextStyle(color: Colors.black),
                    //         decoration: InputDecoration(
                    //           // border: new OutlineInputBorder(
                    //           //   borderRadius: const BorderRadius.all(
                    //           //     const Radius.circular(18.0),
                    //           //   ),
                    //           // ),
                    //           // enabledBorder: OutlineInputBorder(
                    //           //   borderSide: BorderSide(
                    //           //     color: Color(0xffECECEC),
                    //           //   ),
                    //           //   gapPadding: 0.0,
                    //           // ),
                    //           // disabledBorder: OutlineInputBorder(
                    //           //   borderSide: BorderSide(
                    //           //     color: Theme.of(context).primaryColor,
                    //           //   ),
                    //           // ),
                    //           // errorBorder: OutlineInputBorder(
                    //           //   borderSide: BorderSide(
                    //           //     color: Color(0xffECECEC),
                    //           //   ),
                    //           // ),
                    //           // focusedErrorBorder: OutlineInputBorder(
                    //           //   borderSide: BorderSide(
                    //           //     color: Theme.of(context).primaryColor,
                    //           //   ),
                    //           // ),
                    //           // focusedBorder: OutlineInputBorder(
                    //           //   borderSide: BorderSide(
                    //           //     color: Theme.of(context).primaryColor,
                    //           //   ),
                    //           // ),
                    //           hintText: "type here",
                    //           hintStyle: TextStyle(color: Color(0xffA5A5A5)),
                    //           contentPadding: const EdgeInsets.symmetric(
                    //               vertical: 0.0, horizontal: 8.0),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
              if (termsConditionsSettingValue != "")
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      Checkbox(
                        value: selectedCheckBox,
                        onChanged: (val) {
                          setState(() {
                            selectedCheckBox = val!;
                          });
                        },
                      ),
                      Text(
                        termsConditionsSettingValue,
                        textScaleFactor: 1.5,
                        style: GoogleFonts.quicksand(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              if (showPayButton)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      style: ButtonStyle(
                          side: MaterialStateProperty.all(
                        BorderSide(
                          color: Color(0xff286090).withOpacity(0.8),
                          style: BorderStyle.solid,
                          width: 0.8,
                        ),
                      )),
                      // borderSide: BorderSide(
                      //   color: Color(0xff286090).withOpacity(0.8),
                      //   style: BorderStyle.solid,
                      //   width: 0.8,
                      // ),
                      onPressed: () {
                        final feeData = {
                          "feecatid": feeCatId,
                          "tillmonth": selectedMonth!.feeMonthId,
                        };
                        Navigator.pushNamed(
                            context, PayByChequeStudent.routeName,
                            arguments: feeData);
                      },
                      child: Text(
                        "By Cheque",
                        style: GoogleFonts.quicksand(
                            color: Color(0xff286090).withOpacity(0.8),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Color(0xff2ab57d),
                        ),
                        // shape: MaterialStateProperty.all(
                        //   RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.circular(30),
                        //   ),
                        // ),
                      ),
                      onPressed: () async {
                        if (termsConditionsSettingValue != "") {
                          if (selectedCheckBox) {
                            hitGatewayTypeApi();
                          } else {
                            toastAlertNotification(
                                "Please accept terms & conditions.");
                          }
                        } else {
                          hitGatewayTypeApi();
                        }
                      },
                      child: Text(
                        "Pay Online",
                        style: GoogleFonts.quicksand(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
            ],
          )
        : Column();
  }

  void hitGatewayTypeApi() {
    final gatewayData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData!.schoolId,
      "SessionId": userData!.currentSessionid,
      "ActualAmount": editTotalAmount!.toLowerCase() == 'true'
          ? totalAmountController.text
          : totalAmount.toString(),
      // "ActualAmount": "1",
      "TillMonthId": jsonMonthData[0]["FeeMonthId"] as String,
      // "TillMonthId": "4",
      "mobile": stuInfo!.mobile,
      "StuEmpId": userData!.stuEmpId,
      "AdmNo": stuInfo!.admNo,
      "StName": stuInfo!.stName,
      "UserType": userData!.ouserType,
      "FeecatId": feeCatId,
      // "FeecatId": "103",
      "BloggerUrl": "",
      "LogoImgPath": userData!.logoImgPath,
      "WebsiteUrl": userData!.websiteUrl,
      "TestUrl": userData!.appUrl,
      "IncrementMonthId": "",
      "ShowFeeReceipt": "",
      "SendOTP": "N",
    };
    print("Sending GatewayType data => $gatewayData");
    context.read<GatewayTypeCubit>().gatewayTypeCubitCall(gatewayData);
  }

  Container buildTotalAmountTextField(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      // decoration: BoxDecoration(
      //   border: Border.all(color: Colors.black45),
      // ),
      child: TextFormField(
        controller: totalAmountController,
        showCursor: true,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          // LengthLimitingTextInputFormatter(10)
        ],
        style: GoogleFonts.quicksand(
          fontWeight: FontWeight.w400,
          fontSize: 16.0,
          color: Colors.black45,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          // fillColor: Color(0xffECECEC),
          border: new OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(18.0),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black45,
              // color: Color(0xffECECEC),
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
              color: Colors.white,
              // color: Color(0xffECECEC),
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
          hintText: "0",
          hintStyle: TextStyle(color: Color(0xffA5A5A5), fontSize: 12),
          isDense: true,
          // contentPadding:
          //     EdgeInsets.zero,
          contentPadding: const EdgeInsets.all(4),
        ),
        textAlign: TextAlign.right,
        onChanged: (String? val) {
          // if (widget.feeDetails != null &&
          //     widget.feeDetails != [] &&
          //     widget.currentIndex != -1) {
          //   print(
          //       'Before : ${feeDetailsList![widget.currentIndex!].amountPaid} & $totalAmount');
          //   setState(() {
          //     feeDetailsList![widget.currentIndex!]
          //         .amountPaid = paidAmountController.text;
          //     totalAmount = 0;
          //   });
          //   feeDetailsList!.forEach((element) {
          //     setState(() {
          //       totalAmount = totalAmount +
          //           int.tryParse(element.amountPaid!)!;
          //     });
          //   });
          //   print(
          //       'After : ${feeDetailsList![widget.currentIndex!].amountPaid} & $totalAmount');
          // } else {
          //   setState(() {
          //     totalAmount =
          //         int.parse(paidAmountController.text);
          //   });
          //   print(
          //       "totalAmount after edit => $totalAmount");
          // }
        },
      ),
    );
  }

  TableRow buildTableRows({
    String? feeName,
    String? amountDue,
    String? paidAmount,
    String? editCell = "1",
    int? currentIndex,
    List<StudentFeeReceiptModel>? feeDetails,
  }) {
    return TableRow(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xffECECEC))),
      ),
      children: [
        buildTableRowText(
            title: feeName,
            color: Colors.transparent,
            alignment: Alignment.centerLeft),
        buildTableRowText(
            title: amountDue,
            // color: Colors.blue[50],
            fontWeight: FontWeight.w600,
            alignment: Alignment.centerRight),
        if (editCell == '0' && feeName!.toLowerCase() != "fine")
          FeePaymentTextField(
            paidAmount:
                userData!.fillFeeAmount!.toUpperCase() == "N" ? "" : paidAmount,
            currentIndex: currentIndex,
            feeDetails: feeDetails,
          )
        else
          buildTableRowText(
              title: paidAmount,
              // color: Colors.green[100],
              // border: Border.all(color: Colors.black45),
              // border: Border.all(color: Color(0xffECECEC)),
              fontWeight: FontWeight.w700,
              alignment: Alignment.centerRight),
      ],
    );
  }

  Container buildTableRowText(
          {String? title,
          FontWeight? fontWeight,
          Color? color,
          BoxBorder? border,
          AlignmentGeometry? alignment}) =>
      Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: color,
          border: border ?? null,
        ),
        child: Align(
          alignment: alignment!,
          child: Text(
            title!,
            // textScaleFactor: 1.5,
            style: GoogleFonts.quicksand(
              fontWeight: fontWeight ?? FontWeight.w400,
              fontSize: 16.0,
            ),
            // style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      );

  Container buildTabBar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 8.0),
      height: 40,
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor)),
      child: TabBar(
        unselectedLabelColor: Theme.of(context).primaryColor,
        labelColor: Colors.white,
        indicator: BoxDecoration(
          // gradient: customGradient,
          color: Theme.of(context).primaryColor,
        ),
        physics: ClampingScrollPhysics(),
        onTap: (int tabIndex) {
          print("tabIndex: $tabIndex");
          switch (tabIndex) {
            case 0:
              tabIndexChange(tabIndex);
              getFeeReceiptsTransactions();
              break;
            case 1:
              tabIndexChange(tabIndex);
              getFeeReceiptsTransactions();
              break;
            default:
              tabIndexChange(tabIndex);
              getFeeReceiptsTransactions();
              break;
          }
        },
        tabs: [
          buildTabs(title: 'Fee Receipts', index: 0),
          buildTabs(title: 'Trans. History', index: 1),
        ],
        controller: tabController,
      ),
    );
  }

  Tab buildTabs({String? title, int? index}) {
    return Tab(
      child: FittedBox(
        child: Text(title!,
            style: GoogleFonts.quicksand(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            )),
      ),
    );
  }

  Container buildFeeReceipts(BuildContext context,
      {List<FeeReceiptsModel>? receiptsList}) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: receiptsList!.isNotEmpty
          ? ListView.separated(
              separatorBuilder: (context, index) => SizedBox(height: 10.0),
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: receiptsList.length,
              itemBuilder: (context, i) {
                var item = receiptsList[i];
                return Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffDBDBDB)),
                  ),
                  child: Column(
                    children: [
                      buildRow(title: "Receipt No.", value: item.receiptNo),
                      buildRow(title: "Receipt Date", value: item.newFeeDate),
                      Divider(color: Color(0xffDBDBDB), height: 20),
                      buildRow(
                          title: "Receive Amount", value: item.receiveAmount),
                    ],
                  ),
                );
              },
            )
          : noRecordFound(),
    );
  }

  Container buildTransactionHistory(BuildContext context,
      {List<FeeTransactionHistoryModel>? transactionlist}) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: transactionlist!.isNotEmpty
          ? ListView.separated(
              separatorBuilder: (context, index) => SizedBox(height: 10),
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: transactionlist.length,
              itemBuilder: (context, i) {
                var item = transactionlist[i];
                return Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffDBDBDB)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildColumn(title: "Transaction Id", value: item.transId),
                      Divider(color: Color(0xffDBDBDB), height: 20),
                      buildRow(
                          title: "Transaction Date", value: item.transDate),
                      Divider(color: Colors.white, height: 10),
                      buildColumn(
                          title: "Transaction Status",
                          value: item.transStatus,
                          color: Colors.red[400]),
                      Divider(color: Color(0xffDBDBDB), height: 20),
                      buildRow(title: "Amount", value: item.amountDep),
                    ],
                  ),
                );
              },
            )
          : Center(child: Text(NO_RECORD_FOUND)),
    );
  }

  Row buildRow({String? title, String? value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title ?? "",
          style:
              TextStyle(color: Color(0xff777777), fontWeight: FontWeight.w600),
        ),
        Text(
          value ?? "",
          style:
              TextStyle(color: Color(0xff3A3A3A), fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Padding buildDetailsRow(
      {String? title, String? dueAmount, String? paidAmount, Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title ?? "",
            style: TextStyle(
                color: color ?? Color(0xff777777), fontWeight: FontWeight.w600),
          ),
          Row(
            children: [
              Text(
                dueAmount ?? "",
                style: TextStyle(
                    color: color ?? Color(0xff3A3A3A),
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(width: 30),
              Text(
                paidAmount ?? "",
                style: TextStyle(
                    color: color ?? Color(0xff3A3A3A),
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Column buildColumn({String? title, String? value, Color? color}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title ?? "",
          style:
              TextStyle(color: Color(0xff777777), fontWeight: FontWeight.w600),
        ),
        Text(
          value ?? "",
          style: TextStyle(
              color: color ?? Color(0xff3A3A3A), fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  void getPayUBizMainHashFromApi() async {
    print("Welcome to getPayUBizMainHashFromApi");
    final payUData = {
      'OUserId': uid,
      'Token': token,
      'OrgId': userData!.organizationId,
      'Schoolid': userData!.schoolId,
      'txnId':
          "WEBPayUBiz${DateFormat("yyyyMMddHHmmssffff").format(DateTime.now())}",
      'amount': '1',
      'productName': 'SchoolFee',
      'firstName': 'Testing',
      'email': 'testing@gmail.com',
      'udf1': userData!.stuEmpId, //StuEmpId
      'udf2': userData!.schoolId, //SchoolId
      'udf3': userData!.organizationId, //OrgId
      'udf4': '28 Jul 2021', //TillMonthId
      'udf5': '3276', //Adm No
    };
    print("Sending PayUBizGateway Data: $payUData");
    await context.read<PayUBizHashCubit>().payUBizHashCubitCall(payUData);
  }

  void _goToPaymentGateway(BuildContext context) async {
    setState(() => paymentLoader = !paymentLoader);
    // PaymentGatewayResponse<PaymentResponseHolder> paymentResponse =
    //     await PaymentGatewayApi.pay(context, '1');

    // if (paymentResponse.respObject!.paymentStatus == "SUCCESS") {
    //   print("Payment Gateway Final Response:-> ${paymentResponse.respObject}");

    //   setState(() => paymentLoader = !paymentLoader);
    // } else {
    //   print("Payment Gateway Final Error: -> ${paymentResponse.errorCause}");
    //   // showPaymentFailedDialog(paymentResponse.errorCause, isSuccess: false);
    //   setState(() => paymentLoader = !paymentLoader);
    // }
  }
}

class FeePaymentTextField extends StatefulWidget {
  final String? paidAmount;
  final int? currentIndex;
  final List<StudentFeeReceiptModel>? feeDetails;
  const FeePaymentTextField(
      {Key? key, this.paidAmount, this.feeDetails, this.currentIndex})
      : super(key: key);

  @override
  _FeePaymentTextFieldState createState() => _FeePaymentTextFieldState();
}

class _FeePaymentTextFieldState extends State<FeePaymentTextField> {
  TextEditingController paidAmountController = TextEditingController();

  @override
  void initState() {
    if (widget.feeDetails != null && widget.feeDetails != [])
      paidAmountController.text = widget.paidAmount!;
    else
      paidAmountController.text = totalAmount.toString();
    super.initState();
  }

  @override
  void dispose() {
    paidAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      // decoration: BoxDecoration(
      //   border: Border.all(color: Colors.black45),
      // ),
      child: TextFormField(
        // obscureText: !obscureText ? false : true,
        controller: paidAmountController,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          // LengthLimitingTextInputFormatter(10)
        ],
        // validator: validator,
        keyboardType: TextInputType.number,
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        textAlign: TextAlign.right,
        style: GoogleFonts.quicksand(
          fontWeight: FontWeight.w400,
          fontSize: 16.0,
          color: Colors.black45,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.transparent,
          // fillColor: Color(0xffECECEC),
          border: new OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(18.0),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black26,
              // color: Color(0xffECECEC),
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
          hintText: "0",
          hintStyle: TextStyle(color: Color(0xffA5A5A5), fontSize: 12),
          isDense: true,
          // contentPadding:
          //     EdgeInsets.zero,
          contentPadding: const EdgeInsets.all(4),
          // contentPadding:
          //     const EdgeInsets.symmetric(vertical: -10.0, horizontal: 16.0),
        ),
        onChanged: (String? val) {
          // widget.feeDetails.in
          // list.map((data) => widget.feeDetails.add(data)).toList();

          if (widget.feeDetails != null &&
              widget.feeDetails != [] &&
              widget.currentIndex != -1) {
            print(
                'Before : ${feeDetailsList![widget.currentIndex!].amountPaid} & $totalAmount');
            setState(() {
              // feeDetailsList![widget.currentIndex!].amountPaid = val;
              feeDetailsList![widget.currentIndex!].amountPaid =
                  paidAmountController.text;
              totalAmount = 0;
            });
            feeDetailsList!.forEach((element) {
              setState(() {
                totalAmount = totalAmount + int.tryParse(element.amountPaid!)!;
              });
            });
            print(
                'After : ${feeDetailsList![widget.currentIndex!].amountPaid} & $totalAmount');
          } else {
            setState(() {
              totalAmount = int.parse(paidAmountController.text);
            });
            print("totalAmount after edit => $totalAmount");
          }
        },
      ),
    );
  }
}
