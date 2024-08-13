import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/circularStudentModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/circularStudentRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'circular_student_state.dart';

class CircularStudentCubit extends Cubit<CircularStudentState> {
  final CircularStudentRepository _repository;
  CircularStudentCubit(this._repository) : super(CircularStudentInitial());

  Future<void> circulatStudentCubitCall(
      Map<String, String?> requestPayload) async {
    if (await isInternetPresent()) {
      try {
        emit(CircularStudentLoadInProgress());
        final data = await _repository.circularStudentData(requestPayload);
        emit(CircularStudentLoadSuccess(data));
      } catch (e) {
        emit(CircularStudentLoadFail("$e"));
      }
    } else {
      emit(CircularStudentLoadFail(NO_INTERNET));
    }
  }
}
