part of 'remove_allotted_subject_cubit.dart';

abstract class RemoveAllottedSubjectState extends Equatable {
  const RemoveAllottedSubjectState();
}

class RemoveAllottedSubjectInitial extends RemoveAllottedSubjectState {
  @override
  List<Object> get props => [];
}

class RemoveAllottedSubjectLoadInProgress extends RemoveAllottedSubjectState {
  @override
  List<Object> get props => [];
}

class RemoveAllottedSubjectLoadSuccess extends RemoveAllottedSubjectState {
  final String result;
  RemoveAllottedSubjectLoadSuccess(this.result);
  @override
  List<Object> get props => [result];
}

class RemoveAllottedSubjectLoadFail extends RemoveAllottedSubjectState {
  final String failReason;
  RemoveAllottedSubjectLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
