import 'package:campus_pro/src/DATA/BLOC_CUBIT/DELETE_TASK_DETAIL_CUBIT/delete_task_detail_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/GET_EMPLOYEE_TASK_MANAGEMENT/get_employee_task_management_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/GET_TASK_DATA_CUBIT/get_task_data_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/GET_TASK_DATA_EMPLOYEE/get_tesk_data_employee_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/GET_TASK_LIST_BY_ID_CUBIT/get_task_list_by_id_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/GET_TASK_TASK_MANAGEMENT_CUBIT/get_task_task_management_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/getEmployeeTaskManagementModel.dart';
import 'package:campus_pro/src/DATA/MODELS/getTaskDataEmployeeModel.dart';
import 'package:campus_pro/src/DATA/MODELS/getTaskDataModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/PAGES/STAND_ALONE_PAGES/Task_Management/addTask.dart';
import 'package:campus_pro/src/UI/PAGES/STAND_ALONE_PAGES/Task_Management/taskManagementDetail.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonSnackbar.dart';
import 'package:campus_pro/src/UI/WIDGETS/drawerWidget.dart';
import 'package:campus_pro/src/UTILS/fieldValidators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../globalBlocProvidersFile.dart';

class TaskManagement extends StatefulWidget {
  static const routeName = "/task-management";
  final String? userType;

  const TaskManagement({Key? key, this.userType}) : super(key: key);
  @override
  _TaskManagementState createState() => _TaskManagementState();
}

class _TaskManagementState extends State<TaskManagement> {
  bool filterOpen = false;

  String? currentUserId;

  List<GetTaskDataModel>? taskList;
  List<GetTaskDataEmployeeModel>? taskListEmployee;

  //filter

  DateTime? startDate;
  DateTime? dueDate;

  TextEditingController _nameController = TextEditingController();

  List<String> priorityDropdown = ['Select Priority', 'High', 'Medium', "Low"];
  String? _selectedPriority = 'Select Priority';

  GetEmployeeTaskManagementModel? _selectedTaskStatus;
  List<GetEmployeeTaskManagementModel> taskStatusDropdown = [];

  GetEmployeeTaskManagementModel? _selectedUserStatus;

  List<GetEmployeeTaskManagementModel> employeeList = [];

  // assign multi select
  // final _assignToSelectKey = GlobalKey<FormFieldState>();
  List<GetEmployeeTaskManagementModel> finalAssignEmployeeList = [];
  List<String> idsAssignEmployeeList = [];

  //assign dropdown
  GetEmployeeTaskManagementModel? selectedAssignEmployee;
  List<GetEmployeeTaskManagementModel> assignDropdownEmployee = [];

  //follower multi select
  // final _followerSelectKey = GlobalKey<FormFieldState>();
  List<GetEmployeeTaskManagementModel> finalFollowerEmployeeList = [];
  List<String> idsFollowerEmployeeList = [];

  //follower dropdown
  GetEmployeeTaskManagementModel? selectedFollowerEmployee;
  List<GetEmployeeTaskManagementModel>? followerDropdownEmployee = [];

  getTaskList(
      {String? taskname,
      String? sdate,
      String? ddate,
      String? priority,
      String? status,
      //String? createdid,
      String? folloupids,
      String? assignids}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final data = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "Flag": "GetTasks",
      "Id": "",
      "TaskName": taskname != null ? taskname : "",
      "StartDate": sdate != null ? sdate : "",
      "DueDate": ddate != null ? ddate : "",
      "Priority": priority != null ? priority : "",
      "Status": status != null ? status : "",
      "CreatedID": "",
      "FollowUp": folloupids != null ? folloupids : "",
      "AssignTo": assignids != null ? assignids : "",
      "UserType": userData.ouserType,
      "EmpId": userData.stuEmpId,
    };

    print("sending data for task data $data");

