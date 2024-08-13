part of 'load_last_emp_no_cubit.dart';

abstract class LoadLastEmpNoState extends Equatable {
  const LoadLastEmpNoState();
}

class LoadLastEmpNoInitial extends LoadLastEmpNoState {
  @override
  List<Object> get props => [];
}

class LoadLastEmpNoLoadInProgress extends LoadLastEmpNoState {
  @override
  List<Object> get props => [];
}

class LoadLastEmpNoLoadSuccess extends LoadLastEmpNoState {
  final String result;
  LoadLastEmpNoLoadSuccess(this.result);
  @override
  List<Object> get props => [result];
}

class LoadLastEmpNoLoadFail extends LoadLastEmpNoState {
  final String failReason;
  LoadLastEmpNoLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
