part of 'save_exam_marks_cubit.dart';

abstract class SaveExamMarksState extends Equatable {
  const SaveExamMarksState();
}

class SaveExamMarksInitial extends SaveExamMarksState {
  @override
  List<Object> get props => [];
}

class SaveExamMarksLoadInProgress extends SaveExamMarksState {
  @override
  List<Object> get props => [];
}

class SaveExamMarksLoadSuccess extends SaveExamMarksState {
  final bool status;

  SaveExamMarksLoadSuccess(this.status);
  @override
  List<Object> get props => [status];
}

class SaveExamMarksLoadFail extends SaveExamMarksState {
  final String failReason;

  SaveExamMarksLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
