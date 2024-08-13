part of 'get_student_list_result_announce_cubit.dart';

abstract class GetStudentListResultAnnounceState extends Equatable {
  const GetStudentListResultAnnounceState();
}

class GetStudentListResultAnnounceInitial
    extends GetStudentListResultAnnounceState {
  @override
  List<Object> get props => [];
}

class GetStudentListResultAnnounceLoadInProgress
    extends GetStudentListResultAnnounceState {
  @override
  List<Object> get props => [];
}

class GetStudentListResultAnnounceLoadSuccess
    extends GetStudentListResultAnnounceState {
  final List<GetStudentListResultAnnounceModel> stuList;
  GetStudentListResultAnnounceLoadSuccess(this.stuList);
  @override
  List<Object> get props => [stuList];
}

class GetStudentListResultAnnounceLoadFail
    extends GetStudentListResultAnnounceState {
  final String failReason;
  GetStudentListResultAnnounceLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
