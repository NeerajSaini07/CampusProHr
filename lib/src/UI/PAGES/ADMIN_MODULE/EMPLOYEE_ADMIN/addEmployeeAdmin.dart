import 'package:campus_pro/src/DATA/BLOC_CUBIT/FEE_TYPE_CUBIT/fee_type_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/add_new_employee_cubit/add_new_employee_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/load_last_emp_no_cubit/load_last_emp_no_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/feeTypeModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonSnackbar.dart';
import 'package:campus_pro/src/UTILS/fieldValidators.dart';
import 'package:campus_pro/src/WIDGETS_STYLE/style_common.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddEmployee extends StatefulWidget {
  static const routeName = '/Add-Employee';
  const AddEmployee({Key? key}) : super(key: key);

  @override
  _AddEmployeeState createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  String? lastEmployeeNumber = '';
  DateTime selectedDate = DateTime.now();

  List<FeeTypeModel>? groupItems;
  FeeTypeModel? selectedGroupItem;

  List<FeeTypeModel>? qualificationItems;
  FeeTypeModel? selectedQualification;
  bool? checkBoxValueBoy = false;
  bool? checkBoxValueGirl = false;
  //String? valueCheck;
  String? groupId;
  String? qualificationId;
  bool isSavedChecked = false;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _fatherNameController = TextEditingController();
  TextEditingController _empCodeController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _qualificationController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _specializationController = TextEditingController();

  // final List<DropdownMenuItem<String>> groupDropDown = groupItem
  //     .map((String e) => DropdownMenuItem<String>(value: e, child: Text('$e')))
  //     .toList();

  // final List<DropdownMenuItem<String>> qualificationDropDown = qualificationItem
  //     .map((String e) => DropdownMenuItem<String>(value: e, child: Text('$e')))
  //     .toList();
  GlobalKey<FormState> _key = GlobalKey<FormState>();

  String? pramNameGroup = 'Group';
  String? pramNameQualification = 'Qualification';
  // String? designationPramName="Designation";

  getGroupType({String? paramName}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final feeTypeData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId!,
      "Schoolid": userData.schoolId!,
      "EmpStuId": userData.stuEmpId!,
      "UserType": userData.ouserType!,
      "ParamType": paramName,
    };

    print('groupType Data $feeTypeData');
    context.read<FeeTypeCubit>().feeTypeCubitCall(feeTypeData);
  }

  getQualificationType({String? paramName}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final feeTypeData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId!,
      "Schoolid": userData.schoolId!,
      "EmpStuId": userData.stuEmpId!,
      "UserType": userData.ouserType!,
      "ParamType": "Qualification",
    };

    print('Qualification Type Data $feeTypeData');
    context.read<FeeTypeCubit>().feeTypeCubitCall(feeTypeData);
  }

  getLastEmpNo() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final lastEmpNoData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "UserType": userData.ouserType,
      "StuEmpId": userData.stuEmpId,
      "SchoolId": userData.schoolId,
    };

    context.read<LoadLastEmpNoCubit>().loadLastEmpNoCubitCall(lastEmpNoData);
  }

  addNewEmployee({
    String? empCode,
    String? groupId,
    String? name,
    String? date,
    String? gender,
    String? Fname,
    String? mobile,
    String? email,
    String? specialization,
    String? qualificationId,
    String? profQualification,
  }) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final addNewEmp = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "SchoolId": userData.schoolId,
      "EmpCode": empCode,
      "GroupID": groupId,
      "Name": name,
      "DOB": date,
      "Gender": gender,
      "Father": Fname,
      "Mobile": mobile,
      "Email": email,
      "QulificationID": qualificationId,
      "ProfeQualification": profQualification,
      "Specialization": specialization,
      "DisplayOrder": '0',
      "StuEmpId": userData.stuEmpId,
      "UserType": userData.ouserType,
    };
    context.read<AddNewEmployeeCubit>().addNewEmployeeCubitCall(addNewEmp);
  }

  @override
  void initState() {
    super.initState();
    getLastEmpNo();
    selectedGroupItem = FeeTypeModel(iD: "", paramname: "");
    groupItems = [];
    qualificationItems = [];
    selectedQualification = FeeTypeModel(iD: "", paramname: "");
    getGroupType(paramName: pramNameGroup);
    // getQualificationType(paramName: pramNameQualification);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, title: "Add New Employee"),
      body: Form(
        key: _key,
        child: MultiBlocListener(
          listeners: [
            BlocListener<LoadLastEmpNoCubit, LoadLastEmpNoState>(
                listener: (context, state) {
              if (state is LoadLastEmpNoLoadSuccess) {
                setState(() {
                  lastEmployeeNumber = state.result;
                });
              }
              if (state is LoadLastEmpNoLoadFail) {
                if (state.failReason == 'false') {
                  UserUtils.unauthorizedUser(context);
                }
              }
            }),
            BlocListener<AddNewEmployeeCubit, AddNewEmployeeState>(
                listener: (context, state) {
              if (state is AddNewEmployeeLoadInProgress) {
                setState(() {
                  isSavedChecked = true;
                });
              }
              if (state is AddNewEmployeeLoadSuccess) {
                setState(() {
                  isSavedChecked = false;
                });
                setState(() {
                  _nameController.text = "";
                  _fatherNameController.text = "";
                  _qualificationController.text = "";
                  _specializationController.text = "";
                  _empCodeController.text = "";
                  _emailController.text = "";
                  _mobileController.text = "";
                  checkBoxValueGirl = false;
                  checkBoxValueBoy = false;
                  selectedDate = DateTime.now();
                });
                ScaffoldMessenger.of(context)
                    .showSnackBar(commonSnackBar(title: '${state.result}'));
                getLastEmpNo();
              }
              if (state is AddNewEmployeeLoadFail) {
                setState(() {
                  isSavedChecked = false;
                });
                if (state.failReason == 'false') {
                  UserUtils.unauthorizedUser(context);
                }
                ScaffoldMessenger.of(context)
                    .showSnackBar(commonSnackBar(title: '${state.failReason}'));
              }
            }),
          ],
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(
                              'Last EmpNo/EmpCode',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.022,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.24,
                            height: MediaQuery.of(context).size.height * 0.04,
                            margin:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              border: Border.all(width: 0.2),
                            ),
                            child: Center(
                                child: Text(
                              '$lastEmployeeNumber',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(fontSize: 16),
                            )),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.06,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'DOB',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.009,
                          ),
                          buildDateSelector(
                            selectedDate:
                                DateFormat("dd MMM yyyy").format(selectedDate),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'EmpCode',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.007,
                ),
                buildTextField(
                  controller: _empCodeController,
                  validator: FieldValidators.globalValidator,
                  type: false,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'Name',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.007,
                ),
                buildTextField(
                    controller: _nameController,
                    validator: FieldValidators.globalValidator),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.04),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              'MALE',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Checkbox(
                                value: checkBoxValueBoy,
                                onChanged: (val) {
                                  if (checkBoxValueBoy != true) {
                                    setState(() {
                                      checkBoxValueBoy = val;
                                      checkBoxValueGirl = false;
                                    });
                                  }
                                }),
                          ],
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                        ),
                        Row(
                          children: [
                            Text(
                              'FEMALE',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Checkbox(
                                value: checkBoxValueGirl,
                                onChanged: (val) {
                                  if (checkBoxValueGirl != true) {
                                    setState(() {
                                      checkBoxValueGirl = val;
                                      checkBoxValueBoy = false;
                                    });
                                  }
                                }),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Row(
                  children: [
                    BlocConsumer<FeeTypeCubit, FeeTypeState>(
                      listener: (context, state) {
                        if (state is FeeTypeLoadSuccess) {
                          setState(() {
                            if (pramNameGroup == 'Group') {
                              selectedGroupItem = state.feeTypes[0];
                              groupItems = state.feeTypes;
                              groupId = state.feeTypes[0].iD;
                              pramNameGroup = 'Designation';
                              getQualificationType(
                                  paramName: pramNameQualification);
                            }
                          });
                        }
                        if (state is FeeTypeLoadFail) {
                          if (state.failReason == 'false') {
                            UserUtils.unauthorizedUser(context);
                          }
                        }
                      },
                      builder: (context, state) {
                        if (state is FeeTypeLoadInProgress) {
                          return buildGroupDropDown();
                        } else if (state is FeeTypeLoadSuccess) {
                          return buildGroupDropDown();
                        } else {
                          return Container();
                        }
                      },
                    ),
                    pramNameGroup == 'Designation'
                        ? BlocConsumer<FeeTypeCubit, FeeTypeState>(
                            listener: (context, state) {
                              if (state is FeeTypeLoadSuccess) {
                                setState(() {
                                  if (pramNameQualification ==
                                      'Qualification') {
                                    selectedQualification = state.feeTypes[0];
                                    qualificationItems = state.feeTypes;
                                    qualificationId = state.feeTypes[0].iD;
                                  }
                                });
                              }
                            },
                            builder: (context, state) {
                              if (state is FeeTypeLoadInProgress) {
                                return buildQualificationDropDown();
                              } else if (state is FeeTypeLoadSuccess) {
                                return buildQualificationDropDown();
                              } else {
                                return Container();
                              }
                            },
                          )
                        : buildQualificationDropDown(),
                    // buildGroupDropDown(),
                    // buildQualificationDropDown(),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'Father Name',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.007,
                ),
                buildTextField(
                    controller: _fatherNameController,
                    validator: FieldValidators.globalValidator),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'Mobile',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.007,
                ),
                buildTextField(
                  controller: _mobileController,
                  validator: FieldValidators.globalValidator,
                  type: false,
                  maxLength: 10,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'Professional Qualification',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.007,
                ),
                buildTextField(
                  controller: _qualificationController,
                  //validator: FieldValidators.globalValidator
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'Email',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.007,
                ),
                buildTextField(
                    controller: _emailController,
                    validator: FieldValidators.emailValidator),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'Specialization',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.007,
                ),
                buildTextField(
                  controller: _specializationController,
                  //    validator: FieldValidators.globalValidator
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                isSavedChecked == false
                    ? Center(
                        child: Container(
                          // width: MediaQuery.of(context).size.width * 0.8,
                          // height: MediaQuery.of(context).size.height * 0.06,
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 25),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: InkWell(
                            hoverColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () {
                              if (_key.currentState!.validate()) {
                                if (checkBoxValueBoy == false &&
                                    checkBoxValueGirl == false) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      commonSnackBar(title: 'Select Gender'));
                                } else {
                                  if (_mobileController.text.length > 10 ||
                                      _mobileController.text.length < 10) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        commonSnackBar(
                                            title: 'Enter Valid Number'));
                                  } else {
                                    if (_emailController.text.length > 1) {
                                      addNewEmployee(
                                        empCode: _empCodeController.text,
                                        name: _nameController.text,
                                        groupId: groupId,
                                        date: DateFormat('dd-MMM-yyyy')
                                            .format(selectedDate),
                                        gender: checkBoxValueBoy == true
                                            ? 'Male'
                                            : 'Female',
                                        Fname: _fatherNameController.text,
                                        mobile: _mobileController.text,
                                        email: _emailController.text,
                                        specialization:
                                            _specializationController.text,
                                        qualificationId: qualificationId,
                                        profQualification:
                                            _qualificationController.text,
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(commonSnackBar(
                                              title: 'Enter Email Address'));
                                    }
                                  }
                                }
                              }
                            },
                            child: Text(
                              'Save',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16),
                            ),
                          ),
                        ),
                      )
                    : Center(child: CircularProgressIndicator()),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildTextField({
    int? maxLines = 1,
    String? Function(String?)? validator,
    @required TextEditingController? controller,
    bool? type = true,
    int? maxLength,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        controller: controller,
        validator: validator,
        maxLines: maxLines ?? null,
        maxLength: maxLength ?? null,
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        style: TextStyle(color: Colors.black),
        keyboardType: type == true ? TextInputType.text : TextInputType.number,
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
      ),
    );
  }

  Container buildGroupDropDown() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      width: MediaQuery.of(context).size.width * 0.39,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Group',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
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
            child: Listener(
              onPointerDown: (_) => FocusScope.of(context).unfocus(),
              child: DropdownButton<FeeTypeModel>(
                isDense: true,
                value: selectedGroupItem!,
                key: UniqueKey(),
                isExpanded: true,
                underline: Container(),
                items: groupItems!
                    .map((e) => DropdownMenuItem(
                          child: Text(
                            '${e.paramname}',
                            style: TextStyle(fontSize: 14),
                          ),
                          value: e,
                        ))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    selectedGroupItem = val!;
                    groupId = val.iD;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container buildQualificationDropDown() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 23.0),
      width: MediaQuery.of(context).size.width * 0.39,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Qualification',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
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
            child: Listener(
              onPointerDown: (_) => FocusScope.of(context).unfocus(),
              child: DropdownButton<FeeTypeModel>(
                isDense: true,
                value: selectedQualification,
                key: UniqueKey(),
                isExpanded: true,
                underline: Container(),
                items: qualificationItems!
                    .map((e) => DropdownMenuItem(
                          child: Text(
                            '${e.paramname}',
                            style: TextStyle(fontSize: 16),
                          ),
                          value: e,
                        ))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    selectedQualification = val;
                    qualificationId = val!.iD;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1947),
      lastDate: DateTime(2101),
    );
    if (picked != null)
      setState(
        () {
          selectedDate = picked;
        },
      );
  }

  InkWell buildDateSelector({String? selectedDate, int? index}) {
    return InkWell(
      onTap: () => _selectDate(context),
      child: internalTextForDateTime(context,
          width: MediaQuery.of(context).size.width * 0.4,
          selectedDate: selectedDate),
      // Container(
      //   width: MediaQuery.of(context).size.width * 0.4,
      //   height: MediaQuery.of(context).size.height * 0.06,
      //   padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      //   decoration: BoxDecoration(
      //     border: Border.all(
      //       color: Color(0xffECECEC),
      //     ),
      //   ),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       Container(
      //         width: MediaQuery.of(context).size.width * 0.25,
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
}
