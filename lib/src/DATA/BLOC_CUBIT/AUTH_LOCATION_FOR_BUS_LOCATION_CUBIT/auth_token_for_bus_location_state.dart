part of 'auth_token_for_bus_location_cubit.dart';

abstract class AuthTokenForBusLocationState extends Equatable {
  const AuthTokenForBusLocationState();
}

class AuthTokenForBusLocationInitial extends AuthTokenForBusLocationState {
  @override
  List<Object> get props => [];
}

class AuthTokenForBusLocationLoadInProgress extends AuthTokenForBusLocationState {
  @override
  List<Object> get props => [];
}

class AuthTokenForBusLocationLoadSuccess extends AuthTokenForBusLocationState {
  final String authToken;

  AuthTokenForBusLocationLoadSuccess(this.authToken);
  @override
  List<Object> get props => [authToken];
}

class AuthTokenForBusLocationLoadFail extends AuthTokenForBusLocationState {
  final String failReason;

  AuthTokenForBusLocationLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
