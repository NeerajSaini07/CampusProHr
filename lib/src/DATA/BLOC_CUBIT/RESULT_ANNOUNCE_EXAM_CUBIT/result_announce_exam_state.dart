part of 'result_announce_exam_cubit.dart';

abstract class ResultAnnounceExamState extends Equatable {
  const ResultAnnounceExamState();
}

class ResultAnnounceExamInitial extends ResultAnnounceExamState {
  @override
  List<Object> get props => [];
}

class ResultAnnounceExamLoadInProgress extends ResultAnnounceExamState {
  @override
  List<Object> get props => [];
}

class ResultAnnounceExamLoadSuccess extends ResultAnnounceExamState {
  final List<ResultAnnounceExamModel> examList;
  ResultAnnounceExamLoadSuccess(this.examList);
  @override
  List<Object> get props => [examList];
}

class ResultAnnounceExamLoadFail extends ResultAnnounceExamState {
  final String failReason;
  ResultAnnounceExamLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
