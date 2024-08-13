part of 'grade_entry_list_cubit.dart';

abstract class GradeEntryListState extends Equatable {
  const GradeEntryListState();
}

class GradeEntryListInitial extends GradeEntryListState {
  @override
  List<Object> get props => [];
}

class GradeEntryListLoadInProgress extends GradeEntryListState {
  @override
  List<Object> get props => [];
}

class GradeEntryListLoadSuccess extends GradeEntryListState {
  final List<GradeEntryListModel> gradeEntryList;

  GradeEntryListLoadSuccess(this.gradeEntryList);
  @override
  List<Object> get props => [gradeEntryList];
}

class GradeEntryListLoadFail extends GradeEntryListState {
  final String failReason;

  GradeEntryListLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
