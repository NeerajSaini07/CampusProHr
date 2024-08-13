part of 'student_choice_session_cubit.dart';

abstract class StudentChoiceSessionState extends Equatable {
  const StudentChoiceSessionState();
}

class StudentChoiceSessionInitial extends StudentChoiceSessionState {
  @override
  List<Object> get props => [];
}

class StudentChoiceSessionLoadInProgress extends StudentChoiceSessionState {
  @override
  List<Object> get props => [];
}

class StudentChoiceSessionLoadSuccess extends StudentChoiceSessionState {
  final String myClass;

  StudentChoiceSessionLoadSuccess(this.myClass);
  @override
  List<Object> get props => [myClass];
}

class StudentChoiceSessionLoadFail extends StudentChoiceSessionState {
  final String failReason;

  StudentChoiceSessionLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
