part of 'grades_list_grade_entry_cubit.dart';

abstract class GradesListGradeEntryState extends Equatable {
  const GradesListGradeEntryState();
}

class GradesListGradeEntryInitial extends GradesListGradeEntryState {
  @override
  List<Object> get props => [];
}

class GradesListGradeEntryLoadInProgress extends GradesListGradeEntryState {
  @override
  List<Object> get props => [];
}

class GradesListGradeEntryLoadSuccess extends GradesListGradeEntryState {
  final List<GradesListGradeEntryModel> gradesList;

  GradesListGradeEntryLoadSuccess(this.gradesList);
  @override
  List<Object> get props => [gradesList];
}

class GradesListGradeEntryLoadFail extends GradesListGradeEntryState {
  final String failReason;

  GradesListGradeEntryLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
