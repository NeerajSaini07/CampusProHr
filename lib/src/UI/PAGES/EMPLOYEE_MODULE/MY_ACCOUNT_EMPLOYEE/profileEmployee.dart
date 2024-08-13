import 'package:campus_pro/src/DATA/BLOC_CUBIT/PROFILE_EDIT_REQUEST_CUBIT/profile_edit_request_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/PROFILE_STUDENT_CUBIT/profile_student_cubit.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/PAGES/STUDENT_MODULE/MY_ACCOUNT_STUDENT/profileEditRequestStudent.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/drawerWidget.dart';
import 'package:campus_pro/src/UTILS/appImages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../CONSTANTS/themeData.dart';
import '../../../../UTILS/fieldValidators.dart';

class ProfileEmployee extends StatefulWidget {
  static const routeName = "/profile-employee";
  @override
  _ProfileEmployeeState createState() => _ProfileEmployeeState();
}

class _ProfileEmployeeState extends State<ProfileEmployee> {
  @override
  void initState() {
    getStudentProfile();
    super.initState();
  }

  getStudentProfile() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final data = {
      'OUserId': uid,
      'Token': token,
      'OrgId': userData!.organizationId,
      'Schoolid': userData.schoolId,
      'SessionId': userData.currentSessionid,
      'StudentId': userData.stuEmpId,
    };
    // context.read<ProfileEmployeeCubit>().ProfileEmployeeCubitCall(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: commonAppBar(context, title: "Employee Profile"),
      body: buildProfileBody(context),
      // body: BlocConsumer<ProfileEmployeeCubit, ProfileEmployeeState>(
      //   listener: (context, state) {},
      //   builder: (context, state) {
      //     if (state is ProfileEmployeeLoadInProgress) {
      //       return Center(child: CircularProgressIndicator());
      //     } else if (state is ProfileEmployeeLoadSuccess) {
      //       return buildProfileBody(context, profileData: state.profileData);
      //     } else if (state is ProfileEmployeeLoadFail) {
      //       return Text(state.failReason);
      //     } else {
      //       return Center(child: CircularProgressIndicator());
      //     }
      //   },
      // ),
    );
  }

  Scrollbar buildProfileBody(BuildContext context) {
    return Scrollbar(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // buildPhotoWidget(context, data),
            // Divider(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: buildLabelWithValue(
                      heading: 'Employee No', value: 'data.gender'),
                ),
                Expanded(
                  flex: 2,
                  child: buildLabelWithValue(
                      heading: 'Joining Date', value: 'data.dobNew'),
                ),
              ],
            ),
            buildLabelWithValue(
                heading: "Department", value: 'data.fatherName'),
            buildLabelWithValue(
                heading: "Designation", value: 'data.motherName'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: buildLabelWithValue(
                      heading: 'Gender', value: 'data.gender'),
                ),
                Expanded(
                  flex: 2,
                  child:
                      buildLabelWithValue(heading: 'DOB', value: 'data.dobNew'),
                ),
              ],
            ),
            buildLabelWithValue(
                heading: "Father's Name", value: 'data.fatherName'),
            buildLabelWithValue(
                heading: "Mother's Name", value: 'data.motherName'),
            buildLabelWithValue(heading: 'Mobile No', value: 'data.mobileNo'),
            buildLabelWithValue(
                heading: "Other Mobile No", value: 'data.guardianMobileNo'),
            buildLabelWithValue(heading: "Email Id", value: 'data.email'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: buildLabelWithValue(
                      heading: "Basic Pay", value: 'data.nationality'),
                ),
                Expanded(
                  flex: 2,
                  child: buildLabelWithValue(
                      heading: "Category", value: 'data.category'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: buildLabelWithValue(
                      heading: "Religion", value: 'data.religion'),
                ),
                Expanded(
                  flex: 2,
                  child: buildLabelWithValue(
                      heading: "Blood Group", value: 'data.bloodGroup'),
                ),
              ],
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                "Present Address",
                // style: Theme.of(context).textTheme.headline1,
              ),
            ),
            buildLabelWithValue(heading: "Address", value: 'data.prsntAddress'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child:
                      buildLabelWithValue(heading: "City", value: 'data.pCity'),
                ),
                Expanded(
                  flex: 2,
                  child: buildLabelWithValue(
                      heading: "State", value: 'data.pState'),
                ),
              ],
            ),
            buildLabelWithValue(heading: "Pin Code", value: 'data.presZip'),
          ],
        ),
      ),
    );
  }

  Container buildLabelWithValue({String? heading, String? value}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          Divider(color: Color(0xffE1E3E8)),
        ],
      ),
    );
  }

  // Container buildPhotoWidget(BuildContext context, ProfileEmployeeModel data) {
  //   return Container(
  //     width: MediaQuery.of(context).size.width,
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         Stack(
  //           alignment: Alignment.topCenter,
  //           children: [
  //             Container(
  //               width: MediaQuery.of(context).size.width,
  //               height: 140,
  //               // color: Colors.blue,
  //               // color: Theme.of(context).primaryColor,
  //             ),
  //             Container(
  //               width: MediaQuery.of(context).size.width,
  //               height: 100,
  //               color: Theme.of(context).primaryColor,
  //             ),
  //             Positioned(
  //               bottom: 0,
  //               child: CircleAvatar(
  //                 backgroundColor: Colors.grey,
  //                 radius: 48,
  //                 child: CircleAvatar(
  //                   backgroundColor: Colors.grey,
  //                   radius: 46,
  //                   backgroundImage: AssetImage(AppImages.dummyImage),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //         SizedBox(height: 8),
  //         Text(
  //           "${data.stName}",
  //           style: TextStyle(
  //               color: Colors.black, fontSize: 18, fontWeight: FontWeight.w700),
  //         ),
  //         RichText(
  //           text: TextSpan(
  //             text: "Class ${data.className}-${data.classSection}",
  //             style: TextStyle(
  //               // fontSize: 20,
  //               fontWeight: FontWeight.w600,
  //               color: Colors.black54,
  //             ),
  //             children: <TextSpan>[
  //               TextSpan(
  //                 text: " | ",
  //                 style: TextStyle(
  //                   // fontSize: 20,
  //                   fontWeight: FontWeight.w600,
  //                   color: Colors.black54,
  //                 ),
  //                 children: <TextSpan>[
  //                   TextSpan(
  //                     text: "Adm no: ${data.admNo}",
  //                     style: TextStyle(
  //                       fontWeight: FontWeight.w600,
  //                       // fontSize: 20,
  //                       color: Colors.black54,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //         SizedBox(height: 10),
  //         InkWell(
  //           onTap: () {
  //             Navigator.pushNamed(context, ProfileEditRequest.routeName,
  //                 arguments: data);
  //           },
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Icon(
  //                 Icons.edit,
  //                 color: Theme.of(context).primaryColor,
  //                 size: 20,
  //               ),
  //               Text(
  //                 "Request Edit Detail",
  //                 textScaleFactor: 1.5,
  //                 style: TextStyle(
  //                   fontSize: 12,
  //                   color: Theme.of(context).primaryColor,
  //                   fontWeight: FontWeight.w700,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Text buildLabels(String label) {
    return Text(
      label,
      style: TextStyle(
        // color: Theme.of(context).primaryColor,
        color: Color(0xff313131),
      ),
    );
  }
}
