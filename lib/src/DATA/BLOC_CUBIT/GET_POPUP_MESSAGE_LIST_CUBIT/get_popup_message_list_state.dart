part of 'get_popup_message_list_cubit.dart';

abstract class GetPopupMessageListState extends Equatable {
  const GetPopupMessageListState();
}

class GetPopupMessageListInitial extends GetPopupMessageListState {
  @override
  List<Object> get props => [];
}

class GetPopupMessageListLoadInProgress extends GetPopupMessageListState {
  @override
  List<Object> get props => [];
}

class GetPopupMessageListLoadSuccess extends GetPopupMessageListState {
  final List<GetPopupMessageListModel> popupList;
  GetPopupMessageListLoadSuccess(this.popupList);
  @override
  List<Object> get props => [popupList];
}

class GetPopupMessageListLoadFail extends GetPopupMessageListState {
  final String failReason;
  GetPopupMessageListLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
