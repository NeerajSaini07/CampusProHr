part of 'activity_for_student_cubit.dart';

abstract class ActivityForStudentState extends Equatable {
  const ActivityForStudentState();
}

class ActivityForStudentInitial extends ActivityForStudentState {
  @override
  List<Object> get props => [];
}

class ActivityForStudentLoadInProgress extends ActivityForStudentState {
  @override
  List<Object> get props => [];
}

class ActivityForStudentLoadSuccess extends ActivityForStudentState {
  final List<ActivityForStudentModel> activityList;
  ActivityForStudentLoadSuccess(this.activityList);
  @override
  List<Object> get props => [activityList];
}

class ActivityForStudentLoadFail extends ActivityForStudentState {
  final String failReason;
  ActivityForStudentLoadFail(this.failReason);

  @override
  List<Object> get props => [failReason];
}
