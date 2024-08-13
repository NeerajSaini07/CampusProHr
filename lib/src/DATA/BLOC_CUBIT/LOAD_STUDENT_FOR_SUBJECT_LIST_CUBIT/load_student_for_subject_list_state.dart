part of 'load_student_for_subject_list_cubit.dart';

abstract class LoadStudentForSubjectListState extends Equatable {
  const LoadStudentForSubjectListState();
}

class LoadStudentForSubjectListInitial extends LoadStudentForSubjectListState {
  @override
  List<Object> get props => [];
}

class LoadStudentForSubjectListLoafInProgress
    extends LoadStudentForSubjectListState {
  @override
  List<Object> get props => [];
}

class LoadStudentForSubjectListLoadSuccess
    extends LoadStudentForSubjectListState {
  final List<LoadStudentForSubjectListModel> stuList;
  LoadStudentForSubjectListLoadSuccess(this.stuList);
  @override
  List<Object> get props => [stuList];
}

class LoadStudentForSubjectListLoadFail extends LoadStudentForSubjectListState {
  final String failReason;
  LoadStudentForSubjectListLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
