part of 'send_homework_comment_cubit.dart';

abstract class SendHomeworkCommentState extends Equatable {
  const SendHomeworkCommentState();
}

class SendHomeworkCommentInitial extends SendHomeworkCommentState {
  @override
  List<Object> get props => [];
}

class SendHomeworkCommentLoadInProgress extends SendHomeworkCommentState {
  @override
  List<Object> get props => [];
}

class SendHomeworkCommentLoadSuccess extends SendHomeworkCommentState {
  final bool status;

  SendHomeworkCommentLoadSuccess(this.status);
  @override
  List<Object> get props => [status];
}

class SendHomeworkCommentLoadFail extends SendHomeworkCommentState {
  final String failReason;

  SendHomeworkCommentLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
