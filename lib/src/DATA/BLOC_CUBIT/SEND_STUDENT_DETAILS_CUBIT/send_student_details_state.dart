part of 'send_student_details_cubit.dart';

abstract class SendStudentDetailsState extends Equatable {
  const SendStudentDetailsState();
}

class SendStudentDetailsInitial extends SendStudentDetailsState {
  @override
  List<Object> get props => [];
}

class SendStudentDetailsLoadInProgress extends SendStudentDetailsState {
  @override
  List<Object> get props => [];
}

class SendStudentDetailsLoadSuccess extends SendStudentDetailsState {
  final bool status;

  SendStudentDetailsLoadSuccess(this.status);
  @override
  List<Object> get props => [status];
}

class SendStudentDetailsLoadFail extends SendStudentDetailsState {
  final String failReason;

  SendStudentDetailsLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
