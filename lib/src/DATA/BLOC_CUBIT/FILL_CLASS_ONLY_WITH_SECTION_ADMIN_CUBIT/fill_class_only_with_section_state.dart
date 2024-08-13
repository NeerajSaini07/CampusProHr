part of 'fill_class_only_with_section_cubit.dart';

abstract class FillClassOnlyWithSectionState extends Equatable {
  const FillClassOnlyWithSectionState();
}

class FillClassOnlyWithSectionInitial extends FillClassOnlyWithSectionState {
  @override
  List<Object> get props => [];
}

class FillClassOnlyWithSectionLoadInProgress
    extends FillClassOnlyWithSectionState {
  @override
  List<Object> get props => [];
}

class FillClassOnlyWithSectionLoadSuccess
    extends FillClassOnlyWithSectionState {
  final List<FillClassOnlyWithSectionAdminModel> classList;
  FillClassOnlyWithSectionLoadSuccess(this.classList);
  @override
  List<Object> get props => [classList];
}

class FillClassOnlyWithSectionLoadFail extends FillClassOnlyWithSectionState {
  final String failReason;
  FillClassOnlyWithSectionLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
