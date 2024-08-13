part of 'delete_custom_chat_cubit.dart';

abstract class DeleteCustomChatState extends Equatable {
  const DeleteCustomChatState();
}

class DeleteCustomChatInitial extends DeleteCustomChatState {
  @override
  List<Object> get props => [];
}

class DeleteCustomChatLoadInProgress extends DeleteCustomChatState {
  @override
  List<Object> get props => [];
}

class DeleteCustomChatLoadSuccess extends DeleteCustomChatState {
  final bool status;

  DeleteCustomChatLoadSuccess(this.status);
  @override
  List<Object> get props => [status];
}

class DeleteCustomChatLoadFail extends DeleteCustomChatState {
  final String failReason;

  DeleteCustomChatLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
