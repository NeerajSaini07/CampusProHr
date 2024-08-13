import 'dart:io';
import 'package:campus_pro/src/CONSTANTS/themeData.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/CLASS_LIST_EMPLOYEE_CUBIT/class_list_employee_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/FILL_CLASS_ONLY_WITH_SECTION_ADMIN_CUBIT/fill_class_only_with_section_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/GET_CLASSWISE_SUBJECT_ADMIN_CUBIT/get_classwise_subject_admin_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/HOMEWORK_EMPLOYEE_CUBIT/homework_employee_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/SUBJECT_LIST_EMPLOYEE_CUBIT/subject_list_employee_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/Send_HomeWork_Employee_Cubit/send_homework_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/TEACHER_LIST_SUBJECT_WISE_CUBIT/teacher_list_subject_wise_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/SubjectListEmployeeModel.dart';
import 'package:campus_pro/src/DATA/MODELS/classListEmployeeModel.dart';
import 'package:campus_pro/src/DATA/MODELS/fillClassOnlyWithSectionAdminModel.dart';
import 'package:campus_pro/src/DATA/MODELS/getClasswiseSubjectAdminModel.dart';
import 'package:campus_pro/src/DATA/MODELS/teacherListSubjectWiseModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonSnackbar.dart';
import 'package:campus_pro/src/UTILS/fieldValidators.dart';
import 'package:campus_pro/src/UTILS/filePicker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

class CreateSendHomeWorkEmployee extends StatefulWidget {
  static const routeName = '/Create-Send-HomeWork-Emp';
  const CreateSendHomeWorkEmployee({Key? key}) : super(key: key);

  @override
  _CreateSendHomeWorkEmployeeState createState() =>
      _CreateSendHomeWorkEmployeeState();
}

