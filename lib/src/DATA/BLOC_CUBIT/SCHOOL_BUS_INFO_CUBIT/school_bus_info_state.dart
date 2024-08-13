part of 'school_bus_info_cubit.dart';

abstract class SchoolBusInfoState extends Equatable {
  const SchoolBusInfoState();
}

class SchoolBusInfoInitial extends SchoolBusInfoState {
  @override
  List<Object> get props => [];
}

class SchoolBusInfoLoadInProgress extends SchoolBusInfoState {
  @override
  List<Object> get props => [];
}

class SchoolBusInfoLoadSuccess extends SchoolBusInfoState {
  final SchoolBusInfoModel busData;

  SchoolBusInfoLoadSuccess(this.busData);
  @override
  List<Object> get props => [busData];
}

class SchoolBusInfoLoadFail extends SchoolBusInfoState {
  final String failReason;

  SchoolBusInfoLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}