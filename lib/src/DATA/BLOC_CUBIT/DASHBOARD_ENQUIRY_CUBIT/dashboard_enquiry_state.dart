part of 'dashboard_enquiry_cubit.dart';

abstract class DashboardEnquiryState extends Equatable {
  const DashboardEnquiryState();
}

class DashboardEnquiryInitial extends DashboardEnquiryState {
  @override
  List<Object> get props => [];
}

class DashboardEnquiryLoadInProgress extends DashboardEnquiryState {
  @override
  List<Object> get props => [];
}

class DashboardEnquiryLoadSuccess extends DashboardEnquiryState {
  final DashboardEnquiryModel dashboardEnquiryData;

  DashboardEnquiryLoadSuccess(this.dashboardEnquiryData);
  @override
  List<Object> get props => [dashboardEnquiryData];
}

class DashboardEnquiryLoadFail extends DashboardEnquiryState {
  final String failReason;

  DashboardEnquiryLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
