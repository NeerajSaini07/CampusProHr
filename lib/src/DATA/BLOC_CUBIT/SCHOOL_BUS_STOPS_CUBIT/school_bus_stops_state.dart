part of 'school_bus_stops_cubit.dart';

abstract class SchoolBusStopsState extends Equatable {
  const SchoolBusStopsState();
}

class SchoolBusStopsInitial extends SchoolBusStopsState {
  @override
  List<Object> get props => [];
}

class SchoolBusStopsLoadInProgress extends SchoolBusStopsState {
  @override
  List<Object> get props => [];
}

class SchoolBusStopsLoadSuccess extends SchoolBusStopsState {
  final List<SchoolBusStopsModel> busData;

  SchoolBusStopsLoadSuccess(this.busData);
  @override
  List<Object> get props => [busData];
}

class SchoolBusStopsLoadFail extends SchoolBusStopsState {
  final String failReason;

  SchoolBusStopsLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}