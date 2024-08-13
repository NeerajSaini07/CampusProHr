part of 'update_student_mobile_no_cubit.dart';

abstract class UpdateStudentMobileNoState extends Equatable {
  const UpdateStudentMobileNoState();
}

class UpdateStudentMobileNoInitial extends UpdateStudentMobileNoState {
  @override
  List<Object> get props => [];
}

class UpdateStudentMobileNoLoadInProgress extends UpdateStudentMobileNoState {
  @override
  List<Object> get props => [];
}

class UpdateStudentMobileNoLoadSuccess extends UpdateStudentMobileNoState {
  final bool status;

  UpdateStudentMobileNoLoadSuccess(this.status);
  @override
  List<Object> get props => [status];
}

class UpdateStudentMobileNoLoadFail extends UpdateStudentMobileNoState {
  final String failReason;

  UpdateStudentMobileNoLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
