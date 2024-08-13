part of 'save_grade_entry_cubit.dart';

abstract class SaveGradeEntryState extends Equatable {
  const SaveGradeEntryState();
}

class SaveGradeEntryInitial extends SaveGradeEntryState {
  @override
  List<Object> get props => [];
}

class SaveGradeEntryLoadInProgress extends SaveGradeEntryState {
  @override
  List<Object> get props => [];
}

class SaveGradeEntryLoadSuccess extends SaveGradeEntryState {
  final bool status;

  SaveGradeEntryLoadSuccess(this.status);
  @override
  List<Object> get props => [status];
}

class SaveGradeEntryLoadFail extends SaveGradeEntryState {
  final String failReason;

  SaveGradeEntryLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
