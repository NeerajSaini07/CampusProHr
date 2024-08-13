part of 'notifications_cubit.dart';

abstract class NotificationsState extends Equatable {
  const NotificationsState();
}

class NotificationInitial extends NotificationsState {
  @override
  List<Object> get props => [];
}

class NotificationsLoadInProgress extends NotificationsState {
  @override
  List<Object> get props => [];
}

class NotificationsLoadSuccess extends NotificationsState {
  final List<NotificationsModel> notificationList;
  NotificationsLoadSuccess(this.notificationList);
  @override
  List<Object> get props => [notificationList];
}

class NotificationsLoadFail extends NotificationsState {
  final String failReason;
  NotificationsLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
