part of 'school_bus_detail_cubit.dart';

abstract class SchoolBusDetailState extends Equatable {
  const SchoolBusDetailState();
}

class SchoolBusDetailInitial extends SchoolBusDetailState {
  @override
  List<Object> get props => [];
}

class SchoolBusDetailLoadInProgress extends SchoolBusDetailState {
  @override
  List<Object> get props => [];
}

class SchoolBusDetailLoadSuccess extends SchoolBusDetailState {
  final SchoolBusDetailModel busData;

  SchoolBusDetailLoadSuccess(this.busData);
  @override
  List<Object> get props => [busData];
}

class SchoolBusDetailLoadFail extends SchoolBusDetailState {
  final String failReason;

  SchoolBusDetailLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
