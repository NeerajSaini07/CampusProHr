part of 'class_list_attendance_report_admin_cubit.dart';

abstract class ClassListAttendanceReportAdminState extends Equatable {
  const ClassListAttendanceReportAdminState();
}

class ClassListAttendanceReportAdminInitial
    extends ClassListAttendanceReportAdminState {
  @override
  List<Object> get props => [];
}

class ClassListAttendanceReportAdminLoadInProgress
    extends ClassListAttendanceReportAdminState {
  @override
  List<Object> get props => [];
}

class ClassListAttendanceReportAdminLoadSuccess
    extends ClassListAttendanceReportAdminState {
  final List<ClassListAttendanceReportAdminModel> classList;
  ClassListAttendanceReportAdminLoadSuccess(this.classList);
  @override
  List<Object> get props => [classList];
}

class ClassListAttendanceReportAdminLoadFail
    extends ClassListAttendanceReportAdminState {
  final String failReason;
  ClassListAttendanceReportAdminLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
