part of 'assign_class_teacher_admin_cubit.dart';

abstract class AssignClassTeacherAdminState extends Equatable {
  const AssignClassTeacherAdminState();
}

class AssignClassTeacherAdminInitial extends AssignClassTeacherAdminState {
  @override
  List<Object> get props => [];
}

class AssignClassTeacherAdminLoadInProgress
    extends AssignClassTeacherAdminState {
  @override
  List<Object> get props => [];
}

class AssignClassTeacherAdminLoadSuccess extends AssignClassTeacherAdminState {
  final String success;
  AssignClassTeacherAdminLoadSuccess(this.success);
  @override
  List<Object> get props => [success];
}

class AssignClassTeacherAdminLoadFail extends AssignClassTeacherAdminState {
  final String failReason;
  AssignClassTeacherAdminLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
