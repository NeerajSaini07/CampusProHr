part of 'exams_list_exam_analysis_cubit.dart';

abstract class ExamsListExamAnalysisState extends Equatable {
  const ExamsListExamAnalysisState();
}

class ExamsListExamAnalysisInitial extends ExamsListExamAnalysisState {
  @override
  List<Object> get props => [];
}

class ExamsListExamAnalysisLoadInProgress extends ExamsListExamAnalysisState {
  @override
  List<Object> get props => [];
}

class ExamsListExamAnalysisLoadSuccess extends ExamsListExamAnalysisState {
  final List<ExamsListExamAnalysisModel> examsList;

  ExamsListExamAnalysisLoadSuccess(this.examsList);
  @override
  List<Object> get props => [examsList];
}

class ExamsListExamAnalysisLoadFail extends ExamsListExamAnalysisState {
  final failReason;

  ExamsListExamAnalysisLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
