part of 'student_active_deactive_list_admin_cubit.dart';

abstract class StudentActiveDeactiveListAdminState extends Equatable {
  const StudentActiveDeactiveListAdminState();
}

class StudentActiveDeactiveListAdminInitial
    extends StudentActiveDeactiveListAdminState {
  @override
  List<Object> get props => [];
}

class StudentActiveDeactiveListAdminLoadInProgress
    extends StudentActiveDeactiveListAdminState {
  @override
  List<Object> get props => [];
}

class StudentActiveDeactiveListAdminLoadSuccess
    extends StudentActiveDeactiveListAdminState {
  final bool status;

  StudentActiveDeactiveListAdminLoadSuccess(this.status);

  @override
  List<Object> get props => [status];
}

class StudentActiveDeactiveListAdminLoadFail
    extends StudentActiveDeactiveListAdminState {
  final String failReason;

  StudentActiveDeactiveListAdminLoadFail(this.failReason);

  @override
  List<Object> get props => [failReason];
}
