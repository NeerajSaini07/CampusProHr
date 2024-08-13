part of 'dashboard_admin_cubit.dart';

abstract class DashboardAdminState extends Equatable {
  const DashboardAdminState();
}

class DashboardAdminInitial extends DashboardAdminState {
  @override
  List<Object> get props => [];
}

class DashboardAdminLoadInProgress extends DashboardAdminState {
  @override
  List<Object> get props => [];
}

class DashboardAdminLoadSuccess extends DashboardAdminState {
  final DashboardAdminModel dashboardData;

  DashboardAdminLoadSuccess(this.dashboardData);
  @override
  List<Object> get props => [dashboardData];
}

class DashboardAdminLoadFail extends DashboardAdminState {
  final String failReason;

  DashboardAdminLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
