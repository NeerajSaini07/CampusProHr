part of 'teachers_list_cubit.dart';

abstract class TeachersListState extends Equatable {
  const TeachersListState();
}

class TeachersListInitial extends TeachersListState {
  @override
  List<Object> get props => [];
}

class TeachersListLoadInProgress extends TeachersListState {
  @override
  List<Object> get props => [];
}

class TeachersListLoadSuccess extends TeachersListState {
  final List<TeachersListModel> teacherData;

  TeachersListLoadSuccess(this.teacherData);
  @override
  List<Object> get props => [teacherData];
}

class TeachersListLoadFail extends TeachersListState {
  final String failReason;

  TeachersListLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
