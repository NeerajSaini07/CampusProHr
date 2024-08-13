part of 'sign_in_with_google_cubit.dart';

abstract class SignInWithGoogleState extends Equatable {
  const SignInWithGoogleState();
}

class SignInWithGoogleInitial extends SignInWithGoogleState {
  @override
  List<Object> get props => [];
}

class SignInWithGoogleLoadInProgress extends SignInWithGoogleState {
  @override
  List<Object> get props => [];
}

class SignInWithGoogleLoadSuccess extends SignInWithGoogleState {
  final List<SignInWithGoogleModel> result;
  SignInWithGoogleLoadSuccess(this.result);
  @override
  List<Object> get props => [result];
}

class SignInWithGoogleLoadFail extends SignInWithGoogleState {
  final String failReason;
  SignInWithGoogleLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
