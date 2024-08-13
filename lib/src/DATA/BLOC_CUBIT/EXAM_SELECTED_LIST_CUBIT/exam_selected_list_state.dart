part of 'exam_selected_list_cubit.dart';

abstract class ExamSelectedListState extends Equatable {
  const ExamSelectedListState();
}

class ExamSelectedListInitial extends ExamSelectedListState {
  @override
  List<Object> get props => [];
}

class ExamSelectedListLoadInProgress extends ExamSelectedListState {
  @override
  List<Object> get props => [];
}

class ExamSelectedListLoadSuccess extends ExamSelectedListState {
  final List<ExamSelectedListModel> marksList;

  ExamSelectedListLoadSuccess(this.marksList);
  @override
  List<Object> get props => [marksList];
}

class ExamSelectedListLoadFail extends ExamSelectedListState {
  final String failreason;

  ExamSelectedListLoadFail(this.failreason);
  @override
  List<Object> get props => [failreason];
}
