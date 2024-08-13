part of 'subject_exam_marks_cubit.dart';

abstract class SubjectExamMarksState extends Equatable {
  const SubjectExamMarksState();
}

class SubjectExamMarksInitial extends SubjectExamMarksState {
  @override
  List<Object> get props => [];
}

class SubjectExamMarksLoadInProgress extends SubjectExamMarksState {
  @override
  List<Object> get props => [];
}

class SubjectExamMarksLoadSuccess extends SubjectExamMarksState {
  final List<SubjectExamMarksModel> subjectList;

  SubjectExamMarksLoadSuccess(this.subjectList);
  @override
  List<Object> get props => [subjectList];
}

class SubjectExamMarksLoadFail extends SubjectExamMarksState {
  final String failReason;

  SubjectExamMarksLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
