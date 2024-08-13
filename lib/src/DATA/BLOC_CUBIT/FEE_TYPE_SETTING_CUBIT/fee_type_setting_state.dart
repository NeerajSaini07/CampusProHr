part of 'fee_type_setting_cubit.dart';

abstract class FeeTypeSettingState extends Equatable {
  const FeeTypeSettingState();
}

class FeeTypeSettingInitial extends FeeTypeSettingState {
  @override
  List<Object> get props => [];
}

class FeeTypeSettingLoadInProgress extends FeeTypeSettingState {
  @override
  List<Object> get props => [];
}

class FeeTypeSettingLoadSuccess extends FeeTypeSettingState {
  final String feeTypeSettings;

  FeeTypeSettingLoadSuccess(this.feeTypeSettings);
  @override
  List<Object> get props => [feeTypeSettings];
}

class FeeTypeSettingLoadFail extends FeeTypeSettingState {
  final String failReason;

  FeeTypeSettingLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
