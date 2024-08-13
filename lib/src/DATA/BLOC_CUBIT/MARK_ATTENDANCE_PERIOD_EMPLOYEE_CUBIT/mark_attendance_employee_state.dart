part of 'mark_attendance_employee_cubit.dart';

abstract class MarkAttendanceEmployeeState extends Equatable {
  const MarkAttendanceEmployeeState();
}

class MarkAttendanceEmployeeInitial extends MarkAttendanceEmployeeState {
  @override
  List<Object> get props => [];
}

class MarkAttendanceEmployeeLoadInProgress extends MarkAttendanceEmployeeState {
  @override
  List<Object> get props => [];
}

class MarkAttendanceEmployeeLoadSuccess extends MarkAttendanceEmployeeState {
  final List<MarkAttendacePeriodsEmployeeModel> periodList;
  MarkAttendanceEmployeeLoadSuccess(this.periodList);
  @override
  List<Object> get props => [periodList];
}

class MarkAttendanceEmployeeLoadFail extends MarkAttendanceEmployeeState {
  final String failReason;
  MarkAttendanceEmployeeLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
