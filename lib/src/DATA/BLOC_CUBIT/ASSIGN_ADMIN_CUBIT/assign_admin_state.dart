part of 'assign_admin_cubit.dart';

abstract class AssignAdminState extends Equatable {
  const AssignAdminState();
}

class AssignAdminInitial extends AssignAdminState {
  @override
  List<Object> get props => [];
}

class AssignAdminLoadInProgress extends AssignAdminState {
  @override
  List<Object> get props => [];
}

class AssignAdminLoadSuccess extends AssignAdminState {
  final List<AssignAdminModel> assignAdminList;

  AssignAdminLoadSuccess(this.assignAdminList);
  @override
  List<Object> get props => [assignAdminList];
}

class AssignAdminLoadFail extends AssignAdminState {
  final String failReason;

  AssignAdminLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
