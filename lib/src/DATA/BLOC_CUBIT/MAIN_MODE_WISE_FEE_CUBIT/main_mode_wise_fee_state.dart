part of 'main_mode_wise_fee_cubit.dart';

abstract class MainModeWiseFeeState extends Equatable {
  const MainModeWiseFeeState();
}

class MainModeWiseFeeInitial extends MainModeWiseFeeState {
  @override
  List<Object> get props => [];
}

class MainModeWiseFeeLoadInProgress extends MainModeWiseFeeState {
  @override
  List<Object> get props => [];
}

class MainModeWiseFeeLoadSuccess extends MainModeWiseFeeState {
  final List<MainModeWiseFeeModel> mainModeWiseFee;

  MainModeWiseFeeLoadSuccess(this.mainModeWiseFee);
  @override
  List<Object> get props => [mainModeWiseFee];
}

class MainModeWiseFeeLoadFail extends MainModeWiseFeeState {
  final String failReason;

  MainModeWiseFeeLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
