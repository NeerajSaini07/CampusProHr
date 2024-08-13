part of 'attendance_graph_cubit.dart';

abstract class AttendanceGraphState extends Equatable {
  const AttendanceGraphState();
}

class AttendanceGraphInitial extends AttendanceGraphState {
  @override
  List<Object> get props => [];
}

class AttendanceGraphLoadInProgress extends AttendanceGraphState {
  @override
  List<Object> get props => [];
}

class AttendanceGraphLoadSuccess extends AttendanceGraphState {
  final List<AttendanceGraphModel> attendanceList;

  AttendanceGraphLoadSuccess(this.attendanceList);
  @override
  List<Object> get props => [attendanceList];
}

class AttendanceGraphLoadFail extends AttendanceGraphState {
  final String failReason;

  AttendanceGraphLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
