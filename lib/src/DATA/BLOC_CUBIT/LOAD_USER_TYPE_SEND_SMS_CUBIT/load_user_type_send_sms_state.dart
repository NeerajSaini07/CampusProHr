part of 'load_user_type_send_sms_cubit.dart';

abstract class LoadUserTypeSendSmsState extends Equatable {
  const LoadUserTypeSendSmsState();
}

class LoadUserTypeSendSmsInitial extends LoadUserTypeSendSmsState {
  @override
  List<Object> get props => [];
}

class LoadUserTypeSendSmsLoadInProgress extends LoadUserTypeSendSmsState {
  @override
  List<Object> get props => [];
}

class LoadUserTypeSendSmsLoadSuccess extends LoadUserTypeSendSmsState {
  final List<LoadUserTypeSendSmsModel> userTypeList;
  LoadUserTypeSendSmsLoadSuccess(this.userTypeList);
  @override
  List<Object> get props => [userTypeList];
}

class LoadUserTypeSendSmsLoadFail extends LoadUserTypeSendSmsState {
  final String failReason;
  LoadUserTypeSendSmsLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
