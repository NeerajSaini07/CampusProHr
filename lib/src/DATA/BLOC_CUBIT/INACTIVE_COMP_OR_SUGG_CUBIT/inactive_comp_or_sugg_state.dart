part of 'inactive_comp_or_sugg_cubit.dart';

abstract class InactiveCompOrSuggState extends Equatable {
  const InactiveCompOrSuggState();
}

class InactiveCompOrSuggInitial extends InactiveCompOrSuggState {
  @override
  List<Object> get props => [];
}

class InactiveCompOrSuggLoadInProgress extends InactiveCompOrSuggState {
  @override
  List<Object> get props => [];
}

class InactiveCompOrSuggLoadSuccess extends InactiveCompOrSuggState {
  final String result;
  InactiveCompOrSuggLoadSuccess(this.result);
  @override
  List<Object> get props => [result];
}

class InactiveCompOrSuggLoadFail extends InactiveCompOrSuggState {
  final String failReason;
  InactiveCompOrSuggLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
