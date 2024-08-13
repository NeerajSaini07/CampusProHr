import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/studentListForChangeRollNoModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/studentListForChangeRollNoRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'student_list_for_change_roll_no_state.dart';

class StudentListForChangeRollNoCubit
    extends Cubit<StudentListForChangeRollNoState> {
  final StudentListForChangeRollNoRepository _repository;
  StudentListForChangeRollNoCubit(this._repository)
      : super(StudentListForChangeRollNoInitial());

  Future<void> studentListForChangeRollNoCubitCall(
      Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(StudentListForChangeRollNoLoadInProgress());
        var data = await _repository.getStudentList(request);
        emit(StudentListForChangeRollNoLoadSuccess(data));
      } catch (e) {
        emit(StudentListForChangeRollNoLoadFail('$e'));
      }
    } else {
      emit(StudentListForChangeRollNoLoadFail(NO_INTERNET));
    }
  }
}
