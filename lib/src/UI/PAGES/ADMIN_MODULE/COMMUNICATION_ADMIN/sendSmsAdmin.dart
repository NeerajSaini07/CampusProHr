import 'package:campus_pro/src/DATA/BLOC_CUBIT/LOAD_ADDRESS_GROUP_CUBIT/load_address_group_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/LOAD_BUS_ROUTES_CUBIT/load_bus_routes_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/LOAD_CLASS_FOR_SMS_CUBIT/load_class_for_sms_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/LOAD_EMPLOYEE_GROUPS_CUBIT/load_employee_groups_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/LOAD_HOUSE_GROUP_CUBIT/load_house_group_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/SEND_SMS_ADMIN_CUBIT/send_sms_admin_cubit.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonSnackbar.dart';
import 'package:campus_pro/src/UTILS/fieldValidators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendSmsAdmin extends StatefulWidget {
  static const routeName = "/Send-Sms-Admin";

  const SendSmsAdmin({Key? key}) : super(key: key);

  @override
  _SendSmsAdminState createState() => _SendSmsAdminState();
}

class _SendSmsAdminState extends State<SendSmsAdmin> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();

  Map<String, bool>? classItems;
  Map<String, String>? classIds;

  Map<String, bool>? busRoutes;
  Map<String, String>? busId;

  Map<String, bool>? totalEmployees;
  Map<String, String>? empId;

  Map<String, bool>? totalHouses;
  Map<String, String>? houseId;

  Map<String, bool>? totalAddress;
  Map<String, String>? addressId;

  List<String>? finalClassItems = [];
  List<String>? finalBusRoutes = [];
  List<String>? finalEmployee = [];
  List<String>? finalHouses = [];
  List<String>? finalAddress = [];

  // Map<String, bool> values = {
  //   'foo': true,
  //   'bar': false,
  //   'fooo': true,
  //
  // };
  List checkTrue = [];

  bool allVal = false;
  bool loadCheck = false;

  int selectedIndex = 0;
  bool? checkBoxValue = false;
  TextEditingController _messageController = TextEditingController();
  TextEditingController _noController = TextEditingController();

  getClass() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final sendingClassData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "StuEmpId": userData.stuEmpId,
      "Usertype": userData.ouserType,
    };

    print('Sending class data for exam marks $sendingClassData');

    context
        .read<LoadClassForSmsCubit>()
        .loadClassForSmsCubitCall(sendingClassData);
  }

  getBusRoutes() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final sendingBusRoutes = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "StuEmpId": userData.stuEmpId,
      "UserType": userData.ouserType,
    };

    print('sending data to bus routes $sendingBusRoutes');

    context.read<LoadBusRoutesCubit>().loadBusRoutesCubitCall(sendingBusRoutes);
  }

  getEmployee() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final sendingEmpData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "StuEmpId": userData.stuEmpId,
      "UserType": userData.ouserType,
    };
    print('Sending Data of employee $sendingEmpData');
    context
        .read<LoadEmployeeGroupsCubit>()
        .loadEmployeeGroupsCubitCall(sendingEmpData);
  }

  getHouses() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final sendingHouseData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "StuEmpId": userData.stuEmpId,
      "Usertype": userData.ouserType,
    };
    print('sending data for houses $sendingHouseData');
    context
        .read<LoadHouseGroupCubit>()
        .loadHouseGroupCubitCall(sendingHouseData);
  }

  getAddress() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final sendingAddressData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "StuEmpId": userData.stuEmpId,
      "Usertype": userData.ouserType,
    };

    print('sending address Data $sendingAddressData');

    context
        .read<LoadAddressGroupCubit>()
        .loadAddressGroupCubitCall(sendingAddressData);
  }

  sendSms(
      {String? message,
      String? ids,
      String? ind,
      String? addMsg,
      String? unicodeVal}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final sendingSmsData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "SessionId": userData.currentSessionid,
      "Ids": ids == '' ? userData.stuEmpId : ids,
      "Message": message,
      "UnicodeValue": unicodeVal, //1
      "ToActiveUsers": unicodeVal == '0' ? 'N' : 'Y', //Y
      "AddNos": addMsg,
      "Option": ind, //selectedindex
      "StuEmpId": userData.stuEmpId,
      "UserType": userData.ouserType,
    };

    print('sending data to send sms $sendingSmsData');

    context.read<SendSmsAdminCubit>().sendSmsAdminCubitCall(sendingSmsData);
  }

  @override
  void initState() {
    super.initState();
    classItems = {};
    busRoutes = {};
    totalEmployees = {};
    totalHouses = {};
    totalAddress = {};
    classIds = {};
    empId = {};
    busId = {};
    empId = {};
    houseId = {};
    addressId = {};
    getClass();
    getEmployee();
    getBusRoutes();
    getHouses();
    getAddress();
  }

  @override
  void dispose() {
    _noController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: commonAppBar(
          context,
          title: 'Send SMS',
        ),
        body: Form(
          key: _key,
          child: MultiBlocListener(
            listeners: [
              BlocListener<LoadClassForSmsCubit, LoadClassForSmsState>(
                  listener: (context, state) {
                if (state is LoadClassForSmsLoadSuccess) {
                  state.classList.forEach((element) {
                    setState(() {
                      classItems!.addAll({
                        element.classname!.toString(): false,
                      });
                      classIds!.addAll({
                        element.classname.toString(): element.classId.toString()
                      });
                    });
                  });
                }
                if (state is LoadClassForSmsLoadFail) {
                  if (state.failReason == 'false') {
                    UserUtils.unauthorizedUser(context);
                  }
                }
              }),
              BlocListener<LoadBusRoutesCubit, LoadBusRoutesState>(
                  listener: (context, state) {
                if (state is LoadBusRoutesLoadSuccess) {
                  print(state.busRoutes[0].routeName);
                  setState(() {
                    state.busRoutes.forEach((element) {
                      setState(() {
                        busRoutes!
                            .addAll({element.routeName.toString(): false});
                      });
                      busId!.addAll({
                        element.routeName.toString(): element.routeId.toString()
                      });
                    });
                  });
                }
                if (state is LoadBusRoutesLoadFail) {
                  if (state.failReason == 'false') {
                    UserUtils.unauthorizedUser(context);
                  }
                }
              }),
              BlocListener<LoadEmployeeGroupsCubit, LoadEmployeeGroupsState>(
                  listener: (context, state) {
                if (state is LoadEmployeeGroupsLoadSuccess) {
                  print(state.empList[0].paramName);
                  setState(() {
                    state.empList.forEach((element) {
                      setState(() {
                        totalEmployees!
                            .addAll({element.paramName.toString(): false});
                      });
                      empId!.addAll({
                        element.paramName.toString(): element.id.toString()
                      });
                    });
                  });
                }
                if (state is LoadEmployeeGroupsLoadFail) {
                  if (state.failReason == 'false') {
                    UserUtils.unauthorizedUser(context);
                  }
                }
              }),
              BlocListener<LoadHouseGroupCubit, LoadHouseGroupState>(
                  listener: (context, state) {
                if (state is LoadHouseGroupLoadSuccess) {
                  state.housesList.forEach((element) {
                    setState(() {
                      totalHouses!
                          .addAll({element.paramName.toString(): false});
                    });
                    houseId!.addAll(
                        {element.paramName.toString(): element.id.toString()});
                  });
                }
                if (state is LoadHouseGroupLoadFail) {
                  if (state.failReason == 'false') {
                    UserUtils.unauthorizedUser(context);
                  }
                }
              }),
              BlocListener<LoadAddressGroupCubit, LoadAddressGroupState>(
                  listener: (context, state) {
                if (state is LoadAddressGroupLoadSuccess) {
                  state.addressList.forEach((element) {
                    setState(() {
                      totalAddress!
                          .addAll({element.paramName.toString(): false});
                    });
                    addressId!.addAll(
                        {element.paramName.toString(): element.id.toString()});
                  });
                }
                if (state is LoadAddressGroupLoadFail) {
                  if (state.failReason == 'false') {
                    UserUtils.unauthorizedUser(context);
                  }
                }
              }),
              BlocListener<SendSmsAdminCubit, SendSmsAdminState>(
                  listener: (context, state) {
                if (state is SendSmsAdminLoadSuccess) {
                  setState(() {
                    loadCheck = false;
                    selectedIndex = 0;
                    checkBoxValue = false;
                    _messageController.text = "";
                    _noController.text = "";
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    commonSnackBar(
                      title: 'SMS Sent',
                      duration: Duration(seconds: 1),
                    ),
                  );
                }
              }),
            ],
            child: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.07,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (selectedIndex != 0) {
                              selectedIndex = 0;
                            }
                          });
                          print(selectedIndex);
                        },
                        child: PhysicalModel(
                          color: Color(0xfffFF68B6F5),
                          elevation: 8,
                          shadowColor: Colors.blue,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            // margin: EdgeInsets.all(12),
                            // padding: EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width * 0.22,
                            height: MediaQuery.of(context).size.height * 0.06,
                            decoration: BoxDecoration(
                              border: Border.all(width: 0.1),
                              color: selectedIndex == 0
                                  ? Colors.lightBlueAccent
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Center(
                              child: RichText(
                                text: TextSpan(
                                  text: 'None',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      color: Colors.black),
                                ),
                              ),
                              //     Text(
                              //   "None",
                              //   style: TextStyle(fontWeight: FontWeight.bold),
                              // ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.1,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (selectedIndex != 1) {
                              //loadCheck = true;
                              selectedIndex = 1;
                              //Click on this update select all
                              allVal = false;
                              classItems!
                                  .updateAll((key, value) => value = false);
                            }
                          });
                          print(selectedIndex);
                        },
                        child: PhysicalModel(
                          color: Color(0xfffFF68B6F5),
                          elevation: 8,
                          shadowColor: Colors.blue,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            // margin: EdgeInsets.all(12),
                            // padding: EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width * 0.22,
                            height: MediaQuery.of(context).size.height * 0.06,
                            decoration: BoxDecoration(
                              border: Border.all(width: 0.1),
                              color: selectedIndex == 1
                                  ? Colors.lightBlueAccent
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Center(
                              child: RichText(
                                text: TextSpan(
                                  text: 'Class',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      color: Colors.black),
                                ),
                              ),
                              // Text(
                              //   "Class",
                              //   style: TextStyle(fontWeight: FontWeight.bold),
                              // ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.1,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (selectedIndex != 2) {
                              selectedIndex = 2;
                              //Click on this update select all
                              allVal = false;
                              busRoutes!
                                  .updateAll((key, value) => value = false);
                            }
                          });
                          print(selectedIndex);
                        },
                        child: PhysicalModel(
                          color: Color(0xfffFF68B6F5),
                          elevation: 8,
                          shadowColor: Colors.blue,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            // margin: EdgeInsets.all(12),
                            // padding: EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width * 0.22,
                            height: MediaQuery.of(context).size.height * 0.06,
                            decoration: BoxDecoration(
                              border: Border.all(width: 0.1),
                              color: selectedIndex == 2
                                  ? Colors.lightBlueAccent
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Center(
                              child: RichText(
                                text: TextSpan(
                                  text: 'Bus',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      color: Colors.black),
                                ),
                              ),
                              //     Text(
                              //   "Bus",
                              //   style: TextStyle(fontWeight: FontWeight.bold),
                              // ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.07,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (selectedIndex != 3) {
                              selectedIndex = 3;
                              //Click on this update select all
                              allVal = false;
                              totalEmployees!
                                  .updateAll((key, value) => value = false);
                            }
                          });
                          print(selectedIndex);
                        },
                        child: PhysicalModel(
                          color: Color(0xfffFF68B6F5),
                          elevation: 8,
                          shadowColor: Colors.blue,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            // margin: EdgeInsets.all(12),
                            // padding: EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width * 0.22,
                            height: MediaQuery.of(context).size.height * 0.06,
                            decoration: BoxDecoration(
                              border: Border.all(width: 0.1),
                              color: selectedIndex == 3
                                  ? Colors.lightBlueAccent
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Center(
                              child: RichText(
                                text: TextSpan(
                                  text: 'Employee',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      color: Colors.black),
                                ),
                              ),
                              // Text(
                              //   "Employee",
                              //   style: TextStyle(fontWeight: FontWeight.bold),
                              // ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.1,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (selectedIndex != 4) {
                              selectedIndex = 4;
                              //Click on this update select all
                              allVal = false;
                              totalHouses!
                                  .updateAll((key, value) => value = false);
                            }
                          });
                          print(selectedIndex);
                        },
                        child: PhysicalModel(
                          color: Color(0xfffFF68B6F5),
                          elevation: 8,
                          shadowColor: Colors.blue,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            // margin: EdgeInsets.all(12),
                            // padding: EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width * 0.22,
                            height: MediaQuery.of(context).size.height * 0.06,
                            decoration: BoxDecoration(
                              border: Border.all(width: 0.1),
                              color: selectedIndex == 4
                                  ? Colors.lightBlueAccent
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Center(
                              child: RichText(
                                text: TextSpan(
                                  text: 'House',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      color: Colors.black),
                                ),
                              ),
                              // Text(
                              //   "House",
                              //   style: TextStyle(fontWeight: FontWeight.bold),
                              // ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.1,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (selectedIndex != 5) {
                              selectedIndex = 5;
                              //Click on this update select all
                              allVal = false;
                              totalAddress!
                                  .updateAll((key, value) => value = false);
                            }
                          });
                          print(selectedIndex);
                        },
                        child: PhysicalModel(
                          color: Colors.white,
                          elevation: 8,
                          shadowColor: Colors.blue,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            //margin: EdgeInsets.all(12),
                            //padding: EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width * 0.22,
                            height: MediaQuery.of(context).size.height * 0.06,
                            // color: selectedIndex == 5
                            //     ? Colors.lightBlueAccent
                            //     : Colors.white,
                            decoration: BoxDecoration(
                              border: Border.all(width: 0.1),
                              color: selectedIndex == 5
                                  ? Colors.lightBlueAccent
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Center(
                              child: RichText(
                                text: TextSpan(
                                  text: 'Address',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      color: Colors.black),
                                ),
                              ),
                              // Text(
                              //   "Address",
                              //   style: TextStyle(fontWeight: FontWeight.bold),
                              // ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Divider(
                    thickness: 5,
                  ),
                  selectedIndex != 0
                      ? Container(
                          margin: EdgeInsets.only(left: 17, right: 17),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 0.06,
                            ),
                          ),
                          child: StatefulBuilder(
                            builder: (context, _setState) => CheckboxListTile(
                                title: Text(
                                  'Select All ${selectedIndex == 1 ? 'Classes' : selectedIndex == 2 ? 'Buses' : selectedIndex == 3 ? 'Employees' : selectedIndex == 4 ? 'Houses' : selectedIndex == 5 ? 'Address' : ''}',
                                  style: TextStyle(
                                      color: Colors.pink,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900),
                                ),
                                value: allVal,
                                onChanged: (val) {
                                  _setState(() {
                                    if (selectedIndex == 1) {
                                      finalClassItems = [];
                                      if (allVal == true) {}
                                      allVal != true
                                          ? classItems!.updateAll(
                                              (key, value) => value = true)
                                          : classItems!.updateAll(
                                              (key, value) => value = false);
                                    } else if (selectedIndex == 2) {
                                      allVal != true
                                          ? busRoutes!.updateAll(
                                              (key, value) => value = true)
                                          : busRoutes!.updateAll(
                                              (key, value) => value = false);
                                    } else if (selectedIndex == 3) {
                                      allVal != true
                                          ? totalEmployees!.updateAll(
                                              (key, value) => value = true)
                                          : totalEmployees!.updateAll(
                                              (key, value) => value = false);
                                    } else if (selectedIndex == 4) {
                                      allVal != true
                                          ? totalHouses!.updateAll(
                                              (key, value) => value = true)
                                          : totalHouses!.updateAll(
                                              (key, value) => value = false);
                                    } else if (selectedIndex == 5) {
                                      allVal != true
                                          ? totalAddress!.updateAll(
                                              (key, value) => value = true)
                                          : totalAddress!.updateAll(
                                              (key, value) => value = false);
                                    }
                                    setState(() {
                                      allVal = val!;
                                    });
                                    // buildCheckBoxClassList(context,
                                    //     classList: classItems);
                                  });
                                }),
                          ),
                        )
                      : Container(),
                  selectedIndex == 1
                      ? buildCheckBoxClassList(context, classList: classItems)
                      : selectedIndex == 2
                          ? buildCheckBoxBusList(context, busList: busRoutes)
                          : selectedIndex == 3
                              ? buildCheckBoxEmployeeList(context,
                                  empList: totalEmployees)
                              : selectedIndex == 4
                                  ? buildCheckBoxHouseList(context,
                                      houseList: totalHouses)
                                  : selectedIndex == 5
                                      ? buildCheckBoxAddressList(context,
                                          addressList: totalAddress)
                                      : Container(),
                  Container(
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.all(8),
                    child: buildTextFormField(
                      context,
                      controller: _messageController,
                      text: 'Write your Message Here',
                      maxLines: 5,
                      fieldValidators: FieldValidators.globalValidator,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.all(8),
                    child: buildTextFormField(
                      context,
                      controller: _noController,
                      text: "Addition No ',' separated",
                      maxLines: 1,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: 18, right: 18, top: 7, bottom: 10),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        border: Border.all(width: 0.1, color: Colors.blueGrey)),
                    child: Row(
                      children: [
                        Checkbox(
                          value: checkBoxValue,
                          onChanged: (bool? val) {
                            setState(() {
                              checkBoxValue = val;
                            });
                          },
                        ),
                        Text('SMS Active user in App'),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.06,
                  ),
                  loadCheck == false
                      ? TextButton(
                          onPressed: () {
                            if (_key.currentState!.validate()) {
                              print('Text');
                              setState(() {
                                loadCheck = true;
                                checkTrue = [];
                              });

                              //check index number

                              if (selectedIndex == 0) {
                                sendSms(
                                    message: _messageController.text,
                                    ids: '',
                                    ind: selectedIndex.toString(),
                                    addMsg: _noController.text,
                                    unicodeVal:
                                        checkBoxValue == true ? '1' : '0');
                              }
                              if (selectedIndex == 1) {
                                finalClassItems = [];
                                classItems!.forEach((key, value) {
                                  if (value == true) {
                                    checkTrue.add(key);
                                  }
                                });

                                for (var i in checkTrue) {
                                  finalClassItems!.add(classIds![i]!);
                                }
                                print(finalClassItems);
                                sendSms(
                                    message: _messageController.text,
                                    ids: finalClassItems!.join(','),
                                    ind: selectedIndex.toString(),
                                    addMsg: _noController.text,
                                    unicodeVal:
                                        checkBoxValue == true ? '1' : '0');
                              } else if (selectedIndex == 2) {
                                finalBusRoutes = [];
                                busRoutes!.forEach((key, value) {
                                  if (value == true) {
                                    checkTrue.add(key);
                                  }
                                });

                                for (var i in checkTrue) {
                                  finalBusRoutes!.add(busId![i]!);
                                }
                                print(finalBusRoutes);
                                sendSms(
                                    message: _messageController.text,
                                    ids: finalBusRoutes!.join(','),
                                    ind: selectedIndex.toString(),
                                    addMsg: _noController.text,
                                    unicodeVal:
                                        checkBoxValue == true ? '1' : '0');
                              } else if (selectedIndex == 3) {
                                finalEmployee = [];
                                totalEmployees!.forEach((key, value) {
                                  if (value == true) {
                                    checkTrue.add(key);
                                  }
                                });

                                for (var i in checkTrue) {
                                  finalEmployee!.add(empId![i]!);
                                }
                                print(finalEmployee);
                                sendSms(
                                    message: _messageController.text,
                                    ids: finalEmployee!.join(','),
                                    ind: selectedIndex.toString(),
                                    addMsg: _noController.text,
                                    unicodeVal:
                                        checkBoxValue == true ? '1' : '0');
                              } else if (selectedIndex == 4) {
                                finalHouses = [];
                                totalHouses!.forEach((key, value) {
                                  if (value == true) {
                                    checkTrue.add(key);
                                  }
                                });

                                for (var i in checkTrue) {
                                  finalHouses!.add(houseId![i]!);
                                }
                                print(finalHouses);
                                sendSms(
                                    message: _messageController.text,
                                    ids: finalHouses!.join(','),
                                    ind: selectedIndex.toString(),
                                    addMsg: _noController.text,
                                    unicodeVal:
                                        checkBoxValue == true ? '1' : '0');
                              } else if (selectedIndex == 5) {
                                finalAddress = [];
                                totalAddress!.forEach((key, value) {
                                  if (value == true) {
                                    checkTrue.add(key);
                                  }
                                });

                                for (var i in checkTrue) {
                                  finalAddress!.add(addressId![i]!);
                                }
                                print(finalAddress);
                                sendSms(
                                    message: _messageController.text,
                                    ids: finalAddress!.join(','),
                                    ind: selectedIndex.toString(),
                                    addMsg: _noController.text,
                                    unicodeVal:
                                        checkBoxValue == true ? '1' : '0');
                              }
                            }
                          },
                          style: ButtonStyle(
                            overlayColor:
                                MaterialStateProperty.all(Colors.transparent),
                            backgroundColor: MaterialStateProperty.all(
                                Theme.of(context).primaryColor),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 30),
                            ),
                          ),
                          child: Text(
                            'Send',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      : Center(
                          child: Container(
                            height: 10,
                            width: 10,
                            child: CircularProgressIndicator(),
                          ),
                        )
                ],
              ),
            ),
            // : Center(
            //     child: Container(
            //       height: 10,
            //       width: 10,
            //       child: CircularProgressIndicator(),
            //     ),
            //   ),
          ),
        ));
  }

  Container buildCheckBoxClassList(BuildContext context,
      {Map<String, bool>? classList}) {
    // setState(() {
    //   loadCheck = false;
    // });
    // print('yoo');
    return classList!.length != 0
        ? Container(
            height: MediaQuery.of(context).size.height * 0.3,
            margin: EdgeInsets.only(left: 17, right: 17),
            decoration: BoxDecoration(
              border: Border.all(
                width: 0.06,
              ),
            ),
            child: SingleChildScrollView(
              child: Column(children: [
                for (var i in classList.keys)
                  Container(
                    padding: EdgeInsets.only(left: 13, right: 13),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '$i',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Checkbox(
                          value: classList[i],
                          onChanged: (bool? val) {
                            setState(() {
                              classList[i] = val!;
                            });
                          },
                        ),
                      ],
                    ),
                  )
                // CheckboxListTile(
                //     title: Text(i),
                //     value: classList[i],
                //     onChanged: (bool? val) {
                //       setState(() {
                //         classList[i] = val!;
                //       });
                //     })
              ]
                  // classList!.keys.map((String key) {
                  //   return new CheckboxListTile(
                  //     title: Text(key),
                  //     value: classList[key],
                  //     onChanged: (bool? value) {
                  //       setState(() {
                  //         classList[key] = value!;
                  //       });
                  //     },
                  //   );
                  // }).toList(),
                  ),
            ),
          )
        : Container(
            child: Center(
              child: Text('No Record'),
            ),
          );
  }

  Container buildCheckBoxBusList(BuildContext context,
      {Map<String, bool>? busList}) {
    return busList!.length != 0
        ? Container(
            height: MediaQuery.of(context).size.height * 0.3,
            margin: EdgeInsets.only(left: 17, right: 17),
            decoration: BoxDecoration(
              border: Border.all(
                width: 0.06,
              ),
            ),
            child: SingleChildScrollView(
              child: Column(children: [
                for (var i in busList.keys)
                  Container(
                    padding: EdgeInsets.only(left: 13, right: 13),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '$i',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Checkbox(
                          value: busList[i],
                          onChanged: (bool? val) {
                            setState(() {
                              busList[i] = val!;
                            });
                          },
                        ),
                      ],
                    ),
                  )
              ]),
            ),
          )
        : Container(
            child: Center(
              child: Text('No Record'),
            ),
          );
  }

  Container buildCheckBoxEmployeeList(BuildContext context,
      {Map<String, bool>? empList}) {
    return empList!.length != 0
        ? Container(
            height: MediaQuery.of(context).size.height * 0.3,
            margin: EdgeInsets.only(left: 17, right: 17),
            decoration: BoxDecoration(
              border: Border.all(
                width: 0.06,
              ),
            ),
            child: SingleChildScrollView(
              child: Column(children: [
                for (var i in empList.keys)
                  Container(
                    padding: EdgeInsets.only(left: 13, right: 13),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '$i',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Checkbox(
                          value: empList[i],
                          onChanged: (bool? val) {
                            setState(() {
                              empList[i] = val!;
                            });
                          },
                        ),
                      ],
                    ),
                  )
              ]),
            ),
          )
        : Container(
            child: Center(
              child: Text('No Record'),
            ),
          );
  }

  Container buildCheckBoxHouseList(BuildContext context,
      {Map<String, bool>? houseList}) {
    return houseList!.length != 0
        ? Container(
            height: MediaQuery.of(context).size.height * 0.3,
            margin: EdgeInsets.only(left: 17, right: 17),
            decoration: BoxDecoration(
              border: Border.all(
                width: 0.06,
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (var i in houseList.keys)
                    Container(
                      padding: EdgeInsets.only(left: 13, right: 13),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '$i',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Checkbox(
                            value: houseList[i],
                            onChanged: (bool? val) {
                              setState(() {
                                houseList[i] = val!;
                              });
                            },
                          ),
                        ],
                      ),
                    )
                ],
              ),
            ),
          )
        : Container(
            child: Center(
              child: Text('No Record'),
            ),
          );
  }

  Container buildCheckBoxAddressList(BuildContext context,
      {Map<String, bool>? addressList}) {
    return addressList!.length != 0
        ? Container(
            height: MediaQuery.of(context).size.height * 0.3,
            margin: EdgeInsets.only(left: 17, right: 17),
            decoration: BoxDecoration(
              border: Border.all(
                width: 0.06,
              ),
            ),
            child: SingleChildScrollView(
                child: Column(children: [
              for (var i in addressList.keys)
                Container(
                  padding: EdgeInsets.only(left: 13, right: 13),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$i',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Checkbox(
                        value: addressList[i],
                        onChanged: (bool? val) {
                          setState(() {
                            addressList[i] = val!;
                          });
                        },
                      ),
                    ],
                  ),
                )
            ])),
          )
        : Container(
            child: Center(
              child: Text('No Record'),
            ),
          );
  }

  TextFormField buildTextFormField(BuildContext context,
      {maxLines, controller, text, fieldValidators}) {
    return TextFormField(
      cursorColor: Colors.black,
      maxLines: maxLines,
      validator: fieldValidators,
      style: TextStyle(
        fontSize: 16.0,
        color: Color(0xff323643),
      ),
      controller: controller,
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
        hintText: text,
        hintStyle: TextStyle(color: Color(0xffA5A5A5)),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      ),
      //validator: FieldValidators.globalValidator,
    );
  }
}
