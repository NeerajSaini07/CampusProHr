part of 'mark_attendance_save_attendance_cubit.dart';

abstract class MarkAttendanceSaveAttendanceEmployeeState extends Equatable {
  const MarkAttendanceSaveAttendanceEmployeeState();
}

class MarkAttendanceSaveAttendanceInitial
    extends MarkAttendanceSaveAttendanceEmployeeState {
  @override
  List<Object> get props => [];
}

class MarkAttendanceSaveAttendanceLoadInProgress
    extends MarkAttendanceSaveAttendanceEmployeeState {
  @override
  List<Object> get props => [];
}

class MarkAttendanceSaveAttendanceLoadSuccess
    extends MarkAttendanceSaveAttendanceEmployeeState {
  final List result;
  MarkAttendanceSaveAttendanceLoadSuccess(this.result);
  @override
  List<Object> get props => [result];
}

class MarkAttendanceSaveAttendanceLoadFail
    extends MarkAttendanceSaveAttendanceEmployeeState {
  final String failReason;
  MarkAttendanceSaveAttendanceLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
