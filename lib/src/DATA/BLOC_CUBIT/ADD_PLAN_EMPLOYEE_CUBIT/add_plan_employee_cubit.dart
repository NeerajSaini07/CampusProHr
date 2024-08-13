import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/addPlanEmployeeRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'add_plan_employee_state.dart';

class AddPlanEmployeeCubit extends Cubit<AddPlanEmployeeState> {
  final AddPlanEmployeeRepository repository;
  AddPlanEmployeeCubit(this.repository) : super(AddPlanEmployeeInitial());

  Future<void> addPlanEmployeeCubitCall(Map<String, String?> userData) async {
    if (await isInternetPresent()) {
      try {
        emit(AddPlanEmployeeLoadInProgress());
        final data = await repository.addPlanEmployee(userData);
        emit(AddPlanEmployeeLoadSuccess(data));
      } catch (e) {
        emit(AddPlanEmployeeLoadFail('$e'));
      }
    } else {
      emit(AddPlanEmployeeLoadFail(NO_INTERNET));
    }
  }
}
