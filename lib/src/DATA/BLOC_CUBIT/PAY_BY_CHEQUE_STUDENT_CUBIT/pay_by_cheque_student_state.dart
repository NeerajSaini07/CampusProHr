part of 'pay_by_cheque_student_cubit.dart';

abstract class PayByChequeStudentState extends Equatable {
  const PayByChequeStudentState();
}

class PayByChequeStudentInitial extends PayByChequeStudentState {
  @override
  List<Object> get props => [];
}

class PayByChequeStudentLoadInProgress extends PayByChequeStudentState {
  @override
  List<Object> get props => [];
}

class PayByChequeStudentLoadSuccess extends PayByChequeStudentState {
  final bool status;

  PayByChequeStudentLoadSuccess(this.status);
  @override
  List<Object> get props => [status];
}

class PayByChequeStudentLoadFail extends PayByChequeStudentState {
  final String failReason;

  PayByChequeStudentLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
