part of 'exam_analysis_chart_cubit.dart';

abstract class ExamAnalysisChartState extends Equatable {
  const ExamAnalysisChartState();
}

class ExamAnalysisChartInitial extends ExamAnalysisChartState {
  @override
  List<Object> get props => [];
}

class ExamAnalysisChartLoadInProgress extends ExamAnalysisChartState {
  @override
  List<Object> get props => [];
}

class ExamAnalysisChartLoadSuccess extends ExamAnalysisChartState {
  final List<ExamAnalysisChartModel> examAnalysisData;

  ExamAnalysisChartLoadSuccess(this.examAnalysisData);
  @override
  List<Object> get props => [examAnalysisData];
}

class ExamAnalysisChartLoadFail extends ExamAnalysisChartState {
  final String failReason;

  ExamAnalysisChartLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
