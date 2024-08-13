part of 'schedule_meeting_list_employee_cubit.dart';

abstract class ScheduleMeetingListEmployeeState extends Equatable {
  const ScheduleMeetingListEmployeeState();
}

class ScheduleMeetingListEmployeeInitial
    extends ScheduleMeetingListEmployeeState {
  @override
  List<Object> get props => [];
}

class ScheduleMeetingListEmployeeLoadInProgress
    extends ScheduleMeetingListEmployeeState {
  @override
  List<Object> get props => [];
}

class ScheduleMeetingListEmployeeLoadSuccess
    extends ScheduleMeetingListEmployeeState {
  final List<ScheduleMeetingListEmployeeModel> meetingList;

  ScheduleMeetingListEmployeeLoadSuccess(this.meetingList);
  @override
  List<Object> get props => [meetingList];
}

class ScheduleMeetingListEmployeeLoadFail
    extends ScheduleMeetingListEmployeeState {
  final String? failReason;

  ScheduleMeetingListEmployeeLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason!];
}
