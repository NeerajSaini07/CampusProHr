import 'package:campus_pro/src/DATA/MODELS/profileStudentModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/PAGES/STUDENT_MODULE/MY_ACCOUNT_STUDENT/profileEditRequestStudent.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/drawerWidget.dart';
import 'package:campus_pro/src/UTILS/appImages.dart';
import 'package:flutter/material.dart';

import '../../../../globalBlocProvidersFile.dart';

class ProfileStudent extends StatefulWidget {
  static const routeName = "/profile-student";
  @override
  _ProfileStudentState createState() => _ProfileStudentState();
}

class _ProfileStudentState extends State<ProfileStudent> {
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
    context.read<ProfileStudentCubit>().profileStudentCubitCall(data);
  }

  _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000)).then((value) {
      getStudentProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: commonAppBar(context,
          title: "Student Profile", shadowColor: Colors.transparent),
      body: RefreshIndicator(
        onRefresh: () => _onRefresh(),
        child: BlocConsumer<ProfileStudentCubit, ProfileStudentState>(
          listener: (context, state) {
            if (state is ProfileStudentLoadFail) {
              if (state.failReason == "false") {
                UserUtils.unauthorizedUser(context);
              }
            }
          },
          builder: (context, state) {
            if (state is ProfileStudentLoadInProgress) {
              // return Center(child: CircularProgressIndicator());
              return Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: LinearProgressIndicator());
            } else if (state is ProfileStudentLoadSuccess) {
              return buildProfileBody(context, profileData: state.profileData);
            } else if (state is ProfileStudentLoadFail) {
              return Text(state.failReason);
            } else {
              // return Center(child: CircularProgressIndicator());
              return Center(child: LinearProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Scrollbar buildProfileBody(BuildContext context,
      {List<ProfileStudentModel>? profileData}) {
    var data = profileData![0];
    return Scrollbar(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildPhotoWidget(context, data),
            Divider(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: buildLabelWithValue(
                      heading: 'Gender', value: data.gender),
                ),
                Expanded(
                  flex: 2,
                  child:
                      buildLabelWithValue(heading: 'DOB', value: data.dobNew),
                ),
              ],
            ),
            buildLabelWithValue(
                heading: "Father's Name", value: data.fatherName),
            buildLabelWithValue(
                heading: "Mother's Name", value: data.motherName),
            buildLabelWithValue(heading: 'Mobile No', value: data.mobileNo),
            buildLabelWithValue(
                heading: "Guardian's Mobile No", value: data.guardianMobileNo),
            buildLabelWithValue(heading: "Email Id", value: data.email),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: buildLabelWithValue(
                      heading: "Category", value: data.category),
                ),
                Expanded(
                  flex: 2,
                  child: buildLabelWithValue(
                      heading: "Nationality", value: data.nationality),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: buildLabelWithValue(
                      heading: "Religion", value: data.religion),
                ),
                Expanded(
                  flex: 2,
                  child: buildLabelWithValue(
                      heading: "Blood Group", value: data.bloodGroup),
                ),
              ],
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                "Present Address",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            buildLabelWithValue(heading: "Address", value: data.prsntAddress),
            buildLabelWithValue(heading: "Area / Village", value: data.village),
            buildLabelWithValue(heading: "Post Office", value: data.pO),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child:
                      buildLabelWithValue(heading: "City", value: data.pCity),
                ),
                Expanded(
                  flex: 2,
                  child:
                      buildLabelWithValue(heading: "State", value: data.pState),
                ),
              ],
            ),
            buildLabelWithValue(heading: "Pin Code", value: data.presZip),
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
            '${heading!} :',
            style:
                Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 16),
          ),
          SizedBox(height: 4),
          Text(
            value!,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Colors.black54, fontSize: 16),
          ),
          SizedBox(height: 4),
          Divider(color: Color(0xffE1E3E8)),
        ],
      ),
    );
  }

  Container buildPhotoWidget(BuildContext context, ProfileStudentModel data) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                color: Theme.of(context).primaryColor,
              ),
              Positioned(
                bottom: 0,
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 48,
                  child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 46,
                    backgroundImage:
                        data.studentImage != "" && data.studentImage != null
                            ? NetworkImage(data.studentImage!)
                            : AssetImage(AppImages.dummyImage) as ImageProvider,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            "${data.stName}",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          RichText(
            text: TextSpan(
              text: "Class ${data.className}-${data.classSection}",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Colors.black54, fontSize: 16),
              children: <TextSpan>[
                TextSpan(
                  text: " | ",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Colors.black54, fontSize: 16),
                  children: <TextSpan>[
                    TextSpan(
                      text: "Adm no: ${data.admNo}",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: Colors.black54, fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return BlocProvider<ProfileEditRequestCubit>(
                    create: (_) => ProfileEditRequestCubit(
                        ProfileEditRequestRepository(ProfileEditRequestApi())),
                    child: ProfileEditRequest(
                      profileData: data,
                    ));
              }));
              // Navigator.pushNamed(context, ProfileEditRequest.routeName,
              //     arguments: data);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.edit,
                  color: Theme.of(context).primaryColor,
                  size: 20,
                ),
                Text(
                  "Request Edit Detail",
                  textScaleFactor: 1.5,
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
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
        // color: Theme.of(context).primaryColor,
        color: Color(0xff313131),
      ),
    );
  }
}
