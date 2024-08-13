import 'dart:convert';

import 'package:campus_pro/src/DATA/BLOC_CUBIT/GET_USER_ASSIGN_MENU_CUBIT/get_user_assign_menu_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/UPDATE_ASSIGN_MENU_CUBIT/update_assign_menu_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/getUserAssignMenuModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/PAGES/STAND_ALONE_PAGES/contactList.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonSnackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManageMenuAdmin extends StatefulWidget {
  static const routeName = '/Manage-Menu-Admin';
  const ManageMenuAdmin({Key? key}) : super(key: key);

  @override
  _ManageMenuAdminState createState() => _ManageMenuAdminState();
}

class _ManageMenuAdminState extends State<ManageMenuAdmin> {
  static const item = <String>[
    'Admin',
    'App-Manager',
    'Principle',
    'Employee',
    'Student',
    'Gate Pass'
  ];
  String? selectedUserType = 'Admin';
  List<GetUserAssignMenuModel>? menuList = [];
  List<Map<String, dynamic>>? menuMapList = [];
  bool isSaveChecked = false;

  // List classListItem = [
  //   ['Dashboard', 'Meeting', false],
  //   ['Communication', 'Class Room', false],
  //   ['Communication', 'Notification', true],
  //   ['Communication', 'Mark Attendance', true],
  //   ['Communication', 'Meeting', false],
  //   ['Communication', 'Meeting', false],
  //   ['Communication', 'Meeting', false],
  //   ['Communication', 'Meeting', false],
  // ];

  // List<DropdownMenuItem<String>>? userTypeItem = item
  //     .map((String e) => DropdownMenuItem<String>(
  //           child: Text(
  //             e,
  //             style:
  //                 TextStyle(fontSize: MediaQuery.of(context).size.width * 0.03),
  //           ),
  //           value: e,
  //         ))
  //     .toList();

  getUserAssignMenu({String? userType}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final data = {
      "OUserId": uid,
      "Token": token,
      "OrgID": userData!.organizationId,
      "SchoolID": userData.schoolId,
      "UserType": userType.toString(),
      "LUserType": userData.ouserType,
      "StuEmpId": userData.stuEmpId,
    };
    print('sending data for get user assign menu $data');
    context.read<GetUserAssignMenuCubit>().getUserAssignMenuCubitCall(data);
  }

  updateAssignMenu({List<Map<String, dynamic>>? json, String? userType}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final sendingUpdateData = {
      "OUserId": uid,
      "Token": token,
      "OrgID": userData!.organizationId,
      "SchoolID": userData.schoolId,
      "UserType": userType,
      "OUserType": userData.ouserType,
      "StuEmpId": userData.stuEmpId,
      "JsonData": jsonEncode(json),
    };
    print('Sending update data $sendingUpdateData');

    context
        .read<UpdateAssignMenuCubit>()
        .updateAssignMenuCubitCall(sendingUpdateData);
  }

