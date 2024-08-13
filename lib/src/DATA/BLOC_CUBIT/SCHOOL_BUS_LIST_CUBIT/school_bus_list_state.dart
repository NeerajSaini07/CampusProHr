part of 'school_bus_list_cubit.dart';

abstract class SchoolBusListState extends Equatable {
  const SchoolBusListState();
}

class SchoolBusListInitial extends SchoolBusListState {
  @override
  List<Object> get props => [];
}

class SchoolBusListLoadInProgress extends SchoolBusListState {
  @override
  List<Object> get props => [];
}

class SchoolBusListLoadSuccess extends SchoolBusListState {
  final List<SchoolBusListModel> busData;

  SchoolBusListLoadSuccess(this.busData);
  @override
  List<Object> get props => [busData];
}

class SchoolBusListLoadFail extends SchoolBusListState {
  final String failReason;

  SchoolBusListLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
