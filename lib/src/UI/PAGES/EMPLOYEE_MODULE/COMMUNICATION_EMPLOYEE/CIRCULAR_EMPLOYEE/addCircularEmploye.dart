import 'dart:io';

import 'package:campus_pro/src/DATA/BLOC_CUBIT/ADD_CIRCULAR_EMPLOYEE_CUBIT/add_circular_employee_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/CIRCULAR_EMPLOYEE_CUBIT/circular_employee_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/CLASS_FOR_COORDINATOR_CUBIT/classes_for_coordinator_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/CLASS_LIST_EMPLOYEE_CUBIT/class_list_employee_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/FILL_CLASS_ONLY_WITH_SECTION_ADMIN_CUBIT/fill_class_only_with_section_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/classListEmployeeModel.dart';
import 'package:campus_pro/src/DATA/MODELS/classesForCoordinatorModel.dart';
import 'package:campus_pro/src/DATA/MODELS/fillClassOnlyWithSectionAdminModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonSnackbar.dart';
import 'package:campus_pro/src/UTILS/appImages.dart';
import 'package:campus_pro/src/UTILS/fieldValidators.dart';
import 'package:campus_pro/src/UTILS/filePicker.dart';
import 'package:campus_pro/src/WIDGETS_STYLE/style_common.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/admin/directory_v1.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCircularEmployee extends StatefulWidget {
  static const routeName = 'add-circular-employee';
  @override
  _AddCircularEmployeeState createState() => _AddCircularEmployeeState();
}

class _AddCircularEmployeeState extends State<AddCircularEmployee> {
  bool isLoader = false;

  List finalClassList = [];
  List<ClassListEmployeeModel>? _classEmployeeList = [];
  List<ClassListEmployeeModel> _selectedClassList = [];

  List finalClassListAdmin = [];
  List<FillClassOnlyWithSectionAdminModel>? _classEmployeeListAdmin = [];
  List<FillClassOnlyWithSectionAdminModel> _selectedClassListAdmin = [];

  //Coordinator class
  List finalClassListCoordinator = [];
  List<ClassesForCoordinatorModel> _classEmployeeListCoordinator = [];
  List<ClassesForCoordinatorModel> _selectedClassListCoordinator = [];

  final _classSelectKey = GlobalKey<FormFieldState>();
  // FilePickerResult? _filePicked;
  List<File>? _filePicked;
  // String? _filePickedName;
  // String? _filePickedPath;
  // String? _filePickedExtension;

  //TextEditingController _controllerCircularNo = TextEditingController();
  TextEditingController _controllerSubject = TextEditingController();
  TextEditingController _controllerContent = TextEditingController();

  DateTime selectedDate = DateTime.now();

  GlobalKey<FormState> _key = GlobalKey<FormState>();
  String? UserType;
  bool? isChecked;
  bool? bothChecked;

  Future<List<File>?> showFilePickerSingle() async {
    // Navigator.pop(context);
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        withReadStream: true,
        type: FileType.custom,
        allowCompression: true,
        allowedExtensions: ['jpg', 'pdf', 'jpeg', 'png'],
        allowMultiple: false);

