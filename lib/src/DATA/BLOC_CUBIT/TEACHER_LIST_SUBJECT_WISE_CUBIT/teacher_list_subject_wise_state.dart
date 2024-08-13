part of 'teacher_list_subject_wise_cubit.dart';

abstract class TeacherListSubjectWiseState extends Equatable {
  const TeacherListSubjectWiseState();
}

class TeacherListSubjectWiseInitial extends TeacherListSubjectWiseState {
  @override
  List<Object> get props => [];
}

class TeacherListSubjectWiseLoadInProgress extends TeacherListSubjectWiseState {
  @override
  List<Object> get props => [];
}

class TeacherListSubjectWiseLoadSuccess extends TeacherListSubjectWiseState {
  final List<TeacherListSubjectWiseModel> teacherList;
  TeacherListSubjectWiseLoadSuccess(this.teacherList);
  @override
  List<Object> get props => [teacherList];
}

class TeacherListSubjectWiseLoadFail extends TeacherListSubjectWiseState {
  final String failReason;
  TeacherListSubjectWiseLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
