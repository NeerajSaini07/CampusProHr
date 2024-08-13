part of 'air_pay_hash_cubit.dart';

abstract class AirPayHashState extends Equatable {
  const AirPayHashState();
}

class AirPayHashInitial extends AirPayHashState {
  @override
  List<Object> get props => [];
}

class AirPayHashLoadInProgress extends AirPayHashState {
  @override
  List<Object> get props => [];
}

class AirPayHashLoadSuccess extends AirPayHashState {
  final List<AirPayHashModel> airPayData;

  AirPayHashLoadSuccess(this.airPayData);
  @override
  List<Object> get props => [airPayData];
}

class AirPayHashLoadFail extends AirPayHashState {
  final String failReason;

  AirPayHashLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
