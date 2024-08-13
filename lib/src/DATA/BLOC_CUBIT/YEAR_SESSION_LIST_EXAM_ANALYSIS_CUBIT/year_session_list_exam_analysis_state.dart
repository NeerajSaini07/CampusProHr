part of 'year_session_list_exam_analysis_cubit.dart';

abstract class YearSessionListExamAnalysisState extends Equatable {
  const YearSessionListExamAnalysisState();
}

class YearSessionListExamAnalysisInitial
    extends YearSessionListExamAnalysisState {
  @override
  List<Object> get props => [];
}

class YearSessionListExamAnalysisLoadInProgress
    extends YearSessionListExamAnalysisState {
  @override
  List<Object> get props => [];
}

class YearSessionListExamAnalysisLoadSuccess
    extends YearSessionListExamAnalysisState {
  final List<YearSessionListExamAnalysisModel> yearSessionList;

  YearSessionListExamAnalysisLoadSuccess(this.yearSessionList);
  @override
  List<Object> get props => [yearSessionList];
}

class YearSessionListExamAnalysisLoadFail
    extends YearSessionListExamAnalysisState {
  final String failReason;

  YearSessionListExamAnalysisLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
