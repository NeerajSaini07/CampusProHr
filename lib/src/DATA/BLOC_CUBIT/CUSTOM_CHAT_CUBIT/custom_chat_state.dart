part of 'custom_chat_cubit.dart';

abstract class CustomChatState extends Equatable {
  const CustomChatState();
}

class CustomChatInitial extends CustomChatState {
  @override
  List<Object> get props => [];
}

class CustomChatLoadInProgress extends CustomChatState {
  @override
  List<Object> get props => [];
}

class CustomChatLoadSuccess extends CustomChatState {
  final List<CustomChatModel> customChatList;

  CustomChatLoadSuccess(this.customChatList);
  @override
  List<Object> get props => [customChatList];
}

class CustomChatLoadFail extends CustomChatState {
  final String failReason;

  CustomChatLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
