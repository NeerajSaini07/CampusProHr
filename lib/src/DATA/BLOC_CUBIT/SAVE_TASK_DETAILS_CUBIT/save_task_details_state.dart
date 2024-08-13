part of 'save_task_details_cubit.dart';

abstract class SaveTaskDetailsState extends Equatable {
  const SaveTaskDetailsState();
}

class SaveTaskDetailsInitial extends SaveTaskDetailsState {
  @override
  List<Object> get props => [];
}

class SaveTaskDetailsLoadInProgress extends SaveTaskDetailsState {
  @override
  List<Object> get props => [];
}

class SaveTaskDetailsLoadSuccess extends SaveTaskDetailsState {
  final String result;
  SaveTaskDetailsLoadSuccess(this.result);
  @override
  List<Object> get props => [result];
}

class SaveTaskDetailsLoadFail extends SaveTaskDetailsState {
  final String failReason;
  SaveTaskDetailsLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
