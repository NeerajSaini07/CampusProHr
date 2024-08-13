part of 'exam_test_result_student_cubit.dart';

abstract class ExamTestResultStudentState extends Equatable {
  const ExamTestResultStudentState();
}

class ExamTestResultStudentInitial extends ExamTestResultStudentState {
  @override
  List<Object> get props => [];
}

class ExamTestResultStudentLoadInProgress extends ExamTestResultStudentState {
  @override
  List<Object> get props => [];
}

class ExamTestResultStudentLoadSuccess extends ExamTestResultStudentState {
  final List<ExamTestResultStudentModel> resultList;

  ExamTestResultStudentLoadSuccess(this.resultList);
  @override
  List<Object> get props => [resultList];
}

class ExamTestResultStudentLoadFail extends ExamTestResultStudentState {
  final String failReason;

  ExamTestResultStudentLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
