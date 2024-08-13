part of 'exam_analysis_chart_admin_cubit.dart';

abstract class ExamAnalysisChartAdminState extends Equatable {
  const ExamAnalysisChartAdminState();
}

class ExamAnalysisChartAdminInitial extends ExamAnalysisChartAdminState {
  @override
  List<Object> get props => [];
}

class ExamAnalysisChartAdminLoadInProgress extends ExamAnalysisChartAdminState {
  @override
  List<Object> get props => [];
}

class ExamAnalysisChartAdminLoadSuccess extends ExamAnalysisChartAdminState {
  final List<ExamAnalysisChartAdminModel> chartData;

  ExamAnalysisChartAdminLoadSuccess(this.chartData);
  @override
  List<Object> get props => [chartData];
}

class ExamAnalysisChartAdminLoadFail extends ExamAnalysisChartAdminState {
  final String failReason;

  ExamAnalysisChartAdminLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
