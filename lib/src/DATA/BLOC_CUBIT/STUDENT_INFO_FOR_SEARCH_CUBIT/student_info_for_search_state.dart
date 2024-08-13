part of 'student_info_for_search_cubit.dart';

abstract class StudentInfoForSearchState extends Equatable {
  const StudentInfoForSearchState();
}

class StudentInfoForSearchInitial extends StudentInfoForSearchState {
  @override
  List<Object> get props => [];
}

class StudentInfoForSearchLoadInProgress extends StudentInfoForSearchState {
  @override
  List<Object> get props => [];
}

class StudentInfoForSearchLoadSuccess extends StudentInfoForSearchState {
  final StudentInfoForSearchModel studentInfoData;

  StudentInfoForSearchLoadSuccess(this.studentInfoData);
  @override
  List<Object> get props => [studentInfoData];
}

class StudentInfoForSearchLoadFail extends StudentInfoForSearchState {
  final String failReason;

  StudentInfoForSearchLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