class _CreateSendHomeWorkEmployeeState
    extends State<CreateSendHomeWorkEmployee> {
  final _classSelectKey = GlobalKey<FormFieldState>();
  // final _teacherSelectKey = GlobalKey<FormFieldState>();
  bool? checkBoxValue = false;
  bool _autoValidate = false;
  bool fileAddChecked = false;
  int noOfMale = 0;
  int noOfFemale = 0;

  List<ClassListEmployeeModel>? classDropdown;
  ClassListEmployeeModel? selectedClass;
  List<ClassListEmployeeModel>? _selectedClassList = [];
  List finalClassList = [];

  List<FillClassOnlyWithSectionAdminModel>? classDropdownAdmin;
  FillClassOnlyWithSectionAdminModel? selectedClassAdmin;
  List<FillClassOnlyWithSectionAdminModel>? _selectedClassListAdmin = [];
  List finalClassListAdmin = [];

  List<TeacherListSubjectWiseModel>? teacherDropdown = [];
  TeacherListSubjectWiseModel? selectedTeachers;
  List<TeacherListSubjectWiseModel>? _selectedTeacherList = [];
  List finalTeacherList = [];

  bool? fileLengthChecked = false;

  List<File>? _pickedImage;

  SubjectListEmployeeModel? selectedSubject;
  List<SubjectListEmployeeModel>? subjectDropdown;

  GetClasswiseSubjectAdminModel? selectedSubjectAdmin;
  List<GetClasswiseSubjectAdminModel>? subjectDropdownAdmin;

  TextEditingController _commentController = new TextEditingController();
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  int? subjectId;
  String? subjectIdAdmin;
  //var classId;
  bool? isLoader;
  String? userType;
  List empIds = [];

  Future<File?> getImage({ImageSource source = ImageSource.gallery}) async {
    Navigator.pop(context);
    final pickedFile = await ImagePicker().getImage(source: source);
    if (pickedFile != null) {
      print('Image selected.');
      final image = File(pickedFile.path);
      return image;
    } else {
      print('Ops! No Image selected.');
    }
  }

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
    print('Employee Class List $getEmpClassData');
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

  getEmployeeSubject(
      {@required String? classId,
      @required String? streamId,
      @required String? sectionId,
      @required String? yearID}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final getEmpSubData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "ClassID": classId.toString(),
      "StreamID": streamId.toString(),
      "SectionID": sectionId.toString(),
      "YearID": yearID.toString(),
      "Schoolid": userData.schoolId,
      "SessionId": userData.currentSessionid,
      "EmpId": userData.stuEmpId,
      "UserType": userData.ouserType,
      "TeacherId": userData.stuEmpId,
    };
    print('Get Employee Subject $getEmpSubData');
    context
        .read<SubjectListEmployeeCubit>()
        .subjectListEmployeeCubitCall(getEmpSubData);
  }

  getAdminSubject({String? classId}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final getSubData = {
      "OUserId": uid,
      "Token": token,
      "StuEmpId": userData!.stuEmpId,
      "OrgId": userData.organizationId,
      "Schoolid": userData.schoolId,
      "UserType": userData.ouserType,
      "ClassID": classId.toString(),
    };

    print('Get Admin Subject $getSubData');
    context
        .read<GetClasswiseSubjectAdminCubit>()
        .getClasswiseSubjectAdminCubitCall(getSubData);
  }

  sendHomeWork(
      {String? activeUser,
      String? classid,
      List<File>? img,
      String? teacherIds}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final sendHomeWorkData = {
      "OUserId": uid.toString(),
      "Token": token.toString(),
      "Usertype": userData!.ouserType.toString(),
      "orgid": userData.organizationId.toString(),
      "StuEmpId": userData.stuEmpId.toString(),
      //"classid": await classId.toString(),
      "classid": classid.toString(),
      "subjectid":
          userType == 'E' ? subjectId.toString() : subjectIdAdmin.toString(),
      "homework": _commentController.text,
      "savehomeworkasdraft": "0",
      "ToActiveUsers": activeUser.toString(),
      "sid": userData.schoolId.toString(),
      "ssid": userData.currentSessionid.toString(),
      "empid": teacherIds == ""
          ? userData.stuEmpId.toString()
          : teacherIds.toString(),
      "For": teacherIds == "" ? userData.ouserType.toString() : "e",
    };
    print('Send homework data send $sendHomeWorkData');
    context
        .read<SendHomeworkEmployeeCubit>()
        .sendHomeWorkEmployeeCubitCall(sendHomeWorkData, img);
  }

  getUserType() async {
    final userData = await UserUtils.userTypeFromCache();
    setState(() {
      userType = userData!.ouserType;
    });
  }

  getTeacherList({
    String? classId,
  }) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final teacherListData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "SessionId": userData.currentSessionid,
      "ClassId": classId.toString(),
      "SubjectId":
          userType == 'E' ? subjectId.toString() : subjectIdAdmin.toString(),
      "EmpStuId": userData.stuEmpId,
      "UserType": userData.ouserType,
    };

    context
        .read<TeacherListSubjectWiseCubit>()
        .teacherListSubjectWiseCubitCall(teacherListData);
  }

  @override
  void initState() {
    super.initState();
    getUserType();
    selectedSubject = SubjectListEmployeeModel(subjectHead: '', subjectId: -1);
    subjectDropdown = [];
    selectedClass = ClassListEmployeeModel(iD: '', className: '');
    classDropdown = [];

    selectedSubjectAdmin =
        GetClasswiseSubjectAdminModel(subjectHead: '', iD: -1);
    subjectDropdownAdmin = [];
    selectedClassAdmin =
        FillClassOnlyWithSectionAdminModel(classId: '', classname: '');
    classDropdownAdmin = [];

    getEmployeeClass();
    getClassAdmin();
    isLoader = false;
    _selectedTeacherList = [];
    teacherDropdown = [];
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, title: "Send HomeWork"),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              selectClassAndSubject(context),
              (userType == 'A' || userType == 'M')
                  ? BlocConsumer<TeacherListSubjectWiseCubit,
                      TeacherListSubjectWiseState>(
                      listener: (context, state) {
                        if (state is TeacherListSubjectWiseLoadSuccess) {
                          setState(() {
                            // state.teacherList.forEach((element) {
                            //   teacherDropdown!.add(element.name);
                            // });
                            teacherDropdown = [];
                            _selectedTeacherList = [];
                            finalTeacherList = [];
                            teacherDropdown = state.teacherList;
                          });
                        }
                      },
                      builder: (context, state) {
                        if (state is TeacherListSubjectWiseLoadInProgress) {
                          //return CircularProgressIndicator();
                          return Container();
                        } else if (state is TeacherListSubjectWiseLoadSuccess) {
                          return teacherSelect(context,
                              teacherList: teacherDropdown);
                        } else {
                          return teacherSelect(context);
                        }
                      },
                    )
                  : Container(),
              buildHomeWork(context),
            ],
          ),
        ),
      ),
    );
  }

  Column selectClassAndSubject(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10.0,
        ),
        userType == 'E'
            ? BlocConsumer<ClassListEmployeeCubit, ClassListEmployeeState>(
                listener: (context, state) {
                  if (state is ClassListEmployeeLoadSuccess) {
                    setState(() {
                      //classId = state.classList[0].iD;
                      // print(state.classList[1].iD);
                      classDropdown = state.classList;
                    });
                    //print(dropDownClassValue!.className);
                    // getEmployeeSubject(
                    //   classId: selectedClass!.iD!.split('#')[0],
                    //   streamId: selectedClass!.iD!.split('#')[1],
                    //   sectionId: selectedClass!.iD!.split('#')[2],
                    //   yearID: selectedClass!.iD!.split('#')[3],
                    // );
                  }
                  if (state is ClassListEmployeeLoadFail) {
                    if (state.failReason == "false") {
                      UserUtils.unauthorizedUser(context);
                    }
                    setState(() {
                      selectedClass =
                          ClassListEmployeeModel(iD: "", className: "");
                      classDropdown = [];
                    });
                  }
                },
                builder: (context, state) {
                  if (state is ClassListEmployeeLoadInProgress) {
                    return testContainer();
                    //return classSelect(context);
                    //return CircularProgressIndicator();
                  } else if (state is ClassListEmployeeLoadSuccess) {
                    return classSelect(context);
                  } else if (state is ClassListEmployeeLoadFail) {
                    return classSelect(context);
                  } else {
                    return Container();
                  }
                },
              )
            : BlocConsumer<FillClassOnlyWithSectionCubit,
                FillClassOnlyWithSectionState>(
                listener: (context, state) {
                  if (state is FillClassOnlyWithSectionLoadSuccess) {
                    setState(() {
                      //classId = state.classList[0].iD;
                      print(state.classList[1].classId);
                      //classId = state.classList[0].iD!.split('#')[0];
                      //selectedClass = state.classList[0];
                      classDropdownAdmin = state.classList;
                    });

                    setState(() {
                      noOfFemale = 0;
                      noOfMale = 0;
                      teacherDropdown = [];
                      _selectedTeacherList = [];
                      finalTeacherList = [];
                    });

                    //print(dropDownClassValue!.className);
                    // getEmployeeSubject(
                    //   classId: selectedClass!.iD!.split('#')[0],
                    //   streamId: selectedClass!.iD!.split('#')[1],
                    //   sectionId: selectedClass!.iD!.split('#')[2],
                    //   yearID: selectedClass!.iD!.split('#')[3],
                    // );
                  }
                  if (state is FillClassOnlyWithSectionLoadFail) {
                    if (state.failReason == "false") {
                      UserUtils.unauthorizedUser(context);
                    }

                    setState(() {
                      selectedClassAdmin = FillClassOnlyWithSectionAdminModel(
                          classId: "", classname: "", classDisplayOrder: -1);
                      classDropdownAdmin = [];
                    });
                  }
                },
                builder: (context, state) {
                  if (state is FillClassOnlyWithSectionLoadInProgress) {
                    return testContainer();
                    //return classSelectAdmin(context);
                    //return CircularProgressIndicator();
                  } else if (state is FillClassOnlyWithSectionLoadSuccess) {
                    return classSelectAdmin(context);
                  } else if (state is ClassListEmployeeLoadFail) {
                    return classSelect(context);
                  } else {
                    return Container();
                  }
                },
              ),
        // SizedBox(
        //   height: MediaQuery.of(context).size.height * 0.02,
        // ),
        //subjectSelect(context),

        userType == 'E'
            ? BlocConsumer<SubjectListEmployeeCubit, SubjectListEmployeeState>(
                listener: (context, state) {
                  if (state is SubjectListEmployeeLoadSuccess) {
                    setState(() {
                      subjectId = state.subjectList[0].subjectId;
                      selectedSubject = SubjectListEmployeeModel(
                          subjectHead: '', subjectId: -1);
                      subjectDropdown = [];
                      print(state.subjectList);
                      subjectDropdown = state.subjectList;
                      selectedSubject = state.subjectList[0];
                      _commentController.text =
                          selectedSubject!.subjectHead.toString() + " : ";
                    });
                    // setState(() {
                    //   noOfFemale = 0;
                    //   noOfMale = 0;
                    //   teacherDropdown = [];
                    //   _selectedTeacherList = [];
                    //   finalTeacherList=[];
                    // });
                    //getTeacherList(classId: finalClassList.join(","));

                  }
                  if (state is SubjectListEmployeeLoadFail) {
                    if (state.failReason == "false") {
                      UserUtils.unauthorizedUser(context);
                    }
                    setState(() {
                      subjectDropdown = [];
                      selectedSubject = SubjectListEmployeeModel(
                          subjectHead: "", subjectId: -1);
                    });
                  }
                },
                builder: (context, state) {
                  if (state is SubjectListEmployeeLoadInProgress) {
                    return subjectSelect(context);
                  } else if (state is SubjectListEmployeeLoadSuccess) {
                    return subjectSelect(context);
                  } else if (state is SubjectListEmployeeLoadFail) {
                    return subjectSelect(context);
                    //   //return Container();
                  } else {
                    return Container();
                  }
                },
              )
            : BlocConsumer<GetClasswiseSubjectAdminCubit,
                GetClasswiseSubjectAdminState>(
                listener: (context, state) {
                  if (state is GetClasswiseSubjectAdminLoadSuccess) {
                    setState(() {
                      subjectIdAdmin = state.subjectList[0].iD.toString();
                      selectedSubjectAdmin = GetClasswiseSubjectAdminModel(
                          subjectHead: '', iD: -1);
                      subjectDropdownAdmin = [];
                      print(state.subjectList);
                      subjectDropdownAdmin = state.subjectList;
                      selectedSubjectAdmin = state.subjectList[0];
                      _commentController.text =
                          selectedSubjectAdmin!.subjectHead.toString() + " : ";
                    });
                    setState(() {
                      noOfFemale = 0;
                      noOfMale = 0;
                      teacherDropdown = [];
                      _selectedTeacherList = [];
                      finalTeacherList = [];
                    });
                    getTeacherList(classId: finalClassListAdmin.join(","));
                  }
                  if (state is GetClasswiseSubjectAdminLoadFail) {
                    if (state.failReason == "false") {
                      UserUtils.unauthorizedUser(context);
                    }
                    setState(() {
                      subjectDropdownAdmin = [];
                      selectedSubjectAdmin = GetClasswiseSubjectAdminModel(
                          subjectHead: "", iD: -1);
                    });
                  }
                },
                builder: (context, state) {
                  if (state is GetClasswiseSubjectAdminLoadInProgress) {
                    return subjectSelectAdmin(context);
                  } else if (state is GetClasswiseSubjectAdminLoadSuccess) {
                    return subjectSelectAdmin(context);
                  } else if (state is GetClasswiseSubjectAdminLoadFail) {
                    return subjectSelectAdmin(context);
                    //   //return Container();
                  } else {
                    return Container();
                  }
                },
              ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.00,
        )
      ],
    );
  }

  Column subjectSelect(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 18, right: 18, bottom: 5),
          child: Text(
            'Subject',
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.width * 0.02,
        ),
        Container(
          height: 40.0,
          width: double.infinity,
          margin: EdgeInsets.only(left: 18, right: 18, bottom: 20),
          padding: EdgeInsets.symmetric(vertical: 8.0),
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xffececec)),
          ),
          child: DropdownButton<SubjectListEmployeeModel>(
            value: selectedSubject!,
            icon: const Icon(Icons.arrow_drop_down),
            hint: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                // "SELECT Subject",
                "",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            iconSize: 20,
            elevation: 16,
            isExpanded: true,
            dropdownColor: Color(0xffFFFFFF),
            style: const TextStyle(
              color: Colors.black,
              fontSize: 13.0,
            ),
            underline: Container(
              color: Color(0xffFFFFFF),
            ),
            onChanged: (newValue) {
              setState(() {
                selectedSubject = newValue;
                subjectId = selectedSubject!.subjectId;
              });
              // setState(() {
              //   noOfFemale = 0;
              //   noOfMale = 0;
              //   teacherDropdown = [];
              //   _selectedTeacherList = [];
              //   finalTeacherList = [];
              // });
              // getTeacherList(classId: finalClassList.join(","));
              _commentController.text =
                  selectedSubject!.subjectHead.toString() + " : ";
            },
            items: subjectDropdown!.map((value) {
              return DropdownMenuItem<SubjectListEmployeeModel>(
                value: value,
                child: Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    value.subjectHead.toString(),
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Column subjectSelectAdmin(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 18, right: 18, bottom: 5),
          child: Text(
            'Subject',
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.width * 0.02,
        ),
        Container(
          height: 40.0,
          width: double.infinity,
          margin: EdgeInsets.only(left: 18, right: 18, bottom: 20),
          padding: EdgeInsets.symmetric(vertical: 8.0),
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xffececec)),
          ),
          child: DropdownButton<GetClasswiseSubjectAdminModel>(
            value: selectedSubjectAdmin!,
            icon: const Icon(Icons.arrow_drop_down),
            hint: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                // "SELECT Subject",
                "",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            iconSize: 20,
            elevation: 16,
            isExpanded: true,
            dropdownColor: Color(0xffFFFFFF),
            style: const TextStyle(
              color: Colors.black,
              fontSize: 13.0,
            ),
            underline: Container(
              color: Color(0xffFFFFFF),
            ),
            onChanged: (newValue) {
              setState(() {
                selectedSubjectAdmin = newValue;
                subjectIdAdmin = selectedSubjectAdmin!.iD.toString();
              });
              setState(() {
                noOfFemale = 0;
                noOfMale = 0;
                teacherDropdown = [];
                _selectedTeacherList = [];
                finalTeacherList = [];
                _selectedTeacherList!.length = 0;
              });
              //
              _commentController.text =
                  selectedSubjectAdmin!.subjectHead.toString() + " : ";
              //
              getTeacherList(classId: finalClassListAdmin.join(","));
            },
            items: subjectDropdownAdmin!.map((value) {
              return DropdownMenuItem<GetClasswiseSubjectAdminModel>(
                value: value,
                child: Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    value.subjectHead.toString(),
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Column classSelect(BuildContext context,
      {List<ClassListEmployeeModel>? classList, String? error}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Container(
        //   margin: EdgeInsets.only(left: 18, right: 18, bottom: 5),
        //   child: Text(
        //     'Class',
        //     style: TextStyle(
        //       fontWeight: FontWeight.w600,
        //     ),
        //   ),
        // ),
        // SizedBox(
        //   height: MediaQuery.of(context).size.height * 0.01,
        // ),
        Container(
          alignment: Alignment.center,
          // padding: EdgeInsets.symmetric(horizontal: 10),
          margin: EdgeInsets.only(left: 18, right: 18, bottom: 20),
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
            items: classDropdown!
                .map((teacher) => MultiSelectItem(teacher, teacher.className!))
                .toList(),
            searchable: false,
            validator: (values) {
              if (values == null || values.isEmpty || finalClassList.isEmpty) {
                return "Required Field";
              }
              // List<String> names = values.map((e) => e.name!).toList();
              // if (names.contains("Frog")) {
              //   return "Frogs are weird!";
              // }
              return null;
            },
            onConfirm: (values) {
              if (values.length > 0) {
                setState(() {
                  teacherDropdown = [];
                  finalClassList = [];
                  _selectedClassList = values;
                  //values[0].iD
                });
                //_classSelectKey.currentState!.validate();
                for (var i in _selectedClassList!) {
                  finalClassList.add(i.iD.toString());
                  print(i.iD);
                }

                //print(finalClassList);
                String? classIds = '';
                String? streamsIds = '';
                String? sectionIds = '';
                String? yearIds = '';

                // print(ids.split('#')[0]);
                print(classIds);
                finalClassList.forEach((element) {
                  if (element != null) {
                    // classIds.add(element.split('#')[0]);
                    classIds = classIds! + element.split('#')[0] + ',';
                    print(element.split('#')[0]);
                  }
                  //print(element.split('#')[0]);
                });

                finalClassList.forEach((element) {
                  if (element != null) {
                    //streamsIds.add(element.split('#')[1]);
                    streamsIds = streamsIds! + element.split('#')[1] + ',';
                    print(element.split('#')[1]);
                  }
                  //print(element.split('#')[0]);
                });

                finalClassList.forEach((element) {
                  if (element != null) {
                    //sectionIds.add(element.split('#')[2]);
                    sectionIds = sectionIds! + element.split('#')[2] + ',';
                    print(element.split('#')[2]);
                  }
                  //print(element.split('#')[0]);
                });

                finalClassList.forEach((element) {
                  if (element != null) {
                    //yearIds.add(element.split('#')[3]);
                    yearIds = yearIds! + element.split('#')[3] + ',';
                    print(element.split('#')[3]);
                  }
                  //print(element.split('#')[0]);
                });

                // String id = '';
                // classIds.forEach((element) {
                //   id = id + element + ',';
                // });
                // print(id);
                // print(classIds);
                // print(selectedClass);

                classIds = classIds!.substring(0, classIds!.length - 1);
                sectionIds = sectionIds!.substring(0, sectionIds!.length - 1);
                streamsIds = streamsIds!.substring(0, streamsIds!.length - 1);
                yearIds = yearIds!.substring(0, yearIds!.length - 1);

                //classIds = classIds!.split(',').removeAt(0);
                print(classIds);

                getEmployeeSubject(
                  //classId: selectedClass!.iD!.split('#')[0],
                  classId: classIds,
                  // streamId: selectedClass!.iD!.split('#')[1],
                  // sectionId: selectedClass!.iD!.split('#')[2],
                  // yearID: selectedClass!.iD!.split('#')[3],
                  sectionId: sectionIds,
                  streamId: streamsIds,
                  yearID: yearIds,
                );

                // setState(() {
                //   teacherDropdown = [];
                //   _selectedTeacherList = [];
                //   finalTeacherList = [];
                // });
                // getTeacherList(classId: finalClassListAdmin.join(","));
              } else {
                getEmployeeSubject(
                  //classId: selectedClass!.iD!.split('#')[0],
                  classId: "",
                  // streamId: selectedClass!.iD!.split('#')[1],
                  // sectionId: selectedClass!.iD!.split('#')[2],
                  // yearID: selectedClass!.iD!.split('#')[3],
                  sectionId: "",
                  streamId: "",
                  yearID: "",
                );
              }
              // setState(() {
              //   teacherDropdown = [];
              //   finalClassList = [];
              //   _selectedClassList = values;
              //   //values[0].iD
              // });
              // //_classSelectKey.currentState!.validate();
              // for (var i in _selectedClassList!) {
              //   finalClassList.add(i.iD.toString());
              //   print(i.iD);
              // }
              //
              // //print(finalClassList);
              // String? classIds = '';
              // String? streamsIds = '';
              // String? sectionIds = '';
              // String? yearIds = '';
              //
              // // print(ids.split('#')[0]);
              // print(classIds);
              // finalClassList.forEach((element) {
              //   if (element != null) {
              //     // classIds.add(element.split('#')[0]);
              //     classIds = classIds! + element.split('#')[0] + ',';
              //     print(element.split('#')[0]);
              //   }
              //   //print(element.split('#')[0]);
              // });
              //
              // finalClassList.forEach((element) {
              //   if (element != null) {
              //     //streamsIds.add(element.split('#')[1]);
              //     streamsIds = streamsIds! + element.split('#')[1] + ',';
              //     print(element.split('#')[1]);
              //   }
              //   //print(element.split('#')[0]);
              // });
              //
              // finalClassList.forEach((element) {
              //   if (element != null) {
              //     //sectionIds.add(element.split('#')[2]);
              //     sectionIds = sectionIds! + element.split('#')[2] + ',';
              //     print(element.split('#')[2]);
              //   }
              //   //print(element.split('#')[0]);
              // });
              //
              // finalClassList.forEach((element) {
              //   if (element != null) {
              //     //yearIds.add(element.split('#')[3]);
              //     yearIds = yearIds! + element.split('#')[3] + ',';
              //     print(element.split('#')[3]);
              //   }
              //   //print(element.split('#')[0]);
              // });
              //
              // // String id = '';
              // // classIds.forEach((element) {
              // //   id = id + element + ',';
              // // });
              // // print(id);
              // // print(classIds);
              // // print(selectedClass);
              //
              // classIds = classIds!.substring(0, classIds!.length - 1);
              // sectionIds = sectionIds!.substring(0, sectionIds!.length - 1);
              // streamsIds = streamsIds!.substring(0, streamsIds!.length - 1);
              // yearIds = yearIds!.substring(0, yearIds!.length - 1);
              //
              // //classIds = classIds!.split(',').removeAt(0);
              // print(classIds);
              //
              // getEmployeeSubject(
              //   //classId: selectedClass!.iD!.split('#')[0],
              //   classId: classIds,
              //   // streamId: selectedClass!.iD!.split('#')[1],
              //   // sectionId: selectedClass!.iD!.split('#')[2],
              //   // yearID: selectedClass!.iD!.split('#')[3],
              //   sectionId: sectionIds,
              //   streamId: streamsIds,
              //   yearID: yearIds,
              // );
              //
              // // setState(() {
              // //   teacherDropdown = [];
              // //   _selectedTeacherList = [];
              // //   finalTeacherList = [];
              // // });
              // // getTeacherList(classId: finalClassListAdmin.join(","));
            },
            chipDisplay: MultiSelectChipDisplay(
              onTap: (value) {
                ///
                setState(() {
                  finalClassList = [];

                  _selectedClassList!.remove(value);
                });
                for (var i in _selectedClassList!) {
                  finalClassList.add(i.iD.toString());
                  print(i.iD);
                }

                //print(finalClassList);
                String? classIds = '';
                String? streamsIds = '';
                String? sectionIds = '';
                String? yearIds = '';

                // print(ids.split('#')[0]);
                print(classIds);
                finalClassList.forEach((element) {
                  if (element != null) {
                    // classIds.add(element.split('#')[0]);
                    classIds = classIds! + element.split('#')[0] + ',';
                    print(element.split('#')[0]);
                  }
                  //print(element.split('#')[0]);
                });

                finalClassList.forEach((element) {
                  if (element != null) {
                    //streamsIds.add(element.split('#')[1]);
                    streamsIds = streamsIds! + element.split('#')[1] + ',';
                    print(element.split('#')[1]);
                  }
                  //print(element.split('#')[0]);
                });

                finalClassList.forEach((element) {
                  if (element != null) {
                    //sectionIds.add(element.split('#')[2]);
                    sectionIds = sectionIds! + element.split('#')[2] + ',';
                    print(element.split('#')[2]);
                  }
                  //print(element.split('#')[0]);
                });

                finalClassList.forEach((element) {
                  if (element != null) {
                    //yearIds.add(element.split('#')[3]);
                    yearIds = yearIds! + element.split('#')[3] + ',';
                    print(element.split('#')[3]);
                  }
                  //print(element.split('#')[0]);
                });

                // String id = '';
                // classIds.forEach((element) {
                //   id = id + element + ',';
                // });
                // print(id);
                // print(classIds);
                // print(selectedClass);

                classIds = classIds!.substring(0, classIds!.length - 1);
                sectionIds = sectionIds!.substring(0, sectionIds!.length - 1);
                streamsIds = streamsIds!.substring(0, streamsIds!.length - 1);
                yearIds = yearIds!.substring(0, yearIds!.length - 1);

                //classIds = classIds!.split(',').removeAt(0);
                print(classIds);

                getEmployeeSubject(
                  //classId: selectedClass!.iD!.split('#')[0],
                  classId: classIds,
                  // streamId: selectedClass!.iD!.split('#')[1],
                  // sectionId: selectedClass!.iD!.split('#')[2],
                  // yearID: selectedClass!.iD!.split('#')[3],
                  sectionId: sectionIds,
                  streamId: streamsIds,
                  yearID: yearIds,
                );
              },
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
        )
      ],
    );
  }

  Column classSelectAdmin(BuildContext context,
      {List<FillClassOnlyWithSectionAdminModel>? classList, String? error}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Container(
        //   margin: EdgeInsets.only(left: 18, right: 18, bottom: 5),
        //   child: Text(
        //     'Class',
        //     style: TextStyle(
        //       fontWeight: FontWeight.w600,
        //     ),
        //   ),
        // ),
        // SizedBox(
        //   height: MediaQuery.of(context).size.height * 0.01,
        // ),
        Container(
          alignment: Alignment.center,
          // padding: EdgeInsets.symmetric(horizontal: 10),
          margin: EdgeInsets.only(left: 18, right: 18, bottom: 20),
          child:
              MultiSelectBottomSheetField<FillClassOnlyWithSectionAdminModel>(
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
            items: classDropdownAdmin!
                .map((teacher) => MultiSelectItem(teacher, teacher.classname!))
                .toList(),
            searchable: false,
            validator: (values) {
              if (values == null ||
                  values.isEmpty ||
                  finalClassListAdmin.isEmpty) {
                return "Required Field";
              }
              // List<String> names = values.map((e) => e.name!).toList();
              // if (names.contains("Frog")) {
              //   return "Frogs are weird!";
              // }
              return null;
            },
            onConfirm: (values) {
              setState(() {
                teacherDropdown = [];
                finalTeacherList = [];
                _selectedTeacherList = [];
                finalClassListAdmin = [];
                _selectedClassListAdmin = values;
                //values[0].iD
              });
              //_classSelectKey.currentState!.validate();
              for (var i in _selectedClassListAdmin!) {
                finalClassListAdmin.add(i.classId.toString());
                print(i.classId);
              }

              getAdminSubject(classId: finalClassListAdmin.join(","));
            },
            chipDisplay: MultiSelectChipDisplay(
              onTap: (value) {
                setState(() {
                  teacherDropdown = [];
                  finalTeacherList = [];
                  _selectedTeacherList = [];
                  finalClassListAdmin = [];
                  _selectedClassListAdmin!.remove(value);
                  //values[0].iD
                });
                //_classSelectKey.currentState!.validate();
                for (var i in _selectedClassListAdmin!) {
                  finalClassListAdmin.add(i.classId.toString());
                  print(i.classId);
                }

                getAdminSubject(classId: finalClassListAdmin.join(","));
              },
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
        )
      ],
    );
  }

  Column teacherSelect(BuildContext context,
      {List? teacherList, String? error}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 18, right: 18, bottom: 5),
          child: Text(
            'Selected One Teacher (M:$noOfMale} /F:$noOfFemale)',
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
        Container(
          alignment: Alignment.center,
          // padding: EdgeInsets.symmetric(horizontal: 10),
          margin: EdgeInsets.only(left: 18, right: 18, bottom: 20),
          child: MultiSelectBottomSheetField<TeacherListSubjectWiseModel>(
            autovalidateMode: AutovalidateMode.disabled,
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xffECECEC)),
            ),
            //key: _teacherSelectKey,
            initialChildSize: 0.7,
            maxChildSize: 0.95,
            searchIcon: Icon(Icons.ac_unit),
            title: Text("All Teacher",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 18)),
            buttonText: Text("Select Teacher"),
            // items: _items,
            items: teacherDropdown!
                .map((teacher) => MultiSelectItem<TeacherListSubjectWiseModel>(
                    teacher, teacher.name!))
                .toList(),
            searchable: false,
            // validator: (values) {
            //   if (values == null ||
            //       values.isEmpty ||
            //       finalTeacherList.isEmpty) {
            //     return "Required Field";
            //   }
            //
            //   return null;
            // },
            onConfirm: (values) {
              setState(() {
                noOfMale = 0;
                noOfFemale = 0;
                _selectedTeacherList = values;
                //values[0].iD
              });
              print('no of teacher present ');
              print(values.length);
              _selectedTeacherList!.forEach((element) {
                print(element.name);
              });
              if (_selectedTeacherList!.length < 2) {
                setState(() {
                  values.forEach((element) {
                    element.gender == 'MALE' ? noOfMale += 1 : noOfFemale += 1;
                  });
                  finalTeacherList = [];
                });
                //_classSelectKey.currentState!.validate();
                for (var i in _selectedTeacherList!) {
                  finalTeacherList.add(i.empId.toString());
                }
              } else {
                _selectedTeacherList!.length = 0;
                _selectedTeacherList = [];
                teacherDropdown = [];
                // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                //   content: const Text('Select Only One Teacher'),
                //   backgroundColor: Colors.lightBlue,
                //   duration: const Duration(seconds: 1),
                //   // action: SnackBarAction(
                //   //   label: 'ACTION',
                //   //   onPressed: () {},
                //   // ),
                // ));
                ScaffoldMessenger.of(context).showSnackBar(
                  commonSnackBar(
                    title: "Select Only One Teacher",
                    duration: Duration(seconds: 1),
                  ),
                );

                getTeacherList(classId: finalClassListAdmin.join(","));
              }
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
        )
      ],
    );
  }

  //Container(
  //   height: 40.0,
  //   width: double.infinity,
  //   //width: MediaQuery.of(context).size.width / 2,
  //   padding: EdgeInsets.symmetric(vertical: 8.0),
  //   decoration: BoxDecoration(
  //     border: Border.all(color: Color(0xffECECEC)),
  //   ),
  //   child: DropdownButton<ClassListEmployeeModel>(
  //     value: selectedClass!,
  //     icon: const Icon(Icons.arrow_drop_down),
  //     hint: Padding(
  //       padding: const EdgeInsets.only(left: 8.0),
  //       child: Text(
  //         "SELECT CLASS",
  //         style: TextStyle(
  //           fontWeight: FontWeight.w600,
  //         ),
  //       ),
  //     ),
  //     iconSize: 20,
  //     elevation: 16,
  //     isExpanded: true,
  //     dropdownColor: Color(0xffFFFFFF),
  //     style: const TextStyle(
  //       color: Colors.black,
  //       fontSize: 13.0,
  //     ),
  //     underline: Container(
  //       color: Color(0xffFFFFFF),
  //     ),
  //     onChanged: (newValue) {
  //       setState(() {
  //         selectedClass = newValue!;
  //         //classId = dropDownClassValue!.iD!.split('#')[0];
  //         classId = selectedClass!.iD;
  //       });
  //       print(selectedClass!.iD!.split('#')[0]);
  //       selectedSubject =
  //           SubjectListEmployeeModel(subjectHead: '', subjectId: '');
  //       subjectDropdown = [];
  //       getEmployeeSubject(
  //         classId: selectedClass!.iD!.split('#')[0],
  //         streamId: selectedClass!.iD!.split('#')[1],
  //         sectionId: selectedClass!.iD!.split('#')[2],
  //         yearID: selectedClass!.iD!.split('#')[3],
  //       );
  //     },
  //     items: classDropdown!
  //         .map((item) => DropdownMenuItem<ClassListEmployeeModel>(
  //               value: item,
  //               child: Padding(
  //                 padding: EdgeInsets.only(left: 8.0),
  //                 child: Text(
  //                   item.className!,
  //                   style: TextStyle(
  //                       fontSize: 15.0, fontWeight: FontWeight.w300),
  //                 ),
  //               ),
  //             ))
  //         .toList(),
  //     // items: classList
  //     //     .map<DropdownMenuItem<ClassListEmployeeModel>>((String value) {
  //     //   return DropdownMenuItem<ClassListEmployeeModel>(
  //     //     value: value,
  //     //     child: Padding(
  //     //       padding: EdgeInsets.only(left: 8.0),
  //     //       child: Text(
  //     //         value,
  //     //         style: TextStyle(
  //     //             fontSize: 15.0, fontWeight: FontWeight.w300),
  //     //       ),
  //     //     ),
  //     //   );
  //     // }).toList(),
  //   ),
  // ),

  Column buildHomeWork(BuildContext context) {
    return Column(
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 8),
              padding: EdgeInsets.only(left: 8),
              child: Text(
                'HomeWork',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(8),
              child: TextFormField(
                cursorColor: Colors.black,
                maxLines: 5,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Color(0xff323643),
                ),
                controller: _commentController,
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
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10.0),
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
                validator: FieldValidators.globalValidator,
                // validator: (String? value) {
                //   if (value!.isEmpty) {
                //     return 'Please Enter Comment';
                //   }
                //   return null;
                // },
              ),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(left: 18, right: 18, top: 7, bottom: 10),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              border: Border.all(width: 0.1, color: Colors.blueGrey)),
          child: Row(
            children: [
              Checkbox(
                value: checkBoxValue,
                fillColor: MaterialStateProperty.all(Colors.blue),
                onChanged: (bool? val) {
                  setState(() {
                    checkBoxValue = val;
                  });
                },
              ),
              Text(
                'SMS Active user in App.',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        buildImageUpload(context),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        BlocConsumer<SendHomeworkEmployeeCubit, SendHomeworkState>(
          listener: (context, state) async {
            if (state is SendHomeworkLoadInProgress) {
              setState(() {
                isLoader = true;
              });
            }
            if (state is SendHomeworkLoadSuccess) {
              setState(() {
                isLoader = false;
                _commentController.text = "";
                _pickedImage = null;
                classDropdown = [];
                finalClassList = [];
                //_selectedClassList = [];
                checkBoxValue = false;
                teacherDropdown = [];
                _selectedTeacherList = [];
                finalClassListAdmin = [];
                classDropdownAdmin = [];
              });
              // showDialog(
              //     context: context,
              //     builder: (context) {
              //       return AlertDialog(
              //         title: Text('HomeWork Sent'),
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
                  title: 'HomeWork Sent', duration: Duration(seconds: 1)));
              getEmployeeClass();
              getClassAdmin();

              //Todo:
              final uid = await UserUtils.idFromCache();
              final token = await UserUtils.userTokenFromCache();
              final userData = await UserUtils.userTypeFromCache();
              final homeworkData = {
                'OUserId': uid,
                'Token': token,
                'OrgId': userData!.organizationId,
                'Schoolid': userData.schoolId,
                'subjectid': "0",
                'ClassId': "",
                'streamid': "",
                'sectionid': "",
                'yearid': "",
                'TeacherId': userData.stuEmpId,
                'StuEmpId': userData.stuEmpId,
                'FromDate': DateFormat("dd-MMM-yyyy").format(DateTime.now()),
                'ToDate': DateFormat("dd-MMM-yyyy").format(DateTime.now()),
                'TUsertype': "e",
                'OUserType': userData.ouserType,
              };
              context
                  .read<HomeworkEmployeeCubit>()
                  .homeworkEmployeeCubitCall(homeworkData);
            }
            if (state is SendHomeworkLoadFail) {
              if (state.failReason == "false") {
                UserUtils.unauthorizedUser(context);
              }
              setState(() {
                isLoader = false;
              });
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Something went wrong'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Back'),
                        )
                      ],
                    );
                  });
            }
          },
          builder: (context, state) {
            if (state is SendHomeworkLoadInProgress) {
              return buildSearchButton(context);
            } else if (state is SendHomeworkLoadSuccess) {
              return buildSearchButton(context);
            } else if (state is SendHomeworkLoadFail) {
              return buildSearchButton(context);
            } else {
              return buildSearchButton(context);
            }
          },
        ),
        //buildSearchButton(context),
      ],
    );
  }

  Widget buildSearchButton(BuildContext context) {
    return isLoader == false
        ? TextButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all(
                EdgeInsets.only(
                  top: 12,
                  left: 40,
                  bottom: 10,
                  right: 40,
                ),
              ),
              backgroundColor:
                  MaterialStateProperty.all(Theme.of(context).primaryColor),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                print('Hello');
                sendHomeWork(
                    activeUser: checkBoxValue == false ? "N" : "Y",
                    classid: userType == 'E'
                        ? finalClassList.join(",")
                        : finalClassListAdmin.join(","),
                    img: _pickedImage,
                    teacherIds: finalTeacherList.join(","));
              }
            },
            child: Text(
              "Send",
              textScaleFactor: 1.1,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          )
        :
        // ? Container(
        //     padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
        //     margin:
        //         const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        //     height: MediaQuery.of(context).size.height * 0.05,
        //     decoration: BoxDecoration(
        //       border: Border.all(width: 0.2),
        //       borderRadius: BorderRadius.circular(20),
        //       color: Theme.of(context).primaryColor,
        //     ),
        //     child: InkWell(
        //       hoverColor: Colors.transparent,
        //       focusColor: Colors.transparent,
        //       highlightColor: Colors.transparent,
        //       splashColor: Colors.transparent,
        //       onTap: () {
        //         if (_formKey.currentState!.validate()) {
        //           print('Hello');
        //           sendHomeWork(
        //               activeUser: checkBoxValue == false ? "N" : "Y",
        //               classid: userType == 'E'
        //                   ? finalClassList.join(",")
        //                   : finalClassListAdmin.join(","),
        //               img: _pickedImage,
        //               teacherIds: finalTeacherList.join(","));
        //         }
        //       },
        //       child: Text(
        //         'Send',
        //         style: TextStyle(
        //             color: Colors.white,
        //             fontWeight: FontWeight.w600,
        //             fontSize: 16),
        //       ),
        //     ),
        //   )
        Container(
            child: CircularProgressIndicator(),
          );
  }

  // showUploadSheet() {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (context) {
  //       return Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: <Widget>[
  //           Padding(
  //             padding: const EdgeInsets.only(top: 20),
  //             child: Text(
  //               "Upload via",
  //               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
  //             ),
  //           ),
  //           Container(
  //             width: MediaQuery.of(context).size.width,
  //             margin: const EdgeInsets.symmetric(vertical: 60),
  //             child: Row(
  //               children: [
  //                 buildUploadOption(
  //                   context,
  //                   icon: Icons.camera_alt,
  //                   title: "Camera",
  //                   onTap: () async {
  //                     File? tempFile =
  //                         await getImage(source: ImageSource.camera);
  //                     if (mounted && tempFile != null) {
  //                       setState(() {
  //                         _pickedImage = tempFile;
  //                       });
  //                       //print('File Name $_pickedImage');
  //                     }
  //                   },
  //                 ),
  //                 buildUploadOption(
  //                   context,
  //                   icon: Icons.photo_library,
  //                   title: "Gallery",
  //                   onTap: () async {
  //                     File? tempFile =
  //                         await getImage(source: ImageSource.gallery);
  //                     if (mounted && tempFile != null) {
  //                       setState(() {
  //                         _pickedImage = tempFile;
  //                       });
  //                     }
  //                   },
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  Expanded buildUploadOption(BuildContext context,
      {IconData? icon, String? title, void Function()? onTap}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, color: accentColor, size: 28), //TODO
            Text(
              title.toString(),
              textScaleFactor: 1.0,
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  Padding buildImageUpload(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          buildLabels("Upload File : "),
          fileLengthChecked == true
              ? Center(
                  child: Container(
                    margin: EdgeInsets.all(4),
                    child: Text(
                      'Only 5 images are allowed',
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                          fontSize: 15),
                    ),
                  ),
                )
              : Container(),
          _pickedImage != null
              ? Row(
                  children: [
                    for (int i = 0; i < _pickedImage!.length; i++)
                      Column(
                        children: [
                          IconButton(
                            constraints: BoxConstraints(),
                            onPressed: () {
                              setState(() {
                                _pickedImage!.removeAt(i);
                                _pickedImage!.length == 0
                                    ? _pickedImage = null
                                    : _pickedImage = _pickedImage;
                              });
                            },
                            icon: Icon(
                              Icons.cancel_outlined,
                              color: Colors.red,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) {
                                    return DetailScreen(
                                      selImg: _pickedImage![i],
                                    );
                                  },
                                ),
                              );
                            },
                            child: Hero(
                              tag: 'imageHero',
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.09,
                                width: MediaQuery.of(context).size.width * 0.18,
                                decoration: new BoxDecoration(
                                  color: Color(0xffFAFAFA),
                                  border: Border.all(
                                    width: 1,
                                    style: BorderStyle.solid,
                                    color: Color(0xffECECEC),
                                  ),
                                ),
                                child: _pickedImage![i]
                                            .path
                                            .split(".")
                                            .last
                                            .toLowerCase() !=
                                        'pdf'
                                    ? Image.file(_pickedImage![i],
                                        fit: BoxFit.cover)
                                    : Text(
                                        '${_pickedImage![i].path.split("/").last}',
                                        // 'PDF:${_pickedImage![i].path.split("/").last}',
                                        //overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.pink,
                                            fontWeight: FontWeight.w600),
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    _pickedImage!.length > 0 && _pickedImage!.length < 5
                        ? Column(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                              ),
                              IconButton(
                                onPressed: () async {
                                  var file = await showFilePicker();

                                  setState(() {
                                    if (file != null) {
                                      file.forEach((element) {
                                        _pickedImage!.add(element);
                                      });
                                    }
                                    _pickedImage!.length < 6
                                        ? {fileLengthChecked = false}
                                        : {
                                            _pickedImage = null,
                                            fileLengthChecked = true
                                          };
                                    print(_pickedImage);
                                  });
                                },
                                constraints: BoxConstraints(),
                                icon: Icon(Icons.add_circle_outline),
                              ),
                            ],
                          )
                        : Container()
                  ],
                )
              : GestureDetector(
                  onTap: () async {
                    var file = await showFilePicker();
                    if (file != null) {
                      setState(() {
                        file.length < 6
                            ? {_pickedImage = file, fileLengthChecked = false}
                            : {_pickedImage = null, fileLengthChecked = true};
                        print(_pickedImage);
                      });
                    }
                  },
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          border: Border.all(width: 0.2),
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.green),
                      child: Center(
                        child: Text(
                          'Upload upto 5 Files',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
          _pickedImage != null ? Container() : Container(),
        ],
      ),
    );
  }

  Padding buildLabels(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Text(
        label,
        style: TextStyle(
          // color: Theme.of(context).primaryColor,
          color: Color(0xff313131),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Column testContainer() {
    return Column(
      children: [
        Container(
          child: Text("Select Classes"),
          decoration: BoxDecoration(border: Border.all(width: 0.05)),
          padding: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.062,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        )
      ],
    );
  }
}

class DetailScreen extends StatefulWidget {
  final selImg;

  DetailScreen({
    this.selImg,
  });

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InteractiveViewer(
        panEnabled: false, // Set it to false
        boundaryMargin: EdgeInsets.all(100),
        minScale: 0.5,
        maxScale: 2,
        child: GestureDetector(
          child: Center(
            child: Hero(
                tag: 'imageHero',
                child: widget.selImg.path.split('.').last.toLowerCase() != 'pdf'
                    ? Image.file(
                        widget.selImg,
                      )
                    : Text(
                        '${widget.selImg.path.split('/').last}',
                        style: TextStyle(
                            color: Colors.lightBlue,
                            fontWeight: FontWeight.w600,
                            fontSize: 20),
                      )
                // Image.file(
                //   widget.selImg,
                // ),
                ),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
