import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/employeeInfoModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/employeeInfoRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'employee_info_state.dart';

class EmployeeInfoCubit extends Cubit<EmployeeInfoState> {
  final EmployeeInfoRepository _repository;
  EmployeeInfoCubit(this._repository) : super(EmployeeInfoInitial());

  Future<void> employeeInfoCubitCall(Map<String, String?> employeeData) async {
    if (await isInternetPresent()) {
      try {
        emit(EmployeeInfoLoadInProgress());
        final data = await _repository.employeeInfo(employeeData);
        emit(EmployeeInfoLoadSuccess(data));
      } catch (e) {
        emit(EmployeeInfoLoadFail("$e"));
      }
    } else {
      emit(EmployeeInfoLoadFail(NO_INTERNET));
    }
  }
}
