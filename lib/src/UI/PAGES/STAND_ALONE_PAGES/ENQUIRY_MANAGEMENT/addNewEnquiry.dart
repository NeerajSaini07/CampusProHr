import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/RESULT_ANNOUNCE_CLASS_CUBIT/result_announce_class_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/UPDATE_NEW_ENQUIRY_CUBIT/add_new_enquiry_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/YEAR_SESSION_CUBIT/year_session_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/resultAnnounceClassModel.dart';
import 'package:campus_pro/src/DATA/MODELS/viewEnquiryModel.dart';
import 'package:campus_pro/src/DATA/MODELS/yearSessionModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonSnackbar.dart';
import 'package:campus_pro/src/UI/WIDGETS/sessionCreator.dart';
import 'package:campus_pro/src/UTILS/fieldValidators.dart';
import 'package:campus_pro/src/WIDGETS_STYLE/style_common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewEnquiry extends StatefulWidget {
  static const routeName = '/add-new-enquiry';
  final ViewEnquiryModel? updateData;
  const AddNewEnquiry({Key? key, this.updateData}) : super(key: key);

  @override
  _AddNewEnquiryState createState() => _AddNewEnquiryState();
}

class _AddNewEnquiryState extends State<AddNewEnquiry> {
  final _enquiryFormKey = GlobalKey<FormState>();
  TimeOfDay? selectedTime = TimeOfDay.now();

  bool showAddChildBox = false;
  bool isChildUpdate = false;
  int childIndex = -1;

  List<ChildrenDummy> childrenList = [];

  bool submitButtonLoader = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController fatherNameController = TextEditingController();
  TextEditingController motherNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController schoolNameController = TextEditingController();
  TextEditingController commentController = TextEditingController();

  bool showLoader = false;

  bool checkBoxValue = false;

  String _selectedGender = "MALE";

  ResultAnnounceClassModel? _selectedClass;

  int? _selectedStatus = 0;

  List<ResultAnnounceClassModel>? classDropdown = [];

  final _formKey = GlobalKey<FormState>();
  final _enquiryForm = GlobalKey<FormState>();

