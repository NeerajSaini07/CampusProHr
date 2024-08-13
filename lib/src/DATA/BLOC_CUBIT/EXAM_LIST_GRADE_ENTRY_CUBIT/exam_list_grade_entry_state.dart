part of 'exam_list_grade_entry_cubit.dart';

abstract class ExamListGradeEntryState extends Equatable {
  const ExamListGradeEntryState();
}

class ExamListGradeEntryInitial extends ExamListGradeEntryState {
  @override
  List<Object> get props => [];
}

class ExamListGradeEntryLoadInProgress extends ExamListGradeEntryState {
  @override
  List<Object> get props => [];
}

class ExamListGradeEntryLoadSucccess extends ExamListGradeEntryState {
  final List<ExamListGradeEntryModel> examList;

  ExamListGradeEntryLoadSucccess(this.examList);
  @override
  List<Object> get props => [examList];
}

class ExamListGradeEntryLoadFail extends ExamListGradeEntryState {
  final String failReason;

  ExamListGradeEntryLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
