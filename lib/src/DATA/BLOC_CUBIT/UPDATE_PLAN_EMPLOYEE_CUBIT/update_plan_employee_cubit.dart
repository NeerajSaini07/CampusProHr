import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/BLOC_CUBIT/ATTENDANCE_EMPLOYEE_CUBIT/attendance_employee_cubit.dart';
import 'package:campus_pro/src/DATA/MODELS/updatePlanEmployeeModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/updatePlanEmployeeRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'update_employee_state.dart';

class UpdatePlanEmployeeCubit extends Cubit<UpdateEmployeeState> {
  final UpdatePlanEmployeeRepository repository;
  UpdatePlanEmployeeCubit(this.repository) : super(UpdateEmployeeInitial());

  Future<void> updatePlanEmployeeCubitCall(
      Map<String, String?> userTypeData) async {
    if (await isInternetPresent()) {
      try {
        emit(UpdateEmployeeLoadInProgress());
        final data = await repository.getPlanList(userTypeData);
        emit(UpdateEmployeeLoadSuccess(data));
      } catch (e) {
        emit(UpdateEmployeeLoadFail('$e'));
      }
    } else {
      emit(UpdateEmployeeLoadFail(NO_INTERNET));
    }
  }
}
