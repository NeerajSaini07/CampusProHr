import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/classListEmployeeModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/classListEmployeeRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'class_list_employee_state.dart';

class ClassListEmployeeCubit extends Cubit<ClassListEmployeeState> {
  final ClassListEmployeeRepository _repository;
  ClassListEmployeeCubit(this._repository) : super(ClassListEmployeeInitial());

  Future<void> classListEmployeeCubitCall(
      Map<String, String?> userTypeData) async {
    if (await isInternetPresent()) {
      try {
        emit(ClassListEmployeeLoadInProgress());
        final data = await _repository.getClass(userTypeData);
        emit(ClassListEmployeeLoadSuccess(data));
      } catch (e) {
        emit(ClassListEmployeeLoadFail('$e'));
      }
    } else {
      emit(ClassListEmployeeLoadFail(NO_INTERNET));
    }
  }
}
