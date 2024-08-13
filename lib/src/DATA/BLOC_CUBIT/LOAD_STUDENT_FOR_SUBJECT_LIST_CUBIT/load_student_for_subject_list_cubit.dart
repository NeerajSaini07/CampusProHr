import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/loadStudentForSubjectListModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/loadStudentForSubjectListRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'load_student_for_subject_list_state.dart';

class LoadStudentForSubjectListCubit
    extends Cubit<LoadStudentForSubjectListState> {
  final LoadStudentForSubjectListRepository _repository;
  LoadStudentForSubjectListCubit(this._repository)
      : super(LoadStudentForSubjectListInitial());

  Future<void> loadStudentForSubjectListCubitCall(
      Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(LoadStudentForSubjectListLoafInProgress());
        var data = await _repository.studentList(request);
        emit(LoadStudentForSubjectListLoadSuccess(data));
      } catch (e) {
        emit(LoadStudentForSubjectListLoadFail('$e'));
      }
    } else {
      emit(LoadStudentForSubjectListLoadFail(NO_INTERNET));
    }
  }
}
