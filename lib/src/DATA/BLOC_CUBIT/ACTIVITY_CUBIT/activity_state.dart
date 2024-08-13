part of 'activity_cubit.dart';

abstract class ActivityState extends Equatable {
  const ActivityState();
}

class ActivityInitial extends ActivityState {
  @override
  List<Object> get props => [];
}

class ActivityLoadInProgress extends ActivityState {
  @override
  List<Object> get props => [];
}

class ActivityLoadSuccess extends ActivityState {
  final List<ActivityModel> activityList;

  ActivityLoadSuccess(this.activityList);
  @override
  List<Object> get props => [activityList];
}

class ActivityLoadFail extends ActivityState {
  final String failReason;

  ActivityLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
