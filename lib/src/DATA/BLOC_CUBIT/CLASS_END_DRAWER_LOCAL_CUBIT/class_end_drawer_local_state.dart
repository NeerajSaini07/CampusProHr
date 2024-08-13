part of 'class_end_drawer_local_cubit.dart';

abstract class ClassEndDrawerLocalState extends Equatable {
  const ClassEndDrawerLocalState();
}

class ClassEndDrawerLocalInitial extends ClassEndDrawerLocalState {
  @override
  List<Object> get props => [];
}

class ClassEndDrawerLocalLoadInProgress extends ClassEndDrawerLocalState {
  @override
  List<Object> get props => [];
}

class ClassEndDrawerLocalLoadSuccess extends ClassEndDrawerLocalState {
  final TeachersListModel teacherSelect;

  ClassEndDrawerLocalLoadSuccess(this.teacherSelect);
  @override
  List<Object> get props => [];
}
