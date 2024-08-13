part of 'subject_allote_to_teacher_cubit.dart';

abstract class SubjectAlloteToTeacherState extends Equatable {
  const SubjectAlloteToTeacherState();
}

class SubjectAlloteToTeacherInitial extends SubjectAlloteToTeacherState {
  @override
  List<Object> get props => [];
}

class SubjectAlloteToTeacherLoadInProgress extends SubjectAlloteToTeacherState{
  @override
  List<Object> get props => [];
}

class SubjectAlloteToTeacherLoadSucces extends SubjectAlloteToTeacherState{
  final String success;
  SubjectAlloteToTeacherLoadSucces(this.success);
  @override
  List<Object> get props => [success];
}

class SubjectAlloteToTeacherLoadFail extends SubjectAlloteToTeacherState{
  final String failReason;
  SubjectAlloteToTeacherLoadFail(this.failReason);

  @override
  List<Object> get props => [failReason];
}

