part of 'get_task_task_management_cubit.dart';

abstract class GetTaskTaskManagementState extends Equatable {
  const GetTaskTaskManagementState();
}

class GetTaskTaskManagementInitial extends GetTaskTaskManagementState {
  @override
  List<Object> get props => [];
}

class GetTaskTaskManagementLoadInProgress extends GetTaskTaskManagementState {
  @override
  List<Object> get props => [];
}

class GetTaskTaskManagementLoadSuccess extends GetTaskTaskManagementState {
  final List<GetEmployeeTaskManagementModel> statusList;
  GetTaskTaskManagementLoadSuccess(this.statusList);
  @override
  List<Object> get props => [statusList];
}

class GetTaskTaskManagementLoadFail extends GetTaskTaskManagementState {
  final String failReason;
  GetTaskTaskManagementLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
