import 'dart:io';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/CHAR_ROOM_COMMENTS_COMMON_CUBIT/chat_room_comments_common_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/DELETE_CUSTOM_CHAT_CUBIT/delete_custom_chat_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/DELETE_HOMEWORK_COMMENT_CUBIT/delete_homework_comment_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/SEND_CLASSROOM_COMMENT_CUBIT/send_class_room_comment_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/SEND_CUSTOM_CHAT_CUBIT/send_custom_chat_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/SEND_CUSTOM_CLASSROOM_COMMENT_CUBIT/send_custom_class_room_comment_cubit.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/SEND_HOMEWORK_COMMENT_CUBIT/send_homework_comment_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/classRoomCommentsModel.dart';
import 'package:campus_pro/src/DATA/MODELS/homeWorkCommentsModel.dart';
import 'package:campus_pro/src/DATA/MODELS/userTypeModel.dart';
import 'package:campus_pro/src/DATA/userUtils.dart';
import 'package:campus_pro/src/UI/WIDGETS/commonAppBar.dart';
import 'package:campus_pro/src/UI/WIDGETS/fileDownloader.dart';
import 'package:campus_pro/src/UI/WIDGETS/toast.dart';
import 'package:campus_pro/src/UTILS/appImages.dart';
import 'package:campus_pro/src/UTILS/filePicker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ChatRoomCommon extends StatefulWidget {
  static const routeName = "/chat-room-common";
  final ChatRoomCommonModel? chatData;

  const ChatRoomCommon({Key? key, this.chatData}) : super(key: key);
  @override
  _ChatRoomCommonState createState() => _ChatRoomCommonState();
}

class _ChatRoomCommonState extends State<ChatRoomCommon> {
  TextEditingController messageController = TextEditingController();

  ChatRoomCommonModel? chatData = ChatRoomCommonModel();

  List<ChatBubbleModel> chatBubbleMessagesList = [];

  bool showLoader = false;

  String titleFinal = "";

  // String? screenType;
  String? currentUserType;

  int? noOfComments = 0;

  List<File>? _filePickedList;

  String? uid = "";
  String? token = "";
  UserTypeModel? userData = UserTypeModel();

  String? commentIdForReply = "";
  String? studentIdForReply = "";
  bool showTextField = false;

  @override
  void dispose() {
    messageController.dispose();
    _filePickedList = null;
    // screenType = '';
    currentUserType = '';
    uid = '';
    token = '';
    super.dispose();
  }

  @override
  void initState() {
    chatData = widget.chatData;
    print("ChatRoom Data From Prev. Page => $chatData");
    getChatAccordingScreen();
    super.initState();
  }

  getChatAccordingScreen() async {
    uid = await UserUtils.idFromCache();
    token = await UserUtils.userTokenFromCache();
    userData = await UserUtils.userTypeFromCache();
    if (mounted)
      setState(() {
        currentUserType = userData!.ouserType!.toLowerCase();
        if (chatData!.screenType == "classroom") {
          if (currentUserType == 's' ||
              currentUserType == 'e' &&
                  chatData!.classId != null &&
                  chatData!.classId != "") setState(() => showTextField = true);
          getClassroomComments();
          if (currentUserType == 's') setState(() => showTextField = true);
        } else if (chatData!.screenType == "homework") {
          getHomeworkComments();
        } else if (chatData!.screenType == "custom chat") {
          setState(() => showTextField = true);
          getCustomChat();
        } else if (chatData!.screenType == "custom") {
          setState(() => showTextField = true);
        }
      });
  }

  getClassroomComments() async {
    Map<String, String?> commentData = {
      'OUserId': uid,
      'Token': token,
      'OrgId': userData!.organizationId,
      'Schoolid': userData!.schoolId,
      'SessionId': userData!.currentSessionid,
      'CircularId': chatData!.iD,
      'UserType': userData!.ouserType,

      'StudentId': userData!.stuEmpId, // Admin - empId || StuEmpId

      'StuEmpId': chatData!.teacherId == null ? "" : chatData!.teacherId,
      //userData!.stuEmpId, // StuEmpId

      'For': userData!.ouserType, // admin - e, employee - e, student - s
      // 'StudentId': chatData!.,
      // 'For': chatData!.,
      //Todo
    };
    print("Sending Classroom Comments Data : $commentData");
    context.read<ChatRoomCommentsCommonCubit>().chatRoomCommentsCommonCubitCall(
        commentData: commentData, screenType: chatData!.screenType);
  }

