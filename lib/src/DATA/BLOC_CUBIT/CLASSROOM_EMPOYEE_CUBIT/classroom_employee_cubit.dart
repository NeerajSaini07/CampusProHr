import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/classroomEmployeeModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/classroomEmployeeRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'classroom_employee_state.dart';

class ClassroomEmployeeCubit extends Cubit<ClassroomEmployeeState> {
  final ClassroomEmployeeRepository _repository;

  ClassroomEmployeeCubit(this._repository) : super(ClassroomEmployeeInitial());

  Future<void> classroomEmployeeCubitCall(
      Map<String, String?> classData) async {
    if (await isInternetPresent()) {
      try {
        emit(ClassroomEmployeeLoadInProgress());
        final data = await _repository.classroomData(classData);
        emit(ClassroomEmployeeLoadSuccess(data));
      } catch (e) {
        emit(ClassroomEmployeeLoadFail("$e"));
      }
    } else {
      emit(ClassroomEmployeeLoadFail(NO_INTERNET));
    }
  }
}
