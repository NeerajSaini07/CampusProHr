part of 'delete_homework_comment_cubit.dart';

abstract class DeleteHomeworkCommentState extends Equatable {
  const DeleteHomeworkCommentState();
}

class DeleteHomeworkCommentInitial extends DeleteHomeworkCommentState {
  @override
  List<Object> get props => [];
}

class DeleteHomeworkCommentLoadInProgress extends DeleteHomeworkCommentState {
  @override
  List<Object> get props => [];
}

class DeleteHomeworkCommentLoadSuccess extends DeleteHomeworkCommentState {
  final bool status;

  DeleteHomeworkCommentLoadSuccess(this.status);
  @override
  List<Object> get props => [status];
}

class DeleteHomeworkCommentLoadFail extends DeleteHomeworkCommentState {
  final String failReason;

  DeleteHomeworkCommentLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
