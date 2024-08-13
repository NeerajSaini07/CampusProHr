import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/homeworkEmployeeModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/homeworkEmployeeRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'homework_employee_state.dart';

class HomeworkEmployeeCubit extends Cubit<HomeworkEmployeeState> {
  final HomeworkEmployeeRepository _repository;

  HomeworkEmployeeCubit(this._repository) : super(HomeworkEmployeeInitial());

  Future<void> homeworkEmployeeCubitCall(Map<String, String?> classData) async {
    if (await isInternetPresent()) {
      try {
        emit(HomeworkEmployeeLoadInProgress());
        final data = await _repository.homeworkData(classData);
        emit(HomeworkEmployeeLoadSuccess(data));
      } catch (e) {
        emit(HomeworkEmployeeLoadFail("$e"));
      }
    } else {
      emit(HomeworkEmployeeLoadFail(NO_INTERNET));
    }
  }
}
