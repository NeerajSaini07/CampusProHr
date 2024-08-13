import 'package:campus_pro/src/CONSTANTS/themeData.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/TEACHERS_LIST_CUBIT/teachers_list_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/teachersListModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/PAGES/STAND_ALONE_PAGES/chatRoomCommon.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/drawerWidget.dart';
import 'package:campus_pro/src/UTILS/appImages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactList extends StatefulWidget {
  static const routeName = "/contact-list";
  @override
  _ContactListState createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: commonAppBar(context, title: "Classroom Teacher's List"),
      body: BlocConsumer<TeachersListCubit, TeachersListState>(
        listener: (context, state) {
          if (state is TeachersListLoadFail) {
            if (state.failReason == "false") {
              UserUtils.unauthorizedUser(context);
            }
          }
        },
        builder: (context, state) {
          if (state is TeachersListLoadInProgress) {
            return Center(child: CircularProgressIndicator());
          } else if (state is TeachersListLoadSuccess) {
            return buildTeacherList(context, teacherData: state.teacherData);
          } else if (state is TeachersListLoadFail) {
            return buildTeacherList(context);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  ListView buildTeacherList(BuildContext context,
      {List<TeachersListModel>? teacherData}) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: teacherData!.length,
      itemBuilder: (context, i) {
        if (i != 0)
          return ListTile(
            onTap: () {
              final chatData = ChatRoomCommonModel(
                appbarTitle: teacherData[i].empSub,
                iD: teacherData[i].subjectId,
                stuEmpId: teacherData[i].empId,
                classId: teacherData[i].classID,
                screenType: "custom",
              );
              Navigator.pop(context);
              Navigator.pushNamed(context, ChatRoomCommon.routeName,
                  arguments: chatData);
            },
            leading: CircleAvatar(
              backgroundImage: AssetImage(AppImages.dummyImage),
            ),
            title: Text(teacherData[i].empSub!.contains('-')
                ? teacherData[i].empSub!.split(' - ')[0]
                : teacherData[i].empSub!),
            subtitle: Text(teacherData[i].empSub!.contains('-')
                ? teacherData[i].empSub!.split(' - ')[1]
                : teacherData[i].empSub!),
          );
        else
          return Container();
      },
    );
  }
}

class ContextList {
  String? image;
  String? name;

  ContextList({this.image, this.name});
}

List<ContextList> contextList = [
  ContextList(image: AppImages.logo, name: "Ankur"),
  ContextList(image: AppImages.logo, name: "Ramesh"),
  ContextList(image: AppImages.logo, name: "Suraj"),
  ContextList(image: AppImages.logo, name: "Khushboo"),
  ContextList(image: AppImages.logo, name: "Rani"),
];
