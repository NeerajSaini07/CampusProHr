part of 'get_exam_result_publish_cubit.dart';

abstract class GetExamResultPublishState extends Equatable {
  const GetExamResultPublishState();
}

class GetExamResultPublishInitial extends GetExamResultPublishState {
  @override
  List<Object> get props => [];
}

class GetExamResultPublishLoadInProgress extends GetExamResultPublishState {
  @override
  List<Object> get props => [];
}

class GetExamResultPublishLoadSuccess extends GetExamResultPublishState {
  final List<GetExamResultPublishModel> studentList;
  GetExamResultPublishLoadSuccess(this.studentList);
  @override
  List<Object> get props => [studentList];
}

class GetExamResultPublishLoadFail extends GetExamResultPublishState {
  final String failReason;
  GetExamResultPublishLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
