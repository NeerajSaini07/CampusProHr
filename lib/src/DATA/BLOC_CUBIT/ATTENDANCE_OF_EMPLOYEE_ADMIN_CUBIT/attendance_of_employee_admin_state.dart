part of 'attendance_of_employee_admin_cubit.dart';

abstract class AttendanceOfEmployeeAdminState extends Equatable {
  const AttendanceOfEmployeeAdminState();
}

class AttendanceOfEmployeeAdminInitial extends AttendanceOfEmployeeAdminState {
  @override
  List<Object> get props => [];
}

class AttendanceOfEmployeeAdminLoadInProgress
    extends AttendanceOfEmployeeAdminState {
  @override
  List<Object?> get props => [];
}

class AttendanceOfEmployeeAdminLoadSuccess
    extends AttendanceOfEmployeeAdminState {
  final List<AttendanceOfEmployeeAdminModel> AttendanceList;
  AttendanceOfEmployeeAdminLoadSuccess(this.AttendanceList);
  @override
  List<Object?> get props => [AttendanceList];
}

class AttendanceOfEmployeeAdminLoadFail extends AttendanceOfEmployeeAdminState {
  final String failReason;
  AttendanceOfEmployeeAdminLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
