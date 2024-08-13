import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/employeeStatusListModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/employeeStatusListRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'employee_status_list_state.dart';

class EmployeeStatusListCubit extends Cubit<EmployeeStatusListState> {
  //Dependency
  final EmployeeStatusListRepository _repository;

  EmployeeStatusListCubit(this._repository)
      : super(EmployeeStatusListInitial());

  Future<void> employeeStatusListCubitCall(Map<String, String?> empData) async {
    if (await isInternetPresent()) {
      try {
        emit(EmployeeStatusListLoadInProgress());
        final data = await _repository.employeeStatus(empData);
        emit(EmployeeStatusListLoadSuccess(data));
      } catch (e) {
        emit(EmployeeStatusListLoadFail("$e"));
      }
    } else {
      emit(EmployeeStatusListLoadFail(NO_INTERNET));
    }
  }
}
