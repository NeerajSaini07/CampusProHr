part of 'tech_process_hash_cubit.dart';

abstract class TechProcessHashState extends Equatable {
  const TechProcessHashState();
}

class TechProcessHashInitial extends TechProcessHashState {
  @override
  List<Object> get props => [];
}

class TechProcessHashLoadInProgress extends TechProcessHashState {
  @override
  List<Object> get props => [];
}

class TechProcessHashLoadSuccess extends TechProcessHashState {
  final List<TechProcessHashModel> techProcessData;

  TechProcessHashLoadSuccess(this.techProcessData);
  @override
  List<Object> get props => [techProcessData];
}

class TechProcessHashLoadFail extends TechProcessHashState {
  final String failReason;

  TechProcessHashLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
