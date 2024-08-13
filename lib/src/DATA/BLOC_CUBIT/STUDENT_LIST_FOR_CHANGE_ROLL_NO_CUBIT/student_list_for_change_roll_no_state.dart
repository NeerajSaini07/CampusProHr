part of 'student_list_for_change_roll_no_cubit.dart';

abstract class StudentListForChangeRollNoState extends Equatable {
  const StudentListForChangeRollNoState();
}

class StudentListForChangeRollNoInitial
    extends StudentListForChangeRollNoState {
  @override
  List<Object> get props => [];
}

class StudentListForChangeRollNoLoadInProgress
    extends StudentListForChangeRollNoState {
  @override
  List<Object> get props => [];
}

class StudentListForChangeRollNoLoadSuccess
    extends StudentListForChangeRollNoState {
  final List<StudentListForChangeRollNoModel> studentList;
  StudentListForChangeRollNoLoadSuccess(this.studentList);
  @override
  List<Object> get props => [studentList];
}

class StudentListForChangeRollNoLoadFail
    extends StudentListForChangeRollNoState {
  final String failReason;
  StudentListForChangeRollNoLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
