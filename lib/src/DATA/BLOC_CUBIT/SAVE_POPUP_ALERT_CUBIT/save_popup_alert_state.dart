part of 'save_popup_alert_cubit.dart';

abstract class SavePopupAlertState extends Equatable {
  const SavePopupAlertState();
}

class SavePopupAlertInitial extends SavePopupAlertState {
  @override
  List<Object> get props => [];
}

class SavePopupAlertLoadInProgress extends SavePopupAlertState {
  @override
  List<Object> get props => [];
}

class SavePopupAlertLoadSuccess extends SavePopupAlertState {
  final String result;
  SavePopupAlertLoadSuccess(this.result);
  @override
  List<Object> get props => [result];
}

class SavePopupAlertLoadFail extends SavePopupAlertState {
  final String failReason;
  SavePopupAlertLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
