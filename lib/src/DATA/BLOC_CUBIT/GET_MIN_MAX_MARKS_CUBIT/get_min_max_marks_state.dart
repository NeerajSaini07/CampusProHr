part of 'get_min_max_marks_cubit.dart';

abstract class GetMinMaxMarksState extends Equatable {
  const GetMinMaxMarksState();
}

class GetMinMaxMarksInitial extends GetMinMaxMarksState {
  @override
  List<Object> get props => [];
}

class GetMinMaxMarksLoadInProgress extends GetMinMaxMarksState {
  @override
  List<Object> get props => [];
}

class GetMinMaxMarksLoadSuccess extends GetMinMaxMarksState {
  final List<GetMinMaxmarksModel> marksList;
  GetMinMaxMarksLoadSuccess(this.marksList);
  @override
  List<Object> get props => [marksList];
}

class GetMinMaxMarksLoadFail extends GetMinMaxMarksState {
  final String failReason;
  GetMinMaxMarksLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
