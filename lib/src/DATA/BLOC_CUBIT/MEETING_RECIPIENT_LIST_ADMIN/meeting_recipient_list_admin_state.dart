part of 'meeting_recipient_list_admin_cubit.dart';

abstract class MeetingRecipientListAdminState extends Equatable {
  const MeetingRecipientListAdminState();
}

class MeetingRecipientListAdminInitial extends MeetingRecipientListAdminState {
  @override
  List<Object> get props => [];
}

class MeetingRecipientListAdminLoadInProgress
    extends MeetingRecipientListAdminState {
  @override
  List<Object> get props => [];
}

class MeetingRecipientListAdminLoadSuccess
    extends MeetingRecipientListAdminState {
  final List<MeetingRecipientListAdminModel> recipientList;

  MeetingRecipientListAdminLoadSuccess(this.recipientList);
  @override
  List<Object> get props => [recipientList];
}

class MeetingRecipientListAdminLoadFail extends MeetingRecipientListAdminState {
  final String failReason;

  MeetingRecipientListAdminLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
