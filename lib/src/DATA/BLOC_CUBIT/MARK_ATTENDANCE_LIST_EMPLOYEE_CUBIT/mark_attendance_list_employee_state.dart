part of 'mark_attendance_list_employee_cubit.dart';

abstract class MarkAttendanceListEmployeeState extends Equatable {
  const MarkAttendanceListEmployeeState();
}

class MarkAttendanceListEmployeeInitial
    extends MarkAttendanceListEmployeeState {
  @override
  List<Object> get props => [];
}

class MarkAttendanceListLoadInProgress extends MarkAttendanceListEmployeeState {
  @override
  List<Object> get props => [];
}

class MarkAttendanceListLoadSuccess extends MarkAttendanceListEmployeeState {
  final List<MarkAttendanceListEmployeeModel> attendanceList;
  MarkAttendanceListLoadSuccess(this.attendanceList);
  @override
  List<Object> get props => [attendanceList];
}

class MarkAttendanceListLoadFail extends MarkAttendanceListEmployeeState {
  final String failReason;

  MarkAttendanceListLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
