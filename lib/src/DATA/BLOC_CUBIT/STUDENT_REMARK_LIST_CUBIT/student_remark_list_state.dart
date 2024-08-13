part of 'student_remark_list_cubit.dart';

abstract class StudentRemarkListState extends Equatable {
  const StudentRemarkListState();
}

class StudentRemarkListInitial extends StudentRemarkListState {
  @override
  List<Object> get props => [];
}

class StudentRemarkListLoadInProgress extends StudentRemarkListState {
  @override
  List<Object> get props => [];
}

class StudentRemarkListLoadSuccess extends StudentRemarkListState {
  final List<StudentRemarkListModel> studentRemarksList;

  StudentRemarkListLoadSuccess(this.studentRemarksList);
  @override
  List<Object> get props => [studentRemarksList];
}

class StudentRemarkListLoadFail extends StudentRemarkListState {
  final String failReason;

  StudentRemarkListLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
