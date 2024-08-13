part of 'class_list_attendance_report_cubit.dart';

abstract class ClassListAttendanceReportState extends Equatable {
  const ClassListAttendanceReportState();

  get failReason => null;
}

class ClassListAttendanceReportInitial extends ClassListAttendanceReportState {
  @override
  List<Object> get props => [];
}

class ClassListAttendanceReportLoadInProgress
    extends ClassListAttendanceReportState {
  @override
  List<Object> get props => [];
}

class ClassListAttendanceReportLoadSuccess
    extends ClassListAttendanceReportState {
  final List<ClassListAttendanceReportModel> classList;
  ClassListAttendanceReportLoadSuccess(this.classList);
  @override
  List<Object> get props => [classList];
}

class ClassListAttendanceReportLoadFail extends ClassListAttendanceReportState {
  final String failReason;
  ClassListAttendanceReportLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
