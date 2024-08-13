import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/FEEDBACK_ENQUIRY_CUBIT/feedback_enquiry_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/feedbackEnquiryModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/WIDGETS/noRecordFound.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedbackEnquiry extends StatefulWidget {
  const FeedbackEnquiry({Key? key}) : super(key: key);

  @override
  _FeedbackEnquiryState createState() => _FeedbackEnquiryState();
}

class _FeedbackEnquiryState extends State<FeedbackEnquiry> {
  bool showFilters = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  String? _selectedAdmission = 'All';

  List<String> admissionDropdown = ['All', 'New', 'Old'];

  @override
  void initState() {
    getFeedbackData(0);
    super.initState();
  }

  getFeedbackData(int index) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final feedbackData = {
      'OUserId': uid!,
      'Token': token!,
      'flag': 'S',
      'ID': '',
      'Name': index == 1 ? nameController.text : "",
      'MobileNo': index == 1 ? phoneController.text : "",
      'Admission': index == 1
          ? _selectedAdmission!.contains('All')
              ? ""
              : _selectedAdmission
          : "",
      'EmailID': '',
      'OtherCmnt': '',
      'CreatedBy': '',
      'QusData': '',
      'AnsData': '',
      'SchoolID': userData!.schoolId,
      'OrgID': userData.organizationId,
      'EmpId': userData.stuEmpId,
      'UserType': userData.ouserType,
    };
    print("Sending FeedbackEnquiry data => $feedbackData");
    context.read<FeedbackEnquiryCubit>().feedbackEnquiryCubitCall(feedbackData);
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildAddEnquiry(context),
        if (showFilters) buildTopFilter(context),
        BlocConsumer<FeedbackEnquiryCubit, FeedbackEnquiryState>(
          listener: (context, state) {
            if (state is FeedbackEnquiryLoadFail) {
              if (state.failReason == "false") {
                UserUtils.unauthorizedUser(context);
              }
            }
          },
          builder: (context, state) {
            if (state is FeedbackEnquiryLoadInProgress) {
              return Center(child: CircularProgressIndicator());
            } else if (state is FeedbackEnquiryLoadSuccess) {
              return buildFeedbackBody(context,
                  feedbackList: state.feedbackList);
            } else if (state is FeedbackEnquiryLoadFail) {
              return noRecordFound();
            } else {
              return Text(SOMETHING_WENT_WRONG);
            }
          },
        ),
      ],
    );
  }

  Expanded buildFeedbackBody(BuildContext context,
      {List<FeedbackEnquiryModel>? feedbackList}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(height: 10),
          physics: AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: feedbackList!.length,
          itemBuilder: (context, i) {
            var item = feedbackList[i];
            return Container(
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildEmailPhone(
                                title: item.emailID, icon: Icons.email),
                            buildEmailPhone(
                                title: item.mobileNo, icon: Icons.phone),
                          ],
                        ),
                        SizedBox(height: 4),
                        Text(
                          item.otherCmnt!,
                          style: TextStyle(
                            // fontWeight: FontWeight.w600,
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: item.createdOn,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Text(
                        //       "New Admission",
                        //       textScaleFactor: 1.5,
                        //       style: TextStyle(
                        //         fontWeight: FontWeight.w600,
                        //         color: Colors.deepOrange,
                        //         fontSize: 10,
                        //       ),
                        //     ),
                        //     Card(
                        //       color: Theme.of(context).primaryColor,
                        //       child: Padding(
                        //         padding: const EdgeInsets.symmetric(
                        //             horizontal: 8.0, vertical: 4.0),
                        //         child: Row(
                        //           mainAxisSize: MainAxisSize.min,
                        //           children: [
                        //             Icon(Icons.info_outline,
                        //                 color: Colors.white, size: 16),
                        //             SizedBox(width: 4.0),
                        //             Text(
                        //               "view more",
                        //               textScaleFactor: 1.5,
                        //               style: TextStyle(
                        //                 fontWeight: FontWeight.w600,
                        //                 color: Colors.white,
                        //                 fontSize: 10,
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                    // subtitle: Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text(
                    //       '15 Apr 2021',
                    //       style: TextStyle(
                    //         // fontWeight: FontWeight.w600,
                    //         color: Colors.grey,
                    //         fontSize: 12,
                    //       ),
                    //     ),
                    //     Text(
                    //       'Emp: SANDEEP SHARMA',
                    //       style: TextStyle(
                    //         // fontWeight: FontWeight.w600,
                    //         color: Colors.grey,
                    //         fontSize: 12,
                    //       ),
                    //     ),
                    //     Icon(
                    //       Icons.delete,
                    //       color: Colors.red[300],
                    //     ),
                    //   ],
                    // ),
                  ),
                  // Positioned(
                  //   right: 0.0,
                  //   child: Container(
                  //     color: Colors.orange,
                  //     child: Padding(
                  //       padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  //       child: Text(
                  //         'NEW',
                  //         textScaleFactor: 1.5,
                  //         style: TextStyle(
                  //           fontSize: 10,
                  //           fontWeight: FontWeight.bold,
                  //           color: Colors.white,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            );
          },
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
        // InkWell(
        //   onTap: () {
        //     // Navigator.pushNamed(context, AddNewEnquiry.routeName);
        //     // _drawerKey.currentState!.openEndDrawer();
        //   },
        //   child: Container(
        //     padding: const EdgeInsets.all(8.0),
        //     // color: Theme.of(context).primaryColor,
        //     child: Row(
        //       children: [
        //         Icon(Icons.add, color: Theme.of(context).primaryColor),
        //         Text("New Enquiry",
        //             style: TextStyle(
        //                 color: Theme.of(context).primaryColor,
        //                 fontWeight: FontWeight.bold)),
        //       ],
        //     ),
        //   ),
        // ),
      ],
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
            child: buildLabels(label: "Name"),
          ),
          SizedBox(height: 10.0),
          buildTextField(
            controller: nameController,
            enabled: true,
          ),
          SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: buildLabels(label: "Mobile No"),
          ),
          SizedBox(height: 10.0),
          buildTextField(
            controller: phoneController,
            maxLength: 10,
            keyboardType: TextInputType.phone,
            enabled: true,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: buildDropdown(
                label: "Admission",
                selectedValue: _selectedAdmission,
                dropdown: admissionDropdown),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    nameController.clear();
                    phoneController.clear();
                    _selectedAdmission = "All";
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 18.0,
                    vertical: 12.0,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      border: Border.all(width: 0.1),
                      color: Colors.red),
                  child: Text(
                    "Reset",
                    style: TextStyle(
                      fontFamily: "BebasNeue-Regular",
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 30.0,
              ),
              buildSearchBtn(),
            ],
          ),
        ],
      ),
    );
  }

  Column buildDropdown(
      {String? label, String? selectedValue, List<String>? dropdown}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 8),
        buildLabels(label: label!),
        SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.circular(4),
          ),
          child: DropdownButton<String>(
            isDense: true,
            value: _selectedAdmission,
            key: UniqueKey(),
            isExpanded: true,
            underline: Container(),
            items: dropdown!
                .map((item) => DropdownMenuItem<String>(
                    child: Text(item, style: TextStyle(fontSize: 12)),
                    value: item))
                .toList(),
            onChanged: (val) {
              setState(() {
                _selectedAdmission = val;
                print("_selectedAdmission: $val");
              });
            },
          ),
        ),
      ],
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

  Container buildTextField({
    bool? enabled = false,
    @required TextEditingController? controller,
    int? maxLength,
    TextInputType? keyboardType,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      child: TextFormField(
        enabled: enabled,
        controller: controller,
        maxLength: maxLength ?? null,
        keyboardType: keyboardType ?? null,
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
          counterText: "",
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
          getFeedbackData(1);
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

  Row buildEmailPhone({String? title, IconData? icon}) {
    return Row(
      children: [
        Icon(
          icon,
          color: Theme.of(context).primaryColor,
          // color: Colors.black54,
          // size: 16,
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
}
