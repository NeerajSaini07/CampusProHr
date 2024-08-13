part of 'app_user_list_cubit.dart';

abstract class AppUserListState extends Equatable {
  const AppUserListState();
}

class AppUserListInitial extends AppUserListState {
  @override
  List<Object> get props => [];
}

class AppUserListLoadInProgress extends AppUserListState {
  @override
  List<Object> get props => [];
}

class AppUserListLoadSuccess extends AppUserListState {
  final List<AppUserListModel> appUserList;

  AppUserListLoadSuccess(this.appUserList);
  @override
  List<Object> get props => [appUserList];
}

class AppUserListLoadFail extends AppUserListState {
  final String failReason;

  AppUserListLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
