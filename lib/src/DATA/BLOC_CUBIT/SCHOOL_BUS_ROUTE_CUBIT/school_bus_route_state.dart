part of 'school_bus_route_cubit.dart';

abstract class SchoolBusRouteState extends Equatable {
  const SchoolBusRouteState();
}

class SchoolBusRouteInitial extends SchoolBusRouteState {
  @override
  List<Object> get props => [];
}

class SchoolBusRouteLoadInProgress extends SchoolBusRouteState {
  @override
  List<Object> get props => [];
}

class SchoolBusRouteLoadSuccess extends SchoolBusRouteState {
  final SchoolBusRouteModel busRouteData;

  SchoolBusRouteLoadSuccess(this.busRouteData);
  @override
  List<Object> get props => [busRouteData];
}

class SchoolBusRouteLoadFail extends SchoolBusRouteState {
  final String failReason;

  SchoolBusRouteLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
