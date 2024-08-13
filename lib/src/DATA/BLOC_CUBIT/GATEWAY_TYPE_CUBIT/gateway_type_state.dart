part of 'gateway_type_cubit.dart';

abstract class GatewayTypeState extends Equatable {
  const GatewayTypeState();
}

class GatewayTypeInitial extends GatewayTypeState {
  @override
  List<Object> get props => [];
}

class GatewayTypeLoadInProgress extends GatewayTypeState {
  @override
  List<Object> get props => [];
}

class GatewayTypeLoadSuccess extends GatewayTypeState {
  final String gatewayUrl;

  GatewayTypeLoadSuccess(this.gatewayUrl);
  @override
  List<Object> get props => [gatewayUrl];
}

class GatewayTypeLoadFail extends GatewayTypeState {
  final String failReason;

  GatewayTypeLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
