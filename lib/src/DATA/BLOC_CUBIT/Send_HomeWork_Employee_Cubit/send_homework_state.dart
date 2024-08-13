part of 'send_homework_cubit.dart';

abstract class SendHomeworkState extends Equatable {
  const SendHomeworkState();
}

class SendHomeworkInitial extends SendHomeworkState {
  @override
  List<Object> get props => [];
}

class SendHomeworkLoadInProgress extends SendHomeworkState {
  @override
  List<Object?> get props => [];
}

class SendHomeworkLoadSuccess extends SendHomeworkState {
  final String status;
  SendHomeworkLoadSuccess(this.status);

  @override
  List<Object?> get props => [status];
}

class SendHomeworkLoadFail extends SendHomeworkState {
  final String failReason;

  SendHomeworkLoadFail(this.failReason);
  @override
  List<Object?> get props => [failReason];
}
