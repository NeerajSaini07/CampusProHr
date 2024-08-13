part of 'send_class_room_comment_cubit.dart';

abstract class SendClassRoomCommentState extends Equatable {
  const SendClassRoomCommentState();
}

class SendClassRoomCommentInitial extends SendClassRoomCommentState {
  @override
  List<Object> get props => [];
}

class SendClassRoomCommentLoadInProgress extends SendClassRoomCommentState {
  @override
  List<Object> get props => [];
}

class SendClassRoomCommentLoadSuccess extends SendClassRoomCommentState {
  final bool status;

  SendClassRoomCommentLoadSuccess(this.status);
  @override
  List<Object> get props => [status];
}

class SendClassRoomCommentLoadFail extends SendClassRoomCommentState {
  final String failReason;

  SendClassRoomCommentLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
