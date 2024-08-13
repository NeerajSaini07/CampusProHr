part of 'delete_message_popup_cubit.dart';

abstract class DeleteMessagePopupState extends Equatable {
  const DeleteMessagePopupState();
}

class DeleteMessagePopupInitial extends DeleteMessagePopupState {
  @override
  List<Object> get props => [];
}

class DeleteMessagePopupLoadInProgress extends DeleteMessagePopupState {
  @override
  List<Object> get props => [];
}

class DeleteMessagePopupLoadSuccess extends DeleteMessagePopupState {
  final String result;
  DeleteMessagePopupLoadSuccess(this.result);
  @override
  List<Object> get props => [result];
}

class DeleteMessagePopupLoadFail extends DeleteMessagePopupState {
  final String failReason;
  DeleteMessagePopupLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
