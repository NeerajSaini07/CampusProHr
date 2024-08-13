part of 'account_type_cubit.dart';

abstract class AccountTypeState extends Equatable {
  const AccountTypeState();
}

class AccountTypeInitial extends AccountTypeState {
  @override
  List<Object> get props => [];
}

class AccountTypeLoadInProgress extends AccountTypeState {
  @override
  List<Object> get props => [];
}

class AccountTypeLoadSuccess extends AccountTypeState {
  final List<AccountType> userTypeList;

  AccountTypeLoadSuccess(this.userTypeList);
  @override
  List<Object> get props => [userTypeList];
}

class AccountTypeLoadFail extends AccountTypeState {
  final String failReason;
  AccountTypeLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
