import 'dart:io';

import 'package:campus_pro/src/DATA/BLOC_CUBIT/GET_COMMENTS_EMPLOYEE_TASK_MODEL/get_comments_employee_task_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/GET_EMPLOYEE_TASK_MANAGEMENT2_CUBIT/get_employee_task_management2_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/GET_EMPLOYEE_TASK_STATUS_CUBIT/get_employee_task_status_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/SAVE_TASK_DETAILS_CUBIT/save_task_details_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/getCommentsEmployeeTaskModel.dart';
import 'package:campus_pro/src/DATA/MODELS/getEmployeeTaskManagementModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonSnackbar.dart';
import 'package:campus_pro/src/UTILS/appImages.dart';
import 'package:campus_pro/src/UTILS/fieldValidators.dart';
import 'package:campus_pro/src/UTILS/filePicker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

class AddTask extends StatefulWidget {
  static const routeName = "new-task-form-class";
  final String? name;
  final DateTime? sdate;
  final DateTime? ddate;
  final String? detail;
  final String? follower;
  String? image;
  final String? userType;
  final String? assign;
  final String? priority;
  final bool? isUpdate;
  final String? id;

  AddTask({
    this.userType,
    this.name,
    this.sdate,
    this.priority,
    this.image,
    this.assign,
    this.ddate,
    this.detail,
    this.follower,
    this.isUpdate,
    this.id,
  });

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  bool isLoader = false;

  String? userType = "a";
  //
  DateTime startDate = DateTime.now();
  DateTime dueDate = DateTime.now();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _detailController = TextEditingController();
  TextEditingController _commentController = TextEditingController();

  final _newTaskKey = GlobalKey<FormState>();

  String? baseUrl;

  String? assignName = "";
  String? followerName = "";

  //comments
  List<GetCommentsEmployeeTaskModel>? commentList = [];
  //Priority
  List<String> priorityDropdown = ['Select Priority', 'High', 'Medium', "Low"];
  String? _selectedPriority = 'Select Priority';

  //Task Status
  GetEmployeeTaskManagementModel? _selectedTaskStatus;
  List<GetEmployeeTaskManagementModel> taskStatusDropdown = [];

  List<GetEmployeeTaskManagementModel> employeeList = [];
  List<GetEmployeeTaskManagementModel> employeeList2 = [];

  // assign multi select
  final _assignToSelectKey = GlobalKey<FormFieldState>();
  List<GetEmployeeTaskManagementModel> finalAssignEmployeeList = [];
  List<String> idsAssignEmployeeList = [];

  //follower multi select
  final _followerSelectKey = GlobalKey<FormFieldState>();
  List<GetEmployeeTaskManagementModel> finalFollowerEmployeeList = [];
  List<String> idsFollowerEmployeeList = [];

  //
  List<File> _selectedImage = [];
  List<File> _selectedImageForComment = [];

  getBaseUrlImage() async {
    final userData = await UserUtils.userTypeFromCache();
    setState(() {
      baseUrl = userData!.baseDomainURL;
    });
  }

  List customAssignListBool = [];
  List customFollowerListBool = [];

  getCommentsList({String? id}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final data = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "Flag": "GetCmnt",
      "Id": id,
      "TaskName": "",
      "StartDate": "",
      "DueDate": "",
      "Priority": "",
      "Status": "",
      "CreatedID": userData.stuEmpId,
      "FollowUp": "",
      "AssignTo": "",
      "UserType": userData.ouserType,
      "EmpId": userData.stuEmpId,
    };

    print("sending data for task data $data");

