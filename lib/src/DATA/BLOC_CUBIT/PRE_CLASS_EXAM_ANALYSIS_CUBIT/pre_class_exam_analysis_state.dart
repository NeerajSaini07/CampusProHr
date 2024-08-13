part of 'pre_class_exam_analysis_cubit.dart';

abstract class PreClassExamAnalysisState extends Equatable {
  const PreClassExamAnalysisState();
}

class PreClassExamAnalysisInitial extends PreClassExamAnalysisState {
  @override
  List<Object> get props => [];
}

class PreClassExamAnalysisLoadInProgress extends PreClassExamAnalysisState {
  @override
  List<Object> get props => [];
}

class PreClassExamAnalysisLoadSuccess extends PreClassExamAnalysisState {
  final String classID;

  PreClassExamAnalysisLoadSuccess(this.classID);
  @override
  List<Object> get props => [classID];
}

class PreClassExamAnalysisLoadFail extends PreClassExamAnalysisState {
  final String failReason;

  PreClassExamAnalysisLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
