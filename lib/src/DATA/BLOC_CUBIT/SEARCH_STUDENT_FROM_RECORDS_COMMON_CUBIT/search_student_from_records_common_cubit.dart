import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/searchStudentFromRecordsCommonModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/searchStudentFromRecordsCommonRepository.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/log_in_repository.dart';
import 'package:equatable/equatable.dart';

import '../../../UTILS/internetCheck.dart';

part 'search_student_from_records_common_state.dart';

class SearchStudentFromRecordsCommonCubit
    extends Cubit<SearchStudentFromRecordsCommonState> {
  //Dependency
  final SearchStudentFromRecordsCommonRepository _repository;

  SearchStudentFromRecordsCommonCubit(this._repository)
      : super(SearchStudentFromRecordsCommonInitial());

  Future<void> searchStudentFromRecordsCommonCubitCall(
      Map<String, String> remarkData) async {
    if (await isInternetPresent()) {
      try {
        emit(SearchStudentFromRecordsCommonLoadInProgress());
        final data = await _repository.searchStudentKey(remarkData);
        emit(SearchStudentFromRecordsCommonLoadSuccess(data));
      } catch (e) {
        emit(SearchStudentFromRecordsCommonLoadFail("$e"));
      }
    } else {
      emit(SearchStudentFromRecordsCommonLoadFail(NO_INTERNET));
    }
  }
}
