part of 'update_enquiry_status_cubit.dart';

abstract class UpdateEnquiryStatusState extends Equatable {
  const UpdateEnquiryStatusState();
}

class UpdateEnquiryStatusInitial extends UpdateEnquiryStatusState {
  @override
  List<Object> get props => [];
}

class UpdateEnquiryStatusLoadInProgress extends UpdateEnquiryStatusState {
  @override
  List<Object> get props => [];
}

class UpdateEnquiryStatusLoadSuccess extends UpdateEnquiryStatusState {
  final bool status;

  UpdateEnquiryStatusLoadSuccess(this.status);
  @override
  List<Object> get props => [status];
}

class UpdateEnquiryStatusLoadFail extends UpdateEnquiryStatusState {
  final String failReason;

  UpdateEnquiryStatusLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
