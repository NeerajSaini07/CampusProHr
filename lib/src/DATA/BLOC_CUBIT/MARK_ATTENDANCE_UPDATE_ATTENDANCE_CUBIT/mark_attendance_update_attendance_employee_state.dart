part of 'mark_attendance_update_attendance_employee_cubit.dart';

abstract class MarkAttendanceUpdateAttendanceEmployeeState extends Equatable {
  const MarkAttendanceUpdateAttendanceEmployeeState();
}

class MarkAttendanceUpdateAttendanceEmployeeInitial
    extends MarkAttendanceUpdateAttendanceEmployeeState {
  @override
  List<Object> get props => [];
}

class MarkAttendanceUpdateAttendanceLoadInProgress
    extends MarkAttendanceUpdateAttendanceEmployeeState {
  @override
  List<Object> get props => [];
}

class MarkAttendanceUpdateAttendanceLoadSuccess
    extends MarkAttendanceUpdateAttendanceEmployeeState {
  final List result;
  MarkAttendanceUpdateAttendanceLoadSuccess(this.result);
  @override
  List<Object> get props => [result];
}

class MarkAttendanceUpdateAttendanceLoadFail
    extends MarkAttendanceUpdateAttendanceEmployeeState {
  final String failReason;
  MarkAttendanceUpdateAttendanceLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
