part of 'get_classwise_subject_admin_cubit.dart';

abstract class GetClasswiseSubjectAdminState extends Equatable {
  const GetClasswiseSubjectAdminState();
}

class GetClasswiseSubjectAdminInitial extends GetClasswiseSubjectAdminState {
  @override
  List<Object> get props => [];
}

class GetClasswiseSubjectAdminLoadInProgress
    extends GetClasswiseSubjectAdminState {
  @override
  List<Object> get props => [];
}

class GetClasswiseSubjectAdminLoadSuccess
    extends GetClasswiseSubjectAdminState {
  final List<GetClasswiseSubjectAdminModel> subjectList;
  GetClasswiseSubjectAdminLoadSuccess(this.subjectList);
  @override
  List<Object> get props => [subjectList];
}

class GetClasswiseSubjectAdminLoadFail extends GetClasswiseSubjectAdminState {
  final String failReason;
  GetClasswiseSubjectAdminLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
