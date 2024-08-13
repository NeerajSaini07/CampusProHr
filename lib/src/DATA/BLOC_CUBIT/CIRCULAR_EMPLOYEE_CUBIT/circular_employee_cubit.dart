import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/circularEmployeeModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/circularEmployeeRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'circular_employee_state.dart';

class CircularEmployeeCubit extends Cubit<CircularEmployeeState> {
  //Dependency
  final CircularEmployeeRepository _repository;

  CircularEmployeeCubit(this._repository) : super(CircularEmployeeInitial());

  Future<void> circularEmployeeCubitCall(Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(CircularEmployeeLoadInProgress());
        final data = await _repository.circularEmployeeData(request);
        emit(CircularEmployeeLoadSuccess(data));
      } catch (e) {
        emit(CircularEmployeeLoadFail("$e"));
      }
    } else {
      emit(CircularEmployeeLoadFail(NO_INTERNET));
    }
  }
}
