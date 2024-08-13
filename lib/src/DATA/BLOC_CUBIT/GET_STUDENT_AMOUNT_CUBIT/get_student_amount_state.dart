part of 'get_student_amount_cubit.dart';

abstract class GetStudentAmountState extends Equatable {
  const GetStudentAmountState();
}

class GetStudentAmountInitial extends GetStudentAmountState {
  @override
  List<Object> get props => [];
}

class GetStudentAmountLoadInProgress extends GetStudentAmountState {
  @override
  List<Object> get props => [];
}

class GetStudentAmountLoadSuccess extends GetStudentAmountState {
  final String amount;
  GetStudentAmountLoadSuccess(this.amount);
  @override
  List<Object> get props => [amount];
}

class GetStudentAmountLoadFail extends GetStudentAmountState {
  final String failReason;
  GetStudentAmountLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
