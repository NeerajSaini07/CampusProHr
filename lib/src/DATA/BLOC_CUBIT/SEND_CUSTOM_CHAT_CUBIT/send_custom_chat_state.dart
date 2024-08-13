part of 'send_custom_chat_cubit.dart';

abstract class SendCustomChatState extends Equatable {
  const SendCustomChatState();
}

class SendCustomChatInitial extends SendCustomChatState {
  @override
  List<Object> get props => [];
}

class SendCustomChatLoadInProgress extends SendCustomChatState {
  @override
  List<Object> get props => [];
}

class SendCustomChatLoadSuccess extends SendCustomChatState {
  final bool status;

  SendCustomChatLoadSuccess(this.status);
  @override
  List<Object> get props => [status];
}

class SendCustomChatLoadFail extends SendCustomChatState {
  final String failReason;

  SendCustomChatLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
