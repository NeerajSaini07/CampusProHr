import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/CIRCULAR_EMPLOYEE_CUBIT/circular_employee_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/DELETE_CIRCULAR_CUBIT/delete_circular_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/circularEmployeeModel.dart';
import 'package:campus_pro/src/DATA/MODELS/userTypeModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/PAGES/EMPLOYEE_MODULE/COMMUNICATION_EMPLOYEE/CIRCULAR_EMPLOYEE/addCircularEmploye.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/drawerWidget.dart';
import 'package:campus_pro/src/UI/WIDGETS/fileDownloader.dart';
import 'package:campus_pro/src/WIDGETS_STYLE/style_common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../globalBlocProvidersFile.dart';

class CircularEmployee extends StatefulWidget {
  static const routeName = "/circular-employee";
  @override
  _CircularEmployeeState createState() => _CircularEmployeeState();
}

class _CircularEmployeeState extends State<CircularEmployee> {
  DateTime selectedFromDate = DateTime.now();
  DateTime selectedToDate = DateTime.now();

  UserTypeModel? userData;

  List<CircularEmployeeModel> circularList = [];

  @override
  void initState() {
    getCircular("1");
    super.initState();
  }

  getCircular(String? onLoad) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    userData = await UserUtils.userTypeFromCache();
    final circularData = {
      "OUserId": uid,
      "Token": token,
      "OrgId": userData!.organizationId,
      "Schoolid": userData!.schoolId!,
      "SessionId": userData!.currentSessionid!,
      "CirFromDate": DateFormat("dd MMM yyyy").format(selectedFromDate),
      "CirToDate": DateFormat("dd MMM yyyy").format(selectedToDate),
      "OnLoad": onLoad,
      "StuEmpId": userData!.stuEmpId,
      "UserType": userData!.ouserType,
    };
    print("circularData sending = > $circularData");
    context
        .read<CircularEmployeeCubit>()
        .circularEmployeeCubitCall(circularData);
  }

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

  _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000)).then((value) {
      getCircular("0");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: DrawerWidget(),
        appBar: commonAppBar(context, title: "Circular"),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return BlocProvider<AddCircularEmployeeCubit>(
                create: (_) => AddCircularEmployeeCubit(
                    AddCircularEmployeeRepository(AddCircularEmployeeApi())),
                child: BlocProvider<ClassesForCoordinatorCubit>(
                  create: (_) => ClassesForCoordinatorCubit(
                      ClassesForCoordinatorRepository(
                          ClassesForCoordinatorApi())),
                  child: BlocProvider<FillClassOnlyWithSectionCubit>(
                    create: (_) => FillClassOnlyWithSectionCubit(
                        FillClassOnlyWithSectionAdminRepository(
                            FillClassOnlyWithSectionAdminApi())),
                    child: BlocProvider<ClassListEmployeeCubit>(
                      create: (_) => ClassListEmployeeCubit(
                          ClassListEmployeeRepository(ClassListEmployeeApi())),
                      child: AddCircularEmployee(),
                    ),
                  ),
                ),
              );
            }));
            // Navigator.pushNamed(context, AddCircularEmployee.routeName);
          },
          child: const Icon(Icons.add),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: MultiBlocListener(
          listeners: [
            BlocListener<DeleteCircularCubit, DeleteCircularState>(
              listener: (context, state) {
                if (state is DeleteCircularLoadFail) {
                  if (state.failReason == "false") {
                    UserUtils.unauthorizedUser(context);
                  }
                }
                if (state is DeleteCircularLoadSuccess) {
                  getCircular("0");
                }
              },
            ),
          ],
          child: RefreshIndicator(
            onRefresh: () => _onRefresh(),
            child: Column(
              children: [
                buildTopDateFilter(context),
                Divider(
                  thickness: 2.0,
                  // color: Theme.of(context).primaryColor,
                ),
                BlocConsumer<CircularEmployeeCubit, CircularEmployeeState>(
                  listener: (context, state) {
                    if (state is CircularEmployeeLoadFail) {
                      if (state.failReason == "false") {
                        UserUtils.unauthorizedUser(context);
                      }
                    }
                    if (state is CircularEmployeeLoadSuccess) {
                      setState(() {
                        circularList = state.circularList;
                      });
                    }
                  },
                  builder: (context, state) {
                    if (state is CircularEmployeeLoadInProgress) {
                      // return Center(child: CircularProgressIndicator());
                      return Center(child: LinearProgressIndicator());
                    } else if (state is CircularEmployeeLoadSuccess) {
                      return buildCirculars(context,
                          circularEmployeeList: circularList);
                    } else if (state is CircularEmployeeLoadFail) {
                      return buildCirculars(context, circularEmployeeList: []);
                    } else {
                      // return Center(child: CircularProgressIndicator());
                      return Center(child: LinearProgressIndicator());
                    }
                  },
                ),
              ],
            ),
          ),
        ));
  }

  Widget buildCirculars(BuildContext context,
      {List<CircularEmployeeModel>? circularEmployeeList}) {
    return circularEmployeeList!.length > 0
        ? Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(height: 10),
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              shrinkWrap: true,
              itemCount: circularEmployeeList.length,
              itemBuilder: (context, i) {
                var item = circularEmployeeList[i];
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffDBDBDB)),
                  ),
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(item.cirSubject!,
                              // style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                        Row(
                          children: [
                            if (item.circularFileurl != null &&
                                item.circularFileurl != "")
                              FileDownload(
                                fileName: item.circularFileurl!.split("/").last,
                                fileUrl: userData!.baseDomainURL! +
                                    item.circularFileurl!,
                                downloadWidget: Icon(Icons.file_download,
                                    color: Theme.of(context).primaryColor),
                              ),
                            SizedBox(width: 10.0),
                            InkWell(
                              onTap: () async {
                                final uid = await UserUtils.idFromCache();
                                final token =
                                    await UserUtils.userTokenFromCache();
                                final userData =
                                    await UserUtils.userTypeFromCache();
                                final deleteCircular = {
                                  'OUserId': uid,
                                  'Token': token,
                                  'OrgId': userData!.organizationId,
                                  'Schoolid': userData.schoolId,
                                  'CircularId': item.circularId,
                                  'StuEmpId': userData.stuEmpId,
                                  'UserType': userData.ouserType,
                                };
                                print(
                                    "Sending DeleteCircular data => $deleteCircular");
                                context
                                    .read<DeleteCircularCubit>()
                                    .deleteCircularCubitCall(deleteCircular);
                              },
                              child: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildBodyText("Cir.No.: ${item.cirNo}"),
                            //buildBodyText(item.circularDate!),
                            Text(
                              '${item.circularDate}',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            )
                          ],
                        ),
                        buildBodyText("Content : ${item.cirContent!}"),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        : Center(
            child: Text(
              NO_RECORD_FOUND,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
  }

  Text buildBodyText(String? body) {
    return Text(
      body!,
      // textScaleFactor: 1.2,
      // style: Theme.of(context).textTheme.bodyText1,
    );
  }

  Text buildText({String? title, Color? color}) {
    return Text(
      title ?? "",
      style: TextStyle(fontWeight: FontWeight.w600, color: color),
    );
  }

  InkWell buildDateSelector({String? selectedDate, int? index}) {
    return InkWell(
      onTap: () => _selectDate(context, index: index),
      child: internalTextForDateTime(context, selectedDate: selectedDate),
      // Container(
      //   width: MediaQuery.of(context).size.width,
      //   padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      //   decoration: BoxDecoration(
      //     border: Border.all(color: Color(0xffECECEC)),
      //   ),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       Container(
      //         // width: MediaQuery.of(context).size.width / 4,
      //         child: Text(
      //           selectedDate!,
      //           overflow: TextOverflow.ellipsis,
      //           maxLines: 1,
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
      // color: Colors.white,
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: buildDateSelector(
                  index: 0,
                  selectedDate:
                      DateFormat("dd MMM yyyy").format(selectedFromDate),
                ),
              ),
              Icon(Icons.arrow_right_alt_outlined),
              Expanded(
                child: buildDateSelector(
                  index: 1,
                  selectedDate:
                      DateFormat("dd MMM yyyy").format(selectedToDate),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          InkWell(
            onTap: () => getCircular("0"),
            child: PhysicalModel(
              color: Colors.transparent,
              elevation: 12,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                child: Text(
                  "Show",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Text buildLabels(String label) {
    return Text(
      label,
      style: TextStyle(
        color: Color(0xff3A3A3A),
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
