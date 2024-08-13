part of 'delete_task_detail_cubit.dart';

abstract class DeleteTaskDetailState extends Equatable {
  const DeleteTaskDetailState();
}

class DeleteTaskDetailInitial extends DeleteTaskDetailState {
  @override
  List<Object> get props => [];
}

class DeleteTaskDetailLoadInProgress extends DeleteTaskDetailState {
  @override
  List<Object> get props => [];
}

class DeleteTaskDetailLoadSuccess extends DeleteTaskDetailState {
  final String result;
  DeleteTaskDetailLoadSuccess(this.result);
  @override
  List<Object> get props => [result];
}

class DeleteTaskDetailLoadFail extends DeleteTaskDetailState {
  final String failReason;
  DeleteTaskDetailLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
