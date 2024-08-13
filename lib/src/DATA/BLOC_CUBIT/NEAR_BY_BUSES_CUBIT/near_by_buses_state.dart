part of 'near_by_buses_cubit.dart';

abstract class NearByBusesState extends Equatable {
  const NearByBusesState();
}

class NearByBusesInitial extends NearByBusesState {
  @override
  List<Object> get props => [];
}

class NearByBusesLoadInProgress extends NearByBusesState {
  @override
  List<Object> get props => [];
}

class NearByBusesLoadSuccess extends NearByBusesState {
  final List<NearByBusesModel> nearByBusesList;

  NearByBusesLoadSuccess(this.nearByBusesList);
  @override
  List<Object> get props => [nearByBusesList];
}

class NearByBusesLoadFail extends NearByBusesState {
  final String failReason;

  NearByBusesLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
