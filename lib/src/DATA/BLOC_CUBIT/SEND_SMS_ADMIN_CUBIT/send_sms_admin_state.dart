part of 'send_sms_admin_cubit.dart';

abstract class SendSmsAdminState extends Equatable {
  const SendSmsAdminState();
}

class SendSmsAdminInitial extends SendSmsAdminState {
  @override
  List<Object> get props => [];
}

class SendSmsAdminLoadInProgress extends SendSmsAdminState{
  @override
  List<Object> get props => [];
}

class SendSmsAdminLoadSuccess extends SendSmsAdminState{
  final String result;
  SendSmsAdminLoadSuccess(this.result);
  @override
  List<Object> get props => [result];
}

class SendSmsAdminLoadFail extends SendSmsAdminState{
  final String failReason;
  SendSmsAdminLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}