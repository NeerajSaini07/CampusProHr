part of 'current_user_email_for_zoom_cubit.dart';

abstract class CurrentUserEmailForZoomState extends Equatable {
  const CurrentUserEmailForZoomState();
}

class CurrentUserEmailForZoomInitial extends CurrentUserEmailForZoomState {
  @override
  List<Object> get props => [];
}

class CurrentUserEmailForZoomLoadInProgress extends CurrentUserEmailForZoomState {
  @override
  List<Object> get props => [];
}

class CurrentUserEmailForZoomLoadSuccess extends CurrentUserEmailForZoomState {
  final List<CurrentUserEmailForZoomModel> emailData;

  CurrentUserEmailForZoomLoadSuccess(this.emailData);
  @override
  List<Object> get props => [emailData];
}

class CurrentUserEmailForZoomLoadFail extends CurrentUserEmailForZoomState {
  final String failReason;

  CurrentUserEmailForZoomLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
