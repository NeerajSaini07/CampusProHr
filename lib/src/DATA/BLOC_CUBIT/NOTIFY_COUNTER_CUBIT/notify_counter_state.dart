part of 'notify_counter_cubit.dart';

abstract class NotifyCounterState extends Equatable {
  const NotifyCounterState();
}

class NotifyCounterInitial extends NotifyCounterState {
  @override
  List<Object> get props => [];
}

class NotifyCounterLoadInProgress extends NotifyCounterState {
  @override
  List<Object> get props => [];
}

class NotifyCounterLoadSuccess extends NotifyCounterState {
  final List<NotifyCounterModel> notifyList;

  NotifyCounterLoadSuccess(this.notifyList);
  @override
  List<Object> get props => [notifyList];
}

class NotifyCounterLoadFail extends NotifyCounterState {
  final String failReason;

  NotifyCounterLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
