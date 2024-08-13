part of 'header_token_cubit.dart';

abstract class HeaderTokenState extends Equatable {
  const HeaderTokenState();
}

class HeaderTokenInitial extends HeaderTokenState {
  @override
  List<Object> get props => [];
}

class HeaderTokenLoadInProgress extends HeaderTokenState {
  @override
  List<Object> get props => [];
}

class HeaderTokenLoadSuccess extends HeaderTokenState {
  final String headerToken;

  HeaderTokenLoadSuccess(this.headerToken);
  @override
  List<Object> get props => [headerToken];
}

class HeaderTokenLoadFail extends HeaderTokenState {
  final String failReason;
  HeaderTokenLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
