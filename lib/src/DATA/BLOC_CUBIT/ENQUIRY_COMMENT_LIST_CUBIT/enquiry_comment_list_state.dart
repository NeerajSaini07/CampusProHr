part of 'enquiry_comment_list_cubit.dart';

abstract class EnquiryCommentListState extends Equatable {
  const EnquiryCommentListState();
}

class EnquiryCommentListInitial extends EnquiryCommentListState {
  @override
  List<Object> get props => [];
}

class EnquiryCommentListLoadInProgress extends EnquiryCommentListState {
  @override
  List<Object> get props => [];
}

class EnquiryCommentListLoadSuccess extends EnquiryCommentListState {
  final List<EnquiryCommentListModel> commentList;

  EnquiryCommentListLoadSuccess(this.commentList);
  @override
  List<Object> get props => [commentList];
}

class EnquiryCommentListLoadFail extends EnquiryCommentListState {
  final String failReason;

  EnquiryCommentListLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