    context.read<GetTaskDataCubit>().getTaskDataCubitData(data);
  }

  getTaskListEmployee({
    String? taskname,
    String? sdate,
    String? ddate,
    String? priority,
    String? status,
    //String? createdid,
    String? folloupids,
    String? assignids,
    String? id,
  }) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final data = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "Flag": "GetEmpTask",
      "Id": id != null ? id : "",
      "TaskName": taskname != null ? taskname : "",
      "StartDate": sdate != null ? sdate : "",
      "DueDate": ddate != null ? ddate : "",
      "Priority": priority != null ? priority : "",
      "Status": status != null ? status : "",
      "CreatedID": userData.stuEmpId,
      "FollowUp": folloupids != null ? folloupids : "",
      "AssignTo": assignids != null ? assignids : "",
      "UserType": userData.ouserType,
      "EmpId": userData.stuEmpId,
    };

    print("sending data for task data Employee $data");

    context.read<GetTeskDataEmployeeCubit>().getTeskDataEmployeeCubitData(data);
  }

  deleteTask({
    String? name,
    String? detail,
    String? sDate,
    String? dDate,
    String? follower,
    String? priority,
    String? assign,
    String? id,
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
      "ID": id != null ? id.toString() : "".toString(),
      "StartDate": sDate.toString(),
      "DueDate": dDate.toString(),
      //20-Nov-2021
      "Status": "1",
      "FollowerToArr": follower.toString(),
      //327
      "Priority": priority.toString(),
      "CreatedBy": userData.stuEmpId.toString(),
      "AssignToArr": assign.toString(),
      "Flag": "DeleteTask",
    };

    print('sending data for delete task $data');

    context
        .read<DeleteTaskDetailCubit>()
        .deleteTaskDetailsCubitCall(data, null);
  }

  getUserType() async {
    final userData = await UserUtils.userTypeFromCache();
    setState(() {
      currentUserId = userData!.stuEmpId;
    });
  }

  getEmployeeList() async {
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
        .read<GetEmployeeTaskManagementCubit>()
        .getEmployeeTaskManagementCubitCall(data);
  }

  getStatusList() async {
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
      "Flag": "BindStatus",
      "Id": "",
    };

    print("sending data for getEmployeeTaskManagement $data");

    context
        .read<GetTaskTaskManagementCubit>()
        .getTaskTaskManagementCubitCall(data);
  }

  getTaskListById({String? id}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final data = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "Flag": "GetTaskDataByID",
      "Id": id,
      "TaskName": "",
      "StartDate": "",
      "DueDate": "",
      "Priority": "",
      "Status": "",
      "CreatedID": "",
      "FollowUp": "",
      "AssignTo": "",
      "UserType": userData.ouserType,
      "EmpId": userData.stuEmpId,
    };

    print("sending data for task data $data");

    context.read<GetTaskListByIdCubit>().getTaskDataCubitData(data);
  }

  @override
  void initState() {
    print(widget.userType);
    getUserType();
    getTaskList();
    getEmployeeList();
    getStatusList();
    taskList = [];
    getTaskListEmployee();
    super.initState();
  }

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 1)).then((value) {
      getUserType();
      getTaskList();
      getEmployeeList();
      getStatusList();
      getTaskListEmployee();
      taskList = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: DrawerWidget(),
      appBar: commonAppBar(context, title: "Task Management"),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: widget.userType!.toUpperCase() == "A" ||
              widget.userType!.toUpperCase() == "M" ||
              widget.userType!.toUpperCase() == "P"
          ? FloatingActionButton(
              onPressed: () {
                // Navigator.pushNamed(context, AddTask.routeName,arguments: [widget.userType]);
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return BlocProvider<GetCommentsEmployeeTaskCubit>(
                    create: (_) => GetCommentsEmployeeTaskCubit(
                        GetCommentsEmployeeTaskRepository(
                            GetCommentsEmployeeTaskApi())),
                    child: BlocProvider<GetEmployeeTaskStatusCubit>(
                      create: (_) => GetEmployeeTaskStatusCubit(
                          GetEmployeeTaskManagementRepository(
                              GetEmployeeTaskManagementApi())),
                      child: BlocProvider<SaveTaskDetailsCubit>(
                        create: (_) => SaveTaskDetailsCubit(
                            SaveTaskDetailsRepository(SaveTaskDetailsApi())),
                        child: BlocProvider<GetEmployeeTaskManagement2Cubit>(
                          create: (_) => GetEmployeeTaskManagement2Cubit(
                              GetEmployeeTaskManagementRepository(
                                  GetEmployeeTaskManagementApi())),
                          child: AddTask(
                            userType: widget.userType,
                          ),
                        ),
                      ),
                    ),
                  );
                }));
              },
              child: Icon(Icons.add),
            )
          : SizedBox.shrink(),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: MultiBlocListener(listeners: [
          BlocListener<DeleteTaskDetailCubit, DeleteTaskDetailState>(
              listener: (context, state) {
            if (state is DeleteTaskDetailLoadSuccess) {
              getTaskList();
              ScaffoldMessenger.of(context).showSnackBar(commonSnackBar(
                  title: "Task Deleted", duration: Duration(seconds: 1)));
            }
            if (state is DeleteTaskDetailLoadFail) {
              if (state.failReason == "false") {
                UserUtils.unauthorizedUser(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(commonSnackBar(
                    title: "${state.failReason}",
                    duration: Duration(seconds: 1)));
              }
            }
          }),
          BlocListener<GetEmployeeTaskManagementCubit,
              GetEmployeeTaskManagementState>(
            listener: (context, state) {
              if (state is GetEmployeeTaskManagementLoadSuccess) {
                setState(() {
                  state.empList.sort((c, d) => (c.name)!.compareTo(d.name!));
                  state.empList.insert(0,
                      GetEmployeeTaskManagementModel(id: -1, name: "Select"));
                  employeeList = state.empList;
                  selectedAssignEmployee = state.empList[0];
                  selectedFollowerEmployee = state.empList[0];
                });
              }
              if (state is GetEmployeeTaskManagementLoadFail) {
                setState(() {
                  employeeList = [];
                });
              }
            },
          ),
          BlocListener<GetTaskTaskManagementCubit, GetTaskTaskManagementState>(
            listener: (context, state) {
              if (state is GetTaskTaskManagementLoadSuccess) {
                setState(() {
                  state.statusList.add(GetEmployeeTaskManagementModel(
                      id: 0, name: "Select Status"));
                  taskStatusDropdown = state.statusList;

                  _selectedTaskStatus = state.statusList.last;

                  //_selectedTaskStatus = state.statusList[0];
                  _selectedUserStatus = state.statusList.last;
                  //
                });
              }
              if (state is GetTaskTaskManagementLoadFail) {
                setState(() {
                  taskStatusDropdown = [];
                });
              }
            },
          ),
          BlocListener<GetTaskListByIdCubit, GetTaskListByIdState>(
              listener: (context, state) async {
            if (state is GetTaskListByIdLoadSuccess) {
              print(state.result[0].startDate);
              var sdate =
                  DateFormat("dd-MMM-yyyy").parse(state.result[0].startDate!);

              var ddate =
                  DateFormat("dd-MMM-yyyy").parse(state.result[0].dueDate!);
              //
              print(sdate);
              final userData = await UserUtils.userTypeFromCache();

              print("${userData!.baseDomainURL}${state.result[0].attachFile}");
              //
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return BlocProvider<GetCommentsEmployeeTaskCubit>(
                  create: (_) => GetCommentsEmployeeTaskCubit(
                      GetCommentsEmployeeTaskRepository(
                          GetCommentsEmployeeTaskApi())),
                  child: BlocProvider<GetEmployeeTaskStatusCubit>(
                    create: (_) => GetEmployeeTaskStatusCubit(
                        GetEmployeeTaskManagementRepository(
                            GetEmployeeTaskManagementApi())),
                    child: BlocProvider<SaveTaskDetailsCubit>(
                      create: (_) => SaveTaskDetailsCubit(
                          SaveTaskDetailsRepository(SaveTaskDetailsApi())),
                      child: BlocProvider<GetEmployeeTaskManagement2Cubit>(
                          create: (_) => GetEmployeeTaskManagement2Cubit(
                              GetEmployeeTaskManagementRepository(
                                  GetEmployeeTaskManagementApi())),
                          child: AddTask(
                            userType: widget.userType,
                            name: state.result[0].taskName,
                            detail: state.result[0].taskDetails,
                            sdate: sdate,
                            ddate: ddate,
                            priority: state.result[0].priority,
                            image: state.result[0].attachFile == ""
                                ? ""
                                : state.result[0].attachFile,
                            assign: state.result[0].assignUserID,
                            follower: state.result[0].followUPUserID,
                            isUpdate: true,
                            id: state.result[0].iD.toString(),
                          )),
                    ),
                  ),
                );
              }));
              // Navigator.push(context, MaterialPageRoute(builder: (context) {
              //   return AddTask(
              //     userType: widget.userType,
              //     name: state.result[0].taskName,
              //     detail: state.result[0].taskDetails,
              //     sdate: sdate,
              //     ddate: ddate,
              //     priority: state.result[0].priority,
              //     image: state.result[0].attachFile == ""
              //         ? ""
              //         : state.result[0].attachFile,
              //     assign: state.result[0].assignUserID,
              //     follower: state.result[0].followUPUserID,
              //     isUpdate: true,
              //     id: state.result[0].iD.toString(),
              //   );
              // }));
            }
            if (state is GetTaskListByIdLoadFail) {
              if (state.failReason == "false") {
                UserUtils.unauthorizedUser(context);
              }
            }
          }),
        ], child: buildTaskListBody(context, widget.userType)),
      ),
    );
  }

  Widget buildTaskListBody(BuildContext context, String? type) {
    return Container(
      margin: EdgeInsets.only(bottom: 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                filterOpen = !filterOpen;
              });
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Text(
                    "Filter",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontSize: 18,
                        ),
                  ),
                  Icon(
                    Icons.sort,
                    size: 25,
                  ),
                ],
              ),
            ),
          ),
          filterOpen == true ? buildTaskFilter() : Container(),
          widget.userType!.toLowerCase() != "e"
              ? BlocConsumer<GetTaskDataCubit, GetTaskDataState>(
                  listener: (context, state) {
                  if (state is GetTaskDataLoadSuccess) {
                    setState(() {
                      taskList = state.result;
                    });
                  }
                  if (state is GetTaskDataLoadFail) {
                    if (state.failReason == "false") {
                      UserUtils.unauthorizedUser(context);
                    } else {
                      setState(() {
                        taskList = [];
                      });
                    }
                  }
                }, builder: (context, state) {
                  if (state is GetTaskDataLoadInProgress) {
                    // return Center(child: CircularProgressIndicator());
                    return Center(child: LinearProgressIndicator());
                  } else if (state is GetTaskDataLoadSuccess) {
                    return checkList(taskList: taskList);
                  } else if (state is GetTaskDataLoadFail) {
                    return checkList(error: state.failReason);
                  } else {
                    return Container();
                  }
                })
              : BlocConsumer<GetTeskDataEmployeeCubit,
                  GetTeskDataEmployeeState>(listener: (context, state) {
                  if (state is GetTeskDataEmployeeLoadSuccess) {
                    setState(() {
                      taskListEmployee = state.empList;
                    });
                  }
                  if (state is GetTeskDataEmployeeLoadFail) {
                    if (state.failReason == "false") {
                      UserUtils.unauthorizedUser(context);
                    } else {
                      setState(() {
                        taskListEmployee = [];
                      });
                    }
                  }
                }, builder: (context, state) {
                  if (state is GetTeskDataEmployeeLoadInProgress) {
                    // return Center(child: CircularProgressIndicator());
                    return Center(child: LinearProgressIndicator());
                  } else if (state is GetTeskDataEmployeeLoadSuccess) {
                    return checkListEmployee(taskList: taskListEmployee);
                  } else if (state is GetTeskDataEmployeeLoadFail) {
                    return checkListEmployee(error: state.failReason);
                  } else {
                    return Container();
                  }
                })
        ],
      ),
    );
  }

  Widget checkList({List<GetTaskDataModel>? taskList, String? error}) {
    if (taskList == null || taskList.isEmpty) {
      if (error == null || error.isEmpty) {
        return Center(
          child: Text(
            "Wait",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        );
      } else {
        return Center(
          child: Text(
            "$error",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        );
      }
    } else {
      return buildTaskList(taskList: taskList);
    }
  }

  Container buildTaskFilter() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black12, width: 2.0),
        ),
      ),
      child: Column(
        children: [
          buildCurrentTextFields(
            label: "Task Name:",
            controller: _nameController,
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
                SizedBox(width: 20),
                // buildDropdown(
                //     label: "Task:",
                //     selectedValue:  _selectedTaskStatus,
                //     dropdown: taskStatusDropdown),
                buildStatusDropdown(),
              ],
            ),
          ),
          SizedBox(height: 10),
          widget.userType!.toLowerCase() != "e"
              ? Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Row(
                    children: [
                      buildFollowerDropdown(),
                      SizedBox(
                        width: 20,
                      ),
                      buildAssignDropdown(),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: buildUserStatusDropdown()),
          // buildAssignToSelectDialog(),
          // buildFollowerSelectDialog(),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildClearButton(),
              buildSaveButton(),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildTaskList({List<GetTaskDataModel>? taskList}) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(height: 10.0),
        shrinkWrap: true,
        itemCount: taskList!.length,
        itemBuilder: (context, i) {
          var task = taskList[i];
          return GestureDetector(
            onTap: () {
              //Navigator.pushNamed(context, TaskManagementDetail.routeName);
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return TaskManagementDetail(
                  id: task.iD.toString(),
                );
              }));
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(width: 0.1),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              task.taskName!,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Row(
                              children: [
                                task.createdBy.toString() == currentUserId
                                    ? GestureDetector(
                                        onTap: () {
                                          getTaskListById(
                                              id: task.iD.toString());
                                        },
                                        child: Icon(
                                          Icons.edit,
                                          color: Colors.blue.shade200,
                                        ),
                                      )
                                    : Container(),
                                SizedBox(
                                  width: 40,
                                ),
                                task.createdBy.toString() == currentUserId
                                    ? GestureDetector(
                                        onTap: () {
                                          deleteTask(
                                            id: task.iD.toString(),
                                            name: "",
                                            detail: "",
                                            sDate: "",
                                            dDate: "",
                                            follower: "",
                                            assign: "",
                                            priority: "",
                                          );
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      )
                                    : Container(),
                              ],
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              task.priority!,
                              style: TextStyle(
                                color: task.priority == "Select Priority"
                                    ? Colors.grey
                                    : task.priority == "High"
                                        ? Colors.red
                                        : task.priority == "Medium"
                                            ? Colors.orange
                                            : Colors.green,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  left: 6, right: 6, top: 2, bottom: 2),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 0.1,
                                ),
                                borderRadius: BorderRadius.circular(30),
                                color: task.status == "Pending"
                                    ? Colors.blue
                                    : Colors.green,
                              ),
                              child: Text(
                                task.status!,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: "F:",
                                style: TextStyle(
                                  color: Colors.brown,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                                children: [
                                  TextSpan(
                                    text: "${task.followerCount} ",
                                    style: TextStyle(
                                      color: Colors.brown,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "   A:",
                                        style: TextStyle(
                                          color: Colors.deepPurpleAccent,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        children: [
                                          TextSpan(
                                              text: "${task.assignToCount}")
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  task.startDate!,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                                Icon(Icons.arrow_right),
                                Text(
                                  task.dueDate!,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  //Emp Case

  Widget checkListEmployee(
      {List<GetTaskDataEmployeeModel>? taskList, String? error}) {
    if (taskList == null || taskList.isEmpty) {
      if (error == null || error.isEmpty) {
        return Center(
          child: Text(
            "Wait",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        );
      } else {
        return Center(
          child: Text(
            "$error",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        );
      }
    } else {
      return buildTaskListEmployee(taskList: taskList);
    }
  }

  Widget buildTaskListEmployee({List<GetTaskDataEmployeeModel>? taskList}) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(height: 10.0),
        shrinkWrap: true,
        itemCount: taskList!.length,
        itemBuilder: (context, i) {
          var task = taskList[i];
          return GestureDetector(
            // onTap: () {
            //   //Navigator.pushNamed(context, TaskManagementDetail.routeName);
            //   Navigator.push(context, MaterialPageRoute(builder: (context) {
            //     return TaskManagementDetail(
            //       id: task.iD.toString(),
            //     );
            //   }));
            // },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(width: 0.1),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              task.taskName!,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    getTaskListById(id: task.iD.toString());
                                  },
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.blue.shade200,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              task.priority!,
                              style: TextStyle(
                                color: task.priority == "Select Priority"
                                    ? Colors.grey
                                    : task.priority == "High"
                                        ? Colors.red
                                        : task.priority == "Medium"
                                            ? Colors.orange
                                            : Colors.green,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  left: 6, right: 6, top: 2, bottom: 2),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 0.1,
                                ),
                                borderRadius: BorderRadius.circular(30),
                                color: task.status == "Pending"
                                    ? Colors.blue
                                    : Colors.green,
                              ),
                              child: Text(
                                task.status!,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                  left: 6, right: 6, top: 2, bottom: 2),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 0.1,
                                ),
                                borderRadius: BorderRadius.circular(30),
                                color: task.userCurrentStatus == "Started"
                                    ? Colors.yellow.shade700
                                    : task.userCurrentStatus == "Pause"
                                        ? Colors.blue
                                        : task.userCurrentStatus == "Deleted"
                                            ? Colors.red
                                            : Colors.green,
                              ),
                              child: Text(
                                task.userCurrentStatus!,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  task.startDate!,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                                Icon(Icons.arrow_right),
                                Text(
                                  task.dueDate!,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  //

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
        // obscureText: !obscureText ? false : true,
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

  GestureDetector buildDateSelector({int? index}) {
    return GestureDetector(
      onTap: () => _selectDate(context, index: index),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xffECECEC)),
          borderRadius: BorderRadius.circular(10.0),
        ),
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 4,
              child: Text(
                index == 0
                    ? "${startDate != null ? DateFormat('dd-MM-yyyy').format(startDate!) : ""}"
                    : "${dueDate != null ? DateFormat('dd-MM-yyyy').format(dueDate!) : ""}",
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
              borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButton<String>(
              isDense: true,
              value: _selectedPriority,
              key: UniqueKey(),
              isExpanded: true,
              underline: Container(),
              items: priorityDropdown
                  .map((item) => DropdownMenuItem<String>(
                      child: Text(item, style: TextStyle(fontSize: 14)),
                      value: item))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  _selectedPriority = val;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Expanded buildStatusDropdown() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          buildLabels('Select Status'),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xffECECEC)),
              borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButton<GetEmployeeTaskManagementModel>(
              isDense: true,
              value: _selectedTaskStatus,
              key: UniqueKey(),
              isExpanded: true,
              underline: Container(),
              items: taskStatusDropdown
                  .map((item) =>
                      DropdownMenuItem<GetEmployeeTaskManagementModel>(
                          child: Text("${item.name}",
                              style: TextStyle(fontSize: 14)),
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
      ),
    );
  }

  Expanded buildAssignDropdown() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          buildLabels('Assign To'),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xffECECEC)),
              borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButton<GetEmployeeTaskManagementModel>(
              isDense: true,
              value: selectedAssignEmployee,
              key: UniqueKey(),
              isExpanded: true,
              underline: Container(),
              items: employeeList
                  .map((item) =>
                      DropdownMenuItem<GetEmployeeTaskManagementModel>(
                          child: Text("${item.name}",
                              style: TextStyle(fontSize: 14)),
                          value: item))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  selectedAssignEmployee = val;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Column buildUserStatusDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16),
        buildLabels('User Status'),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          width: MediaQuery.of(context).size.width * 0.4,
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xffECECEC)),
            borderRadius: BorderRadius.circular(4),
          ),
          child: DropdownButton<GetEmployeeTaskManagementModel>(
            isDense: true,
            value: _selectedUserStatus,
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
                _selectedUserStatus = val;
              });
            },
          ),
        ),
      ],
    );
  }

  Expanded buildFollowerDropdown() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          buildLabels('Follower To'),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xffECECEC)),
              borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButton<GetEmployeeTaskManagementModel>(
              isDense: true,
              value: selectedFollowerEmployee,
              key: UniqueKey(),
              isExpanded: true,
              underline: Container(),
              items: employeeList
                  .map((item) =>
                      DropdownMenuItem<GetEmployeeTaskManagementModel>(
                          child: Text("${item.name}",
                              style: TextStyle(fontSize: 14)),
                          value: item))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  selectedFollowerEmployee = val;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  // Widget buildAssignToSelectDialog() {
  //   return Container(
  //     alignment: Alignment.center,
  //     decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(4),
  //         border: Border.all(width: 0.1)),
  //     margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
  //     padding: EdgeInsets.all(2),
  //     child: MultiSelectBottomSheetField<GetEmployeeTaskManagementModel>(
  //       key: _assignToSelectKey,
  //       initialChildSize: 0.7,
  //       maxChildSize: 0.95,
  //       title: Text(
  //         "Staff",
  //         style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
  //       ),
  //       buttonText: Text(
  //         "${finalAssignEmployeeList.length > 0 ? "Assigned To ${finalAssignEmployeeList.length}" : "Assign To"}",
  //         style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
  //       ),
  //       items:
  //           employeeList.map((e) => MultiSelectItem(e, '${e.name}')).toList(),
  //       searchable: true,
  //       decoration: BoxDecoration(border: Border.all(color: Colors.white)),
  //       validator: (values) {
  //         if (values == null || values.isEmpty) {
  //           return "Required";
  //         }
  //       },
  //       onConfirm: (values) {
  //         setState(() {
  //           finalAssignEmployeeList = values;
  //         });
  //         setState(() {
  //           idsAssignEmployeeList = [];
  //         });
  //
  //         finalAssignEmployeeList.forEach((element) {
  //           setState(() {
  //             idsAssignEmployeeList.add(element.id.toString());
  //           });
  //         });
  //       },
  //       chipDisplay: MultiSelectChipDisplay.none(),
  //     ),
  //   );
  // }

  // Widget buildFollowerSelectDialog() {
  //   return Container(
  //     alignment: Alignment.center,
  //     decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(4),
  //         border: Border.all(width: 0.1)),
  //     margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
  //     padding: EdgeInsets.all(2),
  //     child: MultiSelectBottomSheetField<GetEmployeeTaskManagementModel>(
  //         key: _followerSelectKey,
  //         initialChildSize: 0.7,
  //         maxChildSize: 0.95,
  //         title: Text(
  //           "Select Follower",
  //           style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
  //         ),
  //         buttonText: Text(
  //           "${finalFollowerEmployeeList.length > 0 ? "Selected Follower ${finalFollowerEmployeeList.length}" : "Add Follower"}",
  //           style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
  //         ),
  //         items:
  //             employeeList.map((e) => MultiSelectItem(e, '${e.name}')).toList(),
  //         searchable: true,
  //         autovalidateMode: AutovalidateMode.disabled,
  //         decoration: BoxDecoration(
  //           border: Border.all(color: Colors.white),
  //         ),
  //         validator: (values) {
  //           if (values == null || values.isEmpty) {
  //             return "Required";
  //           }
  //         },
  //         onConfirm: (values) {
  //           setState(() {
  //             finalFollowerEmployeeList = values;
  //           });
  //
  //           setState(() {
  //             idsFollowerEmployeeList = [];
  //           });
  //
  //           finalFollowerEmployeeList.forEach((element) {
  //             setState(() {
  //               idsFollowerEmployeeList.add(element.id.toString());
  //             });
  //           });
  //         },
  //         chipDisplay: MultiSelectChipDisplay.none()),
  //   );
  // }

  Container buildSaveButton() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(33.0),
        color: Colors.green,
      ),
      child: TextButton(
        style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(Colors.transparent)),
        onPressed: () {
          widget.userType!.toLowerCase() != "e"
              ? getTaskList(
                  taskname: _nameController.text,
                  sdate: startDate != null
                      ? DateFormat("dd-MMM-yyyy").format(startDate!)
                      : "",
                  ddate: dueDate != null
                      ? DateFormat("dd-MMM-yyyy").format(dueDate!)
                      : "",
                  priority: _selectedPriority == "Select Priority"
                      ? ""
                      : _selectedPriority,
                  status: _selectedTaskStatus!.id.toString() == "0"
                      ? ""
                      : _selectedTaskStatus!.id.toString(),
                  // assignids: idsAssignEmployeeList.join(","),
                  // folloupids: idsFollowerEmployeeList.join(","));
                  assignids: selectedAssignEmployee!.id == -1
                      ? ""
                      : selectedAssignEmployee!.id.toString(),
                  folloupids: selectedFollowerEmployee!.id == -1
                      ? ""
                      : selectedFollowerEmployee!.id.toString(),
                )
              : getTaskListEmployee(
                  taskname: _nameController.text,
                  sdate: startDate != null
                      ? DateFormat("dd-MMM-yyyy").format(startDate!)
                      : "",
                  ddate: dueDate != null
                      ? DateFormat("dd-MMM-yyyy").format(dueDate!)
                      : "",
                  priority: _selectedPriority == "Select Priority"
                      ? ""
                      : _selectedPriority,
                  status: _selectedTaskStatus!.id.toString() == "0"
                      ? ""
                      : _selectedTaskStatus!.id.toString(),
                  id: _selectedUserStatus!.id.toString() == "0"
                      ? ""
                      : _selectedUserStatus!.id.toString(),
                );
        },
        child: Text(
          "Search",
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
            // finalFollowerEmployeeList = [];
            // finalAssignEmployeeList = [];
            selectedFollowerEmployee = employeeList[0];
            selectedAssignEmployee = employeeList[0];
            //employeeList = [];
            _selectedPriority = priorityDropdown[0];
            _selectedUserStatus = taskStatusDropdown.last;
            _selectedTaskStatus = taskStatusDropdown.last;
            startDate = null;
            dueDate = null;
          });
          getTaskList();
          setState(() {
            filterOpen = false;
          });
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

  Future<void> _selectDate(BuildContext context, {int? index}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1947),
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
}
