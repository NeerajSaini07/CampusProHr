import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/studentDetailSearchModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/studentDetailSearchRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'student_detail_search_state.dart';

class StudentDetailSearchCubit extends Cubit<StudentDetailSearchState> {
  //Dependency
  final StudentDetailSearchRepository _repository;

  StudentDetailSearchCubit(this._repository)
      : super(StudentDetailSearchInitial());

  Future<void> studentDetailSearchCubitCall(
      Map<String, String?> studentData) async {
    if (await isInternetPresent()) {
      try {
        emit(StudentDetailSearchLoadInProgress());
        final data = await _repository.studentDetailSearch(studentData);
        emit(StudentDetailSearchLoadSuccess(data));
      } catch (e) {
        emit(StudentDetailSearchLoadFail("$e"));
      }
    } else {
      emit(StudentDetailSearchLoadFail(NO_INTERNET));
    }
  }
}
