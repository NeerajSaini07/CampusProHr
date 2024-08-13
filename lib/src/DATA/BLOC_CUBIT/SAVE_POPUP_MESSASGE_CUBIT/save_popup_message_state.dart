part of 'save_popup_message_cubit.dart';

abstract class SavePopupMessageState extends Equatable {
  const SavePopupMessageState();
}

class SavePopupMessageInitial extends SavePopupMessageState {
  @override
  List<Object> get props => [];
}

class SavePopupMessageLoadInProgress extends SavePopupMessageState {
  @override
  List<Object> get props => [];
}

class SavePopupMessageLoadSuccess extends SavePopupMessageState {
  final String result;
  SavePopupMessageLoadSuccess(this.result);
  @override
  List<Object> get props => [result];
}

class SavePopupMessageLoadFail extends SavePopupMessageState {
  final String failReason;
  SavePopupMessageLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
