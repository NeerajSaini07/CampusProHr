part of 'class_list_hw_status_admin_cubit.dart';

abstract class ClassListHwStatusAdminState extends Equatable {
  const ClassListHwStatusAdminState();
}

class ClassListHwStatusAdminInitial extends ClassListHwStatusAdminState {
  @override
  List<Object> get props => [];
}

class ClassListHwStatusAdminLoadInProgress extends ClassListHwStatusAdminState {
  @override
  List<Object> get props => [];
}

class ClassListHwStatusAdminLoadSuccess extends ClassListHwStatusAdminState {
  final List<ClassListHwStatusAdminModel> classList;
  ClassListHwStatusAdminLoadSuccess(this.classList);
  @override
  List<Object> get props => [classList];
}

class ClassListHwStatusAdminLoadFail extends ClassListHwStatusAdminState {
  final String failReason;
  ClassListHwStatusAdminLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
