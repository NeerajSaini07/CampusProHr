part of 'apply_for_leave_cubit.dart';

abstract class ApplyForLeaveState extends Equatable {
  const ApplyForLeaveState();
}

class ApplyForLeaveInitial extends ApplyForLeaveState {
  @override
  List<Object> get props => [];
}

class ApplyForLeaveLoadInProgress extends ApplyForLeaveState {
  @override
  List<Object> get props => [];
}

class ApplyForLeaveLoadSuccess extends ApplyForLeaveState {
  final String status;

  ApplyForLeaveLoadSuccess(this.status);
  @override
  List<Object> get props => [status];
}

class ApplyForLeaveLoadFail extends ApplyForLeaveState {
  final String failReason;

  ApplyForLeaveLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
