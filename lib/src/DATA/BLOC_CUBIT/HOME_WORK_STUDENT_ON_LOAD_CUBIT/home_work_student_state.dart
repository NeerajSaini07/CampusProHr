part of 'home_work_student_cubit.dart';

abstract class HomeWorkStudentState extends Equatable {
  const HomeWorkStudentState();
}

class HomeworkStudentInitial extends HomeWorkStudentState {
  @override
  List<Object> get props => [];
}

class HomeWorkStudentLoadInProgress extends HomeWorkStudentState {
  @override
  List<Object> get props => [];
}

class HomeWorkStudentLoadSuccess extends HomeWorkStudentState {
  final List<HomeWorkStudentModel> homeWorkList;
  HomeWorkStudentLoadSuccess(this.homeWorkList);
  @override
  List<Object> get props => [homeWorkList];
}

class HomeWorkStudentLoadFail extends HomeWorkStudentState {
  final String failReason;
  HomeWorkStudentLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
