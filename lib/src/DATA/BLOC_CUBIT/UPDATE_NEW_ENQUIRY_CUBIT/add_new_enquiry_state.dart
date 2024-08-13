part of 'add_new_enquiry_cubit.dart';

abstract class AddNewEnquiryState extends Equatable {
  const AddNewEnquiryState();
}

class AddNewEnquiryInitial extends AddNewEnquiryState {
  @override
  List<Object> get props => [];
}

class AddNewEnquiryLoadInProgress extends AddNewEnquiryState {
  @override
  List<Object> get props => [];
}

class AddNewEnquiryLoadSuccess extends AddNewEnquiryState {
  final bool status;

  AddNewEnquiryLoadSuccess(this.status);
  @override
  List<Object> get props => [];
}

class AddNewEnquiryLoadFail extends AddNewEnquiryState {
  final String failReason;

  AddNewEnquiryLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
