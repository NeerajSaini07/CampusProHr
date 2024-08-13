part of 'search_employee_from_records_common_cubit.dart';

abstract class SearchEmployeeFromRecordsCommonState extends Equatable {
  const SearchEmployeeFromRecordsCommonState();
}

class SearchEmployeeFromRecordsCommonInitial
    extends SearchEmployeeFromRecordsCommonState {
  @override
  List<Object> get props => [];
}

class SearchEmployeeFromRecordsCommonLoadInProgress
    extends SearchEmployeeFromRecordsCommonState {
  @override
  List<Object> get props => [];
}

class SearchEmployeeFromRecordsCommonLoadSuccess
    extends SearchEmployeeFromRecordsCommonState {
  final List<SearchEmployeeFromRecordsCommonModel> searchData;

  SearchEmployeeFromRecordsCommonLoadSuccess(this.searchData);
  @override
  List<Object> get props => [searchData];
}

class SearchEmployeeFromRecordsCommonLoadFail
    extends SearchEmployeeFromRecordsCommonState {
  final String failReason;

  SearchEmployeeFromRecordsCommonLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
