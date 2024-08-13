part of 'reply_complain_suggestion_admin_cubit.dart';

abstract class ReplyComplainSuggestionAdminState extends Equatable {
  const ReplyComplainSuggestionAdminState();
}

class ReplyComplainSuggestionAdminInitial
    extends ReplyComplainSuggestionAdminState {
  @override
  List<Object> get props => [];
}

class ReplyComplainSuggestionAdminLoadInProgress
    extends ReplyComplainSuggestionAdminState {
  @override
  List<Object> get props => [];
}

class ReplyComplainSuggestionAdminLoadSuccess
    extends ReplyComplainSuggestionAdminState {
  final String response;
  ReplyComplainSuggestionAdminLoadSuccess(this.response);
  @override
  List<Object> get props => [response];
}

class ReplyComplainSuggestionAdminLoadFail
    extends ReplyComplainSuggestionAdminState {
  final String failReason;
  ReplyComplainSuggestionAdminLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
