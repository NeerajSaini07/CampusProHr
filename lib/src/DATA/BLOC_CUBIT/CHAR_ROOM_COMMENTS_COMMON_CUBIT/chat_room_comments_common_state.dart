part of 'chat_room_comments_common_cubit.dart';

abstract class ChatRoomCommentsCommonState extends Equatable {
  const ChatRoomCommentsCommonState();
}

class ChatRoomCommentsCommonInitial extends ChatRoomCommentsCommonState {
  @override
  List<Object> get props => [];
}

class ChatRoomCommentsCommonLoadInProgress extends ChatRoomCommentsCommonState {
  @override
  List<Object> get props => [];
}

class ChatRoomCommentsCommonLoadSuccess extends ChatRoomCommentsCommonState {
  final List<ClassRoomCommentsModel>? classroomCommentsList;
  final HomeWorkCommentsModel? homeworkComments;
  final List<CustomChatModel>? customComments;

  ChatRoomCommentsCommonLoadSuccess(
      {this.classroomCommentsList, this.homeworkComments, this.customComments});
  @override
  List<Object> get props =>
      [classroomCommentsList!, homeworkComments!, customComments!];
}

class ChatRoomCommentsCommonLoadFail extends ChatRoomCommentsCommonState {
  final String failReason;

  ChatRoomCommentsCommonLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
