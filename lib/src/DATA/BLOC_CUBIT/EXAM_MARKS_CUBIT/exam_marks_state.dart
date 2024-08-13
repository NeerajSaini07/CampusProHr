part of 'exam_marks_cubit.dart';

abstract class ExamMarksState extends Equatable {
  const ExamMarksState();
}

class ExamMarksInitial extends ExamMarksState {
  @override
  List<Object> get props => [];
}

class ExamMarksLoadInProgress extends ExamMarksState {
  @override
  List<Object> get props => [];
}

class ExamMarksLoadSuccess extends ExamMarksState {
  final List<ExamMarksModel> marksList;

  ExamMarksLoadSuccess(this.marksList);
  @override
  List<Object> get props => [marksList];
}

class ExamMarksLoadFail extends ExamMarksState {
  final String failReason;

  ExamMarksLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
