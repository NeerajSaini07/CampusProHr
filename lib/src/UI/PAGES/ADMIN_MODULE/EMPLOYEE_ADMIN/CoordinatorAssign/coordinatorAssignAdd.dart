import 'dart:convert';
import 'dart:io';

import 'package:campus_pro/src/DATA/BLOC_CUBIT/ASSIGN_CLASS_COORDINATOR_CLASS/assign_class_coordinator_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/COORDINATOR_LIST_DETAIL_CUBIT/coordinator_list_detail_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/GET_COORDINATOR_LIST_CUBIT/get_coordinator_list_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/GET_PROFILE_COORDINATOR_CUBIT/get_coordinator_profile_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/GET_SELECT_CLASS_COORDINATOR_CUBIT/get_select_class_coordinator_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/RESULT_ANNOUNCE_CLASS_CUBIT/result_announce_class_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/getCoordinatorListModel.dart';
import 'package:campus_pro/src/DATA/MODELS/getCoordinatorProfileModel.dart';
import 'package:campus_pro/src/DATA/MODELS/getselectClassCoordinatorDropdownModel.dart';
import 'package:campus_pro/src/DATA/MODELS/resultAnnounceClassModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonSnackbar.dart';
import 'package:campus_pro/src/UTILS/appImages.dart';
import 'package:campus_pro/src/UTILS/filePicker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCoordinatorAssign extends StatefulWidget {
  static const routeName = '/add-coordinator-assign';
  const AddCoordinatorAssign({Key? key}) : super(key: key);

  @override
  _AddCoordinatorAssignState createState() => _AddCoordinatorAssignState();
}

class _AddCoordinatorAssignState extends State<AddCoordinatorAssign> {
  //coordinator List
  List<GetCoordinatorListModel>? coordinatorList;
  GetCoordinatorListModel? selectedCoordinator;

  //Multi select Key
  GlobalKey<FormFieldState> _classKey = GlobalKey<FormFieldState>();
  List<ResultAnnounceClassModel>? classItems = [];
  List<ResultAnnounceClassModel>? finalClassList = [];
  //

  List<File>? selectedImage = [];
  List<GetCoordinatorProfileModel>? coordinatorProfile;

  //coordinator selected class
  List<GetSelectClassCoordinatorModel>? selectedClassListCoordinator;

  //
  List<Map<String, String?>>? finalClassSendingList = [];
  //
  String? baseUrl;
  //

  //
  List customClassListBool = [];
  //
  getClassList() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final sendingClassData = {
      "OUserId": uid,
      "Token": token,
      "EmpID": userData!.stuEmpId,
      "OrgId": userData.organizationId,
      "Schoolid": userData.schoolId,
      "usertype": userData.ouserType,
      "classonly": "1",
      "classteacher": "0",
      "SessionId": userData.currentSessionid,
    };

    print('sending class data for change roll no $sendingClassData');

