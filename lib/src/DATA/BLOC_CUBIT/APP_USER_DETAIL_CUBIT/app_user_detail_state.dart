part of 'app_user_detail_cubit.dart';

abstract class AppUserDetailState extends Equatable {
  const AppUserDetailState();
}

class AppUserDetailInitial extends AppUserDetailState {
  @override
  List<Object> get props => [];
}

class AppUserDetailLoadInProgress extends AppUserDetailState {
  @override
  List<Object> get props => [];
}

class AppUserDetailLoadSuccess extends AppUserDetailState {
  final List<AppUserDetailModel> appUserDetail;

  AppUserDetailLoadSuccess(this.appUserDetail);
  @override
  List<Object> get props => [appUserDetail];
}

class AppUserDetailLoadFail extends AppUserDetailState {
  final String failReason;

  AppUserDetailLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
