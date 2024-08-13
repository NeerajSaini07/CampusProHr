part of 'app_config_setting_cubit.dart';

abstract class AppConfigSettingState extends Equatable {
  const AppConfigSettingState();
}

class AppConfigSettingInitial extends AppConfigSettingState {
  @override
  List<Object> get props => [];
}

class AppConfigSettingLoadInProgress extends AppConfigSettingState {
  @override
  List<Object> get props => [];
}

class AppConfigSettingLoadSuccess extends AppConfigSettingState {
  final AppConfigSettingModel appConfig;

  AppConfigSettingLoadSuccess(this.appConfig);
  @override
  List<Object> get props => [appConfig];
}

class AppConfigSettingLoadFail extends AppConfigSettingState {
  final String failReason;

  AppConfigSettingLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
