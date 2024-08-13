part of 'teacher_status_list_cubit.dart';

abstract class TeacherStatusListState extends Equatable {
  const TeacherStatusListState();
}

class TeacherStatusListInitial extends TeacherStatusListState {
  @override
  List<Object> get props => [];
}

class TeacherStatusListLoadInProgress extends TeacherStatusListState {
  @override
  List<Object> get props => [];
}

class TeacherStatusListLoadSuccess extends TeacherStatusListState {
  final List<TeacherStatusListModel> statusList;

  TeacherStatusListLoadSuccess(this.statusList);
  @override
  List<Object> get props => [statusList];
}

class TeacherStatusListLoadFail extends TeacherStatusListState {
  final String failReason;

  TeacherStatusListLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
