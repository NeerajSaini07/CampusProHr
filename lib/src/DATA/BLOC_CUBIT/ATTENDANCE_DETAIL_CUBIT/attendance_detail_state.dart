part of 'attendance_detail_cubit.dart';

abstract class AttendanceDetailState extends Equatable {
  const AttendanceDetailState();
}

class AttendanceDetailInitial extends AttendanceDetailState {
  @override
  List<Object> get props => [];
}

class AttendanceDetailLoadInProgress extends AttendanceDetailState {
  @override
  List<Object?> get props => [];
}

class AttendanceDetailLoadSuccess extends AttendanceDetailState {
  final List<AttendanceDetailModel> attendanceDetailList;
  AttendanceDetailLoadSuccess(this.attendanceDetailList);
  @override
  List<Object?> get props => [attendanceDetailList];
}

class AttendanceDetailLoadFail extends AttendanceDetailState {
  final String failReason;
  AttendanceDetailLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
