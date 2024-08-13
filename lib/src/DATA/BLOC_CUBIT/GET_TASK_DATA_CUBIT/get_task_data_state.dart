part of 'get_task_data_cubit.dart';

abstract class GetTaskDataState extends Equatable {
  const GetTaskDataState();
}

class GetTaskDataInitial extends GetTaskDataState {
  @override
  List<Object> get props => [];
}

class GetTaskDataLoadInProgress extends GetTaskDataState {
  @override
  List<Object> get props => [];
}

class GetTaskDataLoadSuccess extends GetTaskDataState {
  final List<GetTaskDataModel> result;
  GetTaskDataLoadSuccess(this.result);
  @override
  List<Object> get props => [result];
}

class GetTaskDataLoadFail extends GetTaskDataState {
  final String failReason;
  GetTaskDataLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
