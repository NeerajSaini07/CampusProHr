part of 'online_meetings_cubit.dart';

abstract class OnlineMeetingsState extends Equatable {
  const OnlineMeetingsState();
}

class OnlineMeetingsInitial extends OnlineMeetingsState {
  @override
  List<Object> get props => [];
}

class OnlineMeetingsLoadInProgress extends OnlineMeetingsState {
  @override
  List<Object> get props => [];
}

class OnlineMeetingsLoadSuccess extends OnlineMeetingsState {
  final List<OnlineMeetingsModel> onlineMeetingData;

  OnlineMeetingsLoadSuccess(this.onlineMeetingData);
  @override
  List<Object> get props => [onlineMeetingData];
}

class OnlineMeetingsLoadFail extends OnlineMeetingsState {
  final String failReason;

  OnlineMeetingsLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
