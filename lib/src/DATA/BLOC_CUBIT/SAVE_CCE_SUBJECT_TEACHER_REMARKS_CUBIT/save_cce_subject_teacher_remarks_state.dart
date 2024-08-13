part of 'save_cce_subject_teacher_remarks_cubit.dart';

abstract class SaveCceSubjectTeacherRemarksState extends Equatable {
  const SaveCceSubjectTeacherRemarksState();
}

class SaveCceSubjectTeacherRemarksInitial extends SaveCceSubjectTeacherRemarksState {
  @override
  List<Object> get props => [];
}

class SaveCceSubjectTeacherRemarksLoadInProgress extends SaveCceSubjectTeacherRemarksState {
  @override
  List<Object> get props => [];
}

class SaveCceSubjectTeacherRemarksLoadSuccess extends SaveCceSubjectTeacherRemarksState {
    final bool status;

  SaveCceSubjectTeacherRemarksLoadSuccess(this.status);
  @override
  List<Object> get props => [status];
}

class SaveCceSubjectTeacherRemarksLoadFail extends SaveCceSubjectTeacherRemarksState {
  final String failReason;

  SaveCceSubjectTeacherRemarksLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
