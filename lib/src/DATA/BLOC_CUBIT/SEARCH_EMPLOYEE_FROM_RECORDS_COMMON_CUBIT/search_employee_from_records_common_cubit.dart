import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/searchEmployeeFromRecordsCommonModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/searchEmployeeFromRecordsCommonRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'search_employee_from_records_common_state.dart';

class SearchEmployeeFromRecordsCommonCubit
    extends Cubit<SearchEmployeeFromRecordsCommonState> {
  //Dependency
  final SearchEmployeeFromRecordsCommonRepository _repository;

  SearchEmployeeFromRecordsCommonCubit(this._repository)
      : super(SearchEmployeeFromRecordsCommonInitial());

  Future<void> searchEmployeeFromRecordsCommonCubitCall(
      Map<String, String> searchKey) async {
    if (await isInternetPresent()) {
      try {
        emit(SearchEmployeeFromRecordsCommonLoadInProgress());
        final data = await _repository.searchEmployeeKey(searchKey);
        emit(SearchEmployeeFromRecordsCommonLoadSuccess(data));
      } catch (e) {
        emit(SearchEmployeeFromRecordsCommonLoadFail("$e"));
      }
    } else {
      emit(SearchEmployeeFromRecordsCommonLoadFail(NO_INTERNET));
    }
  }
}
