part of 'remark_for_students_list_cubit.dart';

abstract class RemarkForStudentsListState extends Equatable {
  const RemarkForStudentsListState();
}

class RemarkForStudentsListInitial extends RemarkForStudentsListState {
  @override
  List<Object> get props => [];
}

class RemarkForStudentsListLoadInProgress extends RemarkForStudentsListState {
  @override
  List<Object> get props => [];
}

class RemarkForStudentsListLoadSuccess extends RemarkForStudentsListState {
  final List<RemarkForStudentListModel> remarksList;

  RemarkForStudentsListLoadSuccess(this.remarksList);
  @override
  List<Object> get props => [remarksList];
}

class RemarkForStudentsListLoadFail extends RemarkForStudentsListState {
  final String failReason;

  RemarkForStudentsListLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
