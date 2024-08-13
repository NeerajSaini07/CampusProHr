part of 'load_class_for_subject_admin_cubit.dart';

abstract class LoadClassForSubjectAdminState extends Equatable {
  const LoadClassForSubjectAdminState();
}

class LoadClassForSubjectAdminInitial extends LoadClassForSubjectAdminState {
  @override
  List<Object> get props => [];
}

class LoadClassForSubjectAdminLoadInProgress
    extends LoadClassForSubjectAdminState {
  @override
  List<Object> get props => [];
}

class LoadClassForSubjectAdminLoadSuccess
    extends LoadClassForSubjectAdminState {
  final List<LoadClassForSubjectAdminModel> classList;
  LoadClassForSubjectAdminLoadSuccess(this.classList);
  @override
  List<Object> get props => [classList];
}

class LoadClassForSubjectAdminLoadFail extends LoadClassForSubjectAdminState {
  final String failReason;
  LoadClassForSubjectAdminLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
