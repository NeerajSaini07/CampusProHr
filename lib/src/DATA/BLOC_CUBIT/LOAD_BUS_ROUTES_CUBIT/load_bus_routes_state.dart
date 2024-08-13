part of 'load_bus_routes_cubit.dart';

abstract class LoadBusRoutesState extends Equatable {
  const LoadBusRoutesState();
}

class LoadBusRoutesInitial extends LoadBusRoutesState {
  @override
  List<Object> get props => [];
}

class LoadBusRoutesLoadInProgress extends LoadBusRoutesState {
  @override
  List<Object> get props => [];
}

class LoadBusRoutesLoadSuccess extends LoadBusRoutesState {
  final List<LoadBusRoutesModel> busRoutes;
  LoadBusRoutesLoadSuccess(this.busRoutes);
  @override
  List<Object> get props => [busRoutes];
}

class LoadBusRoutesLoadFail extends LoadBusRoutesState {
  final String failReason;
  LoadBusRoutesLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
