part of 'get_task_list_by_id_cubit.dart';

abstract class GetTaskListByIdState extends Equatable {
  const GetTaskListByIdState();
}

class GetTaskListByIdInitial extends GetTaskListByIdState {
  @override
  List<Object> get props => [];
}

class GetTaskListByIdLoadInProgress extends GetTaskListByIdState {
  @override
  List<Object> get props => [];
}

class GetTaskListByIdLoadSuccess extends GetTaskListByIdState {
  final List<GetTaskListByIdModel> result;
  GetTaskListByIdLoadSuccess(this.result);
  @override
  List<Object> get props => [result];
}

class GetTaskListByIdLoadFail extends GetTaskListByIdState {
  final String failReason;
  GetTaskListByIdLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
