part of 'terms_conditions_setting_cubit.dart';

abstract class TermsConditionsSettingState extends Equatable {
  const TermsConditionsSettingState();
}

class TermsConditionsSettingInitial extends TermsConditionsSettingState {
  @override
  List<Object> get props => [];
}

class TermsConditionsSettingLoadInProgress extends TermsConditionsSettingState {
  @override
  List<Object> get props => [];
}

class TermsConditionsSettingLoadSuccess extends TermsConditionsSettingState {
  final String setting;

  TermsConditionsSettingLoadSuccess(this.setting);
  @override
  List<Object> get props => [setting];
}

class TermsConditionsSettingLoadFail extends TermsConditionsSettingState {
  final String failReason;

  TermsConditionsSettingLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
