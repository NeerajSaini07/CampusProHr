part of 'class_list_att_report_cubit.dart';

@immutable
abstract class ClassListAttReportState extends Equatable {
  const ClassListAttReportState();
}

class ClassListAttReportInitial extends ClassListAttReportState {
  @override
  List<Object> get props => [];
}

class ClassListAttReportLoadInProgress extends ClassListAttReportState {
  @override
  List<Object> get props => [];
}

class ClassListAttReportLoadSuccess extends ClassListAttReportState {
  final List<ClassListAttendanceModel> classList;
  ClassListAttReportLoadSuccess(this.classList);
  @override
  List<Object> get props => [classList];
}

class ClassListAttReportLoadFail extends ClassListAttReportState {
  final String failReason;
  ClassListAttReportLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