    context
        .read<ResultAnnounceClassCubit>()
        .resultAnnounceClassCubitCall(sendingClassData);
  }

  getCoordinatorList() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final sendingDataForCoordinator = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "SessionId": userData.currentSessionid,
      "EmpId": userData.stuEmpId,
      "UserType": userData.ouserType,
    };

    print('sending data for getCoordinatorListApi $sendingDataForCoordinator');

    context
        .read<GetCoordinatorListCubit>()
        .getCoordinatorListCubitCall(sendingDataForCoordinator);
  }

  getCoordinatorProfile({String? empid}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final getProfile = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "SessionId": userData.currentSessionid,
      "EmpId": userData.stuEmpId,
      "UserType": userData.ouserType,
      "SearchEmpId": empid,
    };

    print('sending data for GetCoordinatorProfile $getProfile');

    context
        .read<GetCoordinatorProfileCubit>()
        .getCoordinatorProfileCubitCall(getProfile);
  }

  getCoordinatorClass({String? empid}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final sendingClassData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "SessionId": userData.currentSessionid,
      "EmpId": userData.stuEmpId,
      "UserType": userData.ouserType,
      "SearchEmpId": empid,
    };
    print('sending data of coordinatorClassApi $sendingClassData');

    context
        .read<GetSelectClassCoordinatorCubit>()
        .getSelectClassCoordinatorCubitCall(sendingClassData);
  }

  saveCoordinatorClass(
      {String? empid,
      List<Map<String, String?>>? classJson,
      List<File>? img}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final sendingDataForClassCoordinator = {
      "OUserId": uid.toString(),
      "Token": token.toString(),
      "OrgId": userData!.organizationId.toString(),
      "Schoolid": userData.schoolId.toString(),
      "SessionId": userData.currentSessionid.toString(),
      "EmpId": userData.stuEmpId.toString(),
      "UserType": userData.ouserType.toString(),
      "SearchEmpId": empid.toString(),
      "JsonData": jsonEncode(classJson),
      //[{"ClassID":"204"},{"ClassID":"205"},{"ClassID":"206"},{"ClassID":"207"}],
    };

    print(
        'sending data for assignClassCoordinator $sendingDataForClassCoordinator');
    context
        .read<AssignClassCoordinatorCubit>()
        .assignClassCoordinatorCubitCall(sendingDataForClassCoordinator, img);
  }

  getBaseUrlImage() async {
    final userData = await UserUtils.userTypeFromCache();
    setState(() {
      baseUrl = userData!.baseDomainURL;
    });
  }

  @override
  void initState() {
    getBaseUrlImage();
    super.initState();
    selectedCoordinator =
        GetCoordinatorListModel(stuEmpName: "", mobileNo: "", stuEmpID: -1);
    coordinatorList = [];
    classItems = [];
    getCoordinatorList();
    getClassList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, title: 'Assign Classes To Coordinator'),
      body: MultiBlocListener(
        listeners: [
          BlocListener<GetCoordinatorProfileCubit, GetCoordinatorProfileState>(
              listener: (context, state) {
            if (state is GetCoordinatorProfileLoadSuccess) {
              setState(() {
                coordinatorProfile = state.profileDetails;
              });
              // customMultiSelect(classList: [
              //   '1',
              //   '2',
              //   '3',
              //   '4',
              //   '1',
              //   '2',
              //   '3',
              //   '4',
              //   '1',
              //   '2',
              //   '3',
              //   '4',
              //   '1',
              //   '2',
              //   '3',
              //   '4',
              //   '1',
              //   '2',
              //   '3',
              //   '4'
              // ]);
            }
            if (state is GetCoordinatorProfileLoadFail) {
              if (state.failReason == 'false') {
                UserUtils.unauthorizedUser(context);
              } else {
                setState(() {
                  coordinatorProfile = null;
                });
              }
            }
          }),
          //Coordinator classes : Todo
          BlocListener<GetSelectClassCoordinatorCubit,
              GetSelectClassCoordinatorState>(listener: (context, state) {
            if (state is GetSelectClassCoordinatorLoadSuccess) {
              setState(() {
                selectedClassListCoordinator = state.classList;
              });
              setState(() {
                finalClassSendingList = [];
              });

              //print(selectedClassListCoordinator);
              for (int v = 0; v < classItems!.length; v++) {
                setState(() {
                  customClassListBool[v] = false;
                });
              }

              // main tick for class acq to coordinator
              for (int i = 0; i < classItems!.length; i++) {
                for (int j = 0; j < selectedClassListCoordinator!.length; j++) {
                  if (classItems![i].id ==
                      selectedClassListCoordinator![j].classID) {
                    setState(() {
                      customClassListBool[i] = true;
                    });
                  }
                }
              }
              //

              //
              for (int i = 0; i < classItems!.length; i++) {
                if (customClassListBool[i] == true) {
                  setState(() {
                    finalClassSendingList!
                        .add({"ClassID": "${classItems![i].id}"});
                  });
                }
              }
              //
            }
          }),
          //Save Cubit
          BlocListener<AssignClassCoordinatorCubit,
              AssignClassCoordinatorState>(listener: (context, state) {
            if (state is AssignClassCoordinatorLoadSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                commonSnackBar(
                  title: 'Coordinator Class assigned',
                  duration: Duration(seconds: 1),
                ),
              );
              setState(() {
                selectedImage = [];
                finalClassList = [];
                classItems = [];
                getClassList();
              });
            }
            if (state is AssignClassCoordinatorLoadFail) {
              if (state.failReason == "false") {
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              BlocConsumer<GetCoordinatorListCubit, GetCoordinatorListState>(
                listener: (context, state) {
                  if (state is GetCoordinatorListLoadSuccess) {
                    setState(() {
                      selectedCoordinator = state.coordinatorList[0];
                      coordinatorList = state.coordinatorList;
                    });

                    getCoordinatorProfile(
                        empid: selectedCoordinator!.stuEmpID.toString());

                    getCoordinatorClass(
                        empid: selectedCoordinator!.stuEmpID.toString());
                  }
                  if (state is GetCoordinatorListLoadFail) {
                    if (state.failReason == "false") {
                      UserUtils.unauthorizedUser(context);
                    } else {
                      setState(() {
                        selectedCoordinator = GetCoordinatorListModel(
                            stuEmpID: -1, stuEmpName: "", mobileNo: "");
                        coordinatorList = [];
                      });
                    }
                  }
                },
                builder: (context, state) {
                  if (state is GetCoordinatorListLoadInProgress) {
                    return buildCoordinatorDropDown();
                  } else if (state is GetCoordinatorListLoadSuccess) {
                    return buildCoordinatorDropDown();
                  } else if (state is GetCoordinatorListLoadFail) {
                    return buildCoordinatorDropDown();
                  } else {
                    return Container();
                  }
                },
              ),
              // buildCoordinatorDropDown(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(border: Border.all(width: 0.04)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Class Assign',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Center(
                      child: Container(
                          width: 80,
                          height: 80,
                          child: coordinatorProfile != null
                              ? Image.network(
                                  "$baseUrl${coordinatorProfile![0].image}",
                                  errorBuilder:
                                      (buildContext, object, stackTrace) {
                                  return Image.asset(AppImages.dummyImage);
                                })
                              : Text("")),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Employee No : ${coordinatorProfile != null ? coordinatorProfile![0].empno : ""}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Name :  ${coordinatorProfile != null ? coordinatorProfile![0].name : ""}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Father Name :  ${coordinatorProfile != null ? coordinatorProfile![0].fatherName : ""}',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Designation :  ${coordinatorProfile != null ? coordinatorProfile![0].designation : ""}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Group :  ${coordinatorProfile != null ? coordinatorProfile![0].department : ""}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Class :',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    BlocConsumer<ResultAnnounceClassCubit,
                        ResultAnnounceClassState>(
                      listener: (context, state) {
                        if (state is ResultAnnounceClassLoadSuccess) {
                          setState(() {
                            classItems = state.classList;
                          });
                          classItems!.forEach((element) {
                            setState(() {
                              customClassListBool.add(false);
                            });
                          });
                        }
                        if (state is ResultAnnounceClassLoadFail) {
                          if (state.failReason == 'false') {
                            UserUtils.unauthorizedUser(context);
                          } else {
                            // selectedClass = ResultAnnounceClassModel(
                            //     id: "", className: "", classDisplayOrder: -1);
                            classItems = [];
                          }
                        }
                      },
                      builder: (context, state) {
                        if (state is ResultAnnounceClassLoadInProgress) {
                          // return buildClassMultiSelect();
                          return testContainer();
                        } else if (state is ResultAnnounceClassLoadSuccess) {
                          //return buildClassMultiSelect();
                          return buttonModalBottomSheet(classList: classItems);
                        } else if (state is ResultAnnounceClassLoadFail) {
                          //return buildClassMultiSelect();
                          return testContainer();
                        } else {
                          return Container();
                        }
                      },
                    ),
                    //buildClassMultiSelect(),
                    SizedBox(
                      height: 10,
                    ),
                    //dropdown class
                    Text(
                      'Upload Signature :',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    //Container for image
                    SizedBox(
                      height: 10,
                    ),
                    selectedImage!.length != 0
                        ? Center(
                            child: selectedImage![0]
                                        .path
                                        .split('.')
                                        .last
                                        .toLowerCase() !=
                                    'pdf'
                                ? Container(
                                    // width: MediaQuery.of(context).size.width * 0.3,
                                    // height: MediaQuery.of(context).size.height * 0.2,
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 0.1),
                                    ),
                                    child: Image.file(
                                      selectedImage![0],
                                      fit: BoxFit.cover,
                                    ))
                                : Row(
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.12,
                                      ),
                                      Icon(
                                        Icons.picture_as_pdf,
                                        size: 45,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(width: 0.01),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        // margin: EdgeInsets.all(10),
                                        padding: EdgeInsets.all(4),
                                        height: 50,
                                        width: 180,
                                        child: Center(
                                          child: Text(
                                            '${selectedImage![0].path.split('/')[7].split('.')[0]}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                          )
                        : Container(),
                    SizedBox(
                      height: selectedImage!.length != 0
                          ? MediaQuery.of(context).size.height * 0.03
                          : 0,
                    ),
                    selectedImage!.length == 0
                        ? Center(
                            child: GestureDetector(
                              onTap: () async {
                                List<File>? file =
                                    await showFilePicker(allowMultiple: false);
                                setState(() {
                                  selectedImage = file!;
                                });
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                margin: EdgeInsets.all(8),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(width: 0.1),
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.green,
                                ),
                                child: Center(
                                  child: Text(
                                    'Select File',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Center(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedImage = [];
                                });
                              },
                              child: PhysicalModel(
                                color: Colors.white12,
                                clipBehavior: Clip.antiAlias,
                                elevation: 10,
                                child: Icon(
                                  Icons.delete,
                                  size: 30,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          saveCoordinatorClass(
                            empid: selectedCoordinator!.stuEmpID.toString(),
                            classJson: finalClassSendingList,
                            img: selectedImage,
                          );
                        },
                        child: Container(
                          // width: MediaQuery.of(context).size.width * 0.6,
                          margin: EdgeInsets.all(8),
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                          decoration: BoxDecoration(
                            border: Border.all(width: 0.1),
                            borderRadius: BorderRadius.circular(20),
                            color: Theme.of(context).primaryColor,
                          ),
                          child: Text(
                            'Save Coordinator',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.07,
              )
            ],
          ),
        ),
      ),
    );
  }

  Container buildCoordinatorDropDown() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: EdgeInsets.only(left: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(width: 0.1)),
      child: DropdownButton<GetCoordinatorListModel>(
        underline: Container(),
        isExpanded: true,
        value: selectedCoordinator,
        items: coordinatorList!
            .map((e) => DropdownMenuItem(
                  child: Text('${e.stuEmpName}'),
                  value: e,
                ))
            .toList(),
        onChanged: (val) {
          setState(() {
            selectedCoordinator = val!;
          });
          getCoordinatorProfile(
              empid: selectedCoordinator!.stuEmpID.toString());
          getCoordinatorClass(empid: selectedCoordinator!.stuEmpID.toString());
        },
      ),
    );
  }

  //Todo:Use this custom multi select class dropdown
  Center buttonModalBottomSheet({List<ResultAnnounceClassModel>? classList}) {
    return Center(
      child: GestureDetector(
        onTap: () async {
          customMultiSelect(classList: classList);
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(border: Border.all(width: 0.05)),
          padding: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width * 0.75,
          height: MediaQuery.of(context).size.height * 0.055,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Select Classes",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Icon(Icons.arrow_downward)
            ],
          ),
        ),
      ),
    );
  }

  Future<Widget?> customMultiSelect(
      {List<ResultAnnounceClassModel>? classList}) {
    //showModalBottomSheet
    return showModalBottomSheet<Widget>(
        context: context,
        isDismissible: false,
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                children: [
                  Center(
                    child: Text(
                      'Class List',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(
                        height: 2,
                      ),
                      itemCount: classList!.length,
                      itemBuilder: (context, index) {
                        var item = classList[index];
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${item.className}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Checkbox(
                                value: customClassListBool[index],
                                onChanged: (val) {
                                  setState(
                                    () {
                                      customClassListBool[index] =
                                          !customClassListBool[index];
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    // margin: EdgeInsets.only(top: 9, bottom: 9),
                    // padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          width: 0.2,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: Center(
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(
                                    //color: Colors.black,
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              finalClassList = [];
                              finalClassSendingList = [];
                            });

                            for (int i = 0; i < classList.length; i++) {
                              if (customClassListBool[i] == true) {
                                setState(() {
                                  finalClassSendingList!
                                      .add({"ClassID": "${classList[i].id}"});
                                });
                              }
                            }
                            print(finalClassSendingList);
                            Navigator.pop(context);
                          },
                          child: Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: Center(
                                child: Text(
                                  'OK',
                                  style: TextStyle(
                                    //color: Colors.black,
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )),
                        ),
                      ],
                    ),
                  )
                ],
              );
            },
          );
        });
  }

  Widget buildClassMultiSelect({List<ResultAnnounceClassModel>? initialList}) {
    return Container(
      alignment: Alignment.center,
      // padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: MultiSelectBottomSheetField<ResultAnnounceClassModel>(
        autovalidateMode: AutovalidateMode.disabled,
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xffECECEC)),
        ),
        key: _classKey,
        initialChildSize: 0.7,
        initialValue: initialList != null ? initialList : [],
        maxChildSize: 0.95,
        searchIcon: Icon(Icons.ac_unit),
        title: Text("All Class",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 18)),
        buttonText: Text(
          "Select Classes",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        items: classItems!
            .map(
              (e) => MultiSelectItem(
                e,
                e.className!,
              ),
            )
            .toList(),
        searchable: false,
        validator: (values) {
          if (values == null || values.isEmpty || finalClassList!.isEmpty) {
            return "Required Field";
          }
          return null;
        },
        onConfirm: (values) {
          setState(() {
            finalClassList = [];
          });
          setState(() {
            finalClassList = values;
          });

          setState(() {
            finalClassList!.forEach((element) {
              finalClassSendingList!.add({"ClassID": "${element.id}"});
            });
          });
        },
        chipDisplay: MultiSelectChipDisplay(
          shape: RoundedRectangleBorder(),
          textStyle: TextStyle(
              fontWeight: FontWeight.w900,
              color: Theme.of(context).primaryColor),
        ),
      ),
    );
  }

  Center testContainer() {
    return Center(
      child: Container(
        child: Text(
          "Select Classes",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(border: Border.all(width: 0.05)),
        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width * 0.75,
        height: MediaQuery.of(context).size.height * 0.055,
      ),
    );
  }
}
