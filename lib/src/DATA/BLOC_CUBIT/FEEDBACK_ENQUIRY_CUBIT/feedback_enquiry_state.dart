part of 'feedback_enquiry_cubit.dart';

abstract class FeedbackEnquiryState extends Equatable {
  const FeedbackEnquiryState();
}

class FeedbackEnquiryInitial extends FeedbackEnquiryState {
  @override
  List<Object> get props => [];
}

class FeedbackEnquiryLoadInProgress extends FeedbackEnquiryState {
  @override
  List<Object> get props => [];
}

class FeedbackEnquiryLoadSuccess extends FeedbackEnquiryState {
  final List<FeedbackEnquiryModel> feedbackList;

  FeedbackEnquiryLoadSuccess(this.feedbackList);
  @override
  List<Object> get props => [feedbackList];
}

class FeedbackEnquiryLoadFail extends FeedbackEnquiryState {
  final String failReason;

  FeedbackEnquiryLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
