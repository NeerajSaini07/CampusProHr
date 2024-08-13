part of 'schedule_meeting_today_list_cubit.dart';

abstract class ScheduleMeetingTodayListState extends Equatable {
  const ScheduleMeetingTodayListState();
}

class ScheduleMeetingTodayListInitial
    extends ScheduleMeetingTodayListState {
  @override
  List<Object> get props => [];
}

class ScheduleMeetingTodayListLoadInProgress
    extends ScheduleMeetingTodayListState {
  @override
  List<Object> get props => [];
}

class ScheduleMeetingTodayListLoadSuccess
    extends ScheduleMeetingTodayListState {
  final List<ScheduleMeetingTodayListModel> meetingList;

  ScheduleMeetingTodayListLoadSuccess(this.meetingList);
  @override
  List<Object> get props => [meetingList];
}

class ScheduleMeetingTodayListLoadFail
    extends ScheduleMeetingTodayListState {
  final String? failReason;

  ScheduleMeetingTodayListLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason!];
}
