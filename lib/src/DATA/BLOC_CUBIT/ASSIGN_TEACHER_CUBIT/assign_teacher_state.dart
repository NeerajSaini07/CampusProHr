part of 'assign_teacher_cubit.dart';

abstract class AssignTeacherState extends Equatable {
  const AssignTeacherState();
}

class AssignTeacherInitial extends AssignTeacherState {
  @override
  List<Object> get props => [];
}

class AssignTeacherLoadInProgress extends AssignTeacherState {
  @override
  List<Object> get props => [];
}

class AssignTeacherLoadSuccess extends AssignTeacherState {
  final List<AssignTeacherModel> teacherList;

  AssignTeacherLoadSuccess(this.teacherList);
  @override
  List<Object> get props => [teacherList];
}

class AssignTeacherLoadFail extends AssignTeacherState {
  final String failReason;

  AssignTeacherLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
