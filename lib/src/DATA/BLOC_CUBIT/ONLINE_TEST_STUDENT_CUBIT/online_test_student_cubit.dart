import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/onlineTestStudentRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'online_test_student_state.dart';

class OnlineTestStudentCubit extends Cubit<OnlineTestStudentState> {
  final OnlineTestStudentRepository _repository;
  OnlineTestStudentCubit(this._repository) : super(OnlineTestStudentInitial());

  Future<void> onlineTestStudentCubitCall(
      Map<String, String> testData) async {
    if (await isInternetPresent()) {
      try {
        emit(OnlineTestStudentLoadInProgress());
        final data = await _repository.onlineTestStudent(testData);
        emit(OnlineTestStudentLoadSuccess(data));
      } catch (e) {
        emit(OnlineTestStudentLoadFail("$e"));
      }
    } else {
      emit(OnlineTestStudentLoadFail(NO_INTERNET));
    }
  }
}