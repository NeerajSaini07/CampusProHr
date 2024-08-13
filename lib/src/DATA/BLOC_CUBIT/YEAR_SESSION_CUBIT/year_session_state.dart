part of 'year_session_cubit.dart';

abstract class YearSessionState extends Equatable {
  const YearSessionState();
}

class YearSessionInitial extends YearSessionState {
  @override
  List<Object> get props => [];
}

class YearSessionLoadInProgress extends YearSessionState {
  @override
  List<Object> get props => [];
}

class YearSessionLoadSuccess extends YearSessionState {
  final List<YearSessionModel> yearSessionList;
  YearSessionLoadSuccess(this.yearSessionList);
  @override
  List<Object> get props => [yearSessionList];
}

class YearSessionLoadFail extends YearSessionState {
  final String failReason;
  YearSessionLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
