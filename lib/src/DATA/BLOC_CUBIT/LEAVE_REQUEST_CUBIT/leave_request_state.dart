part of 'leave_request_cubit.dart';

abstract class LeaveRequestState extends Equatable {
  const LeaveRequestState();
}

class LeaveRequestInitial extends LeaveRequestState {
  @override
  List<Object> get props => [];
}

class LeaveRequestLoadInProgress extends LeaveRequestState {
  @override
  List<Object> get props => [];
}

class LeaveRequestLoadSuccess extends LeaveRequestState {
  final List<LeaveRequestModel> leaveRequestList;

  LeaveRequestLoadSuccess(this.leaveRequestList);
  @override
  List<Object> get props => [leaveRequestList];
}

class LeaveRequestLoadFail extends LeaveRequestState {
  final String failReason;

  LeaveRequestLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
