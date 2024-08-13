part of 'student_leave_pending_reject_accept_cubit.dart';

abstract class StudentLeavePendingRejectAcceptState extends Equatable {
  const StudentLeavePendingRejectAcceptState();
}

class StudentLeavePendingRejectAcceptInitial
    extends StudentLeavePendingRejectAcceptState {
  @override
  List<Object> get props => [];
}

class StudentLeavePendingRejectAcceptLoadInProgress
    extends StudentLeavePendingRejectAcceptState {
  @override
  List<Object> get props => [];
}

class StudentLeavePendingRejectAcceptLoadSuccess
    extends StudentLeavePendingRejectAcceptState {
  final List<studentLeavePendingRejectAcceptModel> LeaveListRejAcp;
  StudentLeavePendingRejectAcceptLoadSuccess(this.LeaveListRejAcp);
  @override
  List<Object> get props => [LeaveListRejAcp];
}

class StudentLeavePendingRejectAcceptLoadFail
    extends StudentLeavePendingRejectAcceptState {
  final String failReason;
  StudentLeavePendingRejectAcceptLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
