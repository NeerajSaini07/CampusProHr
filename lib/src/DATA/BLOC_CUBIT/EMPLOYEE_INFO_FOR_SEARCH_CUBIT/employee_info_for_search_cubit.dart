import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/STUDENT_INFO_FOR_SEARCH_CUBIT/student_info_for_search_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/employeeInfoForSearchModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/employeeInfoForSearchRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'employee_info_for_search_state.dart';

class EmployeeInfoForSearchCubit extends Cubit<EmployeeInfoForSearchState> {
  final EmployeeInfoForSearchRepository _repository;

  EmployeeInfoForSearchCubit(this._repository)
      : super(EmployeeInfoForSearchInitial());

  Future<void> employeeInfoForSearchCubitCall(
      Map<String, String> employeeData) async {
    if (await isInternetPresent()) {
      try {
        emit(EmployeeInfoForSearchLoadInProgress());
        final data = await _repository.getEmployeeInfoForSearch(employeeData);
        emit(EmployeeInfoForSearchLoadSuccess(data));
      } catch (e) {
        emit(EmployeeInfoForSearchLoadFail("$e"));
      }
    } else {
      emit(EmployeeInfoForSearchLoadFail(NO_INTERNET));
    }
  }
}
