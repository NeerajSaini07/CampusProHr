part of 'save_sms_type_cubit.dart';

abstract class SaveSmsTypeState extends Equatable {
  const SaveSmsTypeState();
}

class SaveSmsTypeInitial extends SaveSmsTypeState {
  @override
  List<Object> get props => [];
}

class SaveSmsTypeLoadInProgress extends SaveSmsTypeState {
  @override
  List<Object> get props => [];
}

class SaveSmsTypeLoadSuccess extends SaveSmsTypeState {
  final String response;
  SaveSmsTypeLoadSuccess(this.response);
  @override
  List<Object> get props => [response];
}

class SaveSmsTypeLoadFail extends SaveSmsTypeState {
  final String failReason;
  SaveSmsTypeLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
