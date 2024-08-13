part of 'calender_student_cubit.dart';

abstract class CalenderStudentState extends Equatable {
  const CalenderStudentState();
}

class CalenderStudentInitial extends CalenderStudentState {
  @override
  List<Object> get props => [];
}

class CalenderStudentLoadInProgress extends CalenderStudentState {
  @override
  List<Object> get props => [];
}

class CalenderStudentLoadSuccess extends CalenderStudentState {
  final List<CalenderStudentModel> calenderList;

  CalenderStudentLoadSuccess(this.calenderList);
  @override
  List<Object> get props => [calenderList];
}

class CalenderStudentLoadFail extends CalenderStudentState {
  final String failReason;

  CalenderStudentLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
