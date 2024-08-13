part of 'department_wise_employee_meeting_cubit.dart';

abstract class DepartmentWiseEmployeeMeetingState extends Equatable {
  const DepartmentWiseEmployeeMeetingState();
}

class DepartmentWiseEmployeeMeetingInitial
    extends DepartmentWiseEmployeeMeetingState {
  @override
  List<Object> get props => [];
}

class DepartmentWiseEmployeeMeetingLoadInProgress
    extends DepartmentWiseEmployeeMeetingState {
  @override
  List<Object> get props => [];
}

class DepartmentWiseEmployeeMeetingLoadSuccess
    extends DepartmentWiseEmployeeMeetingState {
      final List<DepartmentWiseEmployeeMeetingModel> departmentData;

  DepartmentWiseEmployeeMeetingLoadSuccess(this.departmentData);
  @override
  List<Object> get props => [departmentData];
}

class DepartmentWiseEmployeeMeetingLoadFail
    extends DepartmentWiseEmployeeMeetingState {
      final String failReason;

  DepartmentWiseEmployeeMeetingLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
