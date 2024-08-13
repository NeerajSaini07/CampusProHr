part of 'custom_chat_user_list_cubit.dart';

abstract class CustomChatUserListState extends Equatable {
  const CustomChatUserListState();
}

class CustomChatUserListInitial extends CustomChatUserListState {
  @override
  List<Object> get props => [];
}

class CustomChatUserListLoadInProgress extends CustomChatUserListState {
  @override
  List<Object> get props => [];
}

class CustomChatUserListLoadSuccess extends CustomChatUserListState {
  final List<CustomChatUserListModel> customChatUserList;

  CustomChatUserListLoadSuccess(this.customChatUserList);
  @override
  List<Object> get props => [customChatUserList];
}

class CustomChatUserListLoadFail extends CustomChatUserListState {
  final String failReason;

  CustomChatUserListLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
