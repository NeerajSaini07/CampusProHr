import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/saveStudentRemarkRepository.dart';
import 'package:equatable/equatable.dart';

import '../../../UTILS/internetCheck.dart';

part 'save_student_remark_state.dart';

class SaveStudentRemarkCubit extends Cubit<SaveStudentRemarkState> {
  //Dependency
  final SaveStudentRemarkRepository _repository;

  SaveStudentRemarkCubit(this._repository) : super(SaveStudentRemarkInitial());

  Future<void> saveStudentRemarkCubitCall(Map<String, String?> saveData) async {
    if (await isInternetPresent()) {
      try {
        emit(SaveStudentRemarkLoadInProgress());
        final data = await _repository.saveRemark(saveData);
        emit(SaveStudentRemarkLoadSuccess(data));
      } catch (e) {
        emit(SaveStudentRemarkLoadFail("$e"));
      }
    } else {
      emit(SaveStudentRemarkLoadFail(NO_INTERNET));
    }
  }
}
