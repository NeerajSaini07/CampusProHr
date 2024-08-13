part of 'staff_meetings_employee_dashboard_cubit.dart';

abstract class StaffMeetingsEmployeeDashboardState extends Equatable {
  const StaffMeetingsEmployeeDashboardState();
}

class StaffMeetingsEmployeeDashboardInitial
    extends StaffMeetingsEmployeeDashboardState {
  @override
  List<Object> get props => [];
}

class StaffMeetingsEmployeeDashboardLoadInProgress
    extends StaffMeetingsEmployeeDashboardState {
  @override
  List<Object> get props => [];
}

class StaffMeetingsEmployeeDashboardLoadSuccess
    extends StaffMeetingsEmployeeDashboardState {
  final List<StaffMeetingsEmployeeDashboardModel> staffMeetingsList;

  StaffMeetingsEmployeeDashboardLoadSuccess(this.staffMeetingsList);
  @override
  List<Object> get props => [staffMeetingsList];
}

class StaffMeetingsEmployeeDashboardLoadFail
    extends StaffMeetingsEmployeeDashboardState {
  final String failReason;

  StaffMeetingsEmployeeDashboardLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
