part of 'student_detail_search_cubit.dart';

abstract class StudentDetailSearchState extends Equatable {
  const StudentDetailSearchState();
}

class StudentDetailSearchInitial extends StudentDetailSearchState {
  @override
  List<Object> get props => [];
}

class StudentDetailSearchLoadInProgress extends StudentDetailSearchState {
  @override
  List<Object> get props => [];
}

class StudentDetailSearchLoadSuccess extends StudentDetailSearchState {
  final StudentDetailSearchModel studentDetails;

  StudentDetailSearchLoadSuccess(this.studentDetails);
  @override
  List<Object> get props => [studentDetails];
}

class StudentDetailSearchLoadFail extends StudentDetailSearchState {
  final String failReason;

  StudentDetailSearchLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
