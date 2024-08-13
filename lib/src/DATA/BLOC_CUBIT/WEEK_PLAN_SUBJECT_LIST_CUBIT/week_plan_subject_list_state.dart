part of 'week_plan_subject_list_cubit.dart';

abstract class WeekPlanSubjectListState extends Equatable {
  const WeekPlanSubjectListState();
}

class WeekPlanSubjectListInitial extends WeekPlanSubjectListState {
  @override
  List<Object> get props => [];
}

class WeekPlanSubjectListLoadInProgress extends WeekPlanSubjectListState {
  @override
  List<Object> get props => [];
}

class WeekPlanSubjectListLoadSuccess extends WeekPlanSubjectListState {
  final List<WeekPlanSubjectListModel> subjectList;
  WeekPlanSubjectListLoadSuccess(this.subjectList);
  @override
  List<Object> get props => [subjectList];
}

class WeekPlanSubjectListLoadFail extends WeekPlanSubjectListState {
  final String failReason;
  WeekPlanSubjectListLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
