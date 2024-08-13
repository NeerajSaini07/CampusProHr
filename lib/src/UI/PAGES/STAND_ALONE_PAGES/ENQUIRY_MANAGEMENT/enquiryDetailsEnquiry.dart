import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/ENQUIRY_COMMENT_LIST_CUBIT/enquiry_comment_list_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/UPDATE_ENQUIRY_STATUS_CUBIT/update_enquiry_status_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/enquiryCommentListModel.dart';
import 'package:campus_pro/src/DATA/MODELS/feeDummyData.dart';
import 'package:campus_pro/src/DATA/MODELS/viewEnquiryModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/noRecordFound.dart';
import 'package:campus_pro/src/UTILS/fieldValidators.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EnquiryDetailsEnquiry extends StatefulWidget {
  static const routeName = "/enquiry-details-enquiry";
  final ViewEnquiryModel? updateData;
  const EnquiryDetailsEnquiry({Key? key, this.updateData}) : super(key: key);

  @override
  EnquiryDetailsEnquiryState createState() => EnquiryDetailsEnquiryState();
}

class EnquiryDetailsEnquiryState extends State<EnquiryDetailsEnquiry> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay? selectedTime = TimeOfDay(hour: 00, minute: 00);

  ViewEnquiryModel? updateData;

  TextEditingController commentController = TextEditingController();

  bool checkBoxValue = true;

  int? selectedStatus = 0;

  // List<StatusModel>? statusDropdown = [
  //   StatusModel(title: 'Select', value: "0"),
  //   StatusModel(title: 'Rejected', value: "2"),
  //   StatusModel(title: 'Admission Confirmed', value: "3"),
  //   StatusModel(title: 'Registered', value: "4"),
  // ];

  Future<void> _selectDate(BuildContext context, setState) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      helpText: "SELECT DATE",
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  Future<void> _selectTime(BuildContext context, setState) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      // builder: (BuildContext context, Widget child) {
      //   return MediaQuery(
      //     data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
      //     child: child,
      //   );
      // },
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked;
      });
      print("selected time $picked");
    }
  }

  @override
  void initState() {
    getOldFollowUps();
    super.initState();
  }

  getOldFollowUps() async {
    setState(() {
      selectedStatus = 0;
      updateData = widget.updateData;
    });
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final followupData = {
      'OUserId': uid!,
      'Token': token!,
      'OrgId': userData!.organizationId!,
      'Schoolid': userData.schoolId!,
      'flag': 'S',
      'ID': updateData!.iD!.toString(),
    };
    print("Sending EnquiryCommentList data => $followupData");
    context
        .read<EnquiryCommentListCubit>()
        .enquiryCommentListCubitCall(followupData);
  }

  updateCommentsData() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final updateCommentData = {
      'OUserId': uid!,
      'Token': token!,
      'OrgId': userData!.organizationId!,
      'Schoolid': userData.schoolId!,
      'flag': 'I',
      'EnquiryID': updateData!.iD.toString(),
      'FollowUpDate': "${DateFormat("dd-MMM-yyyy").format(selectedDate)}",
      'FollowUpTime': '${selectedTime!.hour}:${selectedTime!.minute}',
      'FollowUpComments': commentController.text,
      'CreatedID': userData.stuEmpId!,
      'IsActive': checkBoxValue ? '1' : selectedStatus.toString(),
    };
    print("Sending UpdateEnquiryStatus data => $updateCommentData");
    context
        .read<UpdateEnquiryStatusCubit>()
        .updateEnquiryStatusCubitCall(updateCommentData);
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, title: "Enquiry Details"),
      floatingActionButton: buildFloatButton(context, setState),
      body: MultiBlocListener(
        listeners: [
          BlocListener<UpdateEnquiryStatusCubit, UpdateEnquiryStatusState>(
            listener: (context, state) {
              if (state is UpdateEnquiryStatusLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                }
              }
              if (state is UpdateEnquiryStatusLoadSuccess) {
                getOldFollowUps();
              }
            },
          ),
        ],
        child: Column(
          children: [
            buildEnquiryDetailCard(),
            BlocConsumer<EnquiryCommentListCubit, EnquiryCommentListState>(
              listener: (context, state) {
                if (state is EnquiryCommentListLoadFail) {
                  if (state.failReason == "false") {
                    UserUtils.unauthorizedUser(context);
                  }
                }
              },
              builder: (context, state) {
                if (state is EnquiryCommentListLoadInProgress) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is EnquiryCommentListLoadSuccess) {
                  return buildOldFollowUpList(commentList: state.commentList);
                } else if (state is EnquiryCommentListLoadFail) {
                  return noRecordFound();
                } else {
                  return Center(child: Text(SOMETHING_WENT_WRONG));
                }
              },
            ),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }

  Expanded buildOldFollowUpList({List<EnquiryCommentListModel>? commentList}) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(height: 10.0),
        shrinkWrap: true,
        itemCount: commentList!.length,
        itemBuilder: (context, i) {
          var item = commentList[i];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xffE1E3E8)),
            ),
            child: ListTile(
              title: Text(
                  item.isActive == 1
                      ? 'Next Follow Up'
                      : item.isActive == 2
                          ? 'Registered'
                          : item.isActive == 3
                              ? 'Admission Confirmed'
                              : item.isActive == 4
                                  ? 'Registered'
                                  : "",
                  // style: Theme.of(context)
                  //     .textTheme
                  //     .subtitle1!
                  //     .copyWith(fontWeight: FontWeight.bold)
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.followUpDateFormat!),
                  if (item.followUpComments != "") Divider(),
                  if (item.followUpComments != "")
                    Row(
                      children: [
                        Icon(Icons.chat_bubble, color: Colors.grey),
                        SizedBox(width: 8),
                        Text(item.followUpComments!),
                      ],
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  InkWell buildFloatButton(BuildContext context, setState) {
    return InkWell(
      onTap: () {
        showAddNewChildDialog(context, setState);
      },
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(40.0),
        ),
        child: Text(
          "Add Comment",
          textScaleFactor: 1.5,
          style: TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  showAddNewChildDialog(BuildContext context, setState) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              // title: Text("Add Child"),
              content: buildDialogBody(context, setState),
              actions: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  // color: Theme.of(context).primaryColor,
                  onPressed: () {
                    updateCommentsData();
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Send",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
      // builder: (ctx) => AlertDialog(
      //   // title: Text("Add Child"),
      //   content: buildDialogBody(context),
      //   actions: <Widget>[
      //     FlatButton(
      //       color: Theme.of(context).primaryColor,
      //       onPressed: () {
      //         // if (_formKey.currentState!.validate()) {
      //         //   if (_selectedClass != 'Select') {
      //         //     Navigator.pop(
      //         //         context,
      //         //         ChildrenDummy(
      //         //             stuName: nameController.text,
      //         //             className: _selectedClass,
      //         //             gender: _selectedGender));

      //         //     nameController.clear();
      //         //     _selectedGender = "MALE";
      //         //     _selectedClass = 'Select';
      //         //   } else {
      //         //     toast('Please Select Class');
      //         //   }
      //         // }
      //       },
      //       child: Text(
      //         "Send",
      //         style: TextStyle(
      //           color: Colors.white,
      //           fontWeight: FontWeight.bold,
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }

  buildDialogBody(BuildContext context, setState) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Next Follow-up:'),
              SizedBox(width: 8),
              Checkbox(
                value: checkBoxValue,
                onChanged: (_) {
                  print('Pressed before $checkBoxValue');
                  setState(() {
                    checkBoxValue = !checkBoxValue;
                  });
                  print('Pressed after $checkBoxValue');
                },
              ),
            ],
          ),
          if (checkBoxValue)
            Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildLabels(label: "Date"),
                    SizedBox(height: 8.0),
                    buildDateSelector(setState),
                  ],
                ),
                SizedBox(height: 8.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildLabels(label: "Time"),
                    SizedBox(height: 8.0),
                    buildTimeSelector(setState),
                  ],
                ),
              ],
            )
          else
            buildStatusDropdown(context, setState),
          SizedBox(height: 8.0),
          buildLabels(label: 'Comments (Optional)'),
          SizedBox(height: 8.0),
          buildTextField(
              controller: commentController,
              validator: FieldValidators.globalValidator),
        ],
      ),
    );
  }

  Column buildStatusDropdown(BuildContext context, setState) {
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
            value: selectedStatus,
            key: UniqueKey(),
            isExpanded: true,
            underline: Container(),
            //         StatusModel(title: 'Select', value: "0"),
            // StatusModel(title: 'Rejected', value: "2"),
            // StatusModel(title: 'Admission Confirmed', value: "3"),
            // StatusModel(title: 'Registered', value: "4"),
            items: [0, 2, 3, 4]
                .map((index) => DropdownMenuItem<int>(
                    child: Text(
                      // getStatusString(context, index)!,
                      index == 0
                          ? 'Select'
                          : index == 2
                              ? 'Rejected'
                              : index == 3
                                  ? 'Admission Confirmed'
                                  : index == 4
                                      ? 'Registered'
                                      : "",

                      style: TextStyle(fontSize: 12),
                    ),
                    value: index))
                .toList(),
            // items: statusDropdown!
            //     .map((item) => DropdownMenuItem<StatusModel>(
            //         child: Text(item.title!, style: TextStyle(fontSize: 12)),
            //         value: item))
            //     .toList(),
            onChanged: (val) {
              setState(() {
                selectedStatus = val;
                print("selectedStatus: $val");
              });
            },
          ),
        ),
      ],
    );
  }

  String? getStatusString(BuildContext context, int index) {
    switch (index) {
      case 0:
        return 'Select';
      case 2:
        return 'Rejected';
      case 3:
        return 'Admission Confirmed';
      case 4:
        return 'Registered';
      default:
        return 'Select';
    }
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

  Container buildTextField({
    int? maxLines,
    String? Function(String?)? validator,
    @required TextEditingController? controller,
  }) {
    return Container(
      // margin: const EdgeInsets.symmetric(horizontal: 10.0),
      child: TextFormField(
        controller: controller,
        validator: validator,
        maxLines: 3,
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
          hintText: "add comment",
          hintStyle: TextStyle(color: Color(0xffA5A5A5)),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        ),
      ),
    );
  }

  Container buildEnquiryDetailCard() {
    return Container(
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Color(0xff1A5487),
        // color: Theme.of(context).primaryColor,
        // borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black87,
            blurRadius: 5.0,
          ),
        ],
      ),
      child: Column(
        children: [
          buildInfoRows(title: updateData!.name, icon: Icons.person),
          buildInfoRows(
              title: updateData!.enquiryDateFormat, icon: Icons.calendar_today),
          buildInfoRows(
              title: updateData!.contactNo, icon: Icons.phone_android),
          buildInfoRows(title: updateData!.emailID, icon: Icons.email),
          buildInfoRows(title: updateData!.oldSchoolName, icon: Icons.school),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            decoration: BoxDecoration(
              color: Color(0xffE99510),
            ),
            child: Text(
              updateData!.statusVal!,
              textScaleFactor: 1.5,
              style: TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  InkWell buildDateSelector(setState) {
    return InkWell(
      onTap: () => _selectDate(context, setState),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xffECECEC)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              // width: MediaQuery.of(context).size.width / 4,
              child: Text(
                DateFormat("dd-MMM-yyyy").format(selectedDate),
                // "${selectedDate.toLocal()}".split(' ')[0],
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            Icon(Icons.today, color: Theme.of(context).primaryColor)
          ],
        ),
      ),
    );
  }

  InkWell buildTimeSelector(setState) {
    return InkWell(
      onTap: () => _selectTime(context, setState),
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xffECECEC)),
            ),
            child: Text("${selectedTime!.hour}:${selectedTime!.minute}"),
            // child: Text(index == 0 ? _startDateSelected : _endDateSelected),
          ),
          Positioned(
              right: 8,
              top: 8,
              child: Icon(Icons.watch_later,
                  color: Theme.of(context).primaryColor)),
        ],
      ),
    );
  }

  Padding buildInfoRows({String? title, IconData? icon}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Icon(icon, color: Color(0xffE99510)),
          SizedBox(width: 8),
          Text(title!,
              // style: Theme.of(context).textTheme.subtitle2!.copyWith(
              //     fontWeight: FontWeight.w600, color: Colors.white70)
          ),
        ],
      ),
    );
  }
}

class EnquiryDetailDummy {
  String? comment;
  String? status;
  String? date;

  EnquiryDetailDummy({this.comment, this.status, this.date});
}

List<EnquiryDetailDummy> enquiryDummyList = [
  EnquiryDetailDummy(
      date: "31-Jul-2021 03:33 PM",
      status: "Next Follow Up",
      comment: "Not Sure"),
  EnquiryDetailDummy(
      date: "03-Aug-2021 09:00 AM",
      status: "Registered",
      comment: "For Details"),
  EnquiryDetailDummy(
      date: "06-Aug-2021 12:40 PM", status: "Admission Confirmed", comment: ""),
];

class StatusModel {
  String? title;
  String? value;

  StatusModel({this.title, this.value});
}
