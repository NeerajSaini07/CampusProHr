import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/homeWorkStudentModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/homeWorkStudentRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'home_work_student_state.dart';

class HomeWorkStudentCubit extends Cubit<HomeWorkStudentState> {
  final HomeWorkStudentRepository _repository;
  HomeWorkStudentCubit(this._repository) : super(HomeworkStudentInitial());

  Future<void> homeWorkStudentCubitCall(
      Map<String, String?> userTypeData) async {
    if (await isInternetPresent()) {
      try {
        emit(HomeWorkStudentLoadInProgress());
        final data = await _repository.homeWorkData(userTypeData);
        emit(HomeWorkStudentLoadSuccess(data));
      } catch (e) {
        emit(HomeWorkStudentLoadFail("$e"));
      }
    } else {
      emit(HomeWorkStudentLoadFail(NO_INTERNET));
    }
  }
}
