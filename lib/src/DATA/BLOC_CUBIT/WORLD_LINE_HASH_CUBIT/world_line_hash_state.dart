part of 'world_line_hash_cubit.dart';

abstract class WorldLineHashState extends Equatable {
  const WorldLineHashState();
}

class WorldLineHashInitial extends WorldLineHashState {
  @override
  List<Object> get props => [];
}

class WorldLineHashLoadInProgress extends WorldLineHashState {
  @override
  List<Object> get props => [];
}

class WorldLineHashLoadSuccess extends WorldLineHashState {
  final List<WorldLineHashModel> worldLineData;

  WorldLineHashLoadSuccess(this.worldLineData);
  @override
  List<Object> get props => [worldLineData];
}

class WorldLineHashLoadFail extends WorldLineHashState {
  final String failReason;

  WorldLineHashLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
