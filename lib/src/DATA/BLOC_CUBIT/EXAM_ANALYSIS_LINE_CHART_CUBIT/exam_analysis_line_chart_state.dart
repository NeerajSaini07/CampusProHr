part of 'exam_analysis_line_chart_cubit.dart';

abstract class ExamAnalysisLineChartState extends Equatable {
  const ExamAnalysisLineChartState();
}

class ExamAnalysisLineChartInitial extends ExamAnalysisLineChartState {
  @override
  List<Object> get props => [];
}

class ExamAnalysisLineChartLoadInProgress extends ExamAnalysisLineChartState {
  @override
  List<Object> get props => [];
}

class ExamAnalysisLineChartLoadSuccess extends ExamAnalysisLineChartState {
  final ExamAnalysisLineChartModel examAnalysisData;

  ExamAnalysisLineChartLoadSuccess(this.examAnalysisData);
  @override
  List<Object> get props => [examAnalysisData];
}

class ExamAnalysisLineChartLoadFail extends ExamAnalysisLineChartState {
  final String failReason;

  ExamAnalysisLineChartLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
