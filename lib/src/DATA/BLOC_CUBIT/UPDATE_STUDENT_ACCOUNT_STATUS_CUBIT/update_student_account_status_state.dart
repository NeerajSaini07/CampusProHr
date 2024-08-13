part of 'update_student_account_status_cubit.dart';

abstract class UpdateStudentAccountStatusState extends Equatable {
  const UpdateStudentAccountStatusState();
}

class UpdateStudentAccountStatusInitial
    extends UpdateStudentAccountStatusState {
  @override
  List<Object> get props => [];
}

class UpdateStudentAccountStatusLoadInProgress
    extends UpdateStudentAccountStatusState {
  @override
  List<Object> get props => [];
}

class UpdateStudentAccountStatusLoadSuccess
    extends UpdateStudentAccountStatusState {
      final bool status;

  UpdateStudentAccountStatusLoadSuccess(this.status);
  @override
  List<Object> get props => [status];
}

class UpdateStudentAccountStatusLoadFail
    extends UpdateStudentAccountStatusState {
  final String failReason;

  UpdateStudentAccountStatusLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
