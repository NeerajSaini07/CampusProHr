import 'package:campus_pro/src/DATA/MODELS/restrictionPageModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/PAGES/STUDENT_MODULE/feePaymentStudent.dart';
import 'package:campus_pro/src/UI/PAGES/dashboard.dart';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../globalBlocProvidersFile.dart';

class RestrictionPage extends StatefulWidget {
  static const routeName = "/restriction-page";
  const RestrictionPage({Key? key}) : super(key: key);

  @override
  _RestrictionPageState createState() => _RestrictionPageState();
}

class _RestrictionPageState extends State<RestrictionPage> {
  List<RestrictionPageModel> restrictionList = [];

  bool isFeePaymentDue = false;
  bool showLoader = true;

  @override
  void initState() {
    getRestrictionMessages();
    super.initState();
  }

  getRestrictionMessages() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final request = {
      'OUserId': uid,
      'Token': token,
      'OrgId': userData!.organizationId,
      'Schoolid': userData.schoolId,
      'SessionId': userData.currentSessionid,
      'StuEmpId': userData.stuEmpId,
      'UserType': userData.ouserType,
    };
    context.read<RestrictionPageCubit>().restrictionPageCubitCall(request);
  }

  navigateToDashboard() async {
    final userData = await UserUtils.userTypeFromCache();
    final userType = userData!.ouserType;
    final appConfig = {
      'OrgId': userData.organizationId,
      'Schoolid': userData.schoolId,
    };
    context.read<AppConfigSettingCubit>().appConfigSettingCubitCall(appConfig);
    // Navigator.pushNamedAndRemoveUntil(
    //     context, Dashboard.routeName, (route) => false,
    //     arguments: userType);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return BlocProvider<EmployeeInfoCubit>(
        create: (_) =>
            EmployeeInfoCubit(EmployeeInfoRepository(EmployeeInfoApi())),
        child: BlocProvider<DrawerCubit>(
          create: (_) => DrawerCubit(DrawerRepository(DrawerApi())),
          child: BlocProvider<NotifyCounterCubit>(
              create: (_) => NotifyCounterCubit(
                  NotifyCounterRepository(NotifyCounterApi())),
              child: Dashboard(
                userType: userType,
              )),
        ),
      );
    }));
  }

  getStudentData() async {
    final uid = await UserUtils.idFromCache();
    final userToken = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final studentData = {
      "OUserId": uid!,
      "Token": userToken!,
      "OrgId": userData!.organizationId!,
      "Schoolid": userData.schoolId!,
      "StudentId": userData.stuEmpId!,
      "SessionId": userData.currentSessionid!,
      "UserType": userData.ouserType!,
    };
    context.read<StudentInfoCubit>().studentInfoCubitCall(studentData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "MESSAGES & ALERTS",
          style: GoogleFonts.quicksand(
            color: Theme.of(context).primaryColor,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<StudentInfoCubit, StudentInfoState>(
            listener: (context, state) {
              if (state is StudentInfoLoadSuccess) {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return BlocProvider<FeeTransactionHistoryCubit>(
                    create: (_) => FeeTransactionHistoryCubit(
                        FeeTransactionHistoryRepository(
                            FeeTransactionHistoryApi())),
                    child: BlocProvider<FeeReceiptsCubit>(
                      create: (_) => FeeReceiptsCubit(
                          FeeReceiptsRepository(FeeReceiptsApi())),
                      child: BlocProvider<StudentFeeFineCubit>(
                        create: (_) => StudentFeeFineCubit(
                            StudentFeeFineRepository(StudentFeeFineApi())),
                        child: BlocProvider<StudentFeeReceiptCubit>(
                          create: (_) => StudentFeeReceiptCubit(
                              StudentFeeReceiptRepository(
                                  StudentFeeReceiptApi())),
                          child: BlocProvider<FeeTypeCubit>(
                            create: (_) =>
                                FeeTypeCubit(FeeTypeRepository(FeeTypeApi())),
                            child: BlocProvider<FeeMonthsCubit>(
                              create: (_) => FeeMonthsCubit(
                                  FeeMonthsRepository(FeeMonthsApi())),
                              child: BlocProvider<TermsConditionsSettingCubit>(
                                create: (_) => TermsConditionsSettingCubit(
                                    TermsConditionsSettingRepository(
                                        TermsConditionsSettingApi())),
                                child: BlocProvider<FeeTypeSettingCubit>(
                                  create: (_) => FeeTypeSettingCubit(
                                      FeeTypeSettingRepository(
                                          FeeTypeSettingApi())),
                                  child: BlocProvider<StudentInfoCubit>(
                                    create: (_) => StudentInfoCubit(
                                        StudentInfoRepository(
                                            StudentInfoApi())),
                                    child: BlocProvider<PayUBizHashCubit>(
                                      create: (_) => PayUBizHashCubit(
                                          PayUBizHashRepository(
                                              PayUBizHashApi())),
                                      child: BlocProvider<GatewayTypeCubit>(
                                        create: (_) => GatewayTypeCubit(
                                            GatewayTypeRepository(
                                                GatewayTypeApi())),
                                        child: FeePaymentStudent(),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }));
                // Navigator.pushNamed(context, FeePaymentStudent.routeName);
              }
            },
          ),
          BlocListener<RestrictionPageCubit, RestrictionPageState>(
            listener: (context, state) {
              if (state is RestrictionPageLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                } else {
                  setState(() {
                    showLoader = false;
                  });
                }
              }
              if (state is RestrictionPageLoadSuccess) {
                setState(() {
                  restrictionList = state.restrictionList;
                  for (var i = 0; i < restrictionList.length; i++) {
                    if (restrictionList[i].messagetype == 2 &&
                        restrictionList[i].gotopayment == 1) {
                      isFeePaymentDue = true;
                      break;
                    }
                  }
                  showLoader = false;
                });
              }
            },
          ),
        ],
        child: Column(
          children: [
            Divider(
              color: Theme.of(context).primaryColor,
              thickness: 2.0,
            ),
            if (!showLoader)
              buildRestrictionBody(context)
            else
              Expanded(
                child: Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            Divider(
              thickness: 3,
              color: Theme.of(context).primaryColor,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Colors.red,
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        )),
                    onPressed: () => Navigator.pop(context),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.arrow_back_ios,
                          size: 14.0,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Text(
                          "Back",
                          style: GoogleFonts.quicksand(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (restrictionList.isNotEmpty)
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          )),
                      onPressed: () {
                        if (!isFeePaymentDue) {
                          navigateToDashboard();
                        } else {
                          getStudentData();
                          print("Payment is Due");
                        }
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            isFeePaymentDue ? "PAY NOW" : "Continue",
                            style: GoogleFonts.quicksand(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 14.0,
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRestrictionBody(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, i) => Divider(),
        shrinkWrap: true,
        itemCount: restrictionList.length,
        itemBuilder: (context, i) {
          var item = restrictionList[i];
          return ListTile(
            title: Html(
              data: item.message,
              shrinkWrap: true,
              style: {
                "body": Style(),
              },
            ),
          );
        },
      ),
    );
  }
}
