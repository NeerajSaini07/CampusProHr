import 'package:campus_pro/src/DATA/MODELS/viewEnquiryModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/PAGES/STAND_ALONE_PAGES/ENQUIRY_MANAGEMENT/addNewEnquiry.dart';
import 'package:campus_pro/src/UI/PAGES/STAND_ALONE_PAGES/ENQUIRY_MANAGEMENT/enquiryDetailsEnquiry.dart';
import 'package:campus_pro/src/UI/WIDGETS/noRecordFound.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../globalBlocProvidersFile.dart';

class ViewEnquiry extends StatefulWidget {
  const ViewEnquiry({Key? key}) : super(key: key);

  @override
  _ViewEnquiryState createState() => _ViewEnquiryState();
}

class _ViewEnquiryState extends State<ViewEnquiry> {
  bool showFilters = false;

  TextEditingController nameController = TextEditingController();

  int? selectedEnquiryType = 0;
  int? selectedStatus = 0;

  // List<Map<String, String>> enquiryTypeDropdown = [
  //   {'title': 'Select', 'value': '0'},
  //   {'title': 'Email', 'value': '3'},
  //   {'title': 'Phone', 'value': '2'},
  //   {'title': 'Visitors', 'value': '1'},
  //   {'title': 'Online', 'value': '4'},
  // ];

  // List<Map<String, String>> statusDropdown = [
  //   {'title': 'Select', 'value': '0'},
  //   {'title': 'Registered', 'value': '4'},
  //   {'title': 'Admission Confirmed', 'value': '3'},
  //   {'title': 'Next Follow-up', 'value': '1'},
  //   {'title': 'Rejected', 'value': '2'},
  // ];

  // List<String> statusDropdown = [
  //   'Select',
  //   'Registered',
  //   'Admission Confirmed',
  //   'Next Follow-up',
  //   'Rejected'
  // ];

  // DateTime selectedFromDate = DateTime.now().add((Duration(days: -1)));
  DateTime selectedFromDate = DateTime.now();
  DateTime selectedToDate = DateTime.now();

