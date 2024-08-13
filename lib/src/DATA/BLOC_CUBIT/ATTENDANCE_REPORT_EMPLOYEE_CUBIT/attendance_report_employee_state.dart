part of 'attendance_report_employee_cubit.dart';

abstract class AttendanceReportEmployeeState extends Equatable {
  const AttendanceReportEmployeeState();
}

class AttendanceReportEmployeeInitial extends AttendanceReportEmployeeState {
  @override
  List<Object> get props => [];
}

class AttendanceReportEmployeeLoadInProgress
    extends AttendanceReportEmployeeState {
  @override
  List<Object?> get props => [];
}

class AttendanceReportEmployeeLoadSuccess
    extends AttendanceReportEmployeeState {
  final List<AttendanceReportEmployeeModel> attendanceReport;
  AttendanceReportEmployeeLoadSuccess(this.attendanceReport);
  @override
  List<Object?> get props => [attendanceReport];
}

class AttendanceReportEmployeeLoadFail extends AttendanceReportEmployeeState {
  final String failReason;
  AttendanceReportEmployeeLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
