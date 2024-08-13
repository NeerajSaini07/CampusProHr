part of 'section_list_attendance_admin_cubit.dart';

abstract class SectionListAttendanceAdminState extends Equatable {
  const SectionListAttendanceAdminState();
}

class SectionListAttendanceAdminInitial
    extends SectionListAttendanceAdminState {
  @override
  List<Object> get props => [];
}

class SectionListAttendanceAdminLoadInProgress
    extends SectionListAttendanceAdminState {
  @override
  List<Object> get props => [];
}

class SectionListAttendanceAdminLoadSuccess
    extends SectionListAttendanceAdminState {
  final List<SectionListAttendanceAdminModel> sectionList;
  SectionListAttendanceAdminLoadSuccess(this.sectionList);
  @override
  List<Object> get props => [sectionList];
}

class SectionListAttendanceAdminLoadFail
    extends SectionListAttendanceAdminState {
  final String failReason;
  SectionListAttendanceAdminLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
