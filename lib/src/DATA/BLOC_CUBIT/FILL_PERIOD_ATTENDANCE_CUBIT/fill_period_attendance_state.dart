part of 'fill_period_attendance_cubit.dart';

abstract class FillPeriodAttendanceState extends Equatable {
  const FillPeriodAttendanceState();
}

class FillPeriodAttendanceInitial extends FillPeriodAttendanceState {
  @override
  List<Object> get props => [];
}

class FillPeriodAttendanceLoadInProgress extends FillPeriodAttendanceState {
  @override
  List<Object> get props => [];
}

class FillPeriodAttendanceLoadSuccess extends FillPeriodAttendanceState {
  final String result;
  FillPeriodAttendanceLoadSuccess(this.result);
  @override
  List<Object> get props => [result];
}

class FillPeriodAttendanceLoadFail extends FillPeriodAttendanceState {
  final String failReason;
  FillPeriodAttendanceLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
