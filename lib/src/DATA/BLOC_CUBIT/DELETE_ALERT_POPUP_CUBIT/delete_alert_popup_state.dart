part of 'delete_alert_popup_cubit.dart';

abstract class DeleteAlertPopupState extends Equatable {
  const DeleteAlertPopupState();
}

class DeleteAlertPopupInitial extends DeleteAlertPopupState {
  @override
  List<Object> get props => [];
}

class DeleteAlertPopupLoadInProgress extends DeleteAlertPopupState {
  @override
  List<Object> get props => [];
}

class DeleteAlertPopupLoadSuccess extends DeleteAlertPopupState {
  final String result;
  DeleteAlertPopupLoadSuccess(this.result);
  @override
  List<Object> get props => [result];
}

class DeleteAlertPopupLoadFail extends DeleteAlertPopupState {
  final String failReason;
  DeleteAlertPopupLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
