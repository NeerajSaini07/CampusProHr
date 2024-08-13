part of 'get_exam_marks_for_teacher_cubit.dart';

abstract class GetExamMarksForTeacherState extends Equatable {
  const GetExamMarksForTeacherState();
}

class GetExamMarksForTeacherInitial extends GetExamMarksForTeacherState {
  @override
  List<Object> get props => [];
}

class GetExamMarksForTeacherLoadInProgress extends GetExamMarksForTeacherState {
  @override
  List<Object> get props => [];
}

class GetExamMarksForTeacherLoadSuccess extends GetExamMarksForTeacherState {
  final List<GetExamMarksForTeacherModel> examList;
  GetExamMarksForTeacherLoadSuccess(this.examList);
  @override
  List<Object> get props => [examList];
}

class GetExamMarksForTeacherLoadFail extends GetExamMarksForTeacherState {
  final String failReason;
  GetExamMarksForTeacherLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
