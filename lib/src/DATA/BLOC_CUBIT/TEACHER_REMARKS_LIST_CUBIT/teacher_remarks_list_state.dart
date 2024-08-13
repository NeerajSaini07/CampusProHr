part of 'teacher_remarks_list_cubit.dart';

abstract class TeacherRemarksListState extends Equatable {
  const TeacherRemarksListState();
}

class TeacherRemarksListInitial extends TeacherRemarksListState {
  @override
  List<Object> get props => [];
}

class TeacherRemarksListLoadInProgress extends TeacherRemarksListState {
  @override
  List<Object> get props => [];
}

class TeacherRemarksListLoadSuccess extends TeacherRemarksListState {
  final List<TeacherRemarksListModel> teacherRemarksList;

  TeacherRemarksListLoadSuccess(this.teacherRemarksList);
  @override
  List<Object> get props => [teacherRemarksList];
}

class TeacherRemarksListLoadFail extends TeacherRemarksListState {
  final String failReason;

  TeacherRemarksListLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
