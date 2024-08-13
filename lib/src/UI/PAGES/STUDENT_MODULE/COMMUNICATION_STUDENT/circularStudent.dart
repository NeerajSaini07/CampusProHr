import 'package:campus_pro/src/DATA/BLOC_CUBIT/CIRCULAR_STUDENT_CUBIT/circular_student_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/circularStudentModel.dart';
import 'package:campus_pro/src/DATA/MODELS/userTypeModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/drawerWidget.dart';
import 'package:campus_pro/src/UI/WIDGETS/fileDownloader.dart';
import 'package:campus_pro/src/WIDGETS_STYLE/style_common.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CircularStudent extends StatefulWidget {
  static const routeName = "/circular-student";
  @override
  _CircularStudentState createState() => _CircularStudentState();
}

class _CircularStudentState extends State<CircularStudent> {
  DateTime selectedFromDate = DateTime.now().subtract(Duration(days: 7));
  DateTime selectedToDate = DateTime.now();

  UserTypeModel? userData;

  List<CircularStudentModel> circularList = [];

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
      "StuEmpId": userData!.stuEmpId,
      "For": userData!.ouserType,
      "CirFromDate": DateFormat("dd MMM yyyy").format(selectedFromDate),
      "CirToDate": DateFormat("dd MMM yyyy").format(selectedToDate),
      "EmpGroupId": "",
      "OnLoad": onLoad,
    };
    print("circularData sending = > $circularData");
    context.read<CircularStudentCubit>().circulatStudentCubitCall(circularData);
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
      body: RefreshIndicator(
        onRefresh: () => _onRefresh(),
        child: Column(
          children: [
            buildTopDateFilter(context),
            BlocConsumer<CircularStudentCubit, CircularStudentState>(
              listener: (context, state) {
                if (state is CircularStudentLoadFail) {
                  if (state.failReason == "false") {
                    UserUtils.unauthorizedUser(context);
                  }
                }
                if (state is CircularStudentLoadSuccess) {
                  setState(() {
                    circularList = state.circularStudentList;
                  });
                }
              },
              builder: (context, state) {
                if (state is CircularStudentLoadInProgress) {
                  // return Center(child: CircularProgressIndicator());
                  return Center(child: LinearProgressIndicator());
                } else if (state is CircularStudentLoadSuccess) {
                  return buildCirculars(context,
                      circularStudentList: circularList);
                } else if (state is CircularStudentLoadFail) {
                  return buildCirculars(context, circularStudentList: []);
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCirculars(BuildContext context,
      {List<CircularStudentModel>? circularStudentList}) {
    return Expanded(
      child: ListView.separated(
        // separatorBuilder: (context, index) => Divider(color: Color(0xffDBDBDB)),
        separatorBuilder: (context, index) => SizedBox(height: 10),
        shrinkWrap: true,
        itemCount: circularStudentList!.length,
        itemBuilder: (context, i) {
          var item = circularStudentList[i];
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
                    child: Text(
                      "${item.cirsubject}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  if (item.circularfileurl != null &&
                      item.circularfileurl != "")
                    FileDownload(
                      fileName: item.circularfileurl!.split("/").last,
                      fileUrl: userData!.baseDomainURL! + item.circularfileurl!,
                      downloadWidget: Icon(Icons.file_download,
                          color: Theme.of(context).primaryColor),
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
                      buildBodyText("Cir.No : ${item.cirno}", 11),
                      Text(
                        "${item.circulardate}",
                        style: TextStyle(fontSize: 12),
                      )
                    ],
                  ),
                  buildBodyText("Content : ${item.circontent!}", 16),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildBodyText(String? body, int? size) {
    return Text(
      "$body",
      style: TextStyle(
        fontSize: double.parse("$size"),
        color: Colors.black,
      ),
    );
    //   googleFontStyleLeto(
    //   context,
    //   txt: body,
    //   fontSize: double.parse(size.toString()),
    // );
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
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(30.0),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 10, color: Colors.grey, spreadRadius: 1),
                  ]),
              child: Text(
                "Show",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  Text buildLabels(String label) {
    return Text(
      label,
      style: TextStyle(
        // color: Theme.of(context).primaryColor,
        color: Color(0xff3A3A3A),
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
