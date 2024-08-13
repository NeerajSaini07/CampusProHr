part of 'student_fee_receipt_cubit.dart';

abstract class StudentFeeReceiptState extends Equatable {
  const StudentFeeReceiptState();
}

class StudentFeeReceiptInitial extends StudentFeeReceiptState {
  @override
  List<Object> get props => [];
}

class StudentFeeReceiptLoadInProgress extends StudentFeeReceiptState {
  @override
  List<Object> get props => [];
}

class StudentFeeReceiptLoadSuccess extends StudentFeeReceiptState {
  final List<StudentFeeReceiptModel> feeDetails;

  StudentFeeReceiptLoadSuccess(this.feeDetails);
  @override
  List<Object> get props => [feeDetails];
}

class StudentFeeReceiptLoadFail extends StudentFeeReceiptState {
  final String failReason;

  StudentFeeReceiptLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
