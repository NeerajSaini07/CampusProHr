part of 'mark_sheet_student_cubit.dart';

abstract class MarkSheetStudentState extends Equatable {
  const MarkSheetStudentState();
}

class MarkSheetStudentInitial extends MarkSheetStudentState {
  @override
  List<Object> get props => [];
}

class MarkSheetStudentLoadInProgress extends MarkSheetStudentState {
  @override
  List<Object> get props => [];
}

class MarkSheetStudentLoadSuccess extends MarkSheetStudentState {
  final List<MarkSheetStudentModel> markSheetList;
  MarkSheetStudentLoadSuccess(this.markSheetList);
  @override
  List<Object> get props => [markSheetList];
}

class MarkSheetStudentLoadFail extends MarkSheetStudentState {
  final String failReason;
  MarkSheetStudentLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
