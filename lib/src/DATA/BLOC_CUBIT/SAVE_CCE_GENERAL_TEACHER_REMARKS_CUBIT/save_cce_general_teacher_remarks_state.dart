part of 'save_cce_general_teacher_remarks_cubit.dart';

abstract class SaveCceGeneralTeacherRemarksState extends Equatable {
  const SaveCceGeneralTeacherRemarksState();
}

class SaveCceGeneralTeacherRemarksInitial extends SaveCceGeneralTeacherRemarksState {
  @override
  List<Object> get props => [];
}

class SaveCceGeneralTeacherRemarksLoadInProgress extends SaveCceGeneralTeacherRemarksState {
  @override
  List<Object> get props => [];
}

class SaveCceGeneralTeacherRemarksLoadSuccess extends SaveCceGeneralTeacherRemarksState {
    final bool status;

  SaveCceGeneralTeacherRemarksLoadSuccess(this.status);
  @override
  List<Object> get props => [status];
}

class SaveCceGeneralTeacherRemarksLoadFail extends SaveCceGeneralTeacherRemarksState {
  final String failReason;

  SaveCceGeneralTeacherRemarksLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
