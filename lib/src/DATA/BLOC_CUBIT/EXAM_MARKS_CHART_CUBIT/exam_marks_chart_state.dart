part of 'exam_marks_chart_cubit.dart';

abstract class ExamMarksChartState extends Equatable {
  const ExamMarksChartState();
}

class ExamMarksChartInitial extends ExamMarksChartState {
  @override
  List<Object> get props => [];
}

class ExamMarksChartLoadInProgress extends ExamMarksChartState {
  @override
  List<Object> get props => [];
}

class ExamMarksChartLoadSuccess extends ExamMarksChartState {
  final List<ExamMarksChartModel> chartList;

  ExamMarksChartLoadSuccess(this.chartList);
  @override
  List<Object> get props => [chartList];
}

class ExamMarksChartLoadFail extends ExamMarksChartState {
  final String failReason;

  ExamMarksChartLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
