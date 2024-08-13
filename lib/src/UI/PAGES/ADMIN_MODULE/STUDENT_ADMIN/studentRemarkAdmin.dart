import 'package:campus_pro/src/DATA/API_SERVICES/addNewRemarkApi.dart';
import 'package:campus_pro/src/DATA/MODELS/remarkForStudentListModel.dart';
import 'package:campus_pro/src/DATA/MODELS/searchStudentFromRecordsCommonModel.dart';
import 'package:campus_pro/src/DATA/MODELS/studentRemarkListModel.dart';
import 'package:campus_pro/src/DATA/MODELS/userTypeModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonSnackbar.dart';
import 'package:campus_pro/src/UI/WIDGETS/drawerWidget.dart';
import 'package:campus_pro/src/UI/WIDGETS/noRecordFound.dart';
import 'package:campus_pro/src/UI/WIDGETS/searchStudentFromRecordsCommon.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

import '../../../../globalBlocProvidersFile.dart';

class StudentRemarkAdmin extends StatefulWidget {
  static const routeName = "/student-remark-admin";
  @override
  _StudentRemarkAdminState createState() => _StudentRemarkAdminState();
}

class _StudentRemarkAdminState extends State<StudentRemarkAdmin> {
  String? uid = '';
  String? token = '';
  UserTypeModel? userData;

  List<SearchStudentFromRecordsCommonModel>? searchDataList = [];

  TextEditingController searchController = TextEditingController();

  SearchStudentFromRecordsCommonModel? selectedStudent;

  @override
  void initState() {
    selectedStudent = SearchStudentFromRecordsCommonModel(
      studentid: "",
      admno: "",
      stname: "",
      fathername: '',
      classsection: '',
      guardianmobileno: '',
      prsntAddress: '',
      displayorderno: '',
      address: '',
      compClass: '',
      imageUrl: '',
    );
    getDataFromLocal();
    super.initState();
  }

  getDataFromLocal() async {
    uid = await UserUtils.idFromCache();
    token = await UserUtils.userTokenFromCache();
    userData = await UserUtils.userTypeFromCache();
  }

  getSelectedUserRemark() {
    final studentData = {
      'OUserId': uid!,
      'Token': token!,
      'OrgId': userData!.organizationId!,
      'SchoolId': userData!.schoolId!,
      'SessionId': userData!.currentSessionid!,
      'StuEmpType': 's',
      'StuEmpId': userData!.stuEmpId!,
      'StuID': selectedStudent!.studentid!,
      'UserType': userData!.ouserType!,
    };
    context
        .read<StudentRemarkListCubit>()
        .studentRemarkListCubitCall(studentData);
  }

