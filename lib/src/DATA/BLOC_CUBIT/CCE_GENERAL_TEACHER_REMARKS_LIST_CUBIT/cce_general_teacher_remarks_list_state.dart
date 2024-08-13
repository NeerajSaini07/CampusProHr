part of 'cce_general_teacher_remarks_list_cubit.dart';

abstract class CceGeneralTeacherRemarksListState extends Equatable {
  const CceGeneralTeacherRemarksListState();
}

class CceGeneralTeacherRemarksListInitial extends CceGeneralTeacherRemarksListState {
  @override
  List<Object> get props => [];
}

class CceGeneralTeacherRemarksListLoadInProgress extends CceGeneralTeacherRemarksListState {
  @override
  List<Object> get props => [];
}

class CceGeneralTeacherRemarksListLoadSuccess extends CceGeneralTeacherRemarksListState {
  final List<CceGeneralTeacherRemarksListModel> remarksList;

  CceGeneralTeacherRemarksListLoadSuccess(this.remarksList);
  @override
  List<Object> get props => [remarksList];
}

class CceGeneralTeacherRemarksListLoadFail extends CceGeneralTeacherRemarksListState {
  final String failReason;

  CceGeneralTeacherRemarksListLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
