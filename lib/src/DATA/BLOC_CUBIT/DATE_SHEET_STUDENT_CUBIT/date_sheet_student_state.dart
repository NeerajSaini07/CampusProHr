part of 'date_sheet_student_cubit.dart';

abstract class DateSheetStudentState extends Equatable {
  const DateSheetStudentState();
}

class DateSheetStudentInitial extends DateSheetStudentState {
  @override
  List<Object> get props => [];
}

class DateSheetStudentLoadInProgress extends DateSheetStudentState {
  @override
  List<Object> get props => [];
}

class DateSheetStudentLoadSuccess extends DateSheetStudentState {
  final List<DateSheetStudentModel> dateSheet;
  DateSheetStudentLoadSuccess(this.dateSheet);
  @override
  List<Object> get props => [];
}

class DateSheetStudentLoadFail extends DateSheetStudentState {
  final String failReason;
  DateSheetStudentLoadFail(this.failReason);
  @override
  List<Object> get props => [];
}