  getHomeworkComments() async {
    Map<String, String?> commentData = {
      'OUserId': uid,
      'Token': token,
      'OrgId': userData!.organizationId,
      'SchoolId': userData!.schoolId,
      'SessionId': userData!.currentSessionid,
      'HomeworkId': chatData!.iD,
      'UserType': userData!.ouserType,
      'StudentId': userData!.stuEmpId,
    };
    print("Sending Homework Comments Data : $commentData");
    context.read<ChatRoomCommentsCommonCubit>().chatRoomCommentsCommonCubitCall(
        commentData: commentData, screenType: chatData!.screenType);
  }

  getCustomChat() async {
    Map<String, String?> commentData = {
      'OUserId': uid,
      'Token': token,
      'OrgId': userData!.organizationId,
      'Schoolid': userData!.schoolId,
      'NoRows': "0",
      'Counts': "50",
      'EmpId': userData!.stuEmpId,
      'SenderId': chatData!.stuEmpId,
      'UserType': userData!.ouserType,
    };
    print("Sending ChatRoom Data : $commentData");
    context.read<ChatRoomCommentsCommonCubit>().chatRoomCommentsCommonCubitCall(
        commentData: commentData, screenType: chatData!.screenType);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
        context,
        title: chatData!.appbarTitle,
        icon: IconButton(
          onPressed: () => getChatAccordingScreen(),
          icon: Container(
            height: 28,
            width: 28,
            child: Icon(Icons.refresh),
          ),
        ),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<SendCustomChatCubit, SendCustomChatState>(
            listener: (context, state) {
              if (state is SendCustomChatLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                } else {
                  setState(() {
                    messageController.text = "";
                    _filePickedList = null;
                    showLoader = false;
                  });
                  toast("Failed! Try again later.");
                }
              }
              if (state is SendCustomChatLoadSuccess) {
                getCustomChat();
                setState(() {
                  messageController.text = "";
                  _filePickedList = null;
                  showLoader = false;
                });
              }
            },
          ),
          BlocListener<SendClassRoomCommentCubit, SendClassRoomCommentState>(
            listener: (context, state) {
              if (state is SendClassRoomCommentLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                } else {
                  setState(() {
                    messageController.text = "";
                    _filePickedList = null;
                    showLoader = false;
                  });
                  toast("Failed! Try again later.");
                }
              }
              if (state is SendClassRoomCommentLoadSuccess) {
                if (currentUserType != 's')
                  setState(() => showTextField = false);
                getClassroomComments();
              }
            },
          ),
          BlocListener<SendCustomClassRoomCommentCubit,
              SendCustomClassRoomCommentState>(
            listener: (context, state) {
              if (state is SendCustomClassRoomCommentLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                } else {
                  setState(() {
                    messageController.text = "";
                    _filePickedList = null;
                    showLoader = false;
                  });
                  toast("Failed! Try again later.");
                }
              }
              if (state is SendCustomClassRoomCommentLoadSuccess) {
                Navigator.pop(context);
              }
            },
          ),
          BlocListener<SendHomeworkCommentCubit, SendHomeworkCommentState>(
            listener: (context, state) {
              if (state is SendHomeworkCommentLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                } else {
                  setState(() {
                    messageController.text = "";
                    _filePickedList = null;
                    showLoader = false;
                  });
                  toast("Failed! Try again later.");
                }
              }
              if (state is SendHomeworkCommentLoadSuccess) {
                if (currentUserType != 's')
                  setState(() => showTextField = false);
                getHomeworkComments();
              }
            },
          ),
          BlocListener<DeleteHomeworkCommentCubit, DeleteHomeworkCommentState>(
            listener: (context, state) {
              if (state is DeleteHomeworkCommentLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                }
              }
              if (state is DeleteHomeworkCommentLoadSuccess) {
                getHomeworkComments();
              }
            },
          ),
          BlocListener<DeleteCustomChatCubit, DeleteCustomChatState>(
            listener: (context, state) {
              if (state is DeleteCustomChatLoadFail) {
                if (state.failReason == "false") {
                  UserUtils.unauthorizedUser(context);
                }
              }
              if (state is DeleteCustomChatLoadSuccess) {
                getCustomChat();
              }
            },
          ),
        ],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // _buildTop(context),
            // BlocConsumer(builder: builder, listener: listener)
            // if (screenType == 'new')
            //   Expanded(child: Container())
            // else
            BlocConsumer<ChatRoomCommentsCommonCubit,
                ChatRoomCommentsCommonState>(
              listener: (context, state) {
                if (state is ChatRoomCommentsCommonLoadFail) {
                  if (state.failReason == "false") {
                    UserUtils.unauthorizedUser(context);
                  }
                }
                if (state is ChatRoomCommentsCommonLoadSuccess) {
                  if (chatData!.screenType == 'classroom') {
                    setState(() {
                      chatBubbleMessagesList = [];
                      state.classroomCommentsList!.forEach(
                        (element) => chatBubbleMessagesList.add(
                          ChatBubbleModel(
                            commentId: element.commentId.toString(),
                            fileUrl:
                                element.fileUrl != "" ? element.fileUrl : "",
                            message: element.comment,
                            dateTime: element.commentDate1,
                            userTypeApi: element.userType,
                            replyId: element.toreplycommentId,
                            stuEmpId: element.stuEmpId,
                            name: element.name,
                            //studentName: element.studentName,
                            showDeleteIcon: false,
                            showReplyIcon: true,
                          ),
                        ),
                      );
                    });
                  } else if (chatData!.screenType == 'homework') {
                    if (currentUserType!.toLowerCase() == "s" ||
                        currentUserType!.toLowerCase() == "f") {
                      if (state.homeworkComments!.table1![0].noofComments! <
                          2) {
                        setChatData(state.homeworkComments);
                      } else {
                        setState(() {
                          noOfComments =
                              state.homeworkComments!.table1![0].noofComments;
                          showTextField = false;
                        });
                        if (state.homeworkComments!.table!.length > 0) {
                          setChatData(state.homeworkComments);
                        }
                        toastAlertNotification(
                            "You exceed your message limit.");
                      }
                    } else {
                      setChatData(state.homeworkComments);
                    }
                  } else if (chatData!.screenType == 'custom chat') {
                    setState(() {
                      chatBubbleMessagesList = [];
                      state.customComments!.forEach(
                        (element) => chatBubbleMessagesList.add(
                          ChatBubbleModel(
                            commentId: element.id,
                            fileUrl:
                                element.fileUrl != "" ? element.fileUrl : "",
                            message: element.comment,
                            dateTime: element.commentDate1,
                            userTypeApi: element.msgtype,
                            replyId: 0,
                            stuEmpId: -1,
                            name: "",
                            studentName: "",
                            showDeleteIcon: true,
                            showReplyIcon: true,
                          ),
                        ),
                      );
                    });
                  }
                }
              },
              builder: (context, state) {
                if (state is ChatRoomCommentsCommonLoadSuccess) {
                  return buildChatMsgArea(context);
                } else if (state is ChatRoomCommentsCommonLoadFail) {
                  return Expanded(child: Container());
                } else {
                  return Expanded(child: Container());
                }
              },
            ),
            if (_filePickedList != null && _filePickedList != [] && !showLoader)
              Container(
                // height: 60,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.all(4.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 100,
                    childAspectRatio: 3 / 3,
                    crossAxisSpacing: 8,
                    // mainAxisSpacing: 20,
                  ),
                  itemCount: _filePickedList!.length,
                  itemBuilder: (context, i) {
                    return Stack(
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          color: Colors.white,
                          child:
                              _filePickedList![i].path.split(".").last == "pdf"
                                  ? Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Image.asset(AppImages.pdfImage),
                                    )
                                  : Image.file(_filePickedList![i],
                                      fit: BoxFit.cover),
                        ),
                        Positioned(
                          right: 0,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _filePickedList!.removeAt(i);
                                if (_filePickedList!.length == 0)
                                  _filePickedList = null;
                              });
                            },
                            child: Container(
                              color: Colors.black,
                              child: Icon(Icons.close, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            SizedBox(height: 10.0),
            if (showLoader && _filePickedList != null)
              buildFileSendingWidget(context),
            if (chatData!.screenType == 'homework')
              if (currentUserType == 's')
                if (noOfComments! < 2) buildChatSendWidget() else Container()
              else if (showTextField)
                buildChatSendWidget()
              else
                Container()
            else if (chatData!.screenType != 'homework')
              if (showTextField) buildChatSendWidget() else Container()
          ],
        ),
      ),
    );
  }

  setChatData(HomeWorkCommentsModel? homeworkComments) {
    setState(() {
      chatBubbleMessagesList = [];
      if ((userData!.ouserType!.toLowerCase() == "s" ||
              userData!.ouserType!.toLowerCase() == "f") &&
          homeworkComments!.table1![0].noofComments! < 2)
        noOfComments = homeworkComments.table1![0].noofComments;
      // print(
      //     "state.homeworkComments ${homeworkComments!.table!.last.toString()}");
      homeworkComments!.table!.forEach(
        (element) => chatBubbleMessagesList.add(
          ChatBubbleModel(
            commentId: element.replyId.toString(),
            fileUrl: element.fileUrl != ""
                ? userData!.baseDomainURL! + element.fileUrl!
                : "",
            message: element.comment,
            dateTime: element.commentDate1,
            userTypeApi: element.userType,
            replyId: element.toreplycommentId,
            stuEmpId: element.stuEmpId,
            name: element.name,
            studentName: element.studentName,
            showDeleteIcon: true,
            showReplyIcon: true,
          ),
        ),
      );
      for (var i = 0; i < homeworkComments.table!.length; i++) {
        if (homeworkComments.table![i].replyId != 0) {
          final data = chatBubbleMessagesList
              .where((element) =>
                  element.commentId ==
                  homeworkComments.table![i].replyId.toString())
              .toList();
          if (data.length > 1) {
            chatBubbleMessagesList
                .every((element) => element.showReplyIcon = false);
          }
        }
      }
    });
  }

  Container buildFileSendingWidget(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(1.0),
        boxShadow: [
          BoxShadow(
              blurRadius: 0.5,
              spreadRadius: 1.0,
              color: Colors.black.withOpacity(.12))
        ],
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.0),
            topRight: Radius.circular(8.0),
            bottomLeft: Radius.circular(8.0),
            bottomRight: Radius.circular(0.0)),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
        // color: Colors.red,
        color: Colors.white.withOpacity(0.4),
        // height: 60,
        width: MediaQuery.of(context).size.width / 1.5,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                "Uploading...",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    // fontSize: 10.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            Stack(
              children: [
                CircularProgressIndicator(color: Colors.black38),
                Positioned.fill(
                  child: Icon(Icons.upload),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Expanded buildChatMsgArea(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => showTextField = false),
        child: ListView.builder(
          shrinkWrap: true,
          reverse: true,
          itemCount: chatBubbleMessagesList.length,
          itemBuilder: (context, i) {
            final index = chatBubbleMessagesList.length - (i + 1);
            final chat = chatBubbleMessagesList[index];
            print("fileUrl: ${chat.fileUrl}");
            //Todo
            return buildChatBubble(
              context,
              commentId: chat.commentId,
              fileUrl: chat.fileUrl,
              message: chat.message,
              dateTime: chat.dateTime,
              userTypeApi: chat.userTypeApi,
              showDeleteIcon: chat.showDeleteIcon!,
              showReplyIcon: chat.showReplyIcon!,
              stuEmpId: chat.stuEmpId,
              name: chat.name,
              studentName: chat.studentName,
              replyId: chat.replyId,
            );
          },
        ),
      ),
    );
  }

  Column buildChatBubble(
    BuildContext context, {
    String? commentId = "",
    String? fileUrl = "",
    String? message = "",
    String? dateTime = "",
    String? userTypeApi = "",
    int? stuEmpId = -1,
    int? replyId = 0,
    String? name = "",
    String? studentName = "",
    bool showDeleteIcon = false,
    bool showReplyIcon = false,
  }) {
    List<String> filesList = [];
    if (fileUrl != "") filesList = fileUrl!.split(",").toList();
    return Column(
      crossAxisAlignment: chatData!.screenType == "custom chat"
          ? (userTypeApi!.toLowerCase() != "s" ||
                  userTypeApi.toLowerCase() != "f")
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.end
          : currentUserType != userTypeApi!.toLowerCase()
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.end,
      // crossAxisAlignment: chatData!.screenType == "custom chat"? : currentUserType != userTypeApi!.toLowerCase()
      //     ? CrossAxisAlignment.start
      //     : CrossAxisAlignment.end,
      children: [
        Container(
            child: Text(dateTime!,
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 10.0,
                    fontStyle: FontStyle.normal)),
            margin: EdgeInsets.all(5.0)),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: chatData!.screenType == "custom chat"
              ? (userTypeApi.toLowerCase() != "s" ||
                      userTypeApi.toLowerCase() != "f")
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.end
              : currentUserType != userTypeApi.toLowerCase()
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: chatData!.screenType == "custom chat"
                      ? (userTypeApi.toLowerCase() != "s" ||
                              userTypeApi.toLowerCase() != "f")
                          ? Colors.white
                          : Theme.of(context).primaryColor.withOpacity(1.0)
                      : currentUserType != userTypeApi.toLowerCase()
                          ? Colors.white
                          : Theme.of(context).primaryColor.withOpacity(1.0),
                  // color: currentUserType != userTypeApi.toLowerCase()
                  //     ? Colors.white
                  //     : Theme.of(context).primaryColor.withOpacity(1.0),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 0.5,
                        spreadRadius: 1.0,
                        color: Colors.black.withOpacity(.12))
                  ],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),
                    bottomLeft: chatData!.screenType == "custom chat"
                        ? (userTypeApi.toLowerCase() != "s" ||
                                userTypeApi.toLowerCase() != "f")
                            ? Radius.circular(8.0)
                            : Radius.circular(0.0)
                        : currentUserType == userTypeApi.toLowerCase()
                            ? Radius.circular(0.0)
                            : Radius.circular(8.0),
                    bottomRight: chatData!.screenType == "custom chat"
                        ? (userTypeApi.toLowerCase() != "s" ||
                                userTypeApi.toLowerCase() != "f")
                            ? Radius.circular(0.0)
                            : Radius.circular(8.0)
                        : currentUserType == userTypeApi.toLowerCase()
                            ? Radius.circular(8.0)
                            : Radius.circular(0.0),
                    // bottomLeft: currentUserType == userTypeApi.toLowerCase()
                    //     ? Radius.circular(8.0)
                    //     : Radius.circular(0.0),
                    // bottomRight: currentUserType == userTypeApi.toLowerCase()
                    //     ? Radius.circular(0.0)
                    //     : Radius.circular(8.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (filesList != [] && filesList != null)
                      Container(
                        width: MediaQuery.of(context).size.width / 1.5,
                        child: ListView.separated(
                          separatorBuilder: (context, index) =>
                              Divider(height: 8.0),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: filesList.length,
                          itemBuilder: (context, i) {
                            return filesList[i] != ""
                                ? Stack(
                                    children: [
                                      Container(
                                        color: Colors.white,
                                        child: filesList[i].split(".").last ==
                                                "pdf"
                                            ? Container(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                color:
                                                    userTypeApi.toLowerCase() ==
                                                            userData!.ouserType!
                                                                .toLowerCase()
                                                        ? Theme.of(context)
                                                            .primaryColor
                                                            .withOpacity(0.6)
                                                        : Colors.black12,
                                                height: 80,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    1.5,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Image.asset(
                                                        AppImages.pdfImage),
                                                    SizedBox(width: 8.0),
                                                    Flexible(
                                                      child: Text(
                                                        filesList[i]
                                                            .split("/")
                                                            .last,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            // fontSize: 10.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: currentUserType !=
                                                                    userTypeApi
                                                                        .toLowerCase()
                                                                ? Colors.black
                                                                : Colors.black),
                                                      ),
                                                    ),
                                                    SizedBox(width: 8.0),
                                                    FileDownload(
                                                      fileName: filesList[i]
                                                          .split("/")
                                                          .last,
                                                      fileUrl: filesList[i],
                                                      downloadWidget:
                                                          Icon(Icons.download),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : Stack(
                                                children: [
                                                  Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            1.5,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            1.5,
                                                    color: userTypeApi
                                                                .toLowerCase() ==
                                                            userData!.ouserType!
                                                                .toLowerCase()
                                                        ? Theme.of(context)
                                                            .primaryColor
                                                            .withOpacity(0.6)
                                                        : Colors.black12,
                                                    // Uri.parse(URL).isAbsolute
                                                    child: Image.network(
                                                      filesList[i],
                                                      // screenType!.toLowerCase() ==
                                                      //             'homework' ||
                                                      //         screenType!
                                                      //                 .toLowerCase() ==
                                                      //             'custom'
                                                      //     ? userData!
                                                      //             .baseDomainURL! +
                                                      //         filesList[i]
                                                      //     : filesList[i],
                                                      fit: BoxFit.cover,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              1.5,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              1.5,
                                                      errorBuilder: (context,
                                                          exception,
                                                          stackTrace) {
                                                        return Center(
                                                          child: Text(
                                                              'Image not found!'),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  Positioned(
                                                    right: 0,
                                                    child: FileDownload(
                                                      fileName: filesList[i]
                                                          .split("/")
                                                          .last,
                                                      fileUrl: filesList[i],
                                                      downloadWidget: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        color: userTypeApi
                                                                    .toLowerCase() ==
                                                                userData!
                                                                    .ouserType!
                                                                    .toLowerCase()
                                                            ? Theme.of(context)
                                                                .primaryColor
                                                            : Colors.white,
                                                        child: Icon(
                                                            Icons.download),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                      ),
                                    ],
                                  )
                                : Container();
                          },
                        ),
                      ),
                    if (message != "" && message != null)
                      Container(
                        width: MediaQuery.of(context).size.width / 1.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if ((userData!.ouserType!.toLowerCase() != "s" ||
                                        userData!.ouserType!.toLowerCase() !=
                                            "f") &&
                                    chatData!.screenType == "homework" ||
                                chatData!.screenType == "classroom")
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      if (replyId != 0)
                                        Icon(
                                          Icons.reply,
                                          size: 18,
                                          color: Colors.grey,
                                        ),
                                      if (replyId != 0) SizedBox(width: 4.0),
                                      Text(
                                          replyId != 0 && studentName != null
                                              ? "Reply to $studentName"
                                              : "$name",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 10.0,
                                              fontStyle: FontStyle.normal,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  Divider(height: 4),
                                ],
                              ),
                            Text(
                              message,
                              style: TextStyle(
                                color: chatData!.screenType == "custom chat"
                                    ? (userTypeApi.toLowerCase() != "s" ||
                                            userTypeApi.toLowerCase() != "f")
                                        ? Colors.black
                                        : Colors.white70
                                    : currentUserType !=
                                            userTypeApi.toLowerCase()
                                        ? Colors.black
                                        : Colors.white70,
                                // color: currentUserType != userTypeApi.toLowerCase()
                                //     ? Colors.black
                                //     : Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
            if ((currentUserType!.toLowerCase() != "s" ||
                    currentUserType!.toLowerCase() != "f") &&
                currentUserType != userTypeApi.toLowerCase())
              if (showReplyIcon)
                InkWell(
                  onTap: () => setState(() {
                    //Todo:
                    showTextField = true;
                    commentIdForReply = commentId;
                    studentIdForReply = stuEmpId.toString();
                    print(studentIdForReply);
                    print(commentIdForReply);
                  }),
                  child: Icon(Icons.reply),
                ),
          ],
        ),
        if (chatData!.screenType != 'classroom' &&
            currentUserType == userTypeApi.toLowerCase())
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkResponse(
              onTap: () {
                if (chatData!.screenType == 'custom chat') {
                  deleteCustomChatToApi(commentId);
                } else {
                  deleteHomeworkCommentsToApi(commentId);
                }
              },
              child: Icon(Icons.delete, color: Colors.red[300]),
            ),
          )
        // else
        //   SizedBox(height: 10),
      ],
    );
  }

  buildChatSendWidget() {
    return Container(
      width: double.infinity,
      height: 60.0,
      decoration: new BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        children: <Widget>[
          Material(
            child: new Container(
              margin: new EdgeInsets.symmetric(horizontal: 1.0),
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.white)),
              child: new IconButton(
                icon: new Icon(Icons.attach_file),
                color: Colors.grey,
                onPressed: () async {
                  if (chatData!.screenType == "homework") {
                    final _files = await showFilePicker();
                    if (_files!.length <= 4)
                      setState(() => _filePickedList = _files);
                    else
                      toastAlertNotification(
                          "You can upload only max 4 files at a time.");
                  } else if (chatData!.screenType == "classroom" ||
                      chatData!.screenType == "custom") {
                    final _files = await showFilePicker(allowMultiple: false);
                    setState(() => _filePickedList = _files);
                  } else if (chatData!.screenType == "custom chat") {
                    final _files = await showFilePicker();
                    // _files!.removeWhere((element) => element.path.split(".").last.toLowerCase() == "docx");
                    setState(() => _filePickedList = _files);
                  }
                },
              ),
            ),
            color: Colors.white,
          ),

          // Text input
          Flexible(
            child: Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.white)),
              child: TextField(
                cursorColor: Colors.teal,
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 5,
                style: TextStyle(color: Colors.black54, fontSize: 15.0),
                controller: messageController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Type a message',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ),

          // Send Message Button
          Material(
            child: new Container(
              padding: new EdgeInsets.symmetric(horizontal: 8.0),
              height: 60,
              decoration: BoxDecoration(
                  // color: Theme.of(context).primaryColor,
                  // border: Border.all(color: Theme.of(context).primaryColor)),
                  color: Color(0xff2ab57d),
                  border: Border.all(color: Color(0xff2ab57d))),
              child: new IconButton(
                icon: new Icon(Icons.send),
                onPressed: () {
                  if (showLoader == false) {
                    if (messageController.text != "" ||
                        _filePickedList != null) {
                      setState(() => showLoader = true);
                      if (chatData!.screenType == 'classroom') {
                        sendClassroomCommentsToApi();
                      } else if (chatData!.screenType == 'homework') {
                        sendHomeworkCommentsToApi();
                      } else if (chatData!.screenType == 'custom') {
                        sendCustomClassroomCommentsToApi();
                      } else if (chatData!.screenType == 'custom chat') {
                        sendCustomChatApi();
                      }
                    }
                  }
                },
                color: Colors.white,
              ),
            ),
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  sendClassroomCommentsToApi() async {
    print('classroom messageController: ${messageController.text}');
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final sendComment = {
      'UserId': uid!,
      'Token': token!,
      'OrgId': userData!.organizationId!,
      'Schoolid': userData.schoolId!,
      'SessionId': userData.currentSessionid!,
      'StuEmpId': userData.stuEmpId!,
      'UserType': userData.ouserType!.toLowerCase(),
      'Comment': messageController.text,
      'FileFormat': "",
      'CircularId': chatData!.iD!,
      'CommentId':
          userData.ouserType!.toLowerCase() == "e" ? commentIdForReply! : "",
      'ReplyTo': userData.ouserType!.toLowerCase() == "e"
          ? studentIdForReply!
          : chatData!.classId.toString(),
      // 'ReplyTo': chatData!.classId == null ? "" : chatData!.classId.toString(),
      'File': "",
    };

    print(
        "sending data for teacher reply for classroom for particular student $sendComment");

    context
        .read<SendClassRoomCommentCubit>()
        .sendClassRoomCommentCubitCall(sendComment, _filePickedList)
        .then((value) {
      messageController.clear();
      setState(() {
        _filePickedList = null;
        showLoader = !showLoader;
      });
    });
  }

  sendCustomChatApi() async {
    print('custom chat classroom messageController: ${messageController.text}');
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final sendComment = {
      'UserId': uid!,
      'Token': token!,
      'OrgId': userData!.organizationId!,
      'SchoolId': userData.schoolId!,
      'SessionId': userData.currentSessionid!,
      'StuEmpId': userData.stuEmpId!,
      'UserType': userData.ouserType!,
      'Comment': messageController.text,
      'FileFormat': ".jpg",
      'CircularId': chatData!.iD!,
      'CommentId': "",
      'ReplyTo': "",
      'StudentIds': "[{'StudentID':${chatData!.stuEmpId}}]",
    };
    context
        .read<SendCustomChatCubit>()
        .sendCustomChatCubitCall(sendComment, _filePickedList)
        .then((value) {
      messageController.clear();
      setState(() {
        _filePickedList = null;
      });
    });
  }

  sendCustomClassroomCommentsToApi() async {
    print('custom classroom messageController: ${messageController.text}');
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final stuInfo = await UserUtils.stuInfoDataFromCache();
    final sendComment = {
      'UserId': uid!,
      'Token': token!,
      'OrgId': userData!.organizationId!,
      'SchoolId': userData.schoolId!,
      'SessionId': userData.currentSessionid!,
      'CirSubject': chatData!.iD!,
      'CirContent': messageController.text,
      'For': "E",
      'GroupId': "0",
      'UserType': userData.ouserType!,
      'StuEmpId': userData.stuEmpId!,
      'TeacherIds': '[{"StudentID":"${chatData!.stuEmpId}"}]',
      'ClassId': stuInfo!.classId!,
      'StreamId': stuInfo.streamId!,
      'SectionId': stuInfo.classSectionId!,
      'YearId': stuInfo.yearId!,
    };
    context
        .read<SendCustomClassRoomCommentCubit>()
        .sendCustomClassRoomCommentCubitCall(sendComment, _filePickedList)
        .then((value) {
      messageController.clear();
      setState(() {
        _filePickedList = null;
      });
    });
  }

  sendHomeworkCommentsToApi() async {
    print('homework messageController: ${messageController.text}');

    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final sendComment = {
      'UserId': uid!,
      'Token': token!,
      'OrgId': userData!.organizationId!,
      'SchoolId': userData.schoolId!,
      'SessionId': userData.currentSessionid!,
      'StuEmpId': userData.stuEmpId!,
      'UserType': userData.ouserType!.toLowerCase(),
      'Comment': messageController.text,
      // 'HomeworkId': "14026",
      'HomeworkId': chatData!.iD!,
      "FileFormat": "",
      "CommentId":
          userData.ouserType!.toLowerCase() == "e" ? commentIdForReply! : "",
      "ReplyTo":
          userData.ouserType!.toLowerCase() == "e" ? studentIdForReply! : "",
    };
    context
        .read<SendHomeworkCommentCubit>()
        .sendHomeworkCommentCubitCall(sendComment, _filePickedList)
        .then((value) {
      messageController.clear();
      setState(() {
        _filePickedList = null;
        showLoader = !showLoader;
      });
    });
  }

  deleteHomeworkCommentsToApi(String? commentId) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final deleteComment = {
      'OUserId': uid!,
      'Token': token!,
      'OrgId': userData!.organizationId!,
      'UserType': userData.ouserType!.toLowerCase(),
      'Schoolid': userData.schoolId!,
      'StuEmpId': userData.stuEmpId!,
      'commentid': commentId,
    };
    print("sending delete homework data: $deleteComment");
    context
        .read<DeleteHomeworkCommentCubit>()
        .deleteHomeworkCommentCubitCall(deleteComment)
        .then((value) {});
  }

  deleteCustomChatToApi(String? commentId) async {
    final uid = await UserUtils.idFromCache();
    final token = await UserUtils.userTokenFromCache();
    final userData = await UserUtils.userTypeFromCache();
    final deleteComment = {
      'OUserId': uid,
      'Token': token,
      'OrgId': userData!.organizationId,
      'Schoolid': userData.schoolId,
      'StuEmpId': userData.stuEmpId,
      'chatid': commentId,
      'UserType': userData.ouserType,
    };
    print("sending delete homework data: $deleteComment");
    context
        .read<DeleteCustomChatCubit>()
        .deleteCustomChatCubitCall(deleteComment)
        .then((value) {});
  }
}

class ChatRoomCommonModel {
  String? appbarTitle = '';
  String? iD = '';
  String? stuEmpId = '';
  String? classId = '';
  String? screenType = '';
  String? teacherId = "";

  ChatRoomCommonModel(
      {this.appbarTitle,
      this.iD,
      this.stuEmpId,
      this.classId,
      this.screenType,
      this.teacherId});

  @override
  String toString() {
    return "{appbarTitle: $appbarTitle, iD: $iD, stuEmpId: $stuEmpId, classId: $classId, screenType: $screenType}, ";
  }
}

class ChatBubbleModel {
  String? commentId;
  String? fileUrl;
  String? message;
  String? dateTime;
  String? userTypeApi;
  int? stuEmpId;
  String? name;
  String? studentName;
  int? replyId;
  bool? showDeleteIcon = false;
  bool? showReplyIcon = true;

  ChatBubbleModel(
      {this.commentId,
      this.fileUrl,
      this.message,
      this.dateTime,
      this.userTypeApi,
      this.stuEmpId,
      this.name,
      this.studentName,
      this.replyId,
      this.showDeleteIcon,
      this.showReplyIcon});

  @override
  String toString() {
    return "{commentId: $commentId, fileUrl: $fileUrl, message: $message, dateTime: $dateTime, userTypeApi: $userTypeApi, stuEmpId: $stuEmpId, name: $name, studentName: $studentName, replyId: $replyId, showDeleteIcon: $showDeleteIcon, showReplyIcon: $showReplyIcon}, ";
  }
}
