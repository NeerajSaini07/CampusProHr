part of 'mark_visitor_exit_cubit.dart';

abstract class MarkVisitorExitState extends Equatable {
  const MarkVisitorExitState();
}

class MarkVisitorExitInitial extends MarkVisitorExitState {
  @override
  List<Object> get props => [];
}

class MarkVisitorExitLoadInProgress extends MarkVisitorExitState {
  @override
  List<Object> get props => [];
}

class MarkVisitorExitLoadSuccess extends MarkVisitorExitState {
  final String result;
  MarkVisitorExitLoadSuccess(this.result);
  @override
  List<Object> get props => [result];
}

class MarkVisitorExitLoadFail extends MarkVisitorExitState {
  final String failReason;
  MarkVisitorExitLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