  deleteRemark(String? remarkId) {
    final deleteData = {
      'OUserId': uid!,
      'Token': token!,
      'OrgId': userData!.organizationId!,
      'SchoolId': userData!.schoolId!,
      'SessionId': userData!.currentSessionid!,
      'StuEmpId': userData!.stuEmpId!,
      'RemarkDetailId': remarkId!,
      'OUserType': userData!.ouserType!,
    };
    context
        .read<DeleteStudentRemarkCubit>()
        .deleteStudentRemarkCubitCall(deleteData);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: commonAppBar(context, title: "Student Remark"),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return BlocProvider<SearchStudentFromRecordsCommonCubit>(
              create: (_) => SearchStudentFromRecordsCommonCubit(
                  SearchStudentFromRecordsCommonRepository(
                      SearchStudentFromRecordsCommonApi())),
              child: BlocProvider<SaveStudentRemarkCubit>(
                create: (_) => SaveStudentRemarkCubit(
                    SaveStudentRemarkRepository(SaveStudentRemarkApi())),
                child: AddNewRemark(),
              ),
            );
          }));
          // Navigator.pushNamed(context, AddNewRemark.routeName);
        },
        child: Icon(Icons.add),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<DeleteStudentRemarkCubit, DeleteStudentRemarkState>(
            listener: (context, state) {
              if (state is DeleteStudentRemarkLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                }
              }
              if (state is DeleteStudentRemarkLoadSuccess) {
                getSelectedUserRemark();
              }
            },
          ),
          BlocListener<SearchStudentFromRecordsCommonCubit,
              SearchStudentFromRecordsCommonState>(
            listener: (context, state) {
              if (state is SearchStudentFromRecordsCommonLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                }
              }
              if (state is SearchStudentFromRecordsCommonLoadSuccess) {
                setState(() {
                  searchDataList = state.searchData;
                });
              }
            },
          ),
        ],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildLabels(label: "Search Student"),
              GestureDetector(
                onTap: () async {
                  final studentData = await Navigator.pushNamed(
                          context, SearchStudentFromRecordsCommon.routeName)
                      as SearchStudentFromRecordsCommonModel;
                  if (studentData != null) {
                    if (studentData.admno != "") {
                      setState(() => selectedStudent = studentData);
                      getSelectedUserRemark();
                    }
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text("search student here..."),
                ),
              ),
              SizedBox(height: 10.0),
              if (selectedStudent!.admno != "")
                Container(
                  color: Colors.blue.withOpacity(0.1),
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width - 80,
                            // color: Colors.green,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${selectedStudent!.admno!} | ${selectedStudent!.stname!}",
                                  style: GoogleFonts.quicksand(
                                    color: Color(0xff3A3A3A),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "s/o : ${selectedStudent!.fathername!}\nM : ${selectedStudent!.guardianmobileno!}",
                                  style: GoogleFonts.quicksand(
                                    color: Color(0xff3A3A3A),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                selectedStudent =
                                    SearchStudentFromRecordsCommonModel(
                                  studentid: "",
                                  admno: "",
                                  stname: "",
                                  fathername: '',
                                  classsection: '',
                                  guardianmobileno: '',
                                  prsntAddress: '',
                                  displayorderno: '',
                                  address: '',
                                  compClass: '',
                                  imageUrl: '',
                                );
                                studentRemarksList = [];
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              child: Icon(Icons.close, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              BlocConsumer<StudentRemarkListCubit, StudentRemarkListState>(
                listener: (context, state) {
                  if (state is StudentRemarkListLoadFail) {
                    if (state.failReason == "false") {
                      UserUtils.unauthorizedUser(context);
                    }
                  }
                  if (state is StudentRemarkListLoadSuccess) {
                    setState(
                        () => studentRemarksList = state.studentRemarksList);
                  }
                },
                builder: (context, state) {
                  if (state is StudentRemarkListLoadInProgress) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is StudentRemarkListLoadSuccess) {
                    return buildTaskListBody(context);
                  } else if (state is StudentRemarkListLoadFail) {
                    return noRecordFound();
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<StudentRemarkListModel>? studentRemarksList = [];

  Expanded buildTaskListBody(BuildContext context) {
    return Expanded(
      child: Container(
        child: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(height: 10),
          shrinkWrap: true,
          itemCount: studentRemarksList!.length,
          itemBuilder: (context, i) {
            var item = studentRemarksList![i];
            return Container(
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xffDBDBDB)),
              ),
              child: ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    item.remark!,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Extra Remark : ${item.extraRemark!}",
                      style: TextStyle(
                        // fontWeight: FontWeight.w600,
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      'Emp: ${item.empName}',
                      style: TextStyle(
                        // fontWeight: FontWeight.w600,
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item.addedOnDate!,
                          style: TextStyle(
                            // fontWeight: FontWeight.w600,
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        InkWell(
                          onTap: () => deleteRemark(item.id),
                          child: Icon(
                            Icons.delete,
                            color: Colors.red[300],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Padding buildLabels({String? label, Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        label!,
        style: GoogleFonts.quicksand(
          color: color ?? Color(0xff3A3A3A),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class AddNewRemark extends StatefulWidget {
  static const routeName = "/add-new-remark";
  @override
  _AddNewRemarkState createState() => _AddNewRemarkState();
}

class _AddNewRemarkState extends State<AddNewRemark> {
  String? uid = '';
  String? token = '';
  UserTypeModel? userData;
  String? userType;

  DateTime selectedDate = DateTime.now();

  bool showExtraRemark = false;

  bool showLoader = false;

  bool showSaveButton = false;

  TextEditingController searchController = TextEditingController();
  TextEditingController extraRemarkController = TextEditingController();

  TextEditingController remarkController = TextEditingController();

  SearchStudentFromRecordsCommonModel? selectedStudent;

  @override
  void initState() {
    getDataFromLocal();
    selectedStudent = SearchStudentFromRecordsCommonModel(
      studentid: "",
      admno: "",
      stname: "",
      fathername: '',
      classsection: '',
      guardianmobileno: '',
      prsntAddress: '',
      displayorderno: '',
      address: '',
      compClass: '',
      imageUrl: '',
    );
    super.initState();
  }

  getDataFromLocal() async {
    uid = await UserUtils.idFromCache();
    token = await UserUtils.userTokenFromCache();
    userData = await UserUtils.userTypeFromCache();
    setState(() {
      userType = userData!.ouserType;
    });
    getRemarkForStudent();
  }

  getRemarkForStudent() async {
    final remarkData = {
      'OUserId': uid!,
      'Token': token!,
      'OrgId': userData!.organizationId!,
      'Schoolid': userData!.schoolId!,
      'UserType': userData!.ouserType!,
      'Empid': userData!.stuEmpId!,
    };
    context
        .read<RemarkForStudentsListCubit>()
        .remarkForStudentsListCubitCall(remarkData);
  }

  getSelectedUserData(String? studentId) {
    final studentData = {
      "OUserId": uid!,
      "Token": token!,
      "OrgId": userData!.organizationId!,
      "Schoolid": userData!.schoolId!,
      "StudentId": studentId!,
      "SessionId": userData!.currentSessionid!,
      "UserType": userData!.ouserType!,
      "EmpStuId": userData!.stuEmpId!,
    };
    context
        .read<StudentInfoForSearchCubit>()
        .studentInfoForSearchCubitCall(studentData);
  }

  addNewRemark({String? remark}) async {
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
      "Remark": remark,
    };

    print("sending data for add remark $sendingData");

    try {
      await AddNewRemarkApi().addRemark(sendingData);
      getRemarkForStudent();
      remarkController.text = "";
      Navigator.pop(context);
    } catch (e) {
      remarkController.text = "";
      ScaffoldMessenger.of(context)
          .showSnackBar(commonSnackBar(title: "Something Went Wrong"));
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    extraRemarkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, title: "Add New Remark"),
      body: MultiBlocListener(
        listeners: [
          BlocListener<SaveStudentRemarkCubit, SaveStudentRemarkState>(
            listener: (context, state) {
              if (state is SaveStudentRemarkLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                }
              }
              if (state is SaveStudentRemarkLoadInProgress) {
                setState(() {
                  showLoader = true;
                });
              }
              if (state is SaveStudentRemarkLoadSuccess) {
                setState(() {
                  selectedStudent = SearchStudentFromRecordsCommonModel(
                    studentid: "",
                    admno: "",
                    stname: "",
                    fathername: '',
                    classsection: '',
                    guardianmobileno: '',
                    prsntAddress: '',
                    displayorderno: '',
                    address: '',
                    compClass: '',
                    imageUrl: '',
                  );
                  searchController.text = "";
                  extraRemarkController.text = "";
                  showLoader = false;
                  showExtraRemark = false;
                  showSaveButton = false;
                  _selectedRemarkList = [];
                });
                ScaffoldMessenger.of(context).showSnackBar(commonSnackBar(
                  title: "New Remark Added",
                  duration: Duration(seconds: 1),
                ));
                getRemarkForStudent();
                print(_selectedRemarkList.length);
              }
            },
          ),
          BlocListener<SearchStudentFromRecordsCommonCubit,
              SearchStudentFromRecordsCommonState>(
            listener: (context, state) {
              if (state is SearchStudentFromRecordsCommonLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                }
              }
              if (state is SearchStudentFromRecordsCommonLoadSuccess) {
                setState(() => showSaveButton = true);
              }
            },
          ),
        ],
        child: buildNewRemarkBody(context),
      ),
    );
  }

  Widget buildNewRemarkBody(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildLabels(label: "Search Student"),
                GestureDetector(
                  onTap: () async {
                    final studentData = await Navigator.pushNamed(
                            context, SearchStudentFromRecordsCommon.routeName)
                        as SearchStudentFromRecordsCommonModel;
                    if (studentData.admno != "") {
                      setState(() => selectedStudent = studentData);
                    }
                  },
                  child: Container(
                    // height: 40,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                    ),
                    child: Text(
                      "search student here...",
                    ),
                  ),
                ),
                if (selectedStudent!.admno != "")
                  Container(
                    color: Colors.blue.withOpacity(0.1),
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width - 80,
                              // color: Colors.green,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${selectedStudent!.admno!} | ${selectedStudent!.stname!}",
                                    style: GoogleFonts.quicksand(
                                      color: Color(0xff3A3A3A),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "s/o : ${selectedStudent!.fathername!}\nM : ${selectedStudent!.guardianmobileno!}",
                                    style: GoogleFonts.quicksand(
                                      color: Color(0xff3A3A3A),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  selectedStudent =
                                      SearchStudentFromRecordsCommonModel(
                                    studentid: "",
                                    admno: "",
                                    stname: "",
                                    fathername: '',
                                    classsection: '',
                                    guardianmobileno: '',
                                    prsntAddress: '',
                                    displayorderno: '',
                                    address: '',
                                    compClass: '',
                                    imageUrl: '',
                                  );
                                  searchController.text = "";
                                  extraRemarkController.text = "";
                                  showLoader = false;
                                  showExtraRemark = false;
                                  showSaveButton = false;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                                child: Icon(Icons.close, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            SizedBox(height: 10.0),
            Text(
              'Select Atleast One Remark',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            BlocConsumer<RemarkForStudentsListCubit,
                RemarkForStudentsListState>(
              listener: (context, state) {
                if (state is RemarkForStudentsListLoadSuccess) {
                  setState(() {
                    remarkListMulti = state.remarksList;
                  });
                }
                if (state is RemarkForStudentsListLoadFail) {
                  if (state.failReason == "false") {
                    UserUtils.unauthorizedUser(context);
                  } else {
                    setState(() {
                      remarkListMulti = [];
                    });
                  }
                }
              },
              builder: (context, state) {
                if (state is RemarkForStudentsListLoadInProgress) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    height: 40,
                    decoration: BoxDecoration(border: Border.all(width: 0.1)),
                    child: Text(
                      "Select Atleast One Remark",
                    ),
                  );
                } else if (state is RemarkForStudentsListLoadSuccess) {
                  return buildRemarkMultiSelect(context);
                } else {
                  return Container();
                }
              },
            ),
            userType != null
                ? userType!.toLowerCase() == "a" ||
                        userType!.toLowerCase() == "m"
                    ? Center(
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                              // backgroundColor: MaterialStateProperty.all(
                              //   Theme.of(context).backgroundColor,
                              // ),
                              overlayColor:
                                  MaterialStateProperty.all(Colors.transparent),
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Add New Remark"),
                                    content: TextFormField(
                                      controller: remarkController,
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          remarkController.text = "";
                                          Navigator.pop(context);
                                        },
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.red),
                                          shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                          ),
                                        ),
                                        child: Text("Cancel"),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      ElevatedButton(
                                          onPressed: () {
                                            if (remarkController.text != "") {
                                              addNewRemark(
                                                  remark:
                                                      remarkController.text);
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(commonSnackBar(
                                                      title: "Add Remark"));
                                            }
                                          },
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.green),
                                            shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                            ),
                                          ),
                                          child: Text("Add")),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Text(
                              "+ Add New Remark",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    : Container()
                : Container(),
            if (!showExtraRemark)
              InkWell(
                onTap: () => setState(() => showExtraRemark = !showExtraRemark),
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      // color: Theme.of(context).backgroundColor,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    margin: EdgeInsets.all(20),
                    child: Text(
                      '+ Add Extra Remark',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              )
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Extra Remark',
                    style: TextStyle(
                      // color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  buildExtraRemarkTextField(context),
                ],
              ),
            SizedBox(height: 20),
            if (showSaveButton)
              if (!showLoader)
                buildSaveButton()
              else
                Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(width: 12),
                    Text(
                      "Please wait...",
                      textScaleFactor: 1.0,
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Padding buildRow({String? title, String? value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title!,
            style: TextStyle(
                color: Color(0xff777777), fontWeight: FontWeight.w600),
          ),
          Text(
            value!,
            style: TextStyle(
                color: Color(0xff3A3A3A), fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  List<RemarkForStudentListModel> _selectedRemarkList =
      []; // Remark List after Seletion
  List<RemarkForStudentListModel>? remarkListMulti =
      []; // Remark List After API
  final _remarkSelectKey = GlobalKey<FormFieldState>();

  Widget buildRemarkMultiSelect(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      alignment: Alignment.center,
      child: MultiSelectBottomSheetField<RemarkForStudentListModel>(
        autovalidateMode: AutovalidateMode.disabled,
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xffECECEC)),
        ),
        key: _remarkSelectKey,
        initialChildSize: 0.7,
        maxChildSize: 0.95,
        searchIcon: Icon(Icons.ac_unit),
        title: Text("All Remarks",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 18)),
        buttonText: Text("Select Atleast One Remark"),
        items: remarkListMulti!
            .map((remarkList) => MultiSelectItem(remarkList,
                remarkList.remark != null ? remarkList.remark! : ""))
            .toList(),
        searchable: false,
        validator: (values) {
          if (values == null || values.isEmpty) {
            return "Required";
          }
          return null;
        },
        onConfirm: (values) {
          setState(() {
            _selectedRemarkList = values;
          });
          print(_selectedRemarkList.length);
          _remarkSelectKey.currentState!.validate();
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

  Container buildLabelWithValue({String? heading, String? value}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            heading!,
            style: TextStyle(
              // color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            value!,
            style: TextStyle(
              // color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w600,
              color: Colors.black54,
            ),
          ),
          SizedBox(height: 4),
        ],
      ),
    );
  }

  Widget buildSaveButton() {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: Theme.of(context).primaryColor,
        ),
        child: TextButton(
          onPressed: () {
            if (_selectedRemarkList.length > 0) {
              String remarkIds = "";
              String remarkTxt = "";
              _selectedRemarkList.forEach((element) {
                setState(() {
                  if (remarkIds != "") {
                    remarkIds = remarkIds + "," + element.remarkId!;
                    remarkTxt = remarkTxt + "," + element.remark!;
                  } else {
                    remarkIds = element.remarkId!;
                    remarkTxt = element.remark!;
                  }
                });
              });
              print(remarkTxt);
              final remarkData = {
                'OUserId': uid!,
                'Token': token!,
                'OrgId': userData!.organizationId!,
                'Schoolid': userData!.schoolId!,
                'SessionId': userData!.currentSessionid!,
                'StuEmpID': userData!.stuEmpId!,
                'StudentId': selectedStudent!.studentid,
                'RemarkIds': remarkIds,
                'ExtraRemark': extraRemarkController.text,
                'UserType': userData!.ouserType!,
                "Remarks": remarkTxt,
              };
              print("Sending SaveStudentRemark data => $remarkData");
              context
                  .read<SaveStudentRemarkCubit>()
                  .saveStudentRemarkCubitCall(remarkData);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                  commonSnackBar(title: "Add Atleast One Remark"));
            }
          },
          child: Text(
            "Save Remark",
            style:
                TextStyle(fontFamily: "BebasNeue-Regular", color: Colors.white),
          ),
        ),
      ),
    );
  }

  Padding buildLabels({String? label, Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        label!,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Container buildExtraRemarkTextField(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        // obscureText: !obscureText ? false : true,
        controller: extraRemarkController,
        // autovalidateMode: AutovalidateMode.onUserInteraction,
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
          hintText: "type remark",
          hintStyle: TextStyle(color: Color(0xffA5A5A5)),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
        ),
        onChanged: (_) {
          // if (extraRemarkController.text.length > 2) {
          //   final searchData = {
          //     'prefixText': searchController.text,
          //     'contextKey':
          //         "$uid.$token.${userData!.organizationId}.${userData!.schoolId}.${userData!.currentSessionid}",
          //     'StuEmp': userData!.stuEmpId!,
          //     'UserType': userData!.ouserType!,
          //     'Flag': userData!.ouserType!,
          //   };
          //   print("sending Student search data => $searchData");
          //   context
          //       .read<SearchStudentFromRecordsCommonCubit>()
          //       .searchStudentFromRecordsCommonCubitCall(searchData);
          // }
        },
      ),
    );
  }
}
