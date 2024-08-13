part of 'get_grade_cubit.dart';

abstract class GetGradeState extends Equatable {
  const GetGradeState();
}

class GetGradeInitial extends GetGradeState {
  @override
  List<Object> get props => [];
}

class GetGradeLoadInProgress extends GetGradeState {
  @override
  List<Object> get props => [];
}

class GetGradeLoadSuccess extends GetGradeState {
  final List<GetGradeModel> gradeList;
  GetGradeLoadSuccess(this.gradeList);
  @override
  List<Object> get props => [gradeList];
}

class GetGradeLoadFail extends GetGradeState {
  final String failReason;
  GetGradeLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