  InkWell buildDateSelector({String? selectedDate}) {
    return InkWell(
        onTap: () => _selectDate(context),
        child: internalTextForDateTime(context,
            selectedDate: selectedDate,
            width: MediaQuery.of(context).size.width * 0.4));
  }

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context, {int? index}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1947),
      lastDate: DateTime(2101),
      helpText: "SELECT DATE",
    );
    if (picked != null) {
      if (widget.updateData != null) {
        setState(() {
          widget.updateData!.enquiryDate =
              DateFormat("dd-MMM-yyyy").format(picked);
        });
      } else {
        setState(() {
          selectedDate = picked;
        });
      }
    }
  }

  @override
  void initState() {
    if (widget.updateData != null)
      setUpdateData(widget.updateData);
    else
      print("updateData is null");
    setState(() {
      _selectedClass = ResultAnnounceClassModel(id: "", className: "");
    });
    getSession();
    getClassList();
    super.initState();
  }

  setUpdateData(ViewEnquiryModel? updateData) async {
    print("className ${updateData!.className}");
    setState(() {
      childrenList.add(ChildrenDummy(
          iD: 0,
          stuName: updateData.name,
          className: updateData.className,
          gender: 'MALE'));
      selectedEnquiryType = updateData.enquiryType;
      // selectedSession =
      fatherNameController.text = updateData.fatherName!;
      motherNameController.text = updateData.motherName!;
      phoneController.text = updateData.guardianMobileNo!;
      emailController.text = updateData.emailID!;
      addressController.text = updateData.presentAddress!;
      schoolNameController.text = updateData.oldSchoolName!;
      commentController.text = updateData.comments!;
      _selectedStatus = updateData.status!;
    });
  }

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
      "classteacher": "1",
      "SessionId": userData.currentSessionid,
    };

    context
        .read<ResultAnnounceClassCubit>()
        .resultAnnounceClassCubitCall(sendingClassData);
  }

  getSession() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final sendingSessionData = {
      "OUserId": uid!,
      "Token": token,
      "EmpId": userData!.stuEmpId,
      "OrgID": userData.organizationId,
      "SchoolID": userData.schoolId,
      "UserType": userData.ouserType,
    };
    print('Sending YearSession data $sendingSessionData');
    context.read<YearSessionCubit>().yearSessionCubitCall(sendingSessionData);
  }

  @override
  void dispose() {
    nameController.dispose();
    fatherNameController.dispose();
    motherNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    addressController.dispose();
    schoolNameController.dispose();
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, title: 'Add New Enquiry'),
      body: MultiBlocListener(
        listeners: [
          BlocListener<YearSessionCubit, YearSessionState>(
            listener: (context, state) {
              if (state is YearSessionLoadSuccess) {
                final session = getCustomYear();
                Future.delayed(Duration(microseconds: 300));
                setState(() {
                  sessionDropdown = state.yearSessionList;
                  final index = sessionDropdown!
                      .indexWhere((element) => element.sessionFrom == session);
                  selectedSession = sessionDropdown![index];
                  print("yearDropdown![index] : ${sessionDropdown![index]}");
                });

                getClassList();
              }
              if (state is YearSessionLoadFail) {
                setState(() {
                  sessionDropdown = [];
                  selectedSession = null;
                });
              }
            },
          ),
          BlocListener<ResultAnnounceClassCubit, ResultAnnounceClassState>(
            listener: (context, state) {
              if (state is ResultAnnounceClassLoadSuccess) {
                setState(() {
                  classDropdown = state.classList;
                  _selectedClass = null;
                });
                //print(dropDownClassValue!.className);
              }
              if (state is ResultAnnounceClassLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                } else {
                  setState(() {
                    _selectedClass =
                        ResultAnnounceClassModel(id: "", className: "");
                    classDropdown = [];
                  });
                }
              }
            },
          ),
          BlocListener<AddNewEnquiryCubit, AddNewEnquiryState>(
              listener: (context, state) {
            if (state is AddNewEnquiryLoadInProgress) {
              setState(() {
                submitButtonLoader = true;
              });
            }
            if (state is AddNewEnquiryLoadSuccess) {
              setState(() {
                submitButtonLoader = false;
              });
              Future.delayed(Duration(seconds: 1))
                  .then((value) => Navigator.pop(context));
            }
            if (state is AddNewEnquiryLoadFail) {
              if (state.failReason == "false") {
                UserUtils.unauthorizedUser(context);
              } else {
                setState(() {
                  submitButtonLoader = false;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                    commonSnackBar(title: "$SOMETHING_WENT_WRONG"));
              }
            }
          }),
        ],
        child: Form(
          key: _enquiryFormKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      buildTypeDropdown(context),
                      SizedBox(width: 20),
                      buildSessionDropdown(context),
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                  color: Color(0xffDAECFE),
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(4.0),
                  child: buildLabels(
                      label: 'Childrens Information',
                      widget: widget.updateData == null
                          ? Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() => showAddChildBox = true);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      "Add New",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Container()),
                ),
                if (showAddChildBox)
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Student Name",
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Color(0xff313131),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4.0),
                        buildTextField(
                          controller: nameController,
                          validator: FieldValidators.globalValidator,
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          "Gender",
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Color(0xff313131),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            buildRadioText(
                                title: "MALE",
                                value: "MALE",
                                groupValue: _selectedGender),
                            buildRadioText(
                                title: "FEMALE",
                                value: "FEMALE",
                                groupValue: _selectedGender),
                          ],
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          "Class",
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Color(0xff313131),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4.0),
                        buildClassDropdown(context),
                        SizedBox(height: 16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            buildAddButtons(
                              title: "Discard",
                              color: Colors.white,
                              bgColor: Colors.redAccent,
                              onTap: () {
                                setState(() {
                                  showAddChildBox = false;
                                  _selectedClass = null;
                                  nameController.text = "";
                                });
                              },
                            ),
                            buildAddButtons(
                              title: isChildUpdate ? "Update" : "Save",
                              color: Colors.white,
                              bgColor: Colors.green,
                              onTap: () {
                                setState(() {
                                  if (isChildUpdate) {
                                    childrenList[childIndex].stuName =
                                        nameController.text;
                                    childrenList[childIndex].className =
                                        _selectedClass!.className!;
                                    childrenList[childIndex].gender =
                                        _selectedGender;
                                    childrenList[childIndex].iD =
                                        int.tryParse(_selectedClass!.id!);
                                  } else {
                                    childrenList.add(ChildrenDummy(
                                      stuName: nameController.text,
                                      className: _selectedClass!.className!,
                                      gender: _selectedGender,
                                      iD: int.tryParse(_selectedClass!.id!),
                                    ));
                                  }
                                  isChildUpdate = false;
                                  showAddChildBox = false;
                                  nameController.text = "";
                                  _selectedClass = null;
                                  _selectedGender = "MALE";
                                  childIndex = -1;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                if (childrenList.isNotEmpty)
                  buildChildrenListBody()
                else
                  SizedBox(
                    height: 10,
                  ),
                Container(
                  color: Color(0xffDAECFE),
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(4.0),
                  child: buildLabels(label: 'Personal Information'),
                ),
                buildEnquiryForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  int? selectedEnquiryType = 0;

  Expanded buildTypeDropdown(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          buildLabels(label: "Enquiry Type"),
          SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButton<int>(
              isDense: true,
              hint: Text("Select", style: TextStyle(fontSize: 12)),
              value: selectedEnquiryType,
              key: UniqueKey(),
              isExpanded: true,
              underline: Container(),
              items: [0, 4, 3, 1, 2]
                  .map((indexDD) => DropdownMenuItem<int>(
                      child: Text(
                        indexDD == 0
                            ? 'Select'
                            : indexDD == 1
                                ? 'Vistors'
                                : indexDD == 2
                                    ? 'Phone'
                                    : indexDD == 3
                                        ? 'Email'
                                        : indexDD == 4
                                            ? 'Online'
                                            : "",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      value: indexDD))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  selectedEnquiryType = val;
                  print("selectedEnquiryType: $val");
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  YearSessionModel? selectedSession;
  List<YearSessionModel>? sessionDropdown = [];

  Expanded buildSessionDropdown(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          buildLabels(label: "Session"),
          SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButton<YearSessionModel>(
              isDense: true,
              value: selectedSession,
              key: UniqueKey(),
              isExpanded: true,
              underline: Container(),
              items: sessionDropdown!
                  .map((item) => DropdownMenuItem<YearSessionModel>(
                      child: Text(
                        item.sessionFrom!,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      value: item))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  selectedSession = val;
                  print("selectedSession: $val");
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Container buildClassDropdown(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        // borderRadius: BorderRadius.circular(4),
      ),
      child: DropdownButton<ResultAnnounceClassModel>(
        isDense: true,
        value: _selectedClass,
        key: UniqueKey(),
        hint: Text("Select", style: TextStyle(fontSize: 14)),
        isExpanded: true,
        underline: Container(),
        items: classDropdown!
            .map((item) => DropdownMenuItem<ResultAnnounceClassModel>(
                child: Text(item.className!,
                    style: TextStyle(
                      fontSize: 14,
                    )),
                value: item))
            .toList(),
        onChanged: (val) {
          setState(() {
            _selectedClass = val;
            print("_selectedClass: $val");
          });
        },
      ),
    );
  }

  Form buildEnquiryForm() {
    return Form(
      key: _enquiryForm,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildLabels(label: 'Father Name'),
            SizedBox(height: 10.0),
            buildTextField(
                controller: fatherNameController,
                validator: FieldValidators.globalValidator),
            SizedBox(height: 10.0),
            buildLabels(label: 'Mother Name'),
            SizedBox(height: 10.0),
            buildTextField(
                controller: motherNameController,
                validator: FieldValidators.globalValidator),
            SizedBox(height: 10.0),
            buildLabels(label: 'Contact No'),
            SizedBox(height: 10.0),
            buildTextField(
                controller: phoneController,
                validator: FieldValidators.mobileNoValidator),
            SizedBox(height: 10.0),
            buildLabels(label: 'Email ID'),
            SizedBox(height: 10.0),
            buildTextField(
                controller: emailController,
                validator: FieldValidators.emailValidator),
            SizedBox(height: 10.0),
            buildLabels(label: 'Address'),
            SizedBox(height: 10.0),
            buildTextField(
                controller: addressController,
                validator: FieldValidators.globalValidator),
            SizedBox(height: 10.0),
            buildLabels(label: 'Previous School Name'),
            SizedBox(height: 10.0),
            buildTextField(
                controller: schoolNameController,
                validator: FieldValidators.globalValidator),
            SizedBox(height: 10.0),
            buildLabels(label: 'Comment'),
            SizedBox(height: 10.0),
            buildTextField(
                maxLines: 5,
                controller: commentController,
                validator: FieldValidators.globalValidator),
            buildStatusDropdown(),
            SizedBox(height: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildLabels(label: "From Date"),
                SizedBox(height: 8),
                buildDateSelector(
                  selectedDate: widget.updateData != null
                      ? widget.updateData!.enquiryDate.toString()
                      : DateFormat("dd-MMM-yyyy").format(selectedDate),
                )
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              children: [
                Checkbox(
                  value: checkBoxValue,
                  onChanged: (val) {
                    setState(() {
                      checkBoxValue = val!;
                    });
                  },
                ),
                SizedBox(width: 8),
                Text(
                  'Send Email',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Text(
                //   "reset",
                //   style: TextStyle(
                //       fontFamily: "BebasNeue-Regular",
                //       color: Theme.of(context).primaryColor),
                // ),
                buildSubmitBtn(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSubmitBtn() {
    return submitButtonLoader == false
        ? InkWell(
            onTap: () async {
              print(selectedEnquiryType);
              if (selectedEnquiryType != 0 && selectedEnquiryType != null) {
                if (childrenList.length > 0) {
                  if (_enquiryForm.currentState!.validate()) {
                    setState(() => showLoader = !showLoader);
                    final uid = await UserUtils.idFromCache();
                    final token = await UserUtils.userTokenFromCache();
                    final userData = await UserUtils.userTypeFromCache();

                    childrenList.forEach((e) => print("${e.stuName}"));
                    print("here ${childrenList.length}");

                    childrenList.forEach((element) {
                      final newEnquiryData = {
                        "OUserId": uid!,
                        "Token": token!,
                        "OrgId": userData!.organizationId!,
                        "Schoolid": userData.schoolId!,
                        "flag": widget.updateData != null ? "U" : "I",
                        "Name": element.stuName!,
                        "FatherName": fatherNameController.text,
                        "MotherName": motherNameController.text,
                        "ContactNo": phoneController.text,
                        "EmailID": emailController.text,
                        "Comments": commentController.text,
                        "ReferenceId": "0",
                        "ActionID": "0",
                        "ClassID": widget.updateData != null
                            ? widget.updateData!.classID.toString()
                            : element.iD.toString(),
                        // stuInfo!.classId!,
                        "EnquieryDate": widget.updateData != null
                            ? widget.updateData!.enquiryDate.toString()
                            : DateFormat("dd-MMM-yyyy").format(selectedDate),
                        "ISSmsSend": "0",
                        "ISEmailSend": "1",
                        "Status": _selectedStatus.toString(),
                        "FollowDate": widget.updateData != null
                            ? widget.updateData!.createdDate.toString()
                            : DateFormat("dd-MMM-yyyy").format(selectedDate),
                        "FollowupTime":
                            '${selectedTime!.hour}:${selectedTime!.minute}',
                        "FollowupComments": "Enquiry",
                        "CreatedBy": userData.stuEmpId!,
                        "EnquiryType": selectedEnquiryType
                            .toString(), // enquiry type value : 0, 1
                        "Gender": element.gender!,
                        "SessionID":
                            selectedSession!.id!, // session dropdown value
                        "streamID": widget.updateData != null
                            ? widget.updateData!.classID.toString()
                            : "",
                        "OldSchoolName": schoolNameController.text,
                        "Address": addressController.text,
                        "ID": widget.updateData != null
                            ? widget.updateData!.iD.toString()
                            : "",
                        "UserType": userData.ouserType.toString(),
                      };
                      print(
                          "Sending ${element.stuName} newEnquiryData Data => $newEnquiryData");
                      context
                          .read<AddNewEnquiryCubit>()
                          .addNewEnquiry(newEnquiryData);
                    });
                    // Future.delayed(Duration(seconds: 1))
                    //     .then((value) => Navigator.pop(context));
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      commonSnackBar(title: "Please Add Atleast One Children"));
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  commonSnackBar(title: "Please Select Enquiry Type"),
                );
              }
            },
            child: Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                color: Theme.of(context).primaryColor,
              ),
              child: Text(
                widget.updateData != null ? "Update" : "Submit",
                style: TextStyle(
                    fontFamily: "BebasNeue-Regular", color: Colors.white),
              ),
            ),
          )
        : Center(child: CircularProgressIndicator());
  }

  ListView buildChildrenListBody() {
    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (context, index) => Divider(color: Color(0xffECECEC)),
      itemCount: childrenList.length,
      itemBuilder: (context, i) {
        var child = childrenList[i];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  '${i + 1}. ' + child.stuName!,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Row(
                children: [
                  RichText(
                    text: TextSpan(
                      text: child.gender,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black54,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: ' | ',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: '${child.className}    ',
                              style: TextStyle(
                                // fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isChildUpdate = true;
                        childIndex = i;
                        nameController.text = child.stuName!;
                        _selectedClass = classDropdown!
                            .where((element) =>
                                element.className == child.className)
                            .toList()[0];
                        _selectedGender = child.gender!;
                        showAddChildBox = true;
                      });
                    },
                    icon: Icon(
                      Icons.edit,
                      color: Colors.blueAccent,
                    ),
                  ),
                  if (widget.updateData == null)
                    IconButton(
                      onPressed: () {
                        setState(() => childrenList.remove(child));
                      },
                      icon: Icon(
                        Icons.close,
                        color: Colors.red,
                      ),
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  InkWell buildAddButtons(
      {String? title, Color? color, void Function()? onTap, Color? bgColor}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: bgColor,
        ),
        child: Text(title!,
            textScaleFactor: 1.5,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
            )),
      ),
    );
  }

  Future<ChildrenDummy?> showAddNewChildDialog(BuildContext context, setState) {
    final newChild = showDialog<ChildrenDummy>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            // title: Text("Add Child"),
            content: buildDialogBody(context, setState),
            actions: <Widget>[
              TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor)),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // if (_selectedClass != 'Select') {
                    Navigator.pop(
                        context,
                        ChildrenDummy(
                            stuName: nameController.text,
                            className: _selectedClass!.className,
                            gender: _selectedGender));
                    setState(() {
                      nameController.clear();
                      _selectedGender = "MALE";
                      _selectedClass =
                          ResultAnnounceClassModel(id: "", className: "");
                    });
                    // } else {
                    //   toast('Please Select Class');
                    // }
                  }
                },
                child: Text(
                  "Add",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
    return newChild;
  }

  buildDialogBody(BuildContext context, setState) {
    return Container(
      // width: MediaQuery.of(context).size.width,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            buildLabels(label: 'Name'),
            SizedBox(height: 10.0),
            buildTextField(
                controller: nameController,
                validator: FieldValidators.globalValidator),
            // BlocConsumer<ClassListAttendanceCubit, ClassListAttReportState>(
            //   listener: (context, state) {
            //     // if (state is ClassListAttReportLoadSuccess) {
            //     //   setState(() {
            //     //     _selectedClass = state.classList[0];
            //     //     classDropdown = state.classList;
            //     //   });
            //     //   //print(dropDownClassValue!.className);
            //     // }
            //     // if (state is ClassListAttReportLoadFail) {
            //     //   setState(() {
            //     //     _selectedClass = ClassListAttendanceDetailEmployeeModel(
            //     //         id: "", className: "");
            //     //     classDropdown = [];
            //     //   });
            //     // }
            //   },
            //   builder: (context, state) {
            //     if (state is ClassListAttReportLoadInProgress) {
            //       return LinearProgressIndicator();
            //     } else if (state is ClassListAttReportLoadSuccess) {
            //       return buildClassDropdown(setState);
            //     } else if (state is ClassListAttReportLoadFail) {
            //       return buildClassDropdown(setState);
            //     } else {
            //       return Container();
            //     }
            //   },
            // ),
            SizedBox(height: 10.0),
            buildLabels(label: 'Gender'),
            Row(
              children: [
                buildRadioText(
                    title: "MALE", value: "MALE", groupValue: _selectedGender),
                buildRadioText(
                    title: "FEMALE",
                    value: "FEMALE",
                    groupValue: _selectedGender),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Row buildRadioText(
      {String? title, required String value, required String? groupValue}) {
    return Row(
      children: [
        Radio<String?>(
          activeColor: Theme.of(context).primaryColor,
          value: value,
          groupValue: groupValue,
          onChanged: (val) {
            setState(() {
              _selectedGender = value;
              print('_selectedGender = $_selectedGender');
            });
          },
        ),
        SizedBox(width: 4),
        Text(
          title!,
          style: TextStyle(
            fontSize: 12.0,
            color: Color(0xff313131),
            // fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Column buildStatusDropdown() {
    // buildDropdown(
    //             index: 1,
    //             label: "Status",
    //             selectedValue: _selectedStatus,
    //             dropdown: [0, 3, 2, 1, 4]),
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 8),
        buildLabels(label: "Status"),
        SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xffECECEC)),
            // borderRadius: BorderRadius.circular(4),
          ),
          child: DropdownButton<int>(
            isDense: true,
            value: _selectedStatus,
            key: UniqueKey(),
            isExpanded: true,
            underline: Container(),
            items: [0, 3, 2, 1, 4]
                .map((indexDD) => DropdownMenuItem<int>(
                    child: Text(
                      indexDD == 0
                          ? 'Select'
                          : indexDD == 1
                              ? 'Next Follow Up'
                              : indexDD == 2
                                  ? 'Rejected'
                                  : indexDD == 3
                                      ? 'Admission Confirmed'
                                      : indexDD == 4
                                          ? 'Registered'
                                          : "",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    value: indexDD))
                .toList(),
            onChanged: (val) {
              setState(() {
                _selectedStatus = val;
                print("_selectedStatus: $val");
              });
            },
          ),
        ),
      ],
    );
  }

  // Column buildClassDropdown(setState) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     mainAxisSize: MainAxisSize.min,
  //     children: [
  //       SizedBox(height: 8),
  //       buildLabels(label: "Class"),
  //       SizedBox(height: 8),
  //       Container(
  //         padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
  //         decoration: BoxDecoration(
  //           border: Border.all(color: Color(0xffECECEC)),
  //           // borderRadius: BorderRadius.circular(4),
  //         ),
  //         child: DropdownButton<ClassListAttendanceModel>(
  //           isDense: true,
  //           value: _selectedClass,
  //           key: UniqueKey(),
  //           isExpanded: true,
  //           underline: Container(),
  //           items: classDropdown!
  //               .map((item) => DropdownMenuItem<ClassListAttendanceModel>(
  //                   child: Text(
  //                     item.className!,
  //                     style: TextStyle(fontSize: 12),
  //                   ),
  //                   value: item))
  //               .toList(),
  //           onChanged: (val) {
  //             setState(() {
  //               _selectedClass = val;
  //               print("_selectedClass: $val");
  //             });
  //           },
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Container buildTextField({
    int? maxLines,
    String? Function(String?)? validator,
    @required TextEditingController? controller,
  }) {
    return Container(
      child: TextFormField(
        controller: controller,
        validator: validator,
        maxLines: maxLines ?? null,
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
              // color: Theme.of(context).primaryColor,
              color: Color(0xffECECEC),
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xffECECEC),
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              // color: Theme.of(context).primaryColor,
              color: Color(0xffECECEC),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              // color: Theme.of(context).primaryColor,
              color: Color(0xffECECEC),
            ),
          ),
          hintText: "type here",
          hintStyle: TextStyle(color: Color(0xffA5A5A5)),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
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

  Row buildLabels({String? label, Color? color, Widget? widget}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label!,
          style: TextStyle(
            color: color ?? Color(0xff313131),
            fontWeight: FontWeight.bold,
          ),
        ),
        widget ?? Container(),
      ],
    );
  }
}

class ChildrenDummy {
  int? iD;
  String? stuName;
  String? gender;
  String? className;

  ChildrenDummy({this.iD, this.stuName, this.gender, this.className});
}
