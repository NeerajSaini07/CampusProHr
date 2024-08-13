part of 'result_announce_class_cubit.dart';

abstract class ResultAnnounceClassState extends Equatable {
  const ResultAnnounceClassState();
}

class ResultAnnounceClassInitial extends ResultAnnounceClassState {
  @override
  List<Object> get props => [];
}

class ResultAnnounceClassLoadInProgress extends ResultAnnounceClassState {
  @override
  List<Object> get props => [];
}

class ResultAnnounceClassLoadSuccess extends ResultAnnounceClassState {
  final List<ResultAnnounceClassModel> classList;
  ResultAnnounceClassLoadSuccess(this.classList);
  @override
  List<Object> get props => [classList];
}

class ResultAnnounceClassLoadFail extends ResultAnnounceClassState {
  final String failReason;
  ResultAnnounceClassLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
