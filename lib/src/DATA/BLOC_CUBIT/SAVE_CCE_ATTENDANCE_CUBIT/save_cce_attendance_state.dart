part of 'save_cce_attendance_cubit.dart';

abstract class SaveCceAttendanceState extends Equatable {
  const SaveCceAttendanceState();
}

class SaveCceAttendanceInitial extends SaveCceAttendanceState {
  @override
  List<Object> get props => [];
}

class SaveCceAttendanceLoadInProgress extends SaveCceAttendanceState {
  @override
  List<Object> get props => [];
}

class SaveCceAttendanceLoadSuccess extends SaveCceAttendanceState {
  final String result;
  SaveCceAttendanceLoadSuccess(this.result);
  @override
  List<Object> get props => [result];
}

class SaveCceAttendanceLoadFail extends SaveCceAttendanceState {
  final String failReason;
  SaveCceAttendanceLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
