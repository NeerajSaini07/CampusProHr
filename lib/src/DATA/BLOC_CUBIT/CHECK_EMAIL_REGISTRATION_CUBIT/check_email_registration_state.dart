part of 'check_email_registration_cubit.dart';

abstract class CheckEmailRegistrationState extends Equatable {
  const CheckEmailRegistrationState();
}

class CheckEmailRegistrationInitial extends CheckEmailRegistrationState {
  @override
  List<Object> get props => [];
}

class CheckEmailRegistrationLoadSuccess extends CheckEmailRegistrationState {
  final CheckEmailRegistrationModel emailData;

  CheckEmailRegistrationLoadSuccess(this.emailData);
  @override
  List<Object> get props => [emailData];
}

class CheckEmailRegistrationLoadInProgress extends CheckEmailRegistrationState {
  @override
  List<Object> get props => [];
}

class CheckEmailRegistrationLoadFail extends CheckEmailRegistrationState {
  final String failReason;

  CheckEmailRegistrationLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
