part of 'restriction_page_cubit.dart';

abstract class RestrictionPageState extends Equatable {
  const RestrictionPageState();
}

class RestrictionPageInitial extends RestrictionPageState {
  @override
  List<Object> get props => [];
}

class RestrictionPageLoadInProgress extends RestrictionPageState {
  @override
  List<Object> get props => [];
}

class RestrictionPageLoadSuccess extends RestrictionPageState {
  final List<RestrictionPageModel> restrictionList;

  RestrictionPageLoadSuccess(this.restrictionList);
  @override
  List<Object> get props => [restrictionList];
}

class RestrictionPageLoadFail extends RestrictionPageState {
  final String failReason;

  RestrictionPageLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
