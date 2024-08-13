part of 'search_student_from_records_common_cubit.dart';

abstract class SearchStudentFromRecordsCommonState extends Equatable {
  const SearchStudentFromRecordsCommonState();
}

class SearchStudentFromRecordsCommonInitial
    extends SearchStudentFromRecordsCommonState {
  @override
  List<Object> get props => [];
}

class SearchStudentFromRecordsCommonLoadInProgress
    extends SearchStudentFromRecordsCommonState {
  @override
  List<Object> get props => [];
}

class SearchStudentFromRecordsCommonLoadSuccess
    extends SearchStudentFromRecordsCommonState {
  final List<SearchStudentFromRecordsCommonModel> searchData;

  SearchStudentFromRecordsCommonLoadSuccess(this.searchData);
  @override
  List<Object> get props => [searchData];
}

class SearchStudentFromRecordsCommonLoadFail
    extends SearchStudentFromRecordsCommonState {
  final String failReason;

  SearchStudentFromRecordsCommonLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
