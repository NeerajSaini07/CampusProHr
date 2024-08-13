import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/updateRollNoEmployeeRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'update_roll_no_employee_state.dart';

class UpdateRollNoEmployeeCubit extends Cubit<UpdateRollNoEmployeeState> {
  final UpdateRollNoEmployeeRepository _repository;
  UpdateRollNoEmployeeCubit(this._repository)
      : super(UpdateRollNoEmployeeInitial());

  Future<void> updateRollNoEmployeeCubitCall(
      Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(UpdateRollNoEmployeeLoadInProgress());
        final data = await _repository.updateRollNo(request);
        emit(UpdateRollNoEmployeeLoadSuccess(data));
      } catch (e) {
        emit(UpdateRollNoEmployeeLoadFail('$e'));
      }
    } else {
      emit(UpdateRollNoEmployeeLoadFail(NO_INTERNET));
    }
  }
}
