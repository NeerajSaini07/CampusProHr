part of 'day_closing_data_cubit.dart';

abstract class DayClosingDataState extends Equatable {
  const DayClosingDataState();
}

class DayClosingDataInitial extends DayClosingDataState {
  @override
  List<Object> get props => [];
}

class DayClosingDataLoadInProgress extends DayClosingDataState {
  @override
  List<Object> get props => [];
}

class DayClosingDataLoadSuccess extends DayClosingDataState {
  final DayClosingDataModel dayClosingData;

  DayClosingDataLoadSuccess(this.dayClosingData);
  @override
  List<Object> get props => [dayClosingData];
}

class DayClosingDataLoadFail extends DayClosingDataState {
  final String failReason;

  DayClosingDataLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
