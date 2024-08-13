part of 'subject_list_employee_cubit.dart';

abstract class SubjectListEmployeeState extends Equatable {
  const SubjectListEmployeeState();
}

class SubjectListEmployeeInitial extends SubjectListEmployeeState {
  @override
  List<Object> get props => [];
}

class SubjectListEmployeeLoadInProgress extends SubjectListEmployeeState {
  @override
  List<Object> get props => [];
}

class SubjectListEmployeeLoadSuccess extends SubjectListEmployeeState {
  final List<SubjectListEmployeeModel> subjectList;
  SubjectListEmployeeLoadSuccess(this.subjectList);
  @override
  List<Object> get props => [subjectList];
}

class SubjectListEmployeeLoadFail extends SubjectListEmployeeState {
  final String failReason;
  SubjectListEmployeeLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
