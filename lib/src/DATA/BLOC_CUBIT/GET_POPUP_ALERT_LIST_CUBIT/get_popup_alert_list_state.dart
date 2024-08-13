part of 'get_popup_alert_list_cubit.dart';

abstract class GetPopupAlertListState extends Equatable {
  const GetPopupAlertListState();
}

class GetPopupAlertListInitial extends GetPopupAlertListState {
  @override
  List<Object> get props => [];
}

class GetPopupAlertListLoadInProgress extends GetPopupAlertListState {
  @override
  List<Object> get props => [];
}

class GetPopupAlertListLoadSuccess extends GetPopupAlertListState {
  final List<GetPopupAlertListModel> popupList;
  GetPopupAlertListLoadSuccess(this.popupList);
  @override
  List<Object> get props => [popupList];
}

class GetPopupAlertListLoadFail extends GetPopupAlertListState {
  final String failReason;
  GetPopupAlertListLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
