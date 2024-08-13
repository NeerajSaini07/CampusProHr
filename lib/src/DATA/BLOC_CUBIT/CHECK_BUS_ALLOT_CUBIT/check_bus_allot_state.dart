part of 'check_bus_allot_cubit.dart';

abstract class CheckBusAllotState extends Equatable {
  const CheckBusAllotState();
}

class CheckBusAllotInitial extends CheckBusAllotState {
  @override
  List<Object> get props => [];
}

class CheckBusAllotLoadInProgress extends CheckBusAllotState {
  @override
  List<Object> get props => [];
}

class CheckBusAllotLoadSuccess extends CheckBusAllotState {
  final String result;
  CheckBusAllotLoadSuccess(this.result);
  @override
  List<Object> get props => [result];
}

class CheckBusAllotLoadFail extends CheckBusAllotState {
  final String failReason;
  CheckBusAllotLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
