part of 'get_complain_suggestion_list_admin_cubit.dart';

abstract class GetComplainSuggestionListAdminState extends Equatable {
  const GetComplainSuggestionListAdminState();
}

class GetComplainSuggestionListAdminInitial
    extends GetComplainSuggestionListAdminState {
  @override
  List<Object> get props => [];
}

class GetComplainSuggestionListAdminLoadInProgress
    extends GetComplainSuggestionListAdminState {
  @override
  List<Object> get props => [];
}

class GetComplainSuggestionListAdminLoadSuccess
    extends GetComplainSuggestionListAdminState {
  final List<GetComplainSuggestionListAdminModel> suggestionList;
  GetComplainSuggestionListAdminLoadSuccess(this.suggestionList);
  @override
  List<Object> get props => [suggestionList];
}

class GetComplainSuggestionListAdminLoadFail
    extends GetComplainSuggestionListAdminState {
  final String failReason;
  GetComplainSuggestionListAdminLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
