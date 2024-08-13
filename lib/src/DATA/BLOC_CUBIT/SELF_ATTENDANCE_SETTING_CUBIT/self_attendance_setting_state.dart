part of 'self_attendance_setting_cubit.dart';

abstract class SelfAttendanceSettingState extends Equatable {
  const SelfAttendanceSettingState();
}

class SelfAttendanceSettingInitial extends SelfAttendanceSettingState {
  @override
  List<Object> get props => [];
}

class SelfAttendanceSettingLoadInProgress extends SelfAttendanceSettingState {
  @override
  List<Object> get props => [];
}

class SelfAttendanceSettingLoadSuccess extends SelfAttendanceSettingState {
  final bool status;

  SelfAttendanceSettingLoadSuccess(this.status);
  @override
  List<Object> get props => [status];
}

class SelfAttendanceSettingLoadFail extends SelfAttendanceSettingState {
  final String failReason;

  SelfAttendanceSettingLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