  void initState() {
    super.initState();
    getUserAssignMenu(userType: 'A');
  }

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 1)).then((value) {
      getUserAssignMenu(userType: 'A');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, title: 'Manage Menu'),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: MultiBlocListener(
          listeners: [
            BlocListener<UpdateAssignMenuCubit, UpdateAssignMenuState>(
                listener: (context, state) {
              if (state is UpdateAssignMenuLoadInProgress) {
                setState(() {
                  isSaveChecked = true;
                });
              }
              if (state is UpdateAssignMenuLoadSuccess) {
                setState(() {
                  isSaveChecked = false;
                });
                ScaffoldMessenger.of(context).showSnackBar(commonSnackBar(
                    title: 'Menu Updated', duration: Duration(seconds: 1)));
              }
              if (state is UpdateAssignMenuLoadFail) {
                setState(() {
                  isSaveChecked = false;
                });
              }
            }),
          ],
          child: Column(
            children: [
              Row(
                children: [
                  buildUserTypeDropDown(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.15,
                  ),
                  isSaveChecked == false
                      ? Column(
                          children: [
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.035,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  menuMapList = [];
                                });
                                menuList!.forEach((element) {
                                  setState(() {
                                    menuMapList!.add({
                                      "AssignID": element.iD,
                                      "IsChecked": element.isActive
                                    });
                                  });
                                });
                                //print(menuMapList);
                                updateAssignMenu(
                                  json: menuMapList,
                                  userType: selectedUserType == 'Admin'
                                      ? 'A'
                                      : selectedUserType == 'App-Manager'
                                          ? 'M'
                                          : selectedUserType == 'Principle'
                                              ? 'P'
                                              : selectedUserType == 'Employee'
                                                  ? 'E'
                                                  : selectedUserType ==
                                                          'Student'
                                                      ? 'S'
                                                      : 'G',
                                );
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(width: 0.01)),
                                child: Center(
                                  child: Text(
                                    'Save',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            )
                            // ElevatedButton(
                            //   style: ButtonStyle(
                            //       backgroundColor: MaterialStateProperty.all(
                            //           Theme.of(context).primaryColor),
                            //       elevation: MaterialStateProperty.all(2),
                            //       overlayColor: MaterialStateProperty.all(
                            //           Colors.transparent)),
                            //onPressed: () {
                            // setState(() {
                            //   menuMapList = [];
                            // });
                            // menuList!.forEach((element) {
                            //   setState(() {
                            //     menuMapList!.add({
                            //       "AssignID": element.iD,
                            //       "IsChecked": element.isActive
                            //     });
                            //   });
                            // });
                            // //print(menuMapList);
                            // updateAssignMenu(
                            //   json: menuMapList,
                            //   userType: selectedUserType == 'Admin'
                            //       ? 'A'
                            //       : selectedUserType == 'App-Manager'
                            //           ? 'M'
                            //           : selectedUserType == 'Principle'
                            //               ? 'P'
                            //               : selectedUserType == 'Employee'
                            //                   ? 'E'
                            //                   : selectedUserType == 'Student'
                            //                       ? 'S'
                            //                       : 'G',
                            // );
                            //},
                            //   child: Container(
                            //     height:
                            //         MediaQuery.of(context).size.height * 0.055,
                            //     width: MediaQuery.of(context).size.width * 0.2,
                            //     child: Center(
                            //       child: Text('Save'),
                            //     ),
                            //   ),
                            // ),
                          ],
                        )
                      : Column(
                          children: [
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.035,
                            ),
                            Container(
                              width: 10,
                              height: 10,
                              child: CircularProgressIndicator(),
                            ),
                          ],
                        ),
                ],
              ),
              Divider(
                thickness: 5,
              ),
              // isSaveChecked == false
              //     ?
              BlocConsumer<GetUserAssignMenuCubit, GetUserAssignMenuState>(
                listener: (context, state) {
                  if (state is GetUserAssignMenuLoadSuccess) {
                    setState(() {
                      menuList = [];
                      menuList = state.getAssignList;
                    });
                  }
                  if (state is GetUserAssignMenuLoadFail) {
                    if (state.failReason == 'false') {
                      UserUtils.unauthorizedUser(context);
                    }
                  }
                },
                builder: (context, state) {
                  if (state is GetUserAssignMenuLoadInProgress) {
                    // return Center(
                    //   child: CircularProgressIndicator(),
                    // );
                    return LinearProgressIndicator();
                  } else if (state is GetUserAssignMenuLoadSuccess) {
                    //return checkList(menuList: state.getAssignList);
                    return checkList(menuList: menuList);
                  } else if (state is GetUserAssignMenuLoadFail) {
                    return checkList(error: state.failReason);
                  } else {
                    return ContactList();
                  }
                },
              ),
              //buildAssignMenuList(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Expanded checkList({List<GetUserAssignMenuModel>? menuList, String? error}) {
    if (menuList == null || menuList.isEmpty) {
      if (error != null) {
        return Expanded(
            child: Center(
          child: Text('$error'),
        ));
      } else {
        return Expanded(
            child: Center(
          child: Text('Wait'),
        ));
      }
    } else {
      return buildAssignMenuList(menuList: menuList);
    }
  }

  Expanded buildAssignMenuList({List<GetUserAssignMenuModel>? menuList}) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(
          height: 10,
        ),
        itemCount: menuList!.length,
        //itemCount: classListItem.length,
        itemBuilder: (context, index) {
          var item = menuList[index];
          return Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 10),
            padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
            decoration: BoxDecoration(border: Border.all(width: 0.2)),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Text(
                            'Menu : ${item.menuName}',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.1,
                      ),
                      item.subMenuName != ""
                          ? Flexible(
                              child: Text(
                                'Sub Menu : ${item.subMenuName}',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            )
                          : Container()
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: Text(
                        item.isActive == 1 ? 'Active' : 'InActive',
                        style: TextStyle(
                            color:
                                item.isActive == 1 ? Colors.green : Colors.red,
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.01,
                    ),
                    Checkbox(
                        activeColor: Colors.lightBlue,
                        value: item.isActive == 1 ? true : false,
                        onChanged: (val) {
                          setState(() {
                            item.isActive = val == true ? 1 : 0;
                          });
                        })
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Container buildUserTypeDropDown() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 19, top: 8, bottom: 10),
      width: MediaQuery.of(context).size.width * 0.4,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select User Type',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xffECECEC)),
              borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButton(
              isDense: true,
              value: selectedUserType,
              key: UniqueKey(),
              isExpanded: true,
              underline: Container(),
              items: item
                  .map((e) => DropdownMenuItem(
                        child: Text(
                          e,
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.035),
                        ),
                        value: e,
                      ))
                  .toList(),
              onChanged: (String? val) {
                if (val != selectedUserType) {
                  setState(() {
                    selectedUserType = val;
                  });
                  print(selectedUserType);
                  getUserAssignMenu(
                    userType: selectedUserType == 'Admin'
                        ? 'A'
                        : selectedUserType == 'App-Manager'
                            ? 'M'
                            : selectedUserType == 'Principle'
                                ? 'P'
                                : selectedUserType == 'Employee'
                                    ? 'E'
                                    : selectedUserType == 'Student'
                                        ? 'S'
                                        : 'G',
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
