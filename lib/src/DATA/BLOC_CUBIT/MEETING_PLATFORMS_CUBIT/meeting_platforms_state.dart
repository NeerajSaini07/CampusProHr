part of 'meeting_platforms_cubit.dart';

abstract class MeetingPlatformsState extends Equatable {
  const MeetingPlatformsState();
}

class MeetingPlatformsInitial extends MeetingPlatformsState {
  @override
  List<Object> get props => [];
}

class MeetingPlatformsLoadInProgress extends MeetingPlatformsState {
  @override
  List<Object> get props => [];
}

class MeetingPlatformsLoadSuccess extends MeetingPlatformsState {
  final List<MeetingPlatformsModel> platformList;

  MeetingPlatformsLoadSuccess(this.platformList);
  @override
  List<Object> get props => [platformList];
}

class MeetingPlatformsLoadFail extends MeetingPlatformsState {
  final String? failReason;

  MeetingPlatformsLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason!];
}
