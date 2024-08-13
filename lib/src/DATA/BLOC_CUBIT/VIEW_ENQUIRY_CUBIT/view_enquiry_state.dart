part of 'view_enquiry_cubit.dart';

abstract class ViewEnquiryState extends Equatable {
  const ViewEnquiryState();
}

class ViewEnquiryInitial extends ViewEnquiryState {
  @override
  List<Object> get props => [];
}

class ViewEnquiryLoadInProgress extends ViewEnquiryState {
  @override
  List<Object> get props => [];
}

class ViewEnquiryLoadSuccess extends ViewEnquiryState {
  final List<ViewEnquiryModel> viewEnquirylist;

  ViewEnquiryLoadSuccess(this.viewEnquirylist);

  @override
  List<Object> get props => [viewEnquirylist];
}

class ViewEnquiryLoadFail extends ViewEnquiryState {
  final String failReason;

  ViewEnquiryLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
