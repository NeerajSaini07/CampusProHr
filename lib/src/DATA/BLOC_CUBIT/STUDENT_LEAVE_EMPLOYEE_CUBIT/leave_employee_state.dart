part of 'student_leave_employee_cubit.dart';

abstract class LeaveEmployeeState extends Equatable {
  const LeaveEmployeeState();
}

class LeaveEmployeeInitial extends LeaveEmployeeState {
  @override
  List<Object> get props => [];
}

class LeaveEmployeeLoadInProgress extends LeaveEmployeeState {
  @override
  List<Object> get props => [];
}

class LeaveEmployeeLoadSuccess extends LeaveEmployeeState {
  final List<StudentLeaveEmployeeModel> LeaveList;
  LeaveEmployeeLoadSuccess(this.LeaveList);
  @override
  List<Object> get props => [LeaveList];
}

class LeaveEmployeeLoadFail extends LeaveEmployeeState {
  final String failReason;
  LeaveEmployeeLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
