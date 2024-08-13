import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/studentInfoForSearchModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/studentInfoForSearchRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'student_info_for_search_state.dart';

class StudentInfoForSearchCubit extends Cubit<StudentInfoForSearchState> {
  final StudentInfoForSearchRepository _repository;

  StudentInfoForSearchCubit(this._repository) : super(StudentInfoForSearchInitial());

  Future<void> studentInfoForSearchCubitCall(Map<String, String> studentData) async {
    if (await isInternetPresent()) {
      try {
        emit(StudentInfoForSearchLoadInProgress());
        final data = await _repository.getStudentInfoForSearch(studentData);
        emit(StudentInfoForSearchLoadSuccess(data));
      } catch (e) {
        emit(StudentInfoForSearchLoadFail("$e"));
      }
    } else {
      emit(StudentInfoForSearchLoadFail(NO_INTERNET));
    }
  }
}
