part of 'load_allotted_subject_cubit.dart';

abstract class LoadAllottedSubjectState extends Equatable {
  const LoadAllottedSubjectState();
}

class LoadAllottedSubjectInitial extends LoadAllottedSubjectState {
  @override
  List<Object> get props => [];
}

class LoadAllottedSubjectLoadInProgress extends LoadAllottedSubjectState {
  @override
  List<Object> get props => [];
}

class LoadAllottedSubjectLoadSuccess extends LoadAllottedSubjectState {
  final List<LoadAllottedSubjectsModel> subjectListt;
  LoadAllottedSubjectLoadSuccess(this.subjectListt);

  @override
  List<Object> get props => [subjectListt];
}

class LoadAllottedSubjectLoadFail extends LoadAllottedSubjectState {
  final String failReason;
  LoadAllottedSubjectLoadFail(this.failReason);
  @override
  List<Object> get props => [];
}
