part of 'get_follower_list_task_management_cubit.dart';

abstract class GetFollowerListTaskManagementState extends Equatable {
  const GetFollowerListTaskManagementState();
}

class GetFollowerListTaskManagementInitial
    extends GetFollowerListTaskManagementState {
  @override
  List<Object> get props => [];
}

class GetFollowerListTaskManagementLoadInProgress
    extends GetFollowerListTaskManagementState {
  @override
  List<Object> get props => [];
}

class GetFollowerListTaskManagementLoadSuccess
    extends GetFollowerListTaskManagementState {
  final List<AssignFollowerListTaskManagementModel> result;
  GetFollowerListTaskManagementLoadSuccess(this.result);
  @override
  List<Object> get props => [result];
}

class GetFollowerListTaskManagementLoadFail
    extends GetFollowerListTaskManagementState {
  final String failReason;
  GetFollowerListTaskManagementLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
