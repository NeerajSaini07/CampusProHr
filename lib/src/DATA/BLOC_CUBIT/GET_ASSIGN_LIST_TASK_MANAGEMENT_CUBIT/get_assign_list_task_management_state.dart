part of 'get_assign_list_task_management_cubit.dart';

abstract class GetAssignListTaskManagementState extends Equatable {
  const GetAssignListTaskManagementState();
}

class GetAssignListTaskManagementInitial
    extends GetAssignListTaskManagementState {
  @override
  List<Object> get props => [];
}

class GetAssignListTaskManagementLoadInProgress
    extends GetAssignListTaskManagementState {
  @override
  List<Object> get props => [];
}

class GetAssignListTaskManagementLoadSuccess
    extends GetAssignListTaskManagementState {
  final List<AssignFollowerListTaskManagementModel> result;
  GetAssignListTaskManagementLoadSuccess(this.result);
  @override
  List<Object> get props => [result];
}

class GetAssignListTaskManagementLoadFail
    extends GetAssignListTaskManagementState {
  final String failReason;
  GetAssignListTaskManagementLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
