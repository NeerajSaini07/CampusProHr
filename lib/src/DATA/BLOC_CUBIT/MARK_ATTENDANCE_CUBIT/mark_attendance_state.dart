part of 'mark_attendance_cubit.dart';

abstract class MarkAttendanceState extends Equatable {
  const MarkAttendanceState();
}

class MarkAttendanceInitial extends MarkAttendanceState {
  @override
  List<Object> get props => [];
}

class MarkAttendanceLoadInProgress extends MarkAttendanceState {
  @override
  List<Object> get props => [];
}

class MarkAttendanceLoadSuccess extends MarkAttendanceState {
  final bool status;

  MarkAttendanceLoadSuccess(this.status);
  @override
  List<Object> get props => [status];
}

class MarkAttendanceLoadFail extends MarkAttendanceState {
  final String failReason;

  MarkAttendanceLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
