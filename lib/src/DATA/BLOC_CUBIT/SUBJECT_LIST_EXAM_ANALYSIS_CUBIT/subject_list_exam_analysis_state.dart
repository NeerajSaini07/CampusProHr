part of 'subject_list_exam_analysis_cubit.dart';

abstract class SubjectListExamAnalysisState extends Equatable {
  const SubjectListExamAnalysisState();
}

class SubjectListExamAnalysisInitial extends SubjectListExamAnalysisState {
  @override
  List<Object> get props => [];
}

class SubjectListExamAnalysisLoadInProgress
    extends SubjectListExamAnalysisState {
  @override
  List<Object> get props => [];
}

class SubjectListExamAnalysisLoadSuccess extends SubjectListExamAnalysisState {
  final List<SubjectListExamAnalysisModel> subjectList;

  SubjectListExamAnalysisLoadSuccess(this.subjectList);
  @override
  List<Object> get props => [subjectList];
}

class SubjectListExamAnalysisLoadFail extends SubjectListExamAnalysisState {
  final String failReason;

  SubjectListExamAnalysisLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
