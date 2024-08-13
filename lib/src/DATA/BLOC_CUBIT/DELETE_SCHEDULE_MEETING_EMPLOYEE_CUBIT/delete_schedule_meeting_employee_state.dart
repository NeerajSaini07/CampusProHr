part of 'delete_schedule_meeting_employee_cubit.dart';

abstract class DeleteScheduleMeetingEmployeeState extends Equatable {
  const DeleteScheduleMeetingEmployeeState();
}

class DeleteScheduleMeetingEmployeeInitial
    extends DeleteScheduleMeetingEmployeeState {
  @override
  List<Object> get props => [];
}

class DeleteScheduleMeetingEmployeeLoadInProgress
    extends DeleteScheduleMeetingEmployeeState {
  @override
  List<Object> get props => [];
}

class DeleteScheduleMeetingEmployeeLoadSuccess
    extends DeleteScheduleMeetingEmployeeState {
  final bool? status;

  DeleteScheduleMeetingEmployeeLoadSuccess(this.status);
  @override
  List<Object> get props => [status!];
}

class DeleteScheduleMeetingEmployeeLoadFail
    extends DeleteScheduleMeetingEmployeeState {
  final String? failReason;

  DeleteScheduleMeetingEmployeeLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason!];
}