    context
        .read<GetCommentsEmployeeTaskCubit>()
        .getCommentsEmployeeTaskData(data);
  }

  getEmployeeList2() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final data = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "SessionId": userData.currentSessionid,
      "StuEmpId": userData.stuEmpId,
      "UserType": userData.ouserType,
      "Flag": "BindEmployee",
      "Id": "",
    };

    print("sending data for getEmployeeTaskManagement $data");

    context
        .read<GetEmployeeTaskManagement2Cubit>()
        .getEmployeeTaskManagement2CubitCall(data);
  }

  getEmployeeTaskStatus() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final data = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "SessionId": userData.currentSessionid,
      "StuEmpId": userData.stuEmpId,
      "UserType": userData.ouserType,
      "Flag": "BindEmpStatus",
      "Id": "",
    };

    print("sending data for getEmployeeTaskManagement $data");

    context
        .read<GetEmployeeTaskStatusCubit>()
        .getEmployeeTaskStatusCubitCall(data);
  }

  saveTask({
    String? name,
    String? detail,
    String? sDate,
    String? dDate,
    String? follower,
    String? priority,
    String? assign,
    List<File>? img,
  }) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final data = {
      "UserId": uid.toString(),
      "Token": token.toString(),
      "OrgId": userData!.organizationId.toString(),
      "SchoolId": userData.schoolId.toString(),
      "UserType": userData.ouserType.toString(),
      "SessionId": userData.currentSessionid.toString(),
      "TaskName": name.toString(),
      "TaskDetails": detail.toString(),
      "ID": "",
      "StartDate": sDate.toString(),
      "DueDate": dDate.toString(),
      //20-Nov-2021
      "Status": "1".toString(),
      "FollowerToArr": follower.toString(),
      //327
      "Priority": priority.toString(),
      "CreatedBy": userData.stuEmpId.toString(),
      "AssignToArr": assign.toString(),
      "Flag": "I",
    };

    print('sending data for save task $data');

    context.read<SaveTaskDetailsCubit>().saveTaskDetailsCubitCall(data, img);
  }

  updateTask({
    String? name,
    String? detail,
    String? sDate,
    String? dDate,
    String? follower,
    String? priority,
    String? assign,
    List<File>? img,
    String? id,
    String? status,
  }) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final data = {
      "UserId": uid.toString(),
      "Token": token.toString(),
      "OrgId": userData!.organizationId.toString(),
      "SchoolId": userData.schoolId.toString(),
      "UserType": userData.ouserType.toString(),
      "SessionId": userData.currentSessionid.toString(),
      "TaskName": name.toString(),
      "TaskDetails": detail.toString(),
      "ID": id != null ? id : "",
      "StartDate": sDate.toString(),
      "DueDate": dDate.toString(),
      //20-Nov-2021
      "Status": status == null ? "1" : status,
      "FollowerToArr": follower.toString(),
      //327
      "Priority": priority.toString(),
      "CreatedBy": userData.stuEmpId.toString(),
      "AssignToArr": assign.toString(),
      "Flag": widget.userType!.toLowerCase() != "e" ? "U" : "UpdateCmnt",
    };

    print('sending data for update task $data');

    context.read<SaveTaskDetailsCubit>().saveTaskDetailsCubitCall(data, img);
  }

  getUserType() async {
    final userData = await UserUtils.userTypeFromCache();
    setState(() {
      userType = userData!.ouserType;
    });
  }

  @override
  void initState() {
    widget.name != null
        ? _nameController.text = widget.name!
        : _nameController.text = "";
    widget.detail != null
        ? _detailController.text = widget.detail!
        : _detailController.text = "";
    widget.sdate != null
        ? startDate = widget.sdate!
        : startDate = DateTime.now();
    widget.ddate != null ? dueDate = widget.ddate! : dueDate = DateTime.now();
    widget.priority != null
        ? _selectedPriority = widget.priority
        : _selectedPriority = "Select Priority";
    widget.image != "" && widget.image != null
        ? _selectedImage = [File("${widget.image!}")]
        : _selectedImage = [];

    getUserType();
    widget.userType != "e" ? getEmployeeList2() : "";
    getBaseUrlImage();
    getEmployeeTaskStatus();
    getCommentsList(id: widget.id);
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _detailController.dispose();
    super.dispose();
  }

  Widget buildDateSelector({int? index}) {
    return IgnorePointer(
      ignoring: widget.userType!.toLowerCase() != "e" ? false : true,
      child: GestureDetector(
        onTap: () => _selectDate(context, index: index),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xffECECEC)),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 4,
                child: Text(
                  index == 0
                      ? "${DateFormat('dd-MM-yyyy').format(startDate)}"
                      : "${DateFormat('dd-MM-yyyy').format(dueDate)}",
                  overflow: TextOverflow.visible,
                  maxLines: 1,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Icon(Icons.today, color: Theme.of(context).primaryColor)
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, {int? index}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      helpText: "SELECT START DATE",
    );
    if (index == 0) {
      if (picked != null && picked != startDate) {
        setState(() {
          startDate = picked;
        });
      }
    } else {
      if (picked != null && picked != dueDate) {
        setState(() {
          dueDate = picked;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, title: "Add New Task"),
      body: buildNewTaskBody(context),
    );
  }

  Widget buildNewTaskBody(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<GetEmployeeTaskManagement2Cubit,
            GetEmployeeTaskManagement2State>(
          listener: (context, state) {
            if (state is GetEmployeeTaskManagement2LoadSuccess) {
              state.empList.sort((c, d) => (c.name)!.compareTo(d.name!));
              setState(() {
                employeeList = state.empList;
                employeeList2 = state.empList;
              });

              //

              employeeList.forEach((element) {
                setState(() {
                  customAssignListBool.add(false);
                  customFollowerListBool.add(false);
                });
              });

              // for (int v = 0; v < employeeList.length; v++) {
              //   setState(() {
              //     customClassListBool[v] = false;
              //     customClassListBool2[v] = false;
              //   });
              // }

              if (widget.assign != null) {
                List<String> assignids = widget.assign!.split(",");
                // main tick for class acq to coordinator
                for (int i = 0; i < employeeList.length; i++) {
                  for (int j = 0; j < assignids.length; j++) {
                    if (employeeList[i].id.toString() ==
                        assignids[j].toString()) {
                      setState(() {
                        customAssignListBool[i] = true;
                        assignName = assignName! + "${employeeList[i].name} , ";
                      });
                    }
                  }
                }
                idsAssignEmployeeList = assignids;
              }

              if (widget.follower != null) {
                List<String> followerids = widget.follower!.split(",");
                // main tick for class acq to coordinator
                for (int i = 0; i < employeeList2.length; i++) {
                  for (int j = 0; j < followerids.length; j++) {
                    if (employeeList2[i].id.toString() ==
                        followerids[j].toString()) {
                      setState(() {
                        customFollowerListBool[i] = true;
                        followerName =
                            followerName! + "${employeeList2[i].name} , ";
                      });
                    }
                  }
                }
                idsFollowerEmployeeList = followerids;
              }
            }
            if (state is GetEmployeeTaskManagement2LoadFail) {
              setState(() {
                employeeList = [];
              });
            }
          },
        ),
        BlocListener<SaveTaskDetailsCubit, SaveTaskDetailsState>(
            listener: (context, state) {
          if (state is SaveTaskDetailsLoadInProgress) {
            setState(() {
              isLoader = true;
            });
          }
          if (state is SaveTaskDetailsLoadSuccess) {
            setState(() {
              _nameController.text = "";
              _detailController.text = "";
              finalFollowerEmployeeList = [];
              finalAssignEmployeeList = [];
              employeeList = [];
              _selectedPriority = priorityDropdown[0];
              _selectedImage = [];
              startDate = DateTime.now();
              dueDate = DateTime.now();
              customAssignListBool = [];
              customFollowerListBool = [];
              //
              widget.image = "";
            });
            getEmployeeList2();
            ScaffoldMessenger.of(context).showSnackBar(commonSnackBar(
                title:
                    "${widget.isUpdate != true ? "Task Added" : "Task Updated"}",
                duration: Duration(seconds: 1)));

            //close loader
            setState(() {
              isLoader = false;
            });
            Navigator.pop(context);
          }
          if (state is SaveTaskDetailsLoadFail) {
            if (state.failReason == "false") {
              UserUtils.unauthorizedUser(context);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(commonSnackBar(
                  title: "${state.failReason}",
                  duration: Duration(seconds: 1)));
              //close loader
              setState(() {
                isLoader = false;
              });
            }
          }
        }),
        BlocListener<GetEmployeeTaskStatusCubit, GetEmployeeTaskStatusState>(
            listener: (context, state) {
          if (state is GetEmployeeTaskStatusLoadSuccess) {
            setState(() {
              state.empList.insert(0,
                  GetEmployeeTaskManagementModel(id: 0, name: "Select Status"));
              _selectedTaskStatus = state.empList[0];
              taskStatusDropdown = state.empList;
            });
          }

          if (state is GetEmployeeTaskStatusLoadFail) {
            if (state.failReason == "false") {
              UserUtils.unauthorizedUser(context);
            } else {}
          }
        }),
        BlocListener<GetCommentsEmployeeTaskCubit,
            GetCommentsEmployeeTaskState>(listener: (context, state) {
          if (state is GetCommentsEmployeeLoadSuccess) {
            setState(() {
              print("comment list");
              commentList = state.result;
            });
          }
          if (state is GetCommentsEmployeeLoadFail) {
            setState(() {
              commentList = [];
            });
          }
        }),
      ],
      child: SingleChildScrollView(
        child: Form(
          key: _newTaskKey,
          child: Column(
            children: [
              buildCurrentTextFields(
                label: "Task Name:",
                controller: _nameController,
                validator: FieldValidators.globalValidator,
              ),
              buildCurrentTextFields(
                label: "Add Task Details:",
                controller: _detailController,
                validator: FieldValidators.globalValidator,
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildLabels("Start Date:"),
                          buildDateSelector(index: 0),
                        ],
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildLabels("Due Date:"),
                          buildDateSelector(index: 1),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 7,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    buildPriorityDropdown(),
                    // SizedBox(width: 20),
                    // buildDropdown(
                    //     label: "Task:",
                    //     selectedValue: _selectedTaskStatus,
                    //     dropdown: taskStatusDropdown),
                  ],
                ),
              ),
              SizedBox(height: 10),

              //Multi Select
              // buildAssignToSelectDialog(),
              // buildFollowerSelectDialog(),
              //

              widget.userType!.toLowerCase() != "e"
                  ? buttonModalBottomSheetForAssign(empList: employeeList)
                  : Container(
                      width: MediaQuery.of(context).size.width * 0.92,
                      margin: EdgeInsets.all(8),
                      padding: EdgeInsets.only(left: 6, top: 12, bottom: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(width: 0.08),
                      ),
                      child: Text(
                        "Assigned: $assignName",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
              widget.userType!.toLowerCase() != "e"
                  ? buttonModalBottomSheetForFollower(empList: employeeList2)
                  : Container(
                      width: MediaQuery.of(context).size.width * 0.92,
                      margin: EdgeInsets.all(8),
                      padding: EdgeInsets.only(left: 6, top: 12, bottom: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(width: 0.08),
                      ),
                      child: Text(
                        "Follower: $followerName",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
              //
              SizedBox(height: 20),
              widget.image == "" || widget.image == null
                  ? widget.userType!.toLowerCase() == "a" ||
                          widget.userType!.toLowerCase() == "m" ||
                          widget.userType!.toLowerCase() == "p"
                      ? _selectedImage.length == 0
                          ? buildAddFileButton(context)
                          : Row(
                              children: [
                                SizedBox(
                                    width: _selectedImage[0]
                                                .path
                                                .split('.')
                                                .last
                                                .toLowerCase() !=
                                            'pdf'
                                        ? MediaQuery.of(context).size.width *
                                            0.2
                                        : MediaQuery.of(context).size.width *
                                            0.055),
                                _selectedImage[0]
                                            .path
                                            .split('.')
                                            .last
                                            .toLowerCase() !=
                                        'pdf'
                                    ? Container(
                                        height: 150,
                                        width: 150,
                                        decoration: BoxDecoration(
                                            border: Border.all(width: 0.2)),
                                        child: Image.file(
                                          _selectedImage[0],
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : Row(
                                        children: [
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
                                                '${_selectedImage[0].path.split('/')[7].split('.')[0]}',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedImage = [];
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.red.shade500,
                                      border: Border.all(width: 0.1),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    margin: EdgeInsets.all(10),
                                    padding: EdgeInsets.all(8),
                                    child: Text(
                                      'Remove Image',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                )
                              ],
                            )
                      : Container()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 150,
                          height: 150,
                          child: Image.network(
                              "$baseUrl${_selectedImage[0].path}",
                              errorBuilder: (buildContext, object, stackTrace) {
                            print(
                                "building image ${"$baseUrl${_selectedImage[0].path}"}");
                            return Image.asset(AppImages.dummyImage);
                          }),
                        ),
                        widget.userType!.toLowerCase() != "e"
                            ? GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedImage = [];
                                    widget.image = null;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.red.shade500,
                                    border: Border.all(width: 0.1),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  margin: EdgeInsets.all(10),
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    'Remove Image',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              )
                            : Container()
                      ],
                    ),
              SizedBox(height: widget.userType!.toLowerCase() == "a" ? 20 : 0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  widget.isUpdate != true ? buildClearButton() : Container(),
                  widget.userType!.toLowerCase() != "e"
                      ? buildSaveButton()
                      : Container(),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              widget.userType!.toLowerCase() == "e"
                  ? Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      decoration:
                          BoxDecoration(border: Border.all(width: 0.08)),
                      child: Column(
                        children: [
                          Text(
                            "Update Status",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          buildCurrentTextFieldsForComments(
                              label: "Add Comments",
                              controller: _commentController,
                              validator: FieldValidators.globalValidator),
                          Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              child: buildTaskStatusDropdown()),
                          SizedBox(
                            height: 20,
                          ),
                          _selectedImageForComment.length == 0
                              ? buildAddFileButtonEmployee(context)
                              : Row(
                                  children: [
                                    SizedBox(
                                        width: _selectedImageForComment[0]
                                                    .path
                                                    .split('.')
                                                    .last
                                                    .toLowerCase() !=
                                                'pdf'
                                            ? MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.2
                                            : MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.055),
                                    _selectedImageForComment[0]
                                                .path
                                                .split('.')
                                                .last
                                                .toLowerCase() !=
                                            'pdf'
                                        ? Container(
                                            height: 120,
                                            width: 120,
                                            decoration: BoxDecoration(
                                                border: Border.all(width: 0.2)),
                                            child: Image.file(
                                              _selectedImageForComment[0],
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                        : Row(
                                            children: [
                                              Icon(
                                                Icons.picture_as_pdf,
                                                size: 30,
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border:
                                                      Border.all(width: 0.01),
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                                // margin: EdgeInsets.all(10),
                                                padding: EdgeInsets.all(4),
                                                height: 30,
                                                width: 150,
                                                child: Center(
                                                  child: Text(
                                                    '${_selectedImageForComment[0].path.split('/')[7].split('.')[0]}',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _selectedImageForComment = [];
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.red.shade500,
                                          border: Border.all(width: 0.1),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        margin: EdgeInsets.all(10),
                                        padding: EdgeInsets.all(8),
                                        child: Text(
                                          'Remove Image',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          buildCommentButton(),
                        ],
                      ),
                    )
                  : Container(),
              SizedBox(
                height: 10,
              ),

              widget.userType!.toLowerCase() == "e"
                  ? Text(
                      "All Comments",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                      ),
                    )
                  : Container(),
              widget.userType!.toLowerCase() == "e"
                  ? Container(
                      color: Colors.white,
                      height: MediaQuery.of(context).size.height * 0.55,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: commentList!.length > 0
                          ? ListView.builder(
                              shrinkWrap: true,
                              itemCount: commentList!.length,
                              itemBuilder: (context, index) {
                                var item = commentList![index];
                                return Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      border: Border.all(width: 0.09),
                                      borderRadius: BorderRadius.circular(4)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "${item.taskName}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                            ),
                                          ),
                                          Text(
                                            "${item.empName}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: 6,
                                                right: 6,
                                                top: 2,
                                                bottom: 2),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                width: 0.1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              color: item.statusVal == "Pending"
                                                  ? Colors.blue
                                                  : Colors.green,
                                            ),
                                            child: Text(
                                              item.statusVal!,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          Text("${item.craedtedOn}"),
                                        ],
                                      ),
                                      Text(
                                        "Comment Details: ${item.comments}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              })
                          : Center(
                              child: Container(
                              child: Text(
                                "No Record",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )))
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAssignToSelectDialog() {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(width: 0.1)),
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      padding: EdgeInsets.all(2),
      child: MultiSelectBottomSheetField<GetEmployeeTaskManagementModel>(
        key: _assignToSelectKey,
        initialChildSize: 0.7,
        maxChildSize: 0.95,
        title: Text(
          "Staff",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        buttonText: Text(
          "Assign To",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        items:
            employeeList.map((e) => MultiSelectItem(e, '${e.name}')).toList(),
        searchable: true,
        decoration: BoxDecoration(border: Border.all(color: Colors.white)),
        validator: (values) {
          if (values == null || values.isEmpty) {
            return "Required";
          }
          // return values;
        },
        onConfirm: (values) {
          setState(() {
            finalAssignEmployeeList = values;
          });
          setState(() {
            idsAssignEmployeeList = [];
          });

          finalAssignEmployeeList.forEach((element) {
            setState(() {
              idsAssignEmployeeList.add(element.id.toString());
            });
          });
        },
        chipDisplay: MultiSelectChipDisplay(),
      ),
    );
  }

  Widget buildFollowerSelectDialog() {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(width: 0.1)),
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      padding: EdgeInsets.all(2),
      child: MultiSelectBottomSheetField<GetEmployeeTaskManagementModel>(
        key: _followerSelectKey,
        initialChildSize: 0.7,
        maxChildSize: 0.95,
        title: Text(
          "Select Follower",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        buttonText: Text(
          "Add Follower",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        items:
            employeeList.map((e) => MultiSelectItem(e, '${e.name}')).toList(),
        searchable: true,
        autovalidateMode: AutovalidateMode.disabled,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
        ),
        validator: (values) {
          if (values == null || values.isEmpty) {
            return "Required";
          }
        },
        onConfirm: (values) {
          setState(() {
            finalFollowerEmployeeList = values;
          });

          setState(() {
            idsFollowerEmployeeList = [];
          });

          finalFollowerEmployeeList.forEach((element) {
            setState(() {
              idsFollowerEmployeeList.add(element.id.toString());
            });
          });
        },
        chipDisplay: MultiSelectChipDisplay(
          onTap: (item) {
            setState(() {});
          },
        ),
      ),
    );
  }

  Widget buildSaveButton() {
    return isLoader == false
        ? Container(
            width: MediaQuery.of(context).size.width * 0.3,
            margin:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(33.0),
              color: Colors.green,
            ),
            child: TextButton(
              style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.transparent)),
              onPressed: () async {
                if (_newTaskKey.currentState!.validate()) {
                  final String path =
                      (await getApplicationSupportDirectory()).path;
                  final String fileName = '$path/${widget.image}';
                  final File file = File(fileName);

                  if (widget.image != "" && widget.image != null) {
                    _selectedImage = [File(widget.image!)];
                  }

                  widget.isUpdate != true
                      ? saveTask(
                          name: _nameController.text,
                          detail: _detailController.text,
                          sDate: DateFormat('dd-MMM-yyyy').format(startDate),
                          dDate: DateFormat('dd-MMM-yyyy').format(dueDate),
                          follower: idsFollowerEmployeeList.join(","),
                          assign: idsAssignEmployeeList.join(","),
                          priority: _selectedPriority,
                          img: _selectedImage,
                        )
                      : updateTask(
                          name: _nameController.text,
                          detail: _detailController.text,
                          sDate: DateFormat('dd-MMM-yyyy').format(startDate),
                          dDate: DateFormat('dd-MMM-yyyy').format(dueDate),
                          follower: idsFollowerEmployeeList.join(","),
                          assign: idsAssignEmployeeList.join(","),
                          priority: _selectedPriority,
                          // img: [file],
                          img: _selectedImage,
                          id: widget.id,
                        );
                }
              },
              child: Text(
                "${widget.isUpdate != true ? "Save Task" : "Update Task"}",
                style: TextStyle(
                    fontFamily: "BebasNeue-Regular",
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
          )
        : CircularProgressIndicator();
  }

  Container buildCommentButton() {
    return Container(
      //width: MediaQuery.of(context).size.width * 0.3,
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(33.0),
        color: Colors.green,
      ),
      child: TextButton(
        style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(Colors.transparent)),
        onPressed: () async {
          if (_commentController.text != "") {
            updateTask(
              name: "",
              detail: _commentController.text,
              sDate: "",
              dDate: "",
              follower: "",
              assign: "",
              priority: "",
              img: _selectedImageForComment,
              id: widget.id,
              status: _selectedTaskStatus!.id.toString(),
            );
          }
        },
        child: Text(
          "Update Status",
          style: TextStyle(
              fontFamily: "BebasNeue-Regular",
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Container buildClearButton() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(33.0),
        color: Colors.red,
      ),
      child: TextButton(
        style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(Colors.transparent)),
        onPressed: () {
          setState(() {
            _nameController.text = "";
            _detailController.text = "";
            finalFollowerEmployeeList = [];
            finalAssignEmployeeList = [];
            employeeList = [];
            _selectedPriority = priorityDropdown[0];
            _selectedImage = [];
            startDate = DateTime.now();
            dueDate = DateTime.now();
          });
          getEmployeeList2();
        },
        child: Text(
          "Clear",
          style: TextStyle(
              fontFamily: "BebasNeue-Regular",
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Expanded buildPriorityDropdown() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          buildLabels('Select Priority'),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xffECECEC)),
              // borderRadius: BorderRadius.circular(4),
            ),
            child: IgnorePointer(
              ignoring: widget.userType!.toLowerCase() != "e" ? false : true,
              child: Listener(
                onPointerDown: (_) => FocusScope.of(context).unfocus(),
                child: DropdownButton<String>(
                  isDense: true,
                  value: _selectedPriority,
                  key: UniqueKey(),
                  isExpanded: true,
                  underline: Container(),
                  items: priorityDropdown
                      .map((item) => DropdownMenuItem<String>(
                          child: Text(item,
                              style: TextStyle(
                                fontSize: 14,
                              )),
                          value: item))
                      .toList(),
                  onChanged: (val) {
                    setState(() {
                      _selectedPriority = val;
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column buildTaskStatusDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16),
        buildLabels('Select Status'),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xffECECEC)),
            // borderRadius: BorderRadius.circular(4),
          ),
          child: DropdownButton<GetEmployeeTaskManagementModel>(
            isDense: true,
            value: _selectedTaskStatus,
            key: UniqueKey(),
            isExpanded: true,
            underline: Container(),
            items: taskStatusDropdown
                .map((item) => DropdownMenuItem<GetEmployeeTaskManagementModel>(
                    child: Text("${item.name}", style: TextStyle(fontSize: 14)),
                    value: item))
                .toList(),
            onChanged: (val) {
              setState(() {
                _selectedTaskStatus = val;
              });
            },
          ),
        ),
      ],
    );
  }

  Container buildCurrentTextFields(
      {String? label,
      TextEditingController? controller,
      String? Function(String?)? validator}) {
    return Container(
      // color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildLabels(label!),
          buildTextField(
            controller: controller,
            validator: validator,
          ),
        ],
      ),
    );
  }

  Container buildCurrentTextFieldsForComments(
      {String? label,
      TextEditingController? controller,
      String? Function(String?)? validator}) {
    return Container(
      // color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildLabels(label!),
          buildTextFieldForComments(
            controller: controller,
            validator: validator,
          ),
        ],
      ),
    );
  }

  Padding buildLabels(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        label,
        style: TextStyle(
          color: Color(0xff313131),
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Container buildTextField({
    String? Function(String?)? validator,
    @required TextEditingController? controller,
  }) {
    return Container(
      child: TextFormField(
        enabled: widget.userType!.toLowerCase() != "e" ? true : false,
        controller: controller,
        validator: validator,
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
          hintText: "type here",
          hintStyle: TextStyle(color: Color(0xffA5A5A5)),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
        ),
      ),
    );
  }

  Container buildTextFieldForComments({
    String? Function(String?)? validator,
    @required TextEditingController? controller,
  }) {
    return Container(
      child: TextFormField(
        controller: controller,
        validator: validator,
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
          hintText: "type here",
          hintStyle: TextStyle(color: Color(0xffA5A5A5)),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
        ),
      ),
    );
  }

  GestureDetector buildAddFileButton(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        List<File>? file = await showFilePicker(allowMultiple: false);
        if (file != null) {
          setState(() {
            _selectedImage = file;
          });
        }
      },
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.3,
          decoration: BoxDecoration(
              border: Border.all(width: 0.2),
              borderRadius: BorderRadius.circular(20),
              color: Colors.green),
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(8),
          child: Center(
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              RichText(
                text: TextSpan(
                  text: '  + ',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 20),
                ),
              ),
              RichText(
                text: TextSpan(
                  text: 'Add File',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }

  GestureDetector buildAddFileButtonEmployee(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        List<File>? file = await showFilePicker(allowMultiple: false);
        if (file != null) {
          setState(() {
            _selectedImageForComment = file;
          });
        }
      },
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.3,
          decoration: BoxDecoration(
              border: Border.all(width: 0.2),
              borderRadius: BorderRadius.circular(20),
              color: Colors.green),
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(8),
          child: Center(
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              RichText(
                text: TextSpan(
                  text: '  + ',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 20),
                ),
              ),
              RichText(
                text: TextSpan(
                  text: 'Add File',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }

  //
  /// 2 bottom sheet

  //Todo:Use this custom multi select class dropdown
  Center buttonModalBottomSheetForAssign(
      {List<GetEmployeeTaskManagementModel>? empList}) {
    return Center(
      child: GestureDetector(
        onTap: () async {
          await customMultiSelect(empList: empList);
          //Add to count
          setState(() {
            idsAssignEmployeeList.length = idsAssignEmployeeList.length;
          });
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(border: Border.all(width: 0.05)),
          padding: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width * 0.92,
          height: MediaQuery.of(context).size.height * 0.06,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${idsAssignEmployeeList.length < 1 ? "Assign" : "${idsAssignEmployeeList.length} Selected"}",
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
      {List<GetEmployeeTaskManagementModel>? empList}) {
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
                      'Assign List',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(
                        height: 2,
                      ),
                      itemCount: empList!.length,
                      itemBuilder: (context, index) {
                        var item = empList[index];
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${item.name}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Checkbox(
                                value: customAssignListBool[index],
                                onChanged: (val) {
                                  setState(
                                    () {
                                      customAssignListBool[index] =
                                          !customAssignListBool[index];
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
                    //margin: EdgeInsets.only(top: 9, bottom: 9),
                    //padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(
                      width: 0.2,
                      color: Colors.black,
                    ))
                        // border: Border.symmetric(
                        //   vertical: BorderSide.none,
                        //   horizontal: BorderSide(width: 0.1),
                        // ),
                        ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          // style: ButtonStyle(
                          //     backgroundColor:
                          //         MaterialStateProperty.all(Colors.white)),
                          child: Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              //padding: EdgeInsets.all(8),
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
                        // GestureDetector(
                        //   onTap: () {
                        //     Navigator.pop(context);
                        //   },
                        //   child: Container(
                        //       width: MediaQuery.of(context).size.width * 0.4,
                        //       padding: EdgeInsets.all(8),
                        //       child: Center(
                        //         child: Text(
                        //           'Cancel',
                        //           style: TextStyle(
                        //             //color: Colors.black,
                        //             color: Theme.of(context).primaryColor,
                        //             fontSize: 16,
                        //             fontWeight: FontWeight.w600,
                        //           ),
                        //         ),
                        //       )),
                        // ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              finalAssignEmployeeList = [];
                              idsAssignEmployeeList = [];
                            });

                            for (int i = 0; i < empList.length; i++) {
                              if (customAssignListBool[i] == true) {
                                setState(() {
                                  // finalClassSendingList!
                                  //     .add({"ClassID": "${classList[i].id}"});
                                  idsAssignEmployeeList
                                      .add(empList[i].id.toString());
                                });
                              }
                            }
                            print(idsAssignEmployeeList);
                            Navigator.pop(context);
                          },
                          // style: ButtonStyle(
                          //     backgroundColor:
                          //         MaterialStateProperty.all(Colors.white)),
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

  //Todo:Use this custom multi select class dropdown
  Center buttonModalBottomSheetForFollower(
      {List<GetEmployeeTaskManagementModel>? empList}) {
    return Center(
      child: GestureDetector(
        onTap: () async {
          await customMultiSelectFollower(empList: empList);
          setState(() {
            idsFollowerEmployeeList.length = idsFollowerEmployeeList.length;
          });
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(border: Border.all(width: 0.05)),
          padding: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width * 0.92,
          height: MediaQuery.of(context).size.height * 0.06,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${idsFollowerEmployeeList.length < 1 ? "Follower" : "${idsFollowerEmployeeList.length} Selected"}",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Icon(Icons.arrow_downward)
            ],
          ),
        ),
      ),
    );
  }

  Future<Widget?> customMultiSelectFollower(
      {List<GetEmployeeTaskManagementModel>? empList}) {
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
                      'Follower List',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(
                        height: 2,
                      ),
                      itemCount: empList!.length,
                      itemBuilder: (context, index) {
                        var item = empList[index];
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${item.name}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Checkbox(
                                value: customFollowerListBool[index],
                                onChanged: (val) {
                                  setState(
                                    () {
                                      customFollowerListBool[index] =
                                          !customFollowerListBool[index];
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
                    ))),
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
                              finalFollowerEmployeeList = [];
                              idsFollowerEmployeeList = [];
                            });

                            for (int i = 0; i < empList.length; i++) {
                              if (customFollowerListBool[i] == true) {
                                setState(() {
                                  // finalClassSendingList!
                                  //     .add({"ClassID": "${classList[i].id}"});
                                  idsFollowerEmployeeList
                                      .add(empList[i].id.toString());
                                });
                              }
                            }
                            print(idsFollowerEmployeeList);
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

  String getPriority() {
    switch (_selectedPriority) {
      case ("Select Priority"):
        {
          return "0";
        }
      case ("High"):
        {
          return "High";
        }
      case ("Medium"):
        {
          return "Medium";
        }
      case ("Low"):
        {
          return "Low";
        }
      default:
        {
          return "N/A";
        }
    }
  }
}
