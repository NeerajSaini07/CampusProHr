part of 'delete_homework_cubit.dart';

abstract class DeleteHomeworkState extends Equatable {
  const DeleteHomeworkState();
}

class DeleteHomeworkInitial extends DeleteHomeworkState {
  @override
  List<Object> get props => [];
}

class DeleteHomeworkLoadInProgress extends DeleteHomeworkState {
  @override
  List<Object> get props => [];
}

class DeleteHomeworkLoadSuccess extends DeleteHomeworkState {
  final bool status;

  DeleteHomeworkLoadSuccess(this.status);
  @override
  List<Object> get props => [status];
}

class DeleteHomeworkLoadFail extends DeleteHomeworkState {
   final String failReason;

  DeleteHomeworkLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
