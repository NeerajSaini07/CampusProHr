part of 'open_marksheet_cubit.dart';

abstract class OpenMarksheetState extends Equatable {
  const OpenMarksheetState();
}

class OpenMarksheetInitial extends OpenMarksheetState {
  @override
  List<Object> get props => [];
}

class OpenMarksheetLoadInProgress extends OpenMarksheetState {
  @override
  List<Object> get props => [];
}

class OpenMarksheetLoadSuccess extends OpenMarksheetState {
  final String marksheetURL;

  OpenMarksheetLoadSuccess(this.marksheetURL);
  @override
  List<Object> get props => [marksheetURL];
}

class OpenMarksheetLoadFail extends OpenMarksheetState {
  final String failReason;

  OpenMarksheetLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
