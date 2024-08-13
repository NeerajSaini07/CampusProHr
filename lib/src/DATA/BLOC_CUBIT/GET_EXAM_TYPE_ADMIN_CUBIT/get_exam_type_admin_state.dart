part of 'get_exam_type_admin_cubit.dart';

abstract class GetExamTypeAdminState extends Equatable {
  const GetExamTypeAdminState();
}

class GetExamTypeAdminInitial extends GetExamTypeAdminState {
  @override
  List<Object> get props => [];
}

class GetExamTypeAdminLoadInProgress extends GetExamTypeAdminState {
  @override
  List<Object> get props => [];
}

class GetExamTypeAdminLoadSuccess extends GetExamTypeAdminState {
  final List<GetExamTypeAdminModel> examList;
  GetExamTypeAdminLoadSuccess(this.examList);
  @override
  List<Object> get props => [examList];
}

class GetExamTypeAdminLoadFail extends GetExamTypeAdminState {
  final String failReason;
  GetExamTypeAdminLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
