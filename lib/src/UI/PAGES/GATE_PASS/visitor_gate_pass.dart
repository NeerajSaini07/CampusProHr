import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/DATA/MODELS/gatePassMeetToModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/PAGES/GATE_PASS/gate_pass_history.dart';
import 'package:campus_pro/src/UI/PAGES/GATE_PASS/visitor_gate_pass_history.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonSnackbar.dart';
import 'package:campus_pro/src/UTILS/fieldValidators.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../globalBlocProvidersFile.dart';

class VisitorGatePassCheck extends StatefulWidget {
  static const routeName = "/visitor-new-gate-pass/";
  const VisitorGatePassCheck({Key? key}) : super(key: key);

  @override
  _VisitorGatePassCheckState createState() => _VisitorGatePassCheckState();
}

class _VisitorGatePassCheckState extends State<VisitorGatePassCheck> {
  String? visitorId = "";

  File? _pickedImage;
  File? _pickedImageIdProof;

  TextEditingController _mobileController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _detailController = TextEditingController();
  TextEditingController _otherPurposeController = TextEditingController();

  ///
  TextEditingController _otpController = TextEditingController();
  TextEditingController _otpController1 = TextEditingController();
  TextEditingController _otpController2 = TextEditingController();
  TextEditingController _otpController3 = TextEditingController();
  TextEditingController _otpController4 = TextEditingController();
  TextEditingController _otpController5 = TextEditingController();
  TextEditingController _otpController6 = TextEditingController();

  bool isVerify = false;

  int num = 0;
  // To Meet DropDown
  List<GatePassMeetToModel>? toMeetDropDown = [];
  GatePassMeetToModel? selectedToMeet;

  List<GatePassMeetToModel>? purposeDropDown = [];
  GatePassMeetToModel? selectedPurpose;

  bool showHistory = true;

  bool isIdProofLoader = false;
  bool isFinalLoader = false;

  bool isNumberCount = false;
  // List<DropdownMenuItem<String>> meetItems = toMeetList
  //     .map((e) => DropdownMenuItem(
  //           child: Text('$e'),
  //           value: e,
  //         ))
  //     .toList();

  // List<DropdownMenuItem<String>> purposeItems = purpose
  //     .map((e) => DropdownMenuItem(
  //           child: Text('$e'),
  //           value: e,
  //         ))
  //     .toList();

  ImagePicker picker = ImagePicker();
  PickedFile? selectedImage;

  bool isOtpSend = false;

  getMeetTo({int? num}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final sendingData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "EmpId": userData.stuEmpId,
      "UserType": userData.ouserType,
    };

    print("sending data for meet to $sendingData");

    final SharedPreferences pref = await SharedPreferences.getInstance();

    final String? jsonString =
        pref.getString(num == 0 ? "ToMeetData" : "ToMeetPurpose");

