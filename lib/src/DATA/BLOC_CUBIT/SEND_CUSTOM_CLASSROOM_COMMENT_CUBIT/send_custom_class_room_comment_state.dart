part of 'send_custom_class_room_comment_cubit.dart';

abstract class SendCustomClassRoomCommentState extends Equatable {
  const SendCustomClassRoomCommentState();
}

class SendCustomClassRoomCommentInitial
    extends SendCustomClassRoomCommentState {
  @override
  List<Object> get props => [];
}

class SendCustomClassRoomCommentLoadInProgress
    extends SendCustomClassRoomCommentState {
  @override
  List<Object> get props => [];
}

class SendCustomClassRoomCommentLoadSuccess
    extends SendCustomClassRoomCommentState {
  final bool status;

  SendCustomClassRoomCommentLoadSuccess(this.status);
  @override
  List<Object> get props => [status];
}

class SendCustomClassRoomCommentLoadFail
    extends SendCustomClassRoomCommentState {
  final String failReason;

  SendCustomClassRoomCommentLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