    if (result != null) {
      // final bytes = result.files.single.size;
      // final kb = bytes / 1024;
      // final mb = kb / 1024;
      // print('BYTES : $bytes & KB : $kb & MB : $mb');
      File file = File(result.files.single.path!);

      //FilePickerResult? file = result;
      List<File> files = result.paths.map((path) => File(path!)).toList();
      return files;
    } else {
      print('File Format not Found');
    }
  }

  Future<void> _selectDate(BuildContext context, {int? index}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      helpText: index == 0 ? "SELECT FROM DATE" : "SELECT TO DATE",
    );
    if (picked != null)
      setState(() {
        selectedDate = picked;
      });
  }

  // final _items = _teachers
  //     .map((teacher) => MultiSelectItem(teacher, teacher.name!))
  //     .toList();

  getEmployeeClass() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final getEmpClassData = {
      "OUserId": uid!,
      "Token": token!,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "SessionId": userData.currentSessionid,
      "EmpID": userData.stuEmpId,
    };
    print('Get Employee Class $getEmpClassData');
    context
        .read<ClassListEmployeeCubit>()
        .classListEmployeeCubitCall(getEmpClassData);
  }

  getClassAdmin() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final getEmpClassData = {
      "OUserId": uid!,
      "Token": token!,
      "StuEmpId": userData!.stuEmpId,
      "OrgId": userData.organizationId,
      "Schoolid": userData.schoolId,
      "UserType": userData.ouserType,
    };
    print('Class List for Admin $getEmpClassData');
    context
        .read<FillClassOnlyWithSectionCubit>()
        .fillClassOnlyWithSectionCubitCall(getEmpClassData);
  }

  getCoordinatorClass() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final getClassData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "SessionId": userData.currentSessionid,
      "EmpId": userData.stuEmpId,
      "UserType": userData.ouserType,
    };

    print('sending data for class for coordinator');

    context
        .read<ClassesForCoordinatorCubit>()
        .classesForCoordinatorCubitCall(getClassData);
  }

  sendCircular({
    String? classId,
    String? cirCont,
    String? cirSub,
    String? cirDate,
    String? cirNo,
    List<File>? img,
  }) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final sendCircularData = {
      "UserId": uid!,
      "Token": token!,
      "OrgId": userData!.organizationId.toString(),
      "SchoolId": userData.schoolId.toString(),
      "SessionId": userData.currentSessionid.toString(),
      "CircularDate": cirDate.toString(),
      "CirNo": "",
      "CirSubject": cirSub.toString(),
      "CirContent": cirCont.toString(),
      "For": isChecked == true
          ? "S"
          : bothChecked == false
              ? "E"
              : "Both",
      "ForAll": (finalClassList.length > 0 ||
              finalClassListAdmin.length > 0 ||
              finalClassListCoordinator.length > 0)
          ? "0"
          : "1",
      "ClassId": classId.toString(),
      "GroupId": "0",
      "Empid": userData.stuEmpId.toString(),
      "usertype": UserType.toString(),
      //isChecked == true ? "E" : "A",
      // "image": img.toString(),
    };
    print('Sending circular data $sendCircularData');
    context
        .read<AddCircularEmployeeCubit>()
        .addCircularEmployeeCubitCall(sendCircularData, img);
  }

  getUserType() async {
    final userData = await UserUtils.userTypeFromCache();
    setState(() {
      UserType = userData!.ouserType;
    });
    //print(userData!.ouserType);
  }

  @override
  void initState() {
    super.initState();
    isChecked = true;
    bothChecked = false;
    getUserType();
    getEmployeeClass();
    getClassAdmin();
    getCoordinatorClass();
  }

  @override
  void dispose() {
    _controllerContent.dispose();
    _controllerSubject.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, title: 'Create Circular'),
      body: Form(
        key: _key,
        child: SingleChildScrollView(
          //physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              UserType == 'A' ||
                      UserType == 'C' ||
                      UserType == 'M' ||
                      UserType == 'P'
                  ? Container(
                      //margin: EdgeInsets.symmetric(horizontal: 20),
                      margin: EdgeInsets.only(
                          left: 22, right: 22, top: 5, bottom: 0),
                      decoration: BoxDecoration(border: Border.all(width: 0.1)),
                      padding: EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isChecked == true
                                        ? Colors.blueAccent
                                        : Colors.white,
                                    border: Border.all(width: 0.1)),
                                width: MediaQuery.of(context).size.width * 0.06,
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                margin: EdgeInsets.all(4),
                                child: TextButton(
                                  style: ButtonStyle(
                                      overlayColor: MaterialStateProperty.all(
                                          Colors.transparent)),
                                  onPressed: () {
                                    setState(() {
                                      isChecked = true;
                                      bothChecked = false;
                                    });
                                  },
                                  child: Text(''),
                                ),
                              ),
                              Text(
                                'Student',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          // SizedBox(
                          //   width: MediaQuery.of(context).size.width * 0.2,
                          // ),
                          Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isChecked == false
                                        ? bothChecked == false
                                            ? Colors.blueAccent
                                            : Colors.white
                                        : Colors.white,
                                    border: Border.all(width: 0.1)),
                                width: MediaQuery.of(context).size.width * 0.06,
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                margin: EdgeInsets.all(4),
                                child: TextButton(
                                  style: ButtonStyle(
                                      overlayColor: MaterialStateProperty.all(
                                          Colors.transparent)),
                                  onPressed: UserType == 'C'
                                      ? null
                                      : () {
                                          setState(() {
                                            isChecked = false;
                                            bothChecked = false;
                                          });
                                        },
                                  child: Text(''),
                                ),
                              ),
                              Text(
                                'Employee',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: bothChecked == true
                                        ? Colors.blueAccent
                                        : Colors.white,
                                    // isChecked == false
                                    //     ? Colors.white
                                    //     : bothChecked == false
                                    //         ? Colors.white
                                    //         : Colors.blueAccent,
                                    border: Border.all(width: 0.1)),
                                width: MediaQuery.of(context).size.width * 0.06,
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                margin: EdgeInsets.all(4),
                                child: TextButton(
                                  style: ButtonStyle(
                                      overlayColor: MaterialStateProperty.all(
                                          Colors.transparent)),
                                  onPressed: () {
                                    setState(() {
                                      isChecked = false;
                                      bothChecked = true;
                                    });
                                  },
                                  child: Text(''),
                                ),
                              ),
                              Text(
                                'Both',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  : Container(),
              isChecked == true
                  ? UserType == 'E'
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Container(
                            //   margin: EdgeInsets.only(left: 16, top: 10),
                            //   child: Text(
                            //     "Class",
                            //     style: Theme.of(context).textTheme.headline6,
                            //   ),
                            // ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            BlocConsumer<ClassListEmployeeCubit,
                                ClassListEmployeeState>(
                              listener: (context, state) {
                                if (state is ClassListEmployeeLoadSuccess) {
                                  print(state.classList[0].className);
                                  setState(() {
                                    _classEmployeeList = state.classList;
                                  });
                                  //print(dropDownClassValue!.className);
                                }
                                if (state is ClassListEmployeeLoadFail) {
                                  if (state.failReason == 'false') {
                                    UserUtils.unauthorizedUser(context);
                                  } else {
                                    setState(() {
                                      // dropDownClassValue =
                                      //     ClassListEmployeeModel(iD: "", className: "");
                                      _classEmployeeList = [];
                                    });
                                  }
                                }
                              },
                              builder: (context, state) {
                                if (state is ClassListEmployeeLoadInProgress) {
                                  return testContainer();
                                  //return buildClassMultiSelect();
                                  //return CircularProgressIndicator();
                                } else if (state
                                    is ClassListEmployeeLoadSuccess) {
                                  return buildClassMultiSelect();
                                } else if (state is ClassListEmployeeLoadFail) {
                                  return buildClassMultiSelect();
                                } else {
                                  return Container();
                                }
                              },
                            ),
                            //buildClassMultiSelect(),
                          ],
                        )
                      : (UserType == 'A' || UserType == 'M' || UserType == 'P')
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Container(
                                //   margin: EdgeInsets.only(left: 16, top: 10),
                                //   child: Text(
                                //     "Class",
                                //     style: Theme.of(context).textTheme.headline6,
                                //   ),
                                // ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.02,
                                ),
                                BlocConsumer<FillClassOnlyWithSectionCubit,
                                    FillClassOnlyWithSectionState>(
                                  listener: (context, state) {
                                    if (state
                                        is FillClassOnlyWithSectionLoadSuccess) {
                                      print(state.classList[0].classname);
                                      setState(() {
                                        _classEmployeeListAdmin =
                                            state.classList;
                                      });
                                      //print(dropDownClassValue!.className);
                                    }
                                    if (state
                                        is FillClassOnlyWithSectionLoadFail) {
                                      setState(() {
                                        // dropDownClassValue =
                                        //     ClassListEmployeeModel(iD: "", className: "");
                                        _classEmployeeListAdmin = [];
                                      });
                                      if (state.failReason == 'false') {
                                        UserUtils.unauthorizedUser(context);
                                      }
                                    }
                                  },
                                  builder: (context, state) {
                                    if (state
                                        is FillClassOnlyWithSectionLoadInProgress) {
                                      return testContainer();
                                      // return buildClassMultiSelectAdmin();
                                      //return CircularProgressIndicator();
                                    } else if (state
                                        is FillClassOnlyWithSectionLoadSuccess) {
                                      return buildClassMultiSelectAdmin();
                                    }
                                    // else if (state is ClassListEmployeeLoadFail) {
                                    //   return buildClassMultiSelect();
                                    // }
                                    else {
                                      return Container();
                                    }
                                  },
                                ),
                                //buildClassMultiSelect(),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.02,
                                ),
                                BlocConsumer<ClassesForCoordinatorCubit,
                                    ClassesForCoordinatorState>(
                                  listener: (context, state) {
                                    if (state
                                        is ClassesForCoordinatorLoadSuccess) {
                                      print(state.classList[0].className);
                                      setState(() {
                                        _classEmployeeListCoordinator =
                                            state.classList;
                                      });
                                      //print(dropDownClassValue!.className);
                                    }
                                    if (state
                                        is ClassesForCoordinatorLoadFail) {
                                      setState(() {
                                        // dropDownClassValue =
                                        //     ClassListEmployeeModel(iD: "", className: "");
                                        _classEmployeeListCoordinator = [];
                                      });
                                      if (state.failReason == 'false') {
                                        UserUtils.unauthorizedUser(context);
                                      }
                                    }
                                  },
                                  builder: (context, state) {
                                    if (state
                                        is ClassesForCoordinatorLoadInProgress) {
                                      return testContainer();
                                      // return buildClassMultiSelectAdmin();
                                      //return CircularProgressIndicator();
                                    } else if (state
                                        is ClassesForCoordinatorLoadSuccess) {
                                      return buildClassMultiSelectCoordinator();
                                    } else if (state
                                        is ClassesForCoordinatorLoadFail) {
                                      return buildClassMultiSelectCoordinator();
                                    } else {
                                      return Container();
                                    }
                                  },
                                ),
                                //buildClassMultiSelect(),
                              ],
                            )
                  : Container(),
              // SizedBox(
              //   height: MediaQuery.of(context).size.height * 0.01,
              // ),
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     buildLabels(
              //       label: 'Circular No:',
              //     ),
              //     // SizedBox(
              //     //   height: MediaQuery.of(context).size.height * 0.01,
              //     // ),
              //     // buildTextField(
              //     //   controller: _controllerCircularNo,
              //     //   validator: FieldValidators.globalValidator,
              //     // )
              //   ],
              // ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildLabels(label: 'Subject:'),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  buildTextField(
                    controller: _controllerSubject,
                    validator: FieldValidators.globalValidator,
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 1, bottom: 2, left: 5, right: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Date:",
                              // style: Theme.of(context).textTheme.headline6,
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.018,
                            ),
                            buildDateSelector(
                              selectedDate: DateFormat("dd MMM yyyy")
                                  .format(selectedDate),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildLabels(label: 'Content:'),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  buildTextField(
                      controller: _controllerContent,
                      validator: FieldValidators.globalValidator,
                      maxLines: 5)
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              // if (_filePicked != null)
              //   Container(
              //     width: MediaQuery.of(context).size.width * 0.5,
              //     height: MediaQuery.of(context).size.height * 0.06,
              //     margin: const EdgeInsets.all(4.0),
              //     padding: const EdgeInsets.all(8.0),
              //     decoration: BoxDecoration(
              //       color: Theme.of(context).primaryColor.withOpacity(0.1),
              //       borderRadius: BorderRadius.circular(8.0),
              //     ),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Row(
              //           children: [
              //             _filePickedExtension == "pdf"
              //                 ? Image(
              //                     image: AssetImage(AppImages.pdfImage),
              //                     width: 20.0,
              //                   )
              //                 : _filePickedExtension == "jpg"
              //                     ? Image(
              //                         image: AssetImage(AppImages.jpgImage),
              //                         width: 20.0,
              //                       )
              //                     : _filePickedExtension == "jpeg"
              //                         ? Image(
              //                             image: AssetImage(AppImages.jpegImage),
              //                             width: 20.0,
              //                           )
              //                         : Icon(Icons.upload_file,
              //                             color: Theme.of(context).accentColor,
              //                             size: 18),
              //             SizedBox(width: 8),
              //             Text(_filePickedName!, textScaleFactor: 0.8),
              //           ],
              //         ),
              //         InkResponse(
              //           onTap: () {
              //             setState(() {
              //               _filePicked = null;
              //             });
              //           },
              //           child: Icon(Icons.cancel),
              //         ),
              //       ],
              //     ),
              //   ),
              InkWell(
                splashColor: Colors.transparent,
                onTap: () async {
                  // _filePicked = await showFilePickerSingle();
                  List<File>? file = await showFilePicker(allowMultiple: false);
                  setState(() {
                    if (file != null) {
                      _filePicked = file;
                    }
                  });
                },
                // onTap: () async {
                //   // _filePicked = await showFilePicker();
                //   // if (_filePicked != null) {
                //   //   setState(() {
                //   //     _filePickedName = //_filePicked!.files.single.path!
                //   //     _filePicked!.
                //   //         .split("/")
                //   //         .last
                //   //         .toLowerCase();
                //   //     _filePickedPath = _filePicked!.files.single.path!;
                //   //     _filePickedExtension = _filePicked!.files.single.path!
                //   //         .split(".")
                //   //         .last
                //   //         .toLowerCase();
                //   //   });
                //   //   print('_filePickedPath : $_filePickedPath');
                //   // }
                //
                // },
                child: _filePicked != null
                    ? Container(
                        decoration:
                            BoxDecoration(border: Border.all(width: 0.3)),
                        child: GestureDetector(
                          // onTap: () async {
                          //   // _filePicked = await showFilePickerSingle();
                          //   List<File>? file =
                          //       await showFilePicker(allowMultiple: false);
                          //   setState(() {
                          //     if (file != null) {
                          //       _filePicked = file;
                          //     }
                          //   });
                          // },
                          //("pdf"||"jpg"||"jpeg")
                          child: _filePicked![0]
                                      .path
                                      .split(".")
                                      .last
                                      .toLowerCase() ==
                                  "pdf"
                              ? Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  margin: EdgeInsets.all(8),
                                  //decoration: BoxDecoration(border: ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image(
                                        image: AssetImage(AppImages.pdfImage),
                                        width: 35.0,
                                      ),
                                      SizedBox(width: 8),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.6,
                                            child: Text(
                                              _filePicked![0]
                                                  .path
                                                  .split("/")
                                                  .last
                                                  .toLowerCase(),
                                              textScaleFactor: 1.1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.2,
                                            child: Text(
                                              'Change',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.blue),
                                            ),
                                          ),
                                        ],
                                      ),
                                      InkResponse(
                                        onTap: () {
                                          setState(() {
                                            _filePicked = null;
                                          });
                                        },
                                        child: Icon(
                                          Icons.cancel,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Stack(
                                  children: [
                                    Container(
                                      height: 150,
                                      width: 150,
                                      child: Image.file(_filePicked![0],
                                          fit: BoxFit.cover),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      child: Container(
                                        height: 30,
                                        width: 150,
                                        color: Colors.black54,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 2),
                                          child: FittedBox(
                                              child: Text(
                                            "Change",
                                            style: TextStyle(
                                                color: Colors.white70),
                                          )),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 0,
                                      top: -10,
                                      child: Container(
                                        height: 30,
                                        width: 30,
                                        color: Colors.transparent,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 2),
                                          child: IconButton(
                                            color: Colors.black,
                                            icon: Icon(
                                              Icons.cancel,
                                              color: Colors.black,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _filePicked = null;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      )
                    // InkWell(
                    //     onTap: () async {
                    //       _filePicked = await showFilePickerSingle();
                    //       if (_filePicked != null) {
                    //         setState(() {
                    //           _filePickedName = _filePicked!.files.single.path!
                    //               .split("/")
                    //               .last
                    //               .toLowerCase();
                    //           _filePickedPath = _filePicked!.files.single.path!;
                    //           _filePickedExtension = _filePicked!
                    //               .files.single.path!
                    //               .split(".")
                    //               .last
                    //               .toLowerCase();
                    //         });
                    //         print('_filePickedPath : $_filePickedPath');
                    //       }
                    //     },
                    //     child: new Container(
                    //         width: MediaQuery.of(context).size.width,
                    //         height: MediaQuery.of(context).size.height * 0.08,
                    //         margin: new EdgeInsets.symmetric(
                    //             horizontal: 17.0, vertical: 7),
                    //         decoration: BoxDecoration(
                    //           border: _filePicked == null
                    //               ? Border.all(
                    //                   color: Color(0xffECECEC),
                    //                 )
                    //               : null,
                    //           borderRadius: BorderRadius.circular(13),
                    //           color: _filePicked == null
                    //               ? Colors.white70
                    //               : Colors.white,
                    //         ),
                    //         child: Container(
                    //           width: MediaQuery.of(context).size.width,
                    //           height: MediaQuery.of(context).size.height * 0.06,
                    //           margin: const EdgeInsets.all(4.0),
                    //           padding: const EdgeInsets.all(8.0),
                    //           decoration: BoxDecoration(
                    //             color: Theme.of(context)
                    //                 .primaryColor
                    //                 .withOpacity(0.1),
                    //             borderRadius: BorderRadius.circular(8.0),
                    //           ),
                    //           child: Row(
                    //             mainAxisAlignment:
                    //                 MainAxisAlignment.spaceBetween,
                    //             children: [
                    //               Row(
                    //                 children: [
                    //                   _filePickedExtension == "pdf"
                    //                       ?
                    //                   Image(
                    //                           image: AssetImage(
                    //                               AppImages.pdfImage),
                    //                           width: 25.0,
                    //                         )
                    //                       : _filePickedExtension == "jpg"
                    //                           ? Image(
                    //                               image: AssetImage(
                    //                                   AppImages.jpgImage),
                    //                               width: 25.0,
                    //                             )
                    //                           : _filePickedExtension == "jpeg"
                    //                               ? Image(
                    //                                   image: AssetImage(
                    //                                       AppImages.jpegImage),
                    //                                   width: 25.0,
                    //                                 )
                    //                               : Icon(Icons.upload_file,
                    //                                   color: Theme.of(context)
                    //                                       .accentColor,
                    //                                   size: 18),
                    //                   SizedBox(width: 8),
                    //                   Column(
                    //                     crossAxisAlignment:
                    //                         CrossAxisAlignment.start,
                    //                     children: [
                    //                       SizedBox(
                    //                         width: MediaQuery.of(context)
                    //                                 .size
                    //                                 .width *
                    //                             0.6,
                    //                         child: Text(_filePickedName!,
                    //                             textScaleFactor: 1.0,
                    //                             overflow:
                    //                                 TextOverflow.ellipsis),
                    //                       ),
                    //                       SizedBox(
                    //                         width: MediaQuery.of(context)
                    //                                 .size
                    //                                 .width *
                    //                             0.2,
                    //                         child: Text(
                    //                           'Change',
                    //                           style: TextStyle(
                    //                               fontSize: 12,
                    //                               color: Colors.blue),
                    //                         ),
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ],
                    //               ),
                    //               InkResponse(
                    //                 onTap: () {
                    //                   setState(() {
                    //                     _filePicked = null;
                    //                   });
                    //                 },
                    //                 child: Icon(Icons.cancel),
                    //               ),
                    //             ],
                    //           ),
                    //         )),
                    //   )
                    : Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.height * 0.05,
                        margin: new EdgeInsets.symmetric(
                            horizontal: 17.0, vertical: 2),
                        decoration: BoxDecoration(
                          border: _filePicked == null
                              ? Border.all(
                                  color: Color(0xffECECEC),
                                )
                              : null,
                          borderRadius: BorderRadius.circular(20),
                          color:
                              _filePicked == null ? Colors.green : Colors.white,
                        ),
                        child: Center(
                          child: new TextButton(
                            style: ButtonStyle(
                                overlayColor: MaterialStateProperty.all(
                                    Colors.transparent)),
                            child: Text(
                              'Add File',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            //color: Theme.of(context).primaryColor,
                            onPressed: () async {
                              // _filePicked = await showFilePickerSingle();
                              //var file = await showFilePickerSingle();
                              List<File>? file =
                                  await showFilePicker(allowMultiple: false);
                              setState(() {
                                _filePicked = file;
                              });
                              if (_filePicked != null) {
                                // setState(() {
                                //   _filePickedName = _filePicked!
                                //       .files.single.path!
                                //       .split("/")
                                //       .last
                                //       .toLowerCase();
                                //   _filePickedPath =
                                //       _filePicked!.files.single.path!;
                                //   _filePickedExtension = _filePicked!
                                //       .files.single.path!
                                //       .split(".")
                                //       .last
                                //       .toLowerCase();
                                // });
                                //
                                // print('_filePickedPath : $_filePickedPath');
                              }
                            },
                          ),
                        ),
                      ),
                // else{Text('Upload')};
                // child: new FlatButton(
                //   child: Text(
                //     'Add File',
                //     style: TextStyle(color: Colors.black),
                //   ),
                //   //color: Theme.of(context).primaryColor,
                //   onPressed: () async {
                //     _filePicked = await showFilePicker();
                //     setState(() {
                //       _filePickedName = _filePicked!.files.single.path!
                //           .split("/")
                //           .last
                //           .toLowerCase();
                //       _filePickedPath = _filePicked!.files.single.path!;
                //       _filePickedExtension = _filePicked!.files.single.path!
                //           .split(".")
                //           .last
                //           .toLowerCase();
                //     });
                //     print('_filePickedPath : $_filePickedPath');
                //   },
                // ),
              ),
              _filePicked != null
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    )
                  : SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
              BlocConsumer<AddCircularEmployeeCubit, AddCircularEmployeeState>(
                listener: (context, state) async {
                  if (state is AddCircularEmployeeLoadInProgress) {
                    setState(() {
                      isLoader = true;
                    });
                  }
                  if (state is AddCircularEmployeeLoadSuccess) {
                    bool? classSelectBoll;
                    setState(() {
                      if (isChecked == true) {
                        // classSelectBoll = true;
                        _controllerSubject.text = "";
                        _controllerContent.text = "";
                        //_controllerCircularNo.text = "";
                        selectedDate = DateTime.now();
                        _filePicked = null;
                        // _classEmployeeList = [];
                        // finalClassList = [];
                        _classEmployeeListAdmin = [];
                        finalClassListAdmin = [];
                        _selectedClassListAdmin = [];
                        _selectedClassListCoordinator = [];
                        finalClassListCoordinator = [];
                        _classEmployeeListCoordinator = [];
                      } else {
                        //classSelectBoll = false;
                        _controllerSubject.text = "";
                        _controllerContent.text = "";
                        //_controllerCircularNo.text = "";
                        selectedDate = DateTime.now();
                        _filePicked = null;
                        _classEmployeeList = [];
                        finalClassList = [];
                        _selectedClassList = [];
                      }
                    });
                    UserType!.toLowerCase() == 'e'
                        ? getEmployeeClass()
                        : (UserType!.toLowerCase() == 'a' ||
                                UserType!.toLowerCase() == 'm')
                            ? getClassAdmin()
                            : getCoordinatorClass();
                    // classSelectBoll == false
                    //     ? getEmployeeClass()
                    //     : getClassAdmin();
                    setState(() {
                      isLoader = false;
                    });
                    // showDialog(
                    //     context: context,
                    //     builder: (context) {
                    //       return AlertDialog(
                    //         title: Text('Circular Sent'),
                    //         actions: [
                    //           TextButton(
                    //             onPressed: () {
                    //               Navigator.pop(context);
                    //             },
                    //             child: Text('Back'),
                    //           )
                    //         ],
                    //       );
                    //     });
                    ScaffoldMessenger.of(context).showSnackBar(commonSnackBar(
                      title: 'Circular Sent',
                    ));

                    ///
                    ///
                    final uid = await UserUtils.idFromCache();
                    final token = await UserUtils.userTokenFromCache();
                    final userData = await UserUtils.userTypeFromCache();
                    final circularData = {
                      "OUserId": uid,
                      "Token": token,
                      "OrgId": userData!.organizationId,
                      "Schoolid": userData.schoolId!,
                      "SessionId": userData.currentSessionid!,
                      "CirFromDate":
                          DateFormat("dd MMM yyyy").format(DateTime.now()),
                      "CirToDate":
                          DateFormat("dd MMM yyyy").format(DateTime.now()),
                      "OnLoad": "0",
                      "StuEmpId": userData.stuEmpId,
                      "UserType": userData.ouserType,
                    };
                    print("circularData sending = > $circularData");
                    context
                        .read<CircularEmployeeCubit>()
                        .circularEmployeeCubitCall(circularData);

                    ///
                  }
                  if (state is AddCircularEmployeeLoadFail) {
                    setState(() {
                      isLoader = false;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(commonSnackBar(
                      title: '${state.ReasonFail}',
                    ));
                    // showDialog(
                    //     context: context,
                    //     builder: (context) {
                    //       return AlertDialog(
                    //         title: Text('Something went wrong'),
                    //         actions: [
                    //           TextButton(
                    //             onPressed: () {
                    //               Navigator.pop(context);
                    //             },
                    //             child: Text('Back'),
                    //           )
                    //         ],
                    //       );
                    //     });
                  }
                },
                builder: (context, state) {
                  if (state is AddCircularEmployeeLoadInProgress) {
                    return buildSaveButton(context);
                  } else if (state is AddCircularEmployeeLoadSuccess) {
                    return buildSaveButton(context);
                  } else if (state is AddCircularEmployeeLoadFail) {
                    return buildSaveButton(context);
                  } else {
                    return buildSaveButton(context);
                  }
                },
              ),
              //buildSaveButton(context),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildSaveButton(BuildContext context) {
    return isLoader == false
        ? Container(
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
            margin:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            decoration: BoxDecoration(
              border: Border.all(width: 0.2),
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).primaryColor,
            ),
            child: InkWell(
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () {
                print(DateFormat("dd-MMM-yyyy").format(selectedDate));
                if (_key.currentState!.validate()) {
                  // print('Test');
                  //var stringList = finalClassList.join(",");
                  //Todo:Add Image
                  // File? imageFile =
                  //     File(_filePicked!.files.single.path.toString());
                  // print(FileImage(imageFile));
                  if (isChecked == true) {
                    if (finalClassList != null) {
                      sendCircular(
                        classId: UserType == 'E'
                            ? finalClassList.join(",")
                            : (UserType == 'A' || UserType == 'M')
                                ? finalClassListAdmin.join(",")
                                : finalClassListCoordinator.join(','),
                        cirCont: _controllerContent.text,
                        cirNo: "",
                        //_controllerCircularNo.text,
                        cirSub: _controllerSubject.text,
                        cirDate: DateFormat("dd-MMM-yyyy").format(selectedDate),
                        img: _filePicked,
                      );
                    }
                  } else if (bothChecked == false) {
                    sendCircular(
                      //classId: finalClassList.join(","),
                      classId: null,
                      cirCont: _controllerContent.text,
                      cirNo: "",
                      //_controllerCircularNo.text,
                      cirSub: _controllerSubject.text,
                      cirDate: DateFormat("dd-MMM-yyyy").format(selectedDate),
                      img: _filePicked,
                    );
                  }
                  //For Both
                  else {
                    sendCircular(
                      //classId: finalClassList.join(","),
                      classId: null,
                      cirCont: _controllerContent.text,
                      cirNo: "",
                      //_controllerCircularNo.text,
                      cirSub: _controllerSubject.text,
                      cirDate: DateFormat("dd-MMM-yyyy").format(selectedDate),
                      img: _filePicked,
                    );
                  }
                }
              },
              child: Text(
                'Save',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
          )
        : Container(
            child: CircularProgressIndicator(),
          );
  }

  Widget buildClassMultiSelect() {
    return Container(
      alignment: Alignment.center,
      // padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: MultiSelectBottomSheetField<ClassListEmployeeModel>(
        autovalidateMode: AutovalidateMode.disabled,
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xffECECEC)),
        ),
        key: _classSelectKey,
        initialChildSize: 0.7,
        maxChildSize: 0.95,
        searchIcon: Icon(Icons.ac_unit),
        title: Text("All Classes",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 18)),
        buttonText: Text("Select Classes"),
        // items: _items,
        items: _classEmployeeList!
            .map((teacher) => MultiSelectItem(teacher, teacher.className!))
            .toList(),
        searchable: false,
        validator: (values) {
          // if (values == null || values.isEmpty || finalClassList.isEmpty) {
          //   return "Required Field";
          // }
          //
          return null;
        },
        onConfirm: (values) {
          setState(() {
            finalClassList = [];
            _selectedClassList = [];
            _selectedClassList = values;
            //values[0].iD
          });
          // _classSelectKey.currentState!.validate();
          for (var i in _selectedClassList) {
            finalClassList.add(i.iD.toString());
            print(i.iD);
          }
          // print(_selectedClassList);
        },
        chipDisplay: MultiSelectChipDisplay(
          shape: RoundedRectangleBorder(),
          textStyle: TextStyle(
              fontWeight: FontWeight.w900,
              color: Theme.of(context).primaryColor),
          // chipColor: Colors.grey,
          // onTap: (item) {
          //   setState(() {
          //     _selectedClassList.remove(item);
          //   });
          //   _classSelectKey.currentState!.validate();
          // },
        ),
      ),
    );
  }

  Widget buildClassMultiSelectAdmin() {
    return Container(
      alignment: Alignment.center,
      // padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: MultiSelectBottomSheetField<FillClassOnlyWithSectionAdminModel>(
        autovalidateMode: AutovalidateMode.disabled,
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xffECECEC)),
        ),
        key: _classSelectKey,
        initialChildSize: 0.7,
        maxChildSize: 0.95,
        searchIcon: Icon(Icons.ac_unit),
        title: Text("All Classes",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 18)),
        buttonText: Text("Select Classes"),
        // items: _items,
        items: _classEmployeeListAdmin!
            .map((teacher) => MultiSelectItem(teacher, teacher.classname!))
            .toList(),
        searchable: false,
        validator: (values) {
          // if (values == null || values.isEmpty || finalClassListAdmin.isEmpty) {
          //   return "Required Field";
          // }
          //
          return null;
        },
        onConfirm: (values) {
          setState(() {
            finalClassListAdmin = [];
            _selectedClassListAdmin = [];
            _selectedClassListAdmin = values;
            //values[0].iD
          });
          // _classSelectKey.currentState!.validate();
          for (var i in _selectedClassListAdmin) {
            finalClassListAdmin.add(i.classId.toString());
            print(i.classId);
          }
          // print(_selectedClassList);
        },
        chipDisplay: MultiSelectChipDisplay(
          shape: RoundedRectangleBorder(),
          textStyle: TextStyle(
              fontWeight: FontWeight.w900,
              color: Theme.of(context).primaryColor),
          // chipColor: Colors.grey,
          // onTap: (item) {
          //   setState(() {
          //     _selectedClassList.remove(item);
          //   });
          //   _classSelectKey.currentState!.validate();
          // },
        ),
      ),
    );
  }

  //
  Widget buildClassMultiSelectCoordinator() {
    return Container(
      alignment: Alignment.center,
      // padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: MultiSelectBottomSheetField<ClassesForCoordinatorModel>(
        autovalidateMode: AutovalidateMode.disabled,
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xffECECEC)),
        ),
        key: _classSelectKey,
        initialChildSize: 0.7,
        maxChildSize: 0.95,
        searchIcon: Icon(Icons.ac_unit),
        title: Text("All Classes",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 18)),
        buttonText: Text("Select Classes"),
        // items: _items,
        items: _classEmployeeListCoordinator
            .map((teacher) => MultiSelectItem(teacher, teacher.className!))
            .toList(),
        searchable: false,
        validator: (values) {
          // if (values == null ||
          //     values.isEmpty ||
          //     finalClassListCoordinator.isEmpty) {
          //   return "Required Field";
          // }
          //
          return null;
        },
        onConfirm: (values) {
          setState(() {
            finalClassListCoordinator = [];
            _selectedClassListCoordinator = [];
            _selectedClassListCoordinator = values;
            //values[0].iD
          });
          // _classSelectKey.currentState!.validate();
          for (var i in _selectedClassListCoordinator) {
            finalClassListCoordinator.add(i.classId.toString());
            print(i.classId);
          }
          // print(_selectedClassList);
        },
        chipDisplay: MultiSelectChipDisplay(
          shape: RoundedRectangleBorder(),
          textStyle: TextStyle(
              fontWeight: FontWeight.w900,
              color: Theme.of(context).primaryColor),
          // chipColor: Colors.grey,
          // onTap: (item) {
          //   setState(() {
          //     _selectedClassList.remove(item);
          //   });
          //   _classSelectKey.currentState!.validate();
          // },
        ),
      ),
    );
  }

  InkWell buildDateSelector({String? selectedDate, int? index}) {
    return InkWell(
      onTap: () => _selectDate(context, index: index),
      child: internalTextForDateTime(context,
          selectedDate: selectedDate,
          width: MediaQuery.of(context).size.width * 0.48),
      // Container(
      //   width: MediaQuery.of(context).size.width * 0.48,
      //   padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      //   decoration: BoxDecoration(
      //     border: Border.all(color: Color(0xffECECEC)),
      //   ),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       Container(
      //         width: MediaQuery.of(context).size.width * 0.3,
      //         child: Text(
      //           selectedDate!,
      //           overflow: TextOverflow.visible,
      //           maxLines: 1,
      //         ),
      //       ),
      //       Icon(Icons.today, color: Theme.of(context).primaryColor)
      //     ],
      //   ),
      // ),
    );
  }

  // Text buildLabels(String label) {
  //   return Text(
  //     label,
  //     style: TextStyle(
  //       // color: Theme.of(context).primaryColor,
  //       color: Color(0xff3A3A3A),
  //       fontWeight: FontWeight.w600,
  //     ),
  //   );
  // }

  Container buildTextField({
    int? maxLines = 1,
    String? Function(String?)? validator,
    @required TextEditingController? controller,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        controller: controller,
        validator: validator,
        maxLines: maxLines ?? null,
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          //counterText: "",
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
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          // suffixIcon: suffixIcon
          //     ? InkWell(
          //         onTap: () {
          //           setState(() {
          //             _showPassword = !_showPassword;
          //           });
          //         },
          //         child: !_showPassword
          //             ? Icon(Icons.remove_red_eye_outlined)
          //             : Icon(Icons.remove_red_eye),
          //       )
          //     : null,
        ),
      ),
    );
  }

  Padding buildLabels({String? label, Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Text(label!,
        // style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Container testContainer() {
    return Container(
      child: Text("Select Classes"),
      decoration: BoxDecoration(border: Border.all(width: 0.05)),
      padding: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.055,
    );
  }
}
