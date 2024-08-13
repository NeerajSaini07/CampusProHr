part of 'section_list_attendance_cubit.dart';

abstract class SectionListAttendanceState extends Equatable {
  const SectionListAttendanceState();
}

class SectionListAttendanceInitial extends SectionListAttendanceState {
  @override
  List<Object> get props => [];
}

class SectionListAttendanceLoadInProgress extends SectionListAttendanceState {
  @override
  List<Object> get props => [];
}

class SectionListAttendanceLoadSuccess extends SectionListAttendanceState {
  final List<SectionListAttendanceModel> sectionList;
  SectionListAttendanceLoadSuccess(this.sectionList);
  @override
  List<Object> get props => [sectionList];
}

class SectionListAttendanceLoadFail extends SectionListAttendanceState {
  final String failReason;
  SectionListAttendanceLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
