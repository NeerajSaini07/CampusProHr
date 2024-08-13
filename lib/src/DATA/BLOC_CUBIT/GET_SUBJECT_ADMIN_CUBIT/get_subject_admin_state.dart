part of 'get_subject_admin_cubit.dart';

abstract class GetSubjectAdminState extends Equatable {
  const GetSubjectAdminState();
}

class GetSubjectAdminInitial extends GetSubjectAdminState {
  @override
  List<Object> get props => [];
}

class GetSubjectAdminLoadInProgress extends GetSubjectAdminState {
  @override
  List<Object> get props => [];
}

class GetSubjectAdminLoadSuccess extends GetSubjectAdminState {
  final List<GetSubjectAdminModel> subjectList;
  GetSubjectAdminLoadSuccess(this.subjectList);
  @override
  List<Object> get props => [subjectList];
}

class GetSubjectAdminLoadFail extends GetSubjectAdminState {
  final String failReason;
  GetSubjectAdminLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
