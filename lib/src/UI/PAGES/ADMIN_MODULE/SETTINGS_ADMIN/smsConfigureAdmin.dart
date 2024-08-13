import 'dart:convert';

import 'package:campus_pro/src/DATA/BLOC_CUBIT/GET_SMS_TYPE_DETAIL_SMS_CONFIG_CUBT/get_sms_type_detail_sms_confg_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/GET_SMS_TYPE_SMS_CONFIG_CUBIT/get_sms_type_sms_config_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/LOAD_USER_TYPE_SEND_SMS_CUBIT/load_user_type_send_sms_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/SAVE_SMS_TYPE_CUBIT/save_sms_type_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/getSmsTypeSmsConfigModel.dart';
import 'package:campus_pro/src/DATA/MODELS/loadUserTypeSendSmsModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonSnackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SmsConfigureAdmin extends StatefulWidget {
  static const routeName = "/sms-configure-admin";
  const SmsConfigureAdmin({Key? key}) : super(key: key);

  @override
  _SmsConfigureAdminState createState() => _SmsConfigureAdminState();
}

class _SmsConfigureAdminState extends State<SmsConfigureAdmin> {
  //
  LoadUserTypeSendSmsModel? selectedDropDown;
  List<LoadUserTypeSendSmsModel>? dropDownList;

  //sms List
  List<GetSmsTypeSmsConfigModel>? smsList;
  List<bool> statusOfList = [];
  //

  List<Map<String, String>> finalJsonData = [];
  // bool? selectedSmsType = false;
  //
  // List<SmsTypeModel> smsListFinal = [];
  //
  // List<SmsTypeModel> _selectedSmsType = []; // Class List after Seletion
  // // List<ClassListEmployeeModel>? classListMulti = []; // Class List After API
  // final _userSelectKey = GlobalKey<FormFieldState>();

