import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/getTaskDataEmployeeModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/getTaskDataEmployeeRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'get_tesk_data_employee_state.dart';

class GetTeskDataEmployeeCubit extends Cubit<GetTeskDataEmployeeState> {
  final GetTaskDataEmployeeRepository _repository;
  GetTeskDataEmployeeCubit(this._repository)
      : super(GetTeskDataEmployeeInitial());

  Future<void> getTeskDataEmployeeCubitData(
      Map<String, String?> payload) async {
    if (await isInternetPresent()) {
      try {
        emit(GetTeskDataEmployeeLoadInProgress());
        var data = await _repository.getData(payload);
        emit(GetTeskDataEmployeeLoadSuccess(data));
      } catch (e) {
        emit(GetTeskDataEmployeeLoadFail('$e'));
      }
    } else {
      emit(GetTeskDataEmployeeLoadFail(NO_INTERNET));
    }
  }
}
