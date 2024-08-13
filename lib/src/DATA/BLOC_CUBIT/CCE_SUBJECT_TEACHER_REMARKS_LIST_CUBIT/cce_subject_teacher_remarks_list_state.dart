part of 'cce_subject_teacher_remarks_list_cubit.dart';

abstract class CceSubjectTeacherRemarksListState extends Equatable {
  const CceSubjectTeacherRemarksListState();
}

class CceSubjectTeacherRemarksListInitial extends CceSubjectTeacherRemarksListState {
  @override
  List<Object> get props => [];
}

class CceSubjectTeacherRemarksListLoadInProgress extends CceSubjectTeacherRemarksListState {
  @override
  List<Object> get props => [];
}

class CceSubjectTeacherRemarksListLoadSuccess extends CceSubjectTeacherRemarksListState {
  final List remarksList;

  CceSubjectTeacherRemarksListLoadSuccess(this.remarksList);
  @override
  List<Object> get props => [remarksList];
}

class CceSubjectTeacherRemarksListLoadFail extends CceSubjectTeacherRemarksListState {
  final String failReason;

  CceSubjectTeacherRemarksListLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}