  getUserType() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final sendingUserTypeData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "SchoolId": userData.schoolId,
      "EmpId": userData.stuEmpId,
      "UserType": userData.ouserType,
    };

    print('sending Data for get user type $sendingUserTypeData');

    context
        .read<LoadUserTypeSendSmsCubit>()
        .loadUserTypeSendSmsCubitCall(sendingUserTypeData);
  }

  getSmsType() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userType = await UserUtils.userTypeFromCache();

    final sendingSmsTypeData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userType!.organizationId,
      "SchoolId": userType.schoolId,
      "EmpId": userType.stuEmpId,
      "UserType": userType.ouserType,
    };

    print('sending data for get sms type sms config $sendingSmsTypeData');
    context
        .read<GetSmsTypeSmsConfigCubit>()
        .getSmsTypeSmsConfigCubitCall(sendingSmsTypeData);
  }

  getSmsTypeDetail({String? selectedUser}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userType = await UserUtils.userTypeFromCache();

    final sendingSmsTypeDetailData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userType!.organizationId,
      "SchoolId": userType.schoolId,
      "EmpId": userType.stuEmpId,
      "UserType": userType.ouserType,
      "SelectedUserType": selectedUser,
    };

    print('sending data for sms type detail $sendingSmsTypeDetailData');
    context
        .read<GetSmsTypeDetailSmsConfgCubit>()
        .getSmsTypeDetailSmsConfgCubitCall(sendingSmsTypeDetailData);
  }

  saveSmsType(
      {String? selectedUser, List<Map<String, String>>? jsonData}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final sendingDataForSaveSms = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "SchoolId": userData.schoolId,
      "EmpId": userData.stuEmpId,
      "UserType": userData.ouserType,
      "jsondata": jsonEncode(jsonData),
      // [{"SmsType":"Admission"},{"SmsType":"Attendance"},{"SmsType":"BirthDay"},"
      //     "{"SmsType":"Closing"},{"SmsType":"CommonSMS"},{"SmsType":"Complaint"},{"SmsType":"Discount"},"
      //     "{"SmsType":"Exam"},{"SmsType":"Fee"},{"SmsType":"FeeReminder"},{"SmsType":"GatePass"}]↵,
      "SelectedUserType": selectedUser,
    };

    print('sending data for save sms api $sendingDataForSaveSms');

    context
        .read<SaveSmsTypeCubit>()
        .saveSmsTypeCubitCall(sendingDataForSaveSms);
  }

  @override
  void initState() {
    super.initState();
    selectedDropDown =
        LoadUserTypeSendSmsModel(id: "", userType: "", shortName: "");
    dropDownList = [];
    smsList = [];
    getUserType();
    getSmsType();
  }

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 1)).then((value) {
      selectedDropDown =
          LoadUserTypeSendSmsModel(id: "", userType: "", shortName: "");
      dropDownList = [];
      smsList = [];
      getUserType();
      getSmsType();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, title: "SMS Configure"),
      //bottomNavigationBar: buildBottomBar(),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: MultiBlocListener(
          listeners: [
            BlocListener<GetSmsTypeDetailSmsConfgCubit,
                GetSmsTypeDetailSmsConfgState>(listener: (context, state) {
              if (state is GetSmsTypeDetailSmsConfgLoadSuccess) {
                for (var i = 0; i < statusOfList.length; i++) {
                  setState(() {
                    statusOfList[i] = false;
                  });
                }

                state.typeDetailList.forEach((element) {
                  // smsList!.forEach((ele) {
                  //   if(element.smsType == ele.smsType){
                  //
                  //   }
                  // });

                  for (var i = 0; i < smsList!.length; i++) {
                    if (element.smsType == smsList![i].smsType) {
                      setState(() {
                        statusOfList[i] = true;
                      });
                    }
                  }
                });
              }
              if (state is GetSmsTypeDetailSmsConfgLoadFail) {
                if (state.failReason == 'false') {
                  UserUtils.unauthorizedUser(context);
                } else {
                  // statusOfList.forEach((element) {
                  //   setState(() {
                  //     element = false;
                  //   });
                  // });

                  for (var i = 0; i < statusOfList.length; i++) {
                    setState(() {
                      statusOfList[i] = false;
                    });
                  }
                }
              }
            }),
            BlocListener<SaveSmsTypeCubit, SaveSmsTypeState>(
                listener: (context, state) {
              if (state is SaveSmsTypeLoadSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  commonSnackBar(
                    title: 'SMS Saved',
                    duration: Duration(seconds: 1),
                  ),
                );
                getUserType();
                getSmsType();
              }
              if (state is SaveSmsTypeLoadFail) {
                if (state.failReason == ' false') {
                  UserUtils.unauthorizedUser(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    commonSnackBar(
                      title: '${state.failReason}',
                      duration: Duration(seconds: 1),
                    ),
                  );
                }
              }
            }),
          ],
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    BlocConsumer<LoadUserTypeSendSmsCubit,
                        LoadUserTypeSendSmsState>(
                      listener: (context, state) {
                        if (state is LoadUserTypeSendSmsLoadSuccess) {
                          selectedDropDown = state.userTypeList[0];
                          dropDownList = state.userTypeList;
                          getSmsTypeDetail(
                              selectedUser: selectedDropDown!.shortName);
                        }
                        if (state is LoadUserTypeSendSmsLoadFail) {
                          if (state.failReason == 'false') {
                            UserUtils.unauthorizedUser(context);
                          } else {
                            setState(() {
                              selectedDropDown = LoadUserTypeSendSmsModel(
                                  id: "", userType: "", shortName: "");
                              dropDownList = [];
                            });
                          }
                        }
                      },
                      builder: (context, state) {
                        if (state is LoadUserTypeSendSmsLoadInProgress) {
                          return buildDropDownButton(context);
                        } else if (state is LoadUserTypeSendSmsLoadSuccess) {
                          return buildDropDownButton(context);
                        } else if (state is LoadUserTypeSendSmsLoadFail) {
                          return buildDropDownButton(context);
                        } else {
                          return Container();
                        }
                      },
                    ),
                    //buildDropDownButton(context),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.06,
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        buildBottomBar(),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 10),
              Divider(
                thickness: 4,
                //color: Theme.of(context).primaryColor,
              ),
              BlocConsumer<GetSmsTypeSmsConfigCubit, GetSmsTypeSmsConfigState>(
                listener: (context, state) {
                  if (state is GetSmsTypeSmsConfigStateLoadSuccess) {
                    setState(() {
                      state.getSmsList.forEach((element) {
                        statusOfList.add(false);
                      });

                      smsList = state.getSmsList;
                    });
                  }
                  if (state is GetSmsTypeSmsConfigStateLoadFail) {
                    if (state.failReason == 'false') {
                      UserUtils.unauthorizedUser(context);
                    } else {
                      setState(() {
                        smsList = [];
                      });
                    }
                  }
                },
                builder: (context, state) {
                  if (state is GetSmsTypeSmsConfigStateLoadInProgress) {
                    // return Container(
                    //   height: 10,
                    //   width: 10,
                    //   child: Center(
                    //     child: CircularProgressIndicator(),
                    //   ),
                    // );
                    return Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: LinearProgressIndicator());
                  } else if (state is GetSmsTypeSmsConfigStateLoadSuccess) {
                    return buildSmsList();
                  } else if (state is GetSmsTypeSmsConfigStateLoadFail) {
                    return buildSmsList();
                  } else {
                    return Container();
                  }
                },
              ),
              //buildSmsList(),
              // Divider(
              //   thickness: 4,
              //   // color: Theme.of(context).primaryColor,
              // ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.0004,
              )
            ],
          ),
        ),
      ),
    );
  }

  Expanded buildSmsList() {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, i) => SizedBox(
          height: 7,
        ),
        //     Divider(
        //   thickness: 1,
        // ),
        shrinkWrap: true,
        itemCount: smsList!.length,
        itemBuilder: (context, i) {
          var item = smsList![i];
          // statusOfList.add(false);
          return Container(
            margin: EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 7.0,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                width: 0.1,
              ),
            ),
            child: CheckboxListTile(
              activeColor: Colors.lightBlue,
              //value: item.isSelected,
              value: statusOfList[i],
              title: Text(
                item.smsType!,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              onChanged: (val) {
                setState(() {
                  statusOfList[i] = !statusOfList[i];
                });
              },
            ),
          );
        },
      ),
    );
  }

  GestureDetector buildBottomBar() {
    return GestureDetector(
      onTap: () {
        setState(() {
          finalJsonData = [];
        });

        for (var i = 0; i < statusOfList.length; i++) {
          if (statusOfList[i] == true) {
            finalJsonData.add({"SmsType": "${smsList![i].smsType}"});
          }
        }
        // print(statusOfList.length);
        saveSmsType(
          selectedUser: selectedDropDown!.shortName,
          jsonData: finalJsonData,
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.only(left: 5, right: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Theme.of(context).primaryColor),
        child: Center(
          child: Text(
            "Save Changes",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Padding buildDropDownButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              "Select User :",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.4,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xffECECEC)),
              borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButton<LoadUserTypeSendSmsModel>(
              isDense: true,
              value: selectedDropDown,
              key: UniqueKey(),
              isExpanded: true,
              underline: Container(),
              onChanged: (newValue) {
                setState(() {
                  selectedDropDown = newValue;
                });
                getSmsTypeDetail(selectedUser: selectedDropDown!.shortName);
              },
              items: dropDownList!
                  .map<DropdownMenuItem<LoadUserTypeSendSmsModel>>((value) {
                return DropdownMenuItem<LoadUserTypeSendSmsModel>(
                  value: value,
                  child: Text(
                    value.userType!,
                    //style: Theme.of(context).textTheme.headline6
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
