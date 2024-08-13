part of 'class_list_cubit.dart';

abstract class ClassListState extends Equatable {
  const ClassListState();
  @override
  List<Object> get props => [];
}

class ClassListInitial extends ClassListState {
  @override
  List<Object> get props => [];
}

class ClassListLoadInProgress extends ClassListState {
  @override
  List<Object> get props => [];
}

class ClassListLoadSuccess extends ClassListState {
  final List<ClassListModel> classList;
  ClassListLoadSuccess(this.classList);
  @override
  List<Object> get props => [classList];
}

class ClassListLoadFail extends ClassListState {
  final String failReason;
  ClassListLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
