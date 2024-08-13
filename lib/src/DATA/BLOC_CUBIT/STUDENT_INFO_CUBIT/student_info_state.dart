part of 'student_info_cubit.dart';

abstract class StudentInfoState extends Equatable {
  const StudentInfoState();
}

class StudentInfoInitial extends StudentInfoState {
  @override
  List<Object> get props => [];
}

class StudentInfoLoadInProgress extends StudentInfoState {
  @override
  List<Object> get props => [];
}

class StudentInfoLoadSuccess extends StudentInfoState {
  final StudentInfoModel studentInfoData;

  StudentInfoLoadSuccess(this.studentInfoData);
  @override
  List<Object> get props => [studentInfoData];
}

class StudentInfoLoadFail extends StudentInfoState {
  final String failReason;

  StudentInfoLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
