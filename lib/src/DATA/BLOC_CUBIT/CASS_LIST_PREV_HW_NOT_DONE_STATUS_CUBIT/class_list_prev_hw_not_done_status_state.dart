part of 'class_list_prev_hw_not_done_status_cubit.dart';

abstract class ClassListPrevHwNotDoneStatusState extends Equatable {
  const ClassListPrevHwNotDoneStatusState();
}

class ClassListPrevHwNotDoneStatusInitial
    extends ClassListPrevHwNotDoneStatusState {
  @override
  List<Object> get props => [];
}

class ClassListPrevHwNotDoneStatusLoadInProgress
    extends ClassListPrevHwNotDoneStatusState {
  @override
  List<Object> get props => [];
}

class ClassListPrevHwNotDoneStatusLoadSuccess
    extends ClassListPrevHwNotDoneStatusState {
  final List<ClassListPrevHwNotDoneStatusModel> classList;
  ClassListPrevHwNotDoneStatusLoadSuccess(this.classList);
  @override
  List<Object> get props => [classList];
}

class ClassListPrevHwNotDoneStatusLoadFail
    extends ClassListPrevHwNotDoneStatusState {
  final String failReason;
  ClassListPrevHwNotDoneStatusLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
