import 'package:campus_pro/src/DATA/BLOC_CUBIT/CUSTOM_CHAT_USER_LIST_CUBIT/custom_chat_user_list_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/customChatUserListModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/PAGES/STAND_ALONE_PAGES/chatRoomCommon.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UTILS/appImages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomChatUserListAdmin extends StatefulWidget {
  static const routeName = "/custom-chat-user-list-admin";
  @override
  _CustomChatUserListAdminState createState() =>
      _CustomChatUserListAdminState();
}

class _CustomChatUserListAdminState extends State<CustomChatUserListAdmin> {
  @override
  void initState() {
    getChatUsers();
    super.initState();
  }

  getChatUsers() async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final chatUsers = {
      'OUserId': uid,
      'Token': token,
      'OrgId': userData!.organizationId,
      'Schoolid': userData.schoolId,
      'SessionId': userData.currentSessionid,
      'SenderId': userData.stuEmpId,
      'UserType': userData.ouserType,
    };
    print("Sending CustomChatUserList Data => $chatUsers");
    context
        .read<CustomChatUserListCubit>()
        .customChatUserListCubitCall(chatUsers);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, title: "Contacts"),
      body: BlocConsumer<CustomChatUserListCubit, CustomChatUserListState>(
        listener: (context, state) {
          if (state is CustomChatUserListLoadFail) {
            if (state.failReason == "false") {
              UserUtils.unauthorizedUser(context);
            }
          }
        },
        builder: (context, state) {
          if (state is CustomChatUserListLoadInProgress) {
            // return Center(child: CircularProgressIndicator());
            return Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: LinearProgressIndicator());
          } else if (state is CustomChatUserListLoadSuccess) {
            return buildTeacherList(context,
                customChatUserList: state.customChatUserList);
          } else if (state is CustomChatUserListLoadFail) {
            return buildTeacherList(context);
          } else {
            // return Center(child: CircularProgressIndicator());
            return Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: LinearProgressIndicator());
          }
        },
      ),
    );
  }

  ListView buildTeacherList(BuildContext context,
      {List<CustomChatUserListModel>? customChatUserList}) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: customChatUserList!.length,
      itemBuilder: (context, i) {
        if (i != 0)
          return ListTile(
            onTap: () async {
              final userData = await UserUtils.userTypeFromCache();
              final chatData = ChatRoomCommonModel(
                appbarTitle: customChatUserList[i].name,
                iD: "0",
                stuEmpId: customChatUserList[i].eMPID,
                classId: "",
                screenType: "custom chat",
              );
              Navigator.pop(context);
              Navigator.pushNamed(context, ChatRoomCommon.routeName,
                  arguments: chatData);
            },
            leading: CircleAvatar(
              backgroundImage: AssetImage(AppImages.dummyImage),
            ),
            title: Text(customChatUserList[i].name!),
            // subtitle: Text(teacherData[i].empSub!.contains('-')
            //     ? teacherData[i].empSub!.split(' - ')[1]
            //     : teacherData[i].empSub!),
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
