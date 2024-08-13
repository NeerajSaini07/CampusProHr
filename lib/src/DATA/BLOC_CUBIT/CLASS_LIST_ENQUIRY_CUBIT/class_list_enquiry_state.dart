part of 'class_list_enquiry_cubit.dart';

abstract class ClassListEnquiryState extends Equatable {
  const ClassListEnquiryState();
}

class ClassListEnquiryInitial extends ClassListEnquiryState {
  @override
  List<Object> get props => [];
}

class ClassListEnquiryLoadInProgress extends ClassListEnquiryState {
  @override
  List<Object> get props => [];
}

class ClassListEnquiryLoadSuccess extends ClassListEnquiryState {
  final List<ClassListEnquiryModel> classList;

  ClassListEnquiryLoadSuccess(this.classList);
  @override
  List<Object> get props => [];
}

class ClassListEnquiryLoadFail extends ClassListEnquiryState {
  final String failReason;

  ClassListEnquiryLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
