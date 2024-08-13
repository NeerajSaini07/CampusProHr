part of 'attendance_employee_cubit.dart';

abstract class AttendanceEmployeeState extends Equatable {
  const AttendanceEmployeeState();
}

class AttendanceEmployeeInitial extends AttendanceEmployeeState {
  @override
  List<Object> get props => [];
}

class AttendanceEmployeeLoadInProgress extends AttendanceEmployeeState {
  @override
  List<Object?> get props => [];
}

class AttendanceEmployeeLoadSuccess extends AttendanceEmployeeState {
  final List<AttendanceEmployeeModel> AttendanceList;
  AttendanceEmployeeLoadSuccess(this.AttendanceList);
  @override
  List<Object?> get props => [AttendanceList];
}

class AttendanceEmployeeLoadFail extends AttendanceEmployeeState {
  final String failReason;
  AttendanceEmployeeLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