  Future<void> _selectDate(BuildContext context, {int? index}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedFromDate,
      firstDate: DateTime(1990),
      lastDate: DateTime(2050),
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

  @override
  void initState() {
    getEnquiryList(0);
    getEmployeeClass();
    super.initState();
  }

  getEnquiryList(int index) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userType = await UserUtils.userTypeFromCache();
    final enquiryData = {
      'OUserId': uid!,
      'Token': token!,
      'OrgId': userType!.organizationId!,
      'Schoolid': userType.schoolId!,
      'Name': index == 0 ? '' : nameController.text,
      'EnquiryType': index == 0
          ? ''
          : selectedEnquiryType == 0
              ? ""
              : selectedEnquiryType.toString(),
      'ReferenceID': '0',
      'EnquiryFor': '0',
      'EnquiryDate': DateFormat("dd-MMM-yyyy").format(selectedFromDate),
      // index == 0 ? '' : DateFormat("dd-MMM-yyyy").format(selectedFromDate),
      'Status': index == 0
          ? ''
          : selectedStatus == 0
              ? ""
              : selectedStatus.toString(),
      'ToDate': DateFormat("dd-MMM-yyyy").format(selectedToDate),
      // index == 0 ? '' : DateFormat("dd-MMM-yyyy").format(selectedToDate),
    };
    print("Sending ViewEnquiry Data => $enquiryData");
    context.read<ViewEnquiryCubit>().viewEnquiryCubitCall(enquiryData);
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
      "UserType": userData.ouserType,
    };
    print('Get Attendance class list $getEmpClassData');
    context
        .read<ClassListAttendanceReportCubit>()
        .classListAttendanceReportCubitCall(getEmpClassData);
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AddNewEnquiryCubit, AddNewEnquiryState>(
          listener: (context, state) {
            getEnquiryList(0);
          },
        ),
      ],
      child: Column(
        children: [
          buildAddEnquiry(context),
          if (showFilters) buildTopFilter(context),
          BlocConsumer<ViewEnquiryCubit, ViewEnquiryState>(
            listener: (context, state) {
              if (state is ViewEnquiryLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                }
              }
            },
            builder: (context, state) {
              if (state is ViewEnquiryLoadInProgress) {
                return Center(child: CircularProgressIndicator());
              } else if (state is ViewEnquiryLoadSuccess) {
                return buildEnquiryList(viewEnquirylist: state.viewEnquirylist);
              } else if (state is ViewEnquiryLoadFail) {
                return noRecordFound();
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }

  Expanded buildEnquiryList({List<ViewEnquiryModel>? viewEnquirylist}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(height: 10),
          physics: AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: viewEnquirylist!.length,
          itemBuilder: (context, i) {
            var item = viewEnquirylist[i];
            return InkWell(
              onTap: () => Navigator.pushNamed(
                  context, EnquiryDetailsEnquiry.routeName,
                  arguments: item),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffDBDBDB)),
                ),
                child: Stack(
                  children: [
                    ListTile(
                      title: Text(
                        item.name!,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 7,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              buildEmailPhone(
                                  title: item.contactNo, icon: Icons.phone),
                              RichText(
                                text: TextSpan(
                                  text: "${item.createdDate} ",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (item.comments != "")
                                Flexible(
                                  child: Text(
                                    "Comment : ${item.comments!}",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              IconButton(
                                padding: EdgeInsets.zero,
                                constraints: BoxConstraints(),
                                onPressed: () => Navigator.pushNamed(
                                    context, AddNewEnquiry.routeName,
                                    arguments: item),
                                icon: Icon(Icons.edit,
                                    color: Theme.of(context).primaryColor),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      right: 0.0,
                      // top: 10,
                      child: Container(
                        color: Colors.blue,
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 6),
                          child: Text(
                            item.statusVal!,
                            textScaleFactor: 1.5,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
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

  Container buildTopFilter(BuildContext context) {
    return Container(
      color: Color(0xffECECEC),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: buildLabels(label: "Search By Name"),
          ),
          SizedBox(height: 10.0),
          buildTextField(
            controller: nameController,
            enabled: true,
          ),
          SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildLabels(label: "From Date"),
                      SizedBox(height: 8),
                      buildDateSelector(
                        index: 0,
                        selectedDate:
                            DateFormat("dd-MMM-yyyy").format(selectedFromDate),
                      )
                    ],
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildLabels(label: "To Date"),
                      SizedBox(height: 8),
                      buildDateSelector(
                        index: 1,
                        selectedDate:
                            DateFormat("dd-MMM-yyyy").format(selectedToDate),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                buildDropdown(
                    index: 0,
                    label: "Enquiry Type:",
                    selectedValue: selectedEnquiryType,
                    dropdown: [0, 4, 3, 1, 2]),
                SizedBox(width: 20),
                buildDropdown(
                    index: 1,
                    label: "Status",
                    selectedValue: selectedStatus,
                    dropdown: [0, 3, 2, 1, 4]),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                nameController.clear();
                selectedFromDate = DateTime.now();
                selectedToDate = DateTime.now();
                selectedEnquiryType = 0;
                selectedStatus = 0;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Text(
                //   "reset",
                //   style: TextStyle(
                //       fontFamily: "BebasNeue-Regular",
                //       color: Theme.of(context).primaryColor),
                // ),
                buildSearchBtn(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Expanded buildDropdown(
      {String? label, int? selectedValue, List<int>? dropdown, int? index}) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          buildLabels(label: label!),
          SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: DropdownButton<int>(
              isDense: true,
              value: selectedValue,
              key: UniqueKey(),
              isExpanded: true,
              underline: Container(),
              items: dropdown!
                  .map((indexDD) => DropdownMenuItem<int>(
                      child: Text(
                        index == 0
                            ? indexDD == 0
                                ? 'Select'
                                : indexDD == 1
                                    ? 'Next Follow Up'
                                    : indexDD == 2
                                        ? 'Rejected'
                                        : indexDD == 3
                                            ? 'Admission Confirmed'
                                            : indexDD == 4
                                                ? 'Registered'
                                                : ""
                            : indexDD == 0
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
                        style: TextStyle(fontSize: 12),
                      ),
                      value: indexDD))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  if (index == 0)
                    selectedEnquiryType = val;
                  else
                    selectedStatus = val;
                  print("selectedValue: $val");
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Text buildLabels({String? label, Color? color}) {
    return Text(
      label!,
      style: TextStyle(
        color: color ?? Color(0xff313131),
        fontWeight: FontWeight.bold,
      ),
    );
  }

  InkWell buildDateSelector({String? selectedDate, int? index}) {
    return InkWell(
      onTap: () => _selectDate(context, index: index),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              // width: MediaQuery.of(context).size.width / 4,
              child: Text(
                selectedDate!,
                overflow: TextOverflow.ellipsis,
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

  Container buildTextField({
    bool? enabled = false,
    String? Function(String?)? validator,
    @required TextEditingController? controller,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      child: TextFormField(
        enabled: enabled,
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
              color: Colors.black12,
            ),
            gapPadding: 0.0,
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              // color: Theme.of(context).primaryColor,
              color: Colors.black12,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black12,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              // color: Theme.of(context).primaryColor,
              color: Colors.black12,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              // color: Theme.of(context).primaryColor,
              color: Colors.black12,
            ),
          ),
          hintText: "type here",
          hintStyle: TextStyle(color: Colors.black12),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
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

  Row buildAddEnquiry(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            setState(() => showFilters = !showFilters);
            // _drawerKey.currentState!.openEndDrawer();
          },
          child: Container(
            padding: const EdgeInsets.all(8.0),
            // color: Theme.of(context).primaryColor,
            child: Row(
              children: [
                Icon(Icons.sort),
                Text("Filters",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return BlocProvider<AddNewEnquiryCubit>(
                create: (_) => AddNewEnquiryCubit(
                    AddNewEnquiryRepository(AddNewEnquiryApi())),
                child: BlocProvider<ResultAnnounceClassCubit>(
                  create: (_) => ResultAnnounceClassCubit(
                      ResultAnnounceClassRepository(ResultAnnounceClassApi())),
                  child: BlocProvider<YearSessionCubit>(
                    create: (_) => YearSessionCubit(
                        YearSessionRepository(YearSessionApi())),
                    child: AddNewEnquiry(),
                  ),
                ),
              );
            }));
            // Navigator.pushNamed(context, AddNewEnquiry.routeName);
            // _drawerKey.currentState!.openEndDrawer();
          },
          child: Container(
            padding: const EdgeInsets.all(8.0),
            // color: Theme.of(context).primaryColor,
            child: Row(
              children: [
                Icon(Icons.add, color: Theme.of(context).primaryColor),
                Text("New Enquiry",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Row buildEmailPhone({String? title, IconData? icon}) {
    return Row(
      children: [
        Icon(
          icon,
          color: Theme.of(context).primaryColor,
          size: 20.0,
        ),
        SizedBox(width: 4),
        RichText(
          text: TextSpan(
            text: title,
            style: TextStyle(
              // fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black54,
            ),
          ),
        ),
      ],
    );
  }

  Container buildSearchBtn() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Theme.of(context).primaryColor,
      ),
      child: InkWell(
        onTap: () async {
          getEnquiryList(1);
          setState(() => showFilters = !showFilters);
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.search, color: Colors.white),
            SizedBox(width: 4),
            Text(
              "Search",
              style: TextStyle(
                  fontFamily: "BebasNeue-Regular", color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