    if (jsonString != null && jsonString.isNotEmpty) {
      //
      if (num == 0) {
        // print(jsonDecode(jsonString).runtimeType);
        setState(() {
          List data = jsonDecode(jsonString);
          data.forEach((element) {
            toMeetDropDown!.add(GatePassMeetToModel.fromJson(element));
          });
          selectedToMeet = toMeetDropDown![0];
          num = 1;
        });
        print("test");
        getMeetTo(num: 1);
      } else {
        setState(() {
          List data = jsonDecode(jsonString);
          data.forEach((element) {
            purposeDropDown!.add(GatePassMeetToModel.fromJson(element));
          });
          // purposeDropDown = jsonDecode(jsonString);
          selectedPurpose = purposeDropDown![0];
        });
      }
      //
    } else {
      context
          .read<GatePassMeetToCubit>()
          .gatePassMeetToCubitCall(sendingData, num);
    }
  }

  saveVisitor({File? img}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final sendingData = {
      "UserId": uid.toString(),
      "Token": token.toString(),
      "OrgId": userData!.organizationId.toString(),
      "SchoolId": userData.schoolId.toString(),
      "EmpId": userData.stuEmpId.toString(),
      "UserType": userData.ouserType.toString(),
      "SessionId": userData.currentSessionid.toString(),
      "Name": _nameController.text,
      "No": _mobileController.text,
      "Address": _addressController.text,
      "OtherDet": _otherPurposeController.text,
      "MeetToId": selectedToMeet!.id.toString(),
      "PurposeId": selectedPurpose!.id.toString(),
      "OtherPurpose": _otherPurposeController.text,
      "VisitorId": visitorId!,
      "Flag": "F",
    };
    print("Sending SaveVisitorDetailsGatePass Data : $sendingData");
    context
        .read<SaveVisitorDetailsGatePassCubit>()
        .saveVisitorDetailsGatePassCubitCall(sendingData, img!);
  }

  void sendingOtpForGatePass({String? number}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final sendingData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "EmpId": userData.stuEmpId,
      "UserType": userData.ouserType,
      "No": number,
    };

    print("sending data for send otp $sendingData");

    context
        .read<SendingOtpGatePassCubit>()
        .sendingOtpGatePassCubitCall(sendingData);
  }

  void verifyOtpGatePass({String? otp, String? visitorid}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final sendingData = {
      "UserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "SchoolId": userData.schoolId,
      "EmpId": userData.stuEmpId,
      "UserType": userData.ouserType,
      "VisitorId": visitorid,
      "OtpCode": otp,
      "SessionId": userData.currentSessionid,
    };

    print("sending data for send otp $sendingData");

    context
        .read<VerifyOtpGatePassCubit>()
        .verifyOtpGatePassCubitCall(sendingData);
  }

  verifyId() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final sendingData = {
      "UserId": uid.toString(),
      "Token": token.toString(),
      "OrgId": userData!.organizationId.toString(),
      "SchoolId": userData.schoolId.toString(),
      "EmpId": userData.stuEmpId.toString(),
      "UserType": userData.ouserType.toString(),
      "VisitorId": visitorId.toString(),
      "Flag": "F",
    };

    print("sending data for verify id $sendingData");

    context
        .read<VerifyIdProofGatePassCubit>()
        .verifyIdProofGatePassCubitCall(sendingData, _pickedImageIdProof);
  }

  Future<File?> getImage({ImageSource source = ImageSource.gallery}) async {
    // Navigator.pop(context);
    final pickedFile = await ImagePicker().pickImage(
      source: source,
      imageQuality: 60,
    );
    if (pickedFile != null) {
      print('Wow! Image selected.');
      final image = File(pickedFile.path);
      return image;
    } else {
      print('Ops! No Image selected.');
    }
  }

  @override
  void initState() {
    getMeetTo(num: num);
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _detailController.dispose();
    _addressController.dispose();
    _mobileController.dispose();
    _otpController.dispose();
    _otpController1.dispose();
    _otpController2.dispose();
    _otpController3.dispose();
    _otpController4.dispose();
    _otpController5.dispose();
    _otpController6.dispose();
    _otherPurposeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: commonAppBar(context, title: 'Visitor Entry'),
      // drawer: DrawerWidget(),
      // key: _scaffoldKey,
      // appBar: commonAppBar(
      //   context,
      //   scaffoldKey: _scaffoldKey,
      //   centerTitle: true,
      //   showMenuIcon: true,
      //   shadowColor: Colors.transparent,
      //   backgroundColor: Colors.white,
      //   title: "DASHBOARD",
      //   style: GoogleFonts.quicksand(
      //       fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16),
      //   icon: IconButton(
      //     onPressed: () => Navigator.pushNamedAndRemoveUntil(
      //         context, UserType.routeName, (route) => false),
      //     icon: Container(
      //       height: 28,
      //       width: 28,
      //       child: Image.asset(AppImages.switchUser,
      //           fit: BoxFit.cover, color: Theme.of(context).primaryColor),
      //     ),
      //   ),
      // ),

      bottomNavigationBar: Container(
        // padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        // decoration: BoxDecoration(
        //   color: Theme.of(context).primaryColor,
        // ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return BlocProvider<MarkVisitorExitCubit>(
                    create: (_) => MarkVisitorExitCubit(
                        MarkVisitorExitRepository(MarkVisitorExitApi())),
                    child: BlocProvider<GetGatePassHistoryCubit>(
                      create: (_) => GetGatePassHistoryCubit(
                          GetGatePassHistoryRepository(
                              GetGatePassHistoryApi())),
                      child: GatePassHistory(),
                    ),
                  );
                }));
                // Navigator.pushNamed(context,  GatePassHistory.routeName);
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.4,
                margin: EdgeInsets.only(bottom: 5),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 13),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.indigoAccent.shade200,
                ),
                child: Text(
                  'Gate Pass History',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 16.0),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (showHistory == true) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return BlocProvider<VisitorListGatePassCubit>(
                      create: (_) => VisitorListGatePassCubit(
                          VisitorListTodayGatePassRepository(
                              VisitorListTodayGatePassApi())),
                      child: BlocProvider<MarkVisitorExitCubit>(
                        create: (_) => MarkVisitorExitCubit(
                            MarkVisitorExitRepository(MarkVisitorExitApi())),
                        child: VisitorHistory(),
                      ),
                    );
                  }));
                  // Navigator.pushNamed(context, VisitorHistory.routeName);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    commonSnackBar(
                      title: 'No Visitors History',
                      duration: Duration(
                        milliseconds: 400,
                      ),
                    ),
                  );
                }
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.4,
                margin: EdgeInsets.only(bottom: 5),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 13),
                decoration: BoxDecoration(
                  color: Colors.cyan.shade400,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  'Visitor History',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 16.0),
                ),
              ),
            ),
          ],
        ),
      ),
      // floatingActionButton: Container(
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceAround,
      //     children: [
      //       SizedBox(
      //         width: 20,
      //       ),
      //       GestureDetector(
      //         onTap: () {
      //           Navigator.pushNamed(context, GatePassHistory.routeName);
      //         },
      //         child: Container(
      //           padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      //           decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(30),
      //             color: Theme.of(context).primaryColor,
      //           ),
      //           child: Text(
      //             'Gate Pass History',
      //             style: TextStyle(
      //                 fontWeight: FontWeight.w600,
      //                 color: Colors.white,
      //                 fontSize: 16.0),
      //           ),
      //         ),
      //       ),
      //       SizedBox(
      //         width: 2,
      //       ),
      //       //
      //       GestureDetector(
      //         onTap: () {
      //           if (showHistory == true) {
      //             Navigator.pushNamed(context, VisitorHistory.routeName);
      //           } else {
      //             ScaffoldMessenger.of(context).showSnackBar(
      //               commonSnackBar(
      //                 title: 'No Visitors History',
      //                 duration: Duration(
      //                   milliseconds: 400,
      //                 ),
      //               ),
      //             );
      //           }
      //         },
      //         child: Container(
      //           padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      //           decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(30),
      //             color: Theme.of(context).primaryColor,
      //           ),
      //           child: Text(
      //             'Visitor History',
      //             style: TextStyle(
      //                 fontWeight: FontWeight.w600,
      //                 color: Colors.white,
      //                 fontSize: 16.0),
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      resizeToAvoidBottomInset: true,
      body: MultiBlocListener(
        listeners: [
          BlocListener<GatePassMeetToCubit, GatePassMeetToState>(
              listener: (context, state) async {
            SharedPreferences pref = await SharedPreferences.getInstance();

            if (state is GatePassMeetToLoadSuccess) {
              if (num == 0) {
                setState(() {
                  toMeetDropDown = state.res;
                  selectedToMeet = state.res[0];
                  num = 1;
                });
                //"ToMeetData":"ToMeetPurpose"
                try {
                  pref.setString("ToMeetData", jsonEncode(state.res));
                } catch (e) {
                  print('$e');
                }
                getMeetTo(num: num);
              } else {
                setState(() {
                  purposeDropDown = state.res;
                  selectedPurpose = state.res[0];
                });
                try {
                  pref.setString("ToMeetPurpose", jsonEncode(state.res));
                } catch (e) {
                  print('$e');
                }
              }
            }
            if (state is GatePassMeetToLoadFail) {
              if (state.failReason == "false") {
                UserUtils.unauthorizedUser(context);
              }
            }
          }),
          BlocListener<SendingOtpGatePassCubit, SendingOtpGatePassState>(
              listener: (context, state) {
            if (state is SendingOtpGatePassLoadSuccess) {
              setState(() {
                visitorId = state.result;
                isOtpSend = true;
              });
            }
            if (state is SendingOtpGatePassLoadFail) {
              if (state.failReason == "false") {
                UserUtils.unauthorizedUser(context);
              } else {}
            }
          }),
          BlocListener<VerifyOtpGatePassCubit, VerifyOtpGatePassState>(
              listener: (context, state) {
            if (state is VerifyOtpGatePassLoadSuccess) {
              if (state.result.toLowerCase() == "success") {
                setState(() {
                  isVerify = true;
                });
                ScaffoldMessenger.of(context).showSnackBar(commonSnackBar(
                  title: 'Otp Verified',
                  duration: Duration(seconds: 1),
                ));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(commonSnackBar(
                  title: 'Invalid OTP',
                  duration: Duration(seconds: 1),
                ));
              }
            }
            if (state is VerifyOtpGatePassLoadFail) {
              if (state.failReason == "false") {
                UserUtils.unauthorizedUser(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(commonSnackBar(
                  title: 'Otp Not Verified',
                  duration: Duration(seconds: 1),
                ));
              }
            }
          }),
          BlocListener<SaveVisitorDetailsGatePassCubit,
              SaveVisitorDetailsGatePassState>(listener: (context, state) {
            if (state is SaveVisitorDetailsGatePassLoadInProgress) {
              setState(() {
                isFinalLoader = true;
              });
            }
            if (state is SaveVisitorDetailsGatePassLoadSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                commonSnackBar(
                    title: "Details Saved", duration: Duration(seconds: 1)),
              );
              setState(() {
                _pickedImageIdProof = null;
                _pickedImage = null;
                _nameController.text = "";
                _addressController.text = "";
                _otherPurposeController.text = "";
                _mobileController.text = "";
                _otpController.text = "";
                _detailController.text = "";
                _mobileController.text = "";
                selectedPurpose = purposeDropDown![0];
                selectedToMeet = toMeetDropDown![0];
                isOtpSend = false;
                isVerify = false;
                isNumberCount = false;
                //
                _otpController1.text = "";
                _otpController2.text = "";
                _otpController3.text = "";
                _otpController4.text = "";
                _otpController5.text = "";
                _otpController6.text = "";
              });
              // if (state.result == "done") {
              //
              // } else {
              //   ScaffoldMessenger.of(context).showSnackBar(
              //     commonSnackBar(
              //         title: "Not Saved", duration: Duration(seconds: 1)),
              //   );
              // }
              setState(() {
                isFinalLoader = false;
              });
            }
            if (state is SaveVisitorDetailsGatePassLoadFail) {
              if (state.failReason == "false") {
                UserUtils.unauthorizedUser(context);
              } else {
                setState(() {
                  isFinalLoader = false;
                });
              }
            }
          }),
          BlocListener<VerifyIdProofGatePassCubit, VerifyIdProofGatePassState>(
              listener: (context, state) {
            if (state is VerifyIdProofGatePassLoadInProgress) {
              setState(() {
                isIdProofLoader = true;
              });
            }
            if (state is VerifyIdProofGatePassLoadSuccess) {
              setState(() {
                isVerify = true;
              });
              ScaffoldMessenger.of(context).showSnackBar(commonSnackBar(
                title: 'Verified',
                duration: Duration(seconds: 1),
              ));
              setState(() {
                isIdProofLoader = false;
              });
            }
            if (state is VerifyIdProofGatePassLoadFail) {
              if (state.failReason == "false") {
                UserUtils.unauthorizedUser(context);
              } else {
                setState(() {
                  isIdProofLoader = false;
                });
              }
            }
          }),
        ],
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assets/images/userTypePageBackgroundImage.png"),
            fit: BoxFit.cover,
          )),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: Container()),
                    GestureDetector(
                        child: Container(
                            margin: EdgeInsets.only(
                              right: 20,
                              top: 10,
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            decoration: BoxDecoration(color: Colors.red),
                            child: Text(
                              "Reset",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            )),
                        onTap: () {
                          setState(() {
                            isVerify = false;
                            isOtpSend = false;
                            _nameController.text = "";
                            _detailController.text = "";
                            _addressController.text = "";
                            _mobileController.text = "";
                            _otpController.text = "";
                            _otherPurposeController.text = "";
                            isNumberCount = false;

                            ///
                            _otpController1.text = "";
                            _otpController2.text = "";
                            _otpController3.text = "";
                            _otpController4.text = "";
                            _otpController5.text = "";
                            _otpController6.text = "";
                          });
                          FocusScope.of(context).unfocus();
                        }),
                  ],
                ),
                isVerify == false
                    ? Container(
                        margin: EdgeInsets.only(
                          left: 20.0,
                          right: 20.0,
                          bottom: 10.0,
                        ),
                        child: Text(
                          'Mobile No',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      )
                    : Container(),
                isVerify == false
                    ? buildTextField(
                        isAutoFill: false,
                        controller: _mobileController,
                        validator: FieldValidators.mobileNoValidator,
                        maxlength: 10,
                        isNumberType: true,
                        formatter: true,
                      )
                    : Container(),
                SizedBox(
                  height: isOtpSend == false
                      ? MediaQuery.of(context).size.height * 0.1
                      : 0,
                ),
                isOtpSend == false
                    ? isNumberCount == true
                        ? GestureDetector(
                            onTap: () {
                              if (_mobileController.text.length > 9) {
                                sendingOtpForGatePass(
                                    number: _mobileController.text);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  commonSnackBar(
                                    title: "Enter Valid Number",
                                  ),
                                );
                              }
                            },
                            child: Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(width: 0.1),
                                  color: Colors.green,
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                child: Text(
                                  'Verify Number',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          )
                        : Container()
                    : Container(),
                isVerify == false
                    ? isOtpSend == true
                        ? Column(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 10.0),
                                    child: Text(
                                      'OTP',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  //Todo:Adding Custom otp taken field
                                  // buildTextField(
                                  //   isAutoFill: true,
                                  //   controller: _otpController,
                                  //   validator: FieldValidators.mobileNoValidator,
                                  //   width:
                                  //       MediaQuery.of(context).size.width * 0.5,
                                  //   isNumberType: true,
                                  // ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      _otpTextField(context, false, false,
                                          _otpController1),
                                      _otpTextField(context, false, false,
                                          _otpController2),
                                      _otpTextField(context, false, false,
                                          _otpController3),
                                      _otpTextField(context, false, false,
                                          _otpController4),
                                      _otpTextField(context, false, false,
                                          _otpController5),
                                      _otpTextField(context, false, true,
                                          _otpController6),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.02,
                              ),
                              Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 10.0),
                                    child: Text(
                                      '',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      FocusScope.of(context).unfocus();
                                      // if (_otpController.text.length > 0) {
                                      //   verifyOtpGatePass(
                                      //       otp: _otpController.text,
                                      //       visitorid: visitorId);
                                      // }
                                      if (_otpController1.text.length > 0 &&
                                          _otpController2.text.length > 0 &&
                                          _otpController3.text.length > 0 &&
                                          _otpController4.text.length > 0 &&
                                          _otpController5.text.length > 0 &&
                                          _otpController6.text.length > 0) {
                                        print(
                                            "custom otp send ${_otpController1.text + _otpController2.text + _otpController3.text + _otpController4.text + _otpController5.text + _otpController6.text}");
                                        verifyOtpGatePass(
                                            otp: _otpController1.text +
                                                _otpController2.text +
                                                _otpController3.text +
                                                _otpController4.text +
                                                _otpController5.text +
                                                _otpController6.text,
                                            visitorid: visitorId);
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          commonSnackBar(
                                            title: "Please Enter Otp",
                                          ),
                                        );
                                      }
                                    },
                                    child: Center(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          border: Border.all(width: 0.1),
                                          color: Colors.green,
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 8),
                                        child: Text(
                                          'Verify Otp',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        : Container()
                    : Container(),
                SizedBox(
                  height: isVerify == false
                      ? MediaQuery.of(context).size.height * 0.07
                      : 0,
                ),
                isVerify == false
                    ? isOtpSend == true
                        ? isIdProofLoader == false
                            ? Column(
                                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  // GestureDetector(
                                  //   onTap: () {
                                  //     verifyOtpGatePass(
                                  //         otp: _otpController.text,
                                  //         visitorid: visitorId);
                                  //   },
                                  //   child: Center(
                                  //     child: Container(
                                  //       decoration: BoxDecoration(
                                  //         borderRadius: BorderRadius.circular(30),
                                  //         border: Border.all(width: 0.1),
                                  //         color: Colors.green,
                                  //       ),
                                  //       padding: EdgeInsets.symmetric(
                                  //           horizontal: 12, vertical: 8),
                                  //       child: Text(
                                  //         'Verify Otp',
                                  //         style: TextStyle(
                                  //             fontWeight: FontWeight.w600,
                                  //             fontSize: 18,
                                  //             color: Colors.white),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 3),
                                    child: Text(
                                      "~ IF YOU WANT TO VERIFY THOUGH ID PROOF INSTEAD OF OTP.",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      File? tempFile = await getImage(
                                          source: ImageSource.camera);
                                      if (mounted && tempFile != null) {
                                        setState(() {
                                          _pickedImageIdProof = tempFile;
                                        });
                                        print(
                                            "_pickedImageIdProof path : ${_pickedImageIdProof!.path}");
                                        verifyId();
                                      }
                                    },
                                    child: Center(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          border: Border.all(width: 0.1),
                                          color: Colors.green,
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 8),
                                        child: Text(
                                          'Upload ID Proof',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : Center(
                                child: CircularProgressIndicator(),
                              )
                        : Container()
                    : Column(children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildHeadingName(name: "Name"),
                            buildTextField(
                              isAutoFill: false,
                              controller: _nameController,
                              validator: FieldValidators.globalValidator,
                              //width: MediaQuery.of(context).size.width * 0.37,
                              isNumberType: false,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildHeadingName(name: "Address"),
                            buildTextField(
                              isAutoFill: false,
                              controller: _addressController,
                              validator: FieldValidators.globalValidator,
                              //width: MediaQuery.of(context).size.width * 0.37,
                              isNumberType: false,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildHeadingName(name: "Detail"),
                            buildTextField(
                              isAutoFill: false,
                              controller: _detailController,
                              validator: FieldValidators.globalValidator,
                              // width: MediaQuery.of(context).size.width * 0.37,
                              isNumberType: false,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.05,
                            ),
                            // Column(
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   children: [
                            //     buildHeadingName(name: "Detail"),
                            //     buildTextField(
                            //       isAutoFill: false,
                            //       controller: _detailController,
                            //       validator: FieldValidators.globalValidator,
                            //       // width: MediaQuery.of(context).size.width * 0.37,
                            //       isNumberType: false,
                            //     ),
                            //   ],
                            // ),
                            // SizedBox(
                            //   width: MediaQuery.of(context).size.width * 0.1,
                            // ),
                            Column(
                              //crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                buildHeadingName(name: "To Meet"),
                                Container(
                                  padding: EdgeInsets.all(8),
                                  height: MediaQuery.of(context).size.height *
                                      0.064,
                                  width:
                                      MediaQuery.of(context).size.width * 0.37,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 0.1,
                                    ),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: DropdownButton<GatePassMeetToModel>(
                                    isExpanded: true,
                                    items: toMeetDropDown!
                                        .map((e) => DropdownMenuItem(
                                              child: Text(
                                                "${e.name}",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                              value: e,
                                            ))
                                        .toList(),
                                    value: selectedToMeet,
                                    underline: Container(),
                                    onChanged: (val) {
                                      setState(() {
                                        selectedToMeet = val!;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.1,
                            ),
                            Column(
                              //crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                buildHeadingName(name: "Purpose"),
                                Container(
                                  padding: EdgeInsets.all(8),
                                  height: MediaQuery.of(context).size.height *
                                      0.064,
                                  width:
                                      MediaQuery.of(context).size.width * 0.37,
                                  margin: EdgeInsets.symmetric(horizontal: 20),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 0.1,
                                    ),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: DropdownButton<GatePassMeetToModel>(
                                    isExpanded: true,
                                    items: purposeDropDown!
                                        .map((e) => DropdownMenuItem(
                                              child: Text(
                                                '${e.name}',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                              value: e,
                                            ))
                                        .toList(),
                                    value: selectedPurpose,
                                    underline: Container(),
                                    onChanged: (val) {
                                      setState(() {
                                        selectedPurpose = val!;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildHeadingName(name: "Other Purpose"),
                            buildTextField(
                              isAutoFill: false,
                              controller: _otherPurposeController,
                              validator: FieldValidators.globalValidator,
                              // width: MediaQuery.of(context).size.width * 0.37,
                              isNumberType: false,
                            ),
                          ],
                        ),
                        //Todo:Add image picker
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.07,
                        ),
                        isFinalLoader == false
                            ? _pickedImageIdProof != null
                                ? Row(
                                    children: [
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Center(
                                        child: GestureDetector(
                                          onTap: () async {
                                            if (_nameController.text.length >
                                                    0 &&
                                                _addressController.text.length >
                                                    0 &&
                                                _detailController.text.length >
                                                    0) {
                                              File? tempFile = await getImage(
                                                  source: ImageSource.camera);
                                              if (mounted && tempFile != null) {
                                                setState(() {
                                                  _pickedImage = tempFile;
                                                });
                                                print(
                                                    "_pickedImage path : ${_pickedImage!.path}");
                                              }

                                              saveVisitor(img: _pickedImage);
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                commonSnackBar(
                                                    title: "Please Fill Form"),
                                              );
                                            }
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.4,
                                            margin: EdgeInsets.all(8),
                                            padding: EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: Center(
                                              child: Text(
                                                'Upload \n Image',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      //
                                      Center(
                                        child: GestureDetector(
                                          onTap: () async {
                                            if (_nameController.text.length >
                                                    0 &&
                                                _addressController.text.length >
                                                    0 &&
                                                _detailController.text.length >
                                                    0) {
                                              // File? tempFile = await getImage(
                                              //     source: ImageSource.camera);
                                              // if (mounted && tempFile != null) {
                                              //   setState(() {
                                              //     _pickedImage = tempFile;
                                              //   });
                                              //   print(
                                              //       "_pickedImage path : ${_pickedImage!.path}");
                                              // }

                                              saveVisitor(
                                                  img: _pickedImageIdProof);
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                commonSnackBar(
                                                    title: "Please Fill Form"),
                                              );
                                            }
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.4,
                                            margin: EdgeInsets.all(8),
                                            padding: EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: Center(
                                              child: Text(
                                                'Save Without \n Visitor Image',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Center(
                                    child: GestureDetector(
                                      onTap: () async {
                                        if (_nameController.text.length > 0 &&
                                            _addressController.text.length >
                                                0 &&
                                            _detailController.text.length > 0) {
                                          File? tempFile = await getImage(
                                              source: ImageSource.camera);
                                          if (mounted && tempFile != null) {
                                            setState(() {
                                              _pickedImage = tempFile;
                                            });
                                            print(
                                                "_pickedImage path : ${_pickedImage!.path}");
                                          }

                                          saveVisitor(img: _pickedImage);
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            commonSnackBar(
                                                title: "Please Fill Form"),
                                          );
                                        }
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Upload Image',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                            : Center(
                                child: CircularProgressIndicator(),
                              )
                      ]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildHeadingName({String? name}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Text(
        '$name',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }

  Container buildTextField(
      {TextEditingController? controller,
      String? Function(String?)? validator,
      int? maxlength,
      bool? isNumberType,
      double? width,
      bool? formatter,
      @required bool? isAutoFill}) {
    return Container(
      width: width != null ? width : MediaQuery.of(context).size.width * 0.9,
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        //autofillHints: isAutoFill == true ? [AutofillHints.oneTimeCode] : null,
        cursorColor: Colors.black,
        maxLines: 1,
        enableInteractiveSelection: false,
        maxLength: maxlength ?? null,
        inputFormatters: formatter != null
            ? [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10)
              ]
            : [],
        keyboardType:
            isNumberType == true ? TextInputType.number : TextInputType.text,
        style: TextStyle(fontSize: 16.0, color: Color(0xff323643)),
        controller: controller,
        decoration: InputDecoration(
          counterText: "",
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
        validator: validator,
        onChanged: (val) {
          if (isVerify != true) {
            if (_mobileController.text.length == 10) {
              setState(() {
                isNumberCount = true;
              });
            } else {
              setState(() {
                isNumberCount = false;
              });
            }
          }
        },
      ),
    );
  }

  Widget _otpTextField(BuildContext context, bool autoFocus, bool last,
      TextEditingController controller) {
    return Container(
      height: MediaQuery.of(context).size.shortestSide * 0.13,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        shape: BoxShape.rectangle,
      ),
      child: AspectRatio(
        aspectRatio: 1,
        child: TextField(
          autofocus: autoFocus,
          controller: controller,
          decoration: InputDecoration(
            border: InputBorder.none,
          ),
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          style: TextStyle(),
          maxLines: 1,
          onChanged: (value) {
            if (value.length == 1) {
              if (!last) {
                FocusScope.of(context).nextFocus();
              }
            }
          },
        ),
      ),
    );
  }
}
