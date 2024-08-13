import 'dart:async';
import 'dart:io';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';
import 'package:campus_pro/src/DATA/MODELS/classListEmployeeModel.dart';
import 'package:campus_pro/src/DATA/MODELS/loadClassForSmsModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonSnackbar.dart';
import 'package:campus_pro/src/UI/WIDGETS/fileDownloader.dart';
import 'package:campus_pro/src/UTILS/fieldValidators.dart';
import 'package:campus_pro/src/UTILS/filePicker.dart';
import 'package:campus_pro/src/WIDGETS_STYLE/style_common.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../globalBlocProvidersFile.dart';

class Activity extends StatefulWidget {
  static const routeName = "/activity";
  const Activity({Key? key}) : super(key: key);
  @override
  _ActivityState createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  DateTime selectedFromDate = DateTime.now();
  //.subtract(Duration(days: 7));
  DateTime selectedToDate = DateTime.now();

  String? userType = 'e';
  String? userId = '0';
  int index = 0;
  String? url;

  bool isShow = true;

  List<ActivityModel> activityList = [];

  Future<void> _selectDate(BuildContext context, {int? index}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedFromDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      helpText: index == 0 ? "SELECT FROM DATE" : "SELECT TO DATE",
    );
    if (picked != null)
      setState(() {
        if (index == 0) {
          selectedFromDate = picked;
        } else {
          selectedToDate = picked;
        }
      });
  }

  deleteActivity({String? activityid}) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userdata = await UserUtils.userTypeFromCache();

    final sendingDeleteApi = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userdata!.organizationId,
      "Schoolid": userdata.schoolId,
      "SessionId": userdata.currentSessionid,
      "EmpId": userdata.stuEmpId,
      "UserType": userdata.ouserType,
      "ActivityId": activityid,
    };

    print('delete activity api $sendingDeleteApi');
    context
        .read<DeleteActivityCubit>()
        .deleteActivityCubitCall(sendingDeleteApi);
  }

  void getUserType() async {
    final userData = await UserUtils.userTypeFromCache();
    setState(() {
      userType = userData!.ouserType;

      userId = userData.stuEmpId;
      print('userType $userId');
      url = userData.baseDomainURL;
    });
  }

  void getActivity() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final activityData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "SessionId": userData.currentSessionid,
      "StuEmpId": userData.stuEmpId,
      "FromDate": DateFormat("dd-MMM-yyyy").format(selectedFromDate),
      "ToDate": DateFormat("dd-MMM-yyyy").format(selectedToDate),
      "UserType": userData.ouserType,
      "EmpGroupId": "",
      "For": "S",
      "StudentId": "0",
      //
      // "OUserId": uid!,
      // "Token": token!,
      // "OrgId": userData!.organizationId,
      // "Schoolid": userData.schoolId!,
      // "SessionId": userData.currentSessionid!,
      // "StuEmpId": userData.stuEmpId,
      // "For": userData.ouserType,
      // "FromDate": DateFormat("dd MMM yyyy").format(selectedFromDate),
      // "ToDate": DateFormat("dd MMM yyyy").format(selectedToDate),
    };
    context.read<ActivityCubit>().activityCubitCall(activityData);
  }

  List<Color> colorizeColors = [
    Colors.purple,
    Colors.blue,
    Colors.yellow,
    Colors.red,
  ];

  TextStyle colorizeTextStyle = TextStyle(
    fontSize: 18.0,
    fontFamily: 'Horizon',
  );

  @override
  void initState() {
    getUserType();
    Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          isShow = false;
        });
      }
    });
    super.initState();
    getActivity();
  }

  Future _onRefresh() async {
    await Future.delayed(Duration(seconds: 1), () {
      getActivity();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: commonAppBar(context, title: "Activity"),
        body: RefreshIndicator(
          onRefresh: _onRefresh,
          child: MultiBlocListener(
            listeners: [
              BlocListener<DeleteActivityCubit, DeleteActivityState>(
                  listener: (context, state) {
                if (state is DeleteActivityLoadSuccess) {
                  //getActivity();
                  ScaffoldMessenger.of(context).showSnackBar(
                    commonSnackBar(
                      title: 'Activity Deleted',
                      duration: Duration(seconds: 1),
                    ),
                  );
                }
              }),
            ],
            child: Column(
              children: [
                // userType!.toLowerCase() != 's'
                //     ? SizedBox(
                //         height: 0,
                //       )
                //     : SizedBox(
                //         height: 10,
                //       ),
                // // userType!.toLowerCase() != 's'
                // //     ?
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      child: buildTopDateFilter(context),
                    ),
                    buildShowButton(context),
                  ],
                ),
                Divider(
                  thickness: 5,
                ),
                Visibility(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12.0)),
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    child: SizedBox(
                      //width: 150.0,
                      child: AnimatedTextKit(
                        animatedTexts: [
                          ColorizeAnimatedText(
                            'Swipe in any direction to delete',
                            textStyle: colorizeTextStyle,
                            colors: colorizeColors,
                          ),
                        ],
                        isRepeatingAnimation: true,
                        onTap: () {
                          print("Tap Event");
                        },
                      ),
                    ),
                  ),
                  visible: isShow == true ? true : false,
                ),
                BlocConsumer<ActivityCubit, ActivityState>(
                    listener: (context, state) {
                  if (state is ActivityLoadFail) {
                    if (state.failReason == "false") {
                      UserUtils.unauthorizedUser(context);
                    }
                  }
                  if (state is ActivityLoadSuccess) {
                    setState(() {
                      activityList = state.activityList;
                    });
                    print(state.activityList.length);
                  }
                }, builder: (context, state) {
                  if (state is ActivityLoadInProgress) {
                    // return Center(child: CircularProgressIndicator());
                    return Center(child: LinearProgressIndicator());
                  } else if (state is ActivityLoadSuccess) {
                    return buildActivityList(context,
                        activityList: activityList);
                  } else if (state is ActivityLoadFail) {
                    return buildActivityList(context);
                  } else {
                    // return Center(child: CircularProgressIndicator());
                    return Center(child: LinearProgressIndicator());
                  }
                }),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
        // floatingActionButton: userType!.toLowerCase() != 's'
        //     ?
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return BlocProvider<LoadClassForSmsCubit>(
                create: (_) => LoadClassForSmsCubit(
                    LoadClassForSmsRepository(LoadClassForSmsApi())),
                child: BlocProvider<ClassListEmployeeCubit>(
                  create: (_) => ClassListEmployeeCubit(
                      ClassListEmployeeRepository(ClassListEmployeeApi())),
                  child: BlocProvider<CreateActivityCubit>(
                    create: (_) => CreateActivityCubit(
                        CreateActivityRepository(CreateActivityApi())),
                    child: CreateActivity(),
                  ),
                ),
              );
            }));
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => CreateActivity()));
          },
          child: const Icon(Icons.add),
          backgroundColor: Theme.of(context).primaryColor,
        )
        // : Container(),
        );
  }

  Widget buildShowButton(BuildContext context) {
    return InkWell(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      onTap: () => getActivity(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                spreadRadius: 2,
                color: Colors.grey,
              )
            ]),
        margin: EdgeInsets.all(8),
        child: Text(
          "Show",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget buildActivityList(BuildContext context,
      {List<ActivityModel>? activityList}) {
    if (activityList == null || activityList.isEmpty) {
      return Text(
        NO_RECORD_FOUND,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      );
    } else {
      return buildActivity(context, activityList: activityList);
    }
  }

  Expanded buildActivity(BuildContext context,
      {List<ActivityModel>? activityList}) {
    return Expanded(
      child: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(height: 10.0),
          itemCount: activityList!.length,
          itemBuilder: (context, i) {
            var item = activityList[i];
            return userId == item.byUser
                ? IgnorePointer(
                    ignoring: userId == item.byUser ? false : true,
                    child: Dismissible(
                      background: secondaryStackBehindDismiss(),
                      key: UniqueKey(),
                      onDismissed: (direction) {
                        setState(() {
                          activityList.removeAt(i);
                        });
                        deleteActivity(activityid: item.id);
                      },
                      child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20.0),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xffE1E3E8),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Title : ${item.title!}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                'Content : ${item.content!}',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      item.circularFileurl != ""
                                          ? FileDownload(
                                              fileUrl: "$url" +
                                                  item.circularFileurl!,
                                              downloadWidget: Icon(
                                                Icons.download_outlined,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                              fileName: item.circularFileurl!
                                                  .split('.')
                                                  .last,
                                            )
                                          // GestureDetector(
                                          //         onTap: () {
                                          //           FileDownload(
                                          //             fileUrl: item.circularFileurl,
                                          //           );
                                          //         },
                                          //         child:
                                          //         Icon(
                                          //           Icons.download_outlined,
                                          //           color: Theme.of(context).primaryColor,
                                          //         ),
                                          //       )
                                          : Container(),
                                      SizedBox(
                                        width:
                                            item.circularFileurl != "" ? 40 : 0,
                                      ),
                                      //Todo:Delete Icon
                                      // userId == item.byUser
                                      //     ? GestureDetector(
                                      //         onTap: () {
                                      //           deleteActivity(activityid: item.id);
                                      //         },
                                      //         child: Icon(
                                      //           Icons.delete,
                                      //           color: Colors.red,
                                      //         ),
                                      //       )
                                      //     : Container()
                                    ],
                                  ),
                                  Text(
                                    item.dateAdded!,
                                    style: TextStyle(
                                      fontSize: 11.0,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )),
                    ))
                : Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20.0),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xffE1E3E8),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Title : ${item.title!}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          'Content : ${item.content!}',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                item.circularFileurl != ""
                                    ? FileDownload(
                                        fileUrl: "$url" + item.circularFileurl!,
                                        downloadWidget: Icon(
                                          Icons.download_outlined,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        fileName: item.circularFileurl!
                                            .split('.')
                                            .last,
                                      )
                                    // GestureDetector(
                                    //         onTap: () {
                                    //           FileDownload(
                                    //             fileUrl: item.circularFileurl,
                                    //           );
                                    //         },
                                    //         child:
                                    //         Icon(
                                    //           Icons.download_outlined,
                                    //           color: Theme.of(context).primaryColor,
                                    //         ),
                                    //       )
                                    : Container(),
                                SizedBox(
                                  width: item.circularFileurl != "" ? 40 : 0,
                                ),
                                //Todo:Delete Icon
                                // userId == item.byUser
                                //     ? GestureDetector(
                                //         onTap: () {
                                //           deleteActivity(activityid: item.id);
                                //         },
                                //         child: Icon(
                                //           Icons.delete,
                                //           color: Colors.red,
                                //         ),
                                //       )
                                //     : Container()
                              ],
                            ),
                            Text(
                              item.dateAdded!,
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        )
                      ],
                    ));
          }),
    );
  }

  InkWell buildDateSelector({String? selectedDate, int? index}) {
    return InkWell(
        onTap: () => _selectDate(context, index: index),
        child: internalTextForDateTime(context, selectedDate: selectedDate)
        // Container(
        //   width: MediaQuery.of(context).size.width,
        //   padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        //   decoration: BoxDecoration(
        //     border: Border.all(color: Color(0xffECECEC)),
        //   ),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       Flexible(
        //         child: Container(
        //           child: Text(
        //             selectedDate!,
        //             overflow: TextOverflow.ellipsis,
        //             maxLines: 1,
        //             // style: TextStyle(
        //             //     fontSize: MediaQuery.of(context).size.width * 0.03),
        //           ),
        //         ),
        //       ),
        //       Icon(Icons.today, color: Theme.of(context).primaryColor)
        //     ],
        //   ),
        // ),
        );
  }

  Container buildTopDateFilter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Expanded(
            child: buildDateSelector(
              index: 0,
              selectedDate: DateFormat("dd MMM yyyy").format(selectedFromDate),
            ),
          ),
          SizedBox(
            width: 3,
          ),
          Icon(Icons.arrow_right_alt_outlined),
          SizedBox(
            width: 3,
          ),
          Expanded(
            child: buildDateSelector(
              index: 1,
              selectedDate: DateFormat("dd MMM yyyy").format(selectedToDate),
            ),
          ),
        ],
      ),
    );
  }

  Text buildText({String? title, Color? color}) {
    return Text(
      title ?? "",
      style: TextStyle(fontWeight: FontWeight.w600, color: color),
    );
  }

  Widget secondaryStackBehindDismiss() {
    return Container(
      color: Colors.red,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(Icons.delete, color: Colors.white),
            Text('Move to trash', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}

//create activity

class CreateActivity extends StatefulWidget {
  @override
  _CreateActivityState createState() => _CreateActivityState();
}

class _CreateActivityState extends State<CreateActivity> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  TextEditingController _commentController = new TextEditingController();
  TextEditingController _subjectController = new TextEditingController();

  //class employee
  List<ClassListEmployeeModel>? classList;
  ClassListEmployeeModel? selectedClass;

  //class admin
  List<LoadClassForSmsModel>? classListAdmin;
  LoadClassForSmsModel? selectedClassAdmin;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool? isLoader = false;

  DateTime date = DateTime.now();
  String? updatedDt;
  Future<void> selectDateFrom(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(2000),
        lastDate: DateTime(2024));
    if (picked != null) {
      setState(() {
        updatedDt = DateFormat("dd-MMM-yyyy").format(picked);
      });
    }
  }

  List<File>? _selectedImage = [];
  String? userType = '';

  getEmployeeClass({String? empIdForAdmin}) async {
    print(empIdForAdmin);
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final getEmpClassData = {
      "OUserId": uid!,
      "Token": token!,
      "OrgId": userData!.organizationId,
      "Schoolid": userData.schoolId,
      "SessionId": userData.currentSessionid,
      "EmpID": userData.stuEmpId
    };
    print('Employee Class List $getEmpClassData');
    context
        .read<ClassListEmployeeCubit>()
        .classListEmployeeCubitCall(getEmpClassData);
  }

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

  saveActivity({
    String? date,
    String? classid,
    String? streamid,
    String? sectionid,
    String? yearid,
    String? title,
    String? content,
    List<File>? image,
  }) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();

    final sendingActivityData = {
      "UserId": uid!,
      "Token": token!,
      "OrgId": userData!.organizationId!,
      "SchoolId": userData.schoolId!,
      "SessionId": userData.currentSessionid!,
      "Date": date!.toString(),
      "FileFormat": "",
      "For": 'S',
      "ForAll": '0',
      "StuEmpId": userData.stuEmpId!,
      "ClassId": classid!.toString(),
      "GroupId": "0",
      "UserType": userData.ouserType!,
      "StreamId": streamid!.toString(),
      "SectionId": sectionid!.toString(),
      "YearId": yearid!.toString(),
      "Title": title!.toString(),
      "Content": content!.toString(),
    };

    print('send activity data $sendingActivityData');
    context
        .read<CreateActivityCubit>()
        .createActivityCubitCall(sendingActivityData, image);
  }

  getUserType() async {
    final userData = await UserUtils.userTypeFromCache();

    setState(() {
      userType = userData!.ouserType;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserType();
    getEmployeeClass();
    getClass();
    classList = [];
    selectedClass = ClassListEmployeeModel(iD: "", className: "");
    classListAdmin = [];
    selectedClassAdmin =
        LoadClassForSmsModel(classDisplayOrder: "", classname: "", classId: "");
  }

  @override
  void dispose() {
    super.dispose();
    _commentController.dispose();
    _subjectController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: commonAppBar(context, title: "Create Activity"),
        body: MultiBlocListener(
          listeners: [
            BlocListener<CreateActivityCubit, CreateActivityState>(
                listener: (context, state) async {
              if (state is CreateActivityLoadInProgress) {
                setState(() {
                  isLoader = true;
                });
              }
              if (state is CreateActivityLoadSuccess) {
                setState(() {
                  isLoader = false;
                  _subjectController.text = "";
                  _commentController.text = "";
                  _selectedImage = [];
                });
                ScaffoldMessenger.of(context).showSnackBar(commonSnackBar(
                  title: 'Activity Sent',
                  duration: Duration(seconds: 1),
                ));
                //Todo

                final uid = await UserUtils.idFromCache();
                final token = await UserUtils.userTokenFromCache();
                final userData = await UserUtils.userTypeFromCache();
                final activityData = {
                  "OUserId": uid,
                  "Token": token,
                  "OrgId": userData!.organizationId,
                  "Schoolid": userData.schoolId,
                  "SessionId": userData.currentSessionid,
                  "StuEmpId": userData.stuEmpId,
                  "FromDate": DateFormat("dd-MMM-yyyy").format(DateTime.now()),
                  "ToDate": DateFormat("dd-MMM-yyyy").format(DateTime.now()),
                  "UserType": userData.ouserType,
                  "EmpGroupId": "",
                  "For": "S",
                  "StudentId": "0",
                };
                context.read<ActivityCubit>().activityCubitCall(activityData);

                ///
              }
              if (state is CreateActivityLoadFail) {
                if (state.failReason == 'false') {
                  UserUtils.unauthorizedUser(context);
                }
              }
            }),
          ],
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: sendActivity(context),
            ),
          ),
        ),
        // BlocConsumer<CreateActivityCubit, CreateActivityState>(
        //   listener: (context, state) {
        //     if (state is CreateActivityLoadSuccess) {
        //       if (state.status) {
        //         toast("Activity Created Successfully!");
        //         Navigator.pushNamedAndRemoveUntil(
        //             context, Activity.routeName, (route) => false);
        //       }
        //     }
        //     if (state is CreateActivityLoadFail) {
        //       toastFailedNotification(state.failReason);
        //     }
        //   },
        //   builder: (context, state) {
        //     if (state is CreateActivityLoadInProgress) {
        //       return sendActivity(context);
        //     } else if (state is CreateActivityLoadSuccess) {
        //       return sendActivity(context);
        //     } else if (state is CreateActivityLoadFail) {
        //       return toastFailedNotification(state.failReason);
        //     } else {
        //       return sendActivity(context);
        //     }
        //   },
        // ),
      ),
    );
  }

  Form sendActivity(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(
            height: 6.0,
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Row(
              children: [
                userType!.toLowerCase() == 'e'
                    ? BlocConsumer<ClassListEmployeeCubit,
                        ClassListEmployeeState>(listener: (context, state) {
                        if (state is ClassListEmployeeLoadSuccess) {
                          setState(() {
                            selectedClass = state.classList[0];
                            classList = state.classList;
                          });
                        }
                        if (state is ClassListEmployeeLoadFail) {
                          if (state.failReason == 'false') {
                            UserUtils.unauthorizedUser(context);
                          } else {
                            classList = [];
                            selectedClass =
                                ClassListEmployeeModel(className: "", iD: "");
                          }
                        }
                      }, builder: (context, state) {
                        if (state is ClassListEmployeeLoadInProgress) {
                          return selectClass(context);
                        } else if (state is ClassListEmployeeLoadSuccess) {
                          return selectClass(context);
                        } else if (state is ClassListEmployeeLoadFail) {
                          return selectClass(context);
                        } else {
                          return Container();
                        }
                      })
                    : BlocConsumer<LoadClassForSmsCubit, LoadClassForSmsState>(
                        listener: (context, state) {
                        if (state is LoadClassForSmsLoadSuccess) {
                          setState(() {
                            selectedClassAdmin = state.classList[0];
                            classListAdmin = state.classList;
                          });
                        }
                        if (state is LoadClassForSmsLoadFail) {
                          if (state.failReason == 'false') {
                            UserUtils.unauthorizedUser(context);
                          } else {
                            classListAdmin = [];
                            selectedClassAdmin = LoadClassForSmsModel(
                                classId: "",
                                classname: "",
                                classDisplayOrder: "");
                          }
                        }
                      }, builder: (context, state) {
                        if (state is LoadClassForSmsLoadInProgress) {
                          return selectClassAdmin(context);
                        } else if (state is LoadClassForSmsLoadSuccess) {
                          return selectClassAdmin(context);
                        } else if (state is LoadClassForSmsLoadFail) {
                          return selectClassAdmin(context);
                        } else {
                          return Container();
                        }
                      }),
                //selectClass(context),
                SizedBox(width: 30.0),
                InkWell(
                  onTap: () {
                    selectDateFrom(context);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.42,
                    child: internalTextForDateTime(
                      context,
                      selectedDate:
                          updatedDt ?? DateFormat("dd MMM yyyy").format(date),
                    ),
                  ),
                  // Container(
                  //   width: MediaQuery.of(context).size.width * 0.4,
                  //   height: 40.0,
                  //   padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
                  //   decoration: BoxDecoration(
                  //     border: Border.all(color: Color(0xffECECEC)),
                  //   ),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Flexible(
                  //         child: Container(
                  //           child: Padding(
                  //             padding: EdgeInsets.only(left: 0.0),
                  //             child: Text(
                  //               updatedDt ??
                  //                   DateFormat("dd-MMM-yyyy").format(date),
                  //               overflow: TextOverflow.ellipsis,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //       SizedBox(
                  //         width: 13.0,
                  //       ),
                  //       Icon(
                  //         Icons.today,
                  //         color: Theme.of(context).primaryColor,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          buildCurrentTextFields(
            label: "Subject :",
            controller: _subjectController,
            validator: FieldValidators.globalValidator,
            maxline: 1,
          ),
          buildCurrentTextFields(
            label: "Content :",
            controller: _commentController,
            validator: FieldValidators.globalValidator,
            maxline: 5,
          ),
          //buildImageUpload(context),
          SizedBox(
            height: 30,
          ),
          _selectedImage!.length < 1
              ? GestureDetector(
                  onTap: () async {
                    var file = await showFilePicker(allowMultiple: false);
                    if (file != null) {
                      setState(() {
                        _selectedImage = file;
                      });
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.all(8),
                    width: MediaQuery.of(context).size.width * 0.35,
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.1),
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.green,
                    ),
                    child: Center(
                      child: Text(
                        '+ Upload Image',
                        textScaleFactor: 1.0,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                )
              : Column(
                  children: [
                    _selectedImage![0].path.split('.').last.toLowerCase() !=
                            'pdf'
                        ? GestureDetector(
                            onTap: () async {
                              var file =
                                  await showFilePicker(allowMultiple: false);
                              if (file != null) {
                                setState(() {
                                  _selectedImage = file;
                                });
                              }
                            },
                            child: Container(
                              width: 150,
                              height: 150,
                              child: Image.file(_selectedImage![0]),
                            ),
                          )
                        : GestureDetector(
                            onTap: () async {
                              var file =
                                  await showFilePicker(allowMultiple: false);
                              if (file != null) {
                                setState(() {
                                  _selectedImage = file;
                                });
                              }
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10),
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                border: Border.all(width: 0.1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.picture_as_pdf),
                                      Text(
                                        ' ${_selectedImage![0].path.split('/').last}',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Change',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: Colors.lightBlue,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                    SizedBox(
                      height: _selectedImage![0]
                                  .path
                                  .split('.')
                                  .last
                                  .toLowerCase() !=
                              'pdf'
                          ? 0
                          : 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedImage = [];
                        });
                      },
                      child: Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 30,
                      ),
                    ),
                  ],
                ),
          SizedBox(
            height: 25,
          ),
          isLoader == false ? buildSaveButton() : CircularProgressIndicator(),
        ],
      ),
    );
  }

  GestureDetector buildSaveButton() {
    return GestureDetector(
      onTap: () {
        if (formKey.currentState!.validate()) {
          print('true');
          if (_subjectController.text != "" && _commentController.text != "") {
            if (userType!.toLowerCase() == 'e') {
              saveActivity(
                date: DateFormat('dd-MMM-yyyy').format(date),
                classid: selectedClass!.iD!.split("#")[0],
                streamid: selectedClass!.iD!.split("#")[1],
                sectionid: selectedClass!.iD!.split("#")[2],
                yearid: selectedClass!.iD!.split("#")[4],
                title: _subjectController.text,
                content: _commentController.text,
                image: _selectedImage,
              );
            } else {
              saveActivity(
                date: DateFormat('dd-MMM-yyyy').format(date),
                classid: selectedClassAdmin!.classId!.split("#")[0],
                streamid: selectedClassAdmin!.classId!.split("#")[1],
                sectionid: selectedClassAdmin!.classId!.split("#")[2],
                yearid: selectedClassAdmin!.classId!.split("#")[4],
                title: _subjectController.text,
                content: _commentController.text,
                image: _selectedImage,
              );
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              commonSnackBar(
                title: 'Enter Subject or Context',
                duration: Duration(seconds: 1),
              ),
            );
          }
        } else {
          print('false');
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        height: 35,
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Theme.of(context).primaryColor,
        ),
        child: Container(
          child: Center(
            child: Text(
              'SAVE',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container buildCurrentTextFields(
      {String? label,
      int? maxline,
      TextEditingController? controller,
      String? Function(String?)? validator}) {
    return Container(
      // color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildLabels(label!),
          buildTextField(
            maxline: maxline,
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
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Color(0xff313131),
        ),
      ),
    );
  }

  Container buildTextField(
      {String? Function(String?)? validator,
      @required TextEditingController? controller,
      int? maxline}) {
    return Container(
      child: TextFormField(
        // obscureText: !obscureText ? false : true,
        controller: controller,
        validator: FieldValidators.globalValidator,
        //autovalidateMode: AutovalidateMode.onUserInteraction,
        maxLines: maxline ?? 1,
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
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        ),
      ),
    );
  }

  Container selectClass(BuildContext context) {
    return Container(
      height: 40.0,
      width: MediaQuery.of(context).size.width * 0.4,
      padding: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xffECECEC)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0, left: 2.0),
        child: DropdownButton<ClassListEmployeeModel>(
          value: selectedClass,
          icon: const Icon(Icons.arrow_drop_down),
          hint: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              "SELECT CLASS",
              style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w400),
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
              selectedClass = newValue;
            });
          },
          items:
              classList!.map<DropdownMenuItem<ClassListEmployeeModel>>((value) {
            return DropdownMenuItem<ClassListEmployeeModel>(
              value: value,
              child: Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  '${value.className}',
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w300),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Container selectClassAdmin(BuildContext context) {
    return Container(
      height: 40.0,
      width: MediaQuery.of(context).size.width * 0.4,
      padding: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xffECECEC)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0, left: 2.0),
        child: DropdownButton<LoadClassForSmsModel>(
          value: selectedClassAdmin,
          icon: const Icon(Icons.arrow_drop_down),
          hint: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              "SELECT CLASS",
              style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w400),
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
              selectedClassAdmin = newValue;
            });
          },
          items: classListAdmin!
              .map<DropdownMenuItem<LoadClassForSmsModel>>((value) {
            return DropdownMenuItem<LoadClassForSmsModel>(
              value: value,
              child: Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  '${value.classname}',
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w300),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
