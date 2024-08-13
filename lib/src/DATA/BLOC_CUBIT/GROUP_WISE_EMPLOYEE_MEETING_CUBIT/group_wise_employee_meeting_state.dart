part of 'group_wise_employee_meeting_cubit.dart';

abstract class GroupWiseEmployeeMeetingState extends Equatable {
  const GroupWiseEmployeeMeetingState();
}

class GroupWiseEmployeeMeetingInitial
    extends GroupWiseEmployeeMeetingState {
  @override
  List<Object> get props => [];
}

class GroupWiseEmployeeMeetingLoadInProgress
    extends GroupWiseEmployeeMeetingState {
  @override
  List<Object> get props => [];
}

class GroupWiseEmployeeMeetingLoadSuccess
    extends GroupWiseEmployeeMeetingState {
      final List<GroupWiseEmployeeMeetingModel> groupData;

  GroupWiseEmployeeMeetingLoadSuccess(this.groupData);
  @override
  List<Object> get props => [groupData];
}

class GroupWiseEmployeeMeetingLoadFail
    extends GroupWiseEmployeeMeetingState {
      final String failReason;

  GroupWiseEmployeeMeetingLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